unit WoWManager;

interface

uses Debug, StringBuffer,
  SysUtils, Utils, WoWOpCodes, WoWPacket;

const
  BrokenPacketSize   = 80000;
  BrokenPacketOpCode = $FFFF;

type
  TDumpCallBack = procedure(bFromServer: Boolean; tPacket: TSchWoWPacket) of object;

  TSchWoWManager = class(TObject)
  private
    fKeyPacketOrder: array[0..6] of Integer;
    fKeySizesOrder: array[0..6] of Word;

    fCommKey: String;
    fCommKeyDecr: array[1..40] of Boolean;
    fCommKeyStart: Boolean;
    fLoggedIn: Boolean;

    fFullFragment: String;
    fSavePacketPart: String;

    fClientDecoder, fServerDecoder: TSchWoWDecoder;

    fClientInputBuffer, fServerInputBuffer:
    TSchInOutStringBuffer;

    fOnDumpPacket: TDumpCallBack;

    fFirstClientPacket, fFirstServerPacket: Boolean;

    fKeyInitialized: Boolean;

    fFastKey: Boolean;
    fFastKeyIdx: Integer;
    fNextPacketIsFragment: Boolean;
    fPrevFragment: String;
    fPrevFragmentDecSize: Integer;

    procedure SetCommKeyStart(const Value: Boolean);

    procedure SlowKeyDetect(sRaw: String);
    procedure FastKeyDetect(sRaw: String);

    function HRU_PresumingPacket(sRaw: String): Integer;
    procedure HRU_NextOpcodeShouldBe(sRaw: String;
      var NowIndex: Integer);
  public
    InternalError: Boolean;

    constructor Create();
    destructor Destroy(); override;

    procedure AddClientSentRawData(sRaw: String);
    procedure AddServerSentRawData(sRaw: String);

    function KeyAvailable(): Boolean;
    function KeyText(): String;
    function Key(): String;
    function KeyBool(): String;
    function KeyPieces(): Integer;
    procedure SetKey(sKey: String);

    procedure ProcessData();

    property OnDumpPacket: TDumpCallBack
      Read fOnDumpPacket Write fOnDumpPacket;

    property ExtractKey: Boolean
      Read fCommKeyStart Write SetCommKeyStart;
    property ClientDecoder: TSchWoWDecoder Read fClientDecoder;
    property ServerDecoder: TSchWoWDecoder Read fServerDecoder;
    property FastKey: Boolean Read fFastKey Write fFastKey;
  end;

implementation

uses Globals;

{ TSchWoWManager }

procedure TSchWoWManager.AddClientSentRawData(sRaw: String);
var
  MyPacket: TSchWoWPacket;

begin

  if fFirstClientPacket then // Skip First Packet ... Pass it directly to parser.
  begin
    fClientDecoder.SavePosition;

    MyPacket := TSchClientWoWPacket.Create(sRaw, fClientDecoder);

    if Assigned(fOnDumpPacket) then  fOnDumpPacket(False, MyPacket);

    MyPacket.Destroy();

    fClientDecoder.RestorePosition();
    fFirstClientPacket := False;

    Exit;
  end;

  if not fKeyInitialized then // Proceed only if we do not posses al the key.
  begin
    if fFastKey then FastKeyDetect(sRaw)
    else
      SlowKeyDetect(sRaw);

    if Length(fSavePacketPart) >= 6 then
    begin
      if fFastKey then FastKeyDetect(fSavePacketPart)
      else
        SlowKeyDetect(fSavePacketPart);

      fSavePacketPart := '';
    end;
  end;

  fClientInputBuffer.AddChunk(sRaw);

  if not fKeyInitialized then
  begin
    if KeyAvailable() then
    begin
      fKeyInitialized := True;
      fClientDecoder.SetKey(fCommKey);
      fServerDecoder.SetKey(fCommKey);

      ProcessData();
    end;
  end else
    ProcessData();

end;

procedure TSchWoWManager.AddServerSentRawData(sRaw: String);
var
  MyPacket: TSchWoWPacket;
begin

  if fFirstServerPacket then // Skip First Packet ... Pass it directly to parser.
  begin
    MyPacket := TSchServerWoWPacket.Create(sRaw, fServerDecoder);

    if Assigned(fOnDumpPacket) then  fOnDumpPacket(True, MyPacket);

    MyPacket.Destroy();

    fFirstServerPacket := False;

    Exit;
  end;

  // Don't make Size assumptions Server-Side. Packets can be fragmented.

  fServerInputBuffer.AddChunk(sRaw);

  if not fKeyInitialized then
  begin
    if KeyAvailable() then
    begin
      fKeyInitialized := True;
      fClientDecoder.SetKey(fCommKey);
      fServerDecoder.SetKey(fCommKey);

      ProcessData();
    end;
  end else
    ProcessData();

end;

constructor TSchWoWManager.Create;
var
  iI: Integer;
begin

  fPrevFragmentDecSize := 0;
  fNextPacketIsFragment := False;
  fPrevFragment := '';
  fFullFragment := '';
  fLoggedIn := False;

  fSavePacketPart := '';
  ffastKey := False;
  fFastKeyIdx := 0;

  fCommKey := '';

  for iI := 1 to 40 do
  begin
    fCommKey := fCommKey + #0;
    fCommKeyDecr[iI] := False;
  end;

  fKeyInitialized := False;
  fCommKeyStart := False;

  fClientInputBuffer := TSchInOutStringBuffer.Create();
  fServerInputBuffer := TSchInOutStringBuffer.Create();

  fClientDecoder := TSchWoWDecoder.Create('');
  fServerDecoder := TSchWoWDecoder.Create('');

  fFirstClientPacket := True;
  fFirstServerPacket := True;

  fOnDumpPacket := nil;
  InternalError := False;

end;

destructor TSchWoWManager.Destroy;
begin

  fClientInputBuffer.Destroy();
  fServerInputBuffer.Destroy();

  fClientDecoder.Destroy();
  fServerDecoder.Destroy();

end;

procedure TSchWoWManager.FastKeyDetect(sRaw: String);
var
  wSize: Word;
  iCmd: Integer;

  _a: array[0..1] of Char absolute wSize;
  _b: array[0..3] of Char absolute iCmd;

  iKeyPart1, iKeyPart2, iKeyPart3, iKeyPart4, iKeyPart5, iKeyPart6: Integer;

  sKeyPart: String;
  sHdr: String;

  iExpectOpCode: Integer;
  wExpectSize: Word;

  iExpectOp: Integer;
begin

  ASSERT(Length(sRaw) >= 6);   // Must be sure we do not get fragmented packets.
  ASSERT(fFastKeyIdx < 6);     // Key Obviously failed like a bitch !

  iExpectOp := HRU_PresumingPacket(sRaw);
  if iExpectOp <> 0 then
  begin
    { We have an ACCOUNT UPDATE here. }
    if fNextPacketIsFragment then
    begin
      Exit;
    end;{ Ignore Fragment .. Let's wait for full }

    { It's full now :) ... Let's try to get data from it }
    wExpectSize := Length(fFullFragment) - 2;  { Minus Size }
    iExpectOpCode := iExpectOp;

    sRaw := fFullFragment;
    Dec(fFastKeyIdx); { Back The Expected Index }
  end else
  begin
    { Fast Key Heuristics }
    HRU_NextOpcodeShouldBe(sRaw, fFastKeyIdx);

    { Proceed to Normal }
    wExpectSize := fKeySizesOrder[fFastKeyIdx] + 4; { + Size Of OpCode }
    iExpectOpCode := fKeyPacketOrder[fFastKeyIdx];
  end;

  // We have the encrypted packet size and opcode now. Let's try and get
  // some key parts from it:

  _a[0] := sRaw[1];
  _a[1] := sRaw[2];
  _b[0] := sRaw[3];
  _b[1] := sRaw[4];
  _b[2] := sRaw[5];
  _b[3] := sRaw[6];

  sKeyPart := fClientDecoder.DecryptKeyFast(wSize, ChangeByteOrder(
    wExpectSize, False), iCmd, iExpectOpCode, iKeyPart1, iKeyPart2,
    iKeyPart3, iKeyPart4, iKeyPart5, iKeyPart6);

  // Now lets See if everything is fine with those Parts.

  if fCommKeyDecr[iKeyPart1 + 1] then
    ASSERT(fCommKey[iKeyPart1 + 1] = sKeyPart[1]);

  if fCommKeyDecr[iKeyPart2 + 1] then
    ASSERT(fCommKey[iKeyPart2 + 1] = sKeyPart[2]);

  if fCommKeyDecr[iKeyPart3 + 1] then
    ASSERT(fCommKey[iKeyPart3 + 1] = sKeyPart[3]);

  if fCommKeyDecr[iKeyPart4 + 1] then
    ASSERT(fCommKey[iKeyPart4 + 1] = sKeyPart[4]);

  if fCommKeyDecr[iKeyPart5 + 1] then
    ASSERT(fCommKey[iKeyPart5 + 1] = sKeyPart[5]);

  if fCommKeyDecr[iKeyPart6 + 1] then
    ASSERT(fCommKey[iKeyPart6 + 1] = sKeyPart[6]);

  fCommKey[iKeyPart1 + 1] := sKeyPart[1];
  fCommKey[iKeyPart2 + 1] := sKeyPart[2];

  fCommKey[iKeyPart3 + 1] := sKeyPart[3];
  fCommKey[iKeyPart4 + 1] := sKeyPart[4];
  fCommKey[iKeyPart5 + 1] := sKeyPart[5];
  fCommKey[iKeyPart6 + 1] := sKeyPart[6];


  fCommKeyDecr[iKeyPart1 + 1] := True;
  fCommKeyDecr[iKeyPart2 + 1] := True;

  fCommKeyDecr[iKeyPart3 + 1] := True;
  fCommKeyDecr[iKeyPart4 + 1] := True;
  fCommKeyDecr[iKeyPart5 + 1] := True;
  fCommKeyDecr[iKeyPart6 + 1] := True;

  // We have gathered another pieces of the key :))
  // Lets set the last PrevCT for next decrypt...
  sHdr := Copy(sRaw, 1, 6);
  fClientDecoder.DecryptString(sHdr);

  Inc(fFastKeyIdx);

end;


function TSchWoWManager.HRU_PresumingPacket(sRaw: String): Integer;
var
  uiID, uiDecSize: Integer;

  _a: array[0..3] of Char absolute uiID;
  _b: array[0..3] of Char absolute uiDecSize;

  _c, _d: String;

  iI, iJ: Integer;

label
  _NextPacket0, _NextPacket1;
begin

  { Part 1. Let's see if it's a known Packet that can be fragmented }
  Result := 0;


  if (Length(sRaw) = 14) and (fFastKey) then { Assuming the PING Packet }
  begin
    { Extract Ping Value }
    _a[0] := sRaw[07];
    _a[1] := sRaw[08];
    _a[2] := sRaw[09];
    _a[3] := sRaw[10];

    _b[0] := sRaw[11];
    _b[1] := sRaw[12];
    _b[2] := sRaw[13];
    _b[3] := sRaw[14];

    if (uiID > 20) or (uiDecSize > 1000) or
      ((uiDecSize = 0) and (fLoggedIn)) then
      goto _NextPacket1;

    { Packet obviously is ours }

    fFullFragment := sRaw;
    fPrevFragment := '';
    fSavePacketPart := '';
    fNextPacketIsFragment := False;

    Result := CMSG_PING;
    Exit;
  end;

  _NextPacket1:

    if Length(sRaw) >= 14 then { Assume CMSG_UPDATE_ACCOUNT_DATA. Min Size 14 }
    begin
      { Extract uiID and uiSize }
      _a[0] := sRaw[07];
      _a[1] := sRaw[08];
      _a[2] := sRaw[09];
      _a[3] := sRaw[10];
      _b[0] := sRaw[11];
      _b[1] := sRaw[12];
      _b[2] := sRaw[13];
      _b[3] := sRaw[14];


      if (uiID > 8) or (uiID < 0) then goto _NextPacket0;
      { Obviously not our packet. uiID > 6 haven't been found yet :) }

      if (uiDecSize > 20000) or (uiDecSize < 0) then goto _NextPacket0;
      { Obviously not our packet. uiDecSize too fucking big }

      if (uiDecSize = 0) and (Length(sRaw) > 20) then
      begin
        { Exceptional Case Here! We have two Known Packets sticked together. LOL :) }


        { Copy the first Packet to Full Fragment }
        fFullFragment := '';
        for iI := 1 to 14 do fFullFragment := fFullFragment + sRaw[iI];

        { The Remainings copy to left buffer }
        fSavePacketPart := '';
        for iI := 15 to Length(sRaw) do fSavePacketPart := fSavePacketPart + sRaw[iI];

        { Leave This Function }
        Result := CMSG_UPDATE_ACCOUNT_DATA;
        Exit;
      end;


      _c := '';
      for iI := 15 to Length(sRaw) do _c := _c + sRaw[iI];
      { Copy contents of the packet's body to be decompressed later }

      fPrevFragment := _c;

      fFullFragment := sRaw;


      try
        _c := ZLibDecompressInternal(_c, uiDecSize);
        if Length(_c) <> uiDecSize then  raise Exception.Create('Internal Exception');
      except
        on Exception do
        begin
          fNextPacketIsFragment := True;
          Result := CMSG_UPDATE_ACCOUNT_DATA;

          Exit;
          { Next Piece we receive is a fragment of this packet. Mark so and exit }
        end;
      end;

  { OK, if we got here then:
     1. It is really a CMSG_UPDATE_ACCOUNT_DATA packet.
     2. It is not fragmented at all.
     3. It does not contain other fragments in it

    We can simply skip it ... 
  }


      fPrevFragment := '';
      fPrevFragmentDecSize := uiDecSize;
      fSavePacketPart := '';
      fNextPacketIsFragment := False;

      Result := CMSG_UPDATE_ACCOUNT_DATA;
      Exit;
    end;

  _NextPacket0:

    if ((Length(sRaw) = 7) or (Length(sRaw) = 18) or (Length(sRaw) >= 24)) and
      (not fNextPacketIsFragment) then
      { Assume CMSG_HARDWARE_SURVEY_RESULTS. }
    begin
      { It's it for sure .. no need to check more :) }

      fFullFragment := sRaw;
      fPrevFragment := '';
      fSavePacketPart := '';
      fNextPacketIsFragment := False;

      Result := $02E7;       //743=CMSG_HARDWARE_SURVEY_RESULTS
      Exit;
    end;

  if (fNextPacketIsFragment) and (Length(sRaw) > 6) then
    { Assume CMSG_UPDATE_ACCOUNT_DATA fragment }
  begin
  { Now we're going to copy byte-by-byte
    from the buffer and try to decompress it until we get the desired result
    or consider this buffer to be just-a-fragment and continue to next.
  }

    _c := fPrevFragment;


    for iI := 7 to Length(sRaw) do
    begin
      _c := _c + sRaw[iI];
      fFullFragment := fFullFragment + sRaw[iI];


      try
        _d := ZLibDecompressInternal(_c, fPrevFragmentDecSize);
        if Length(_d) <> uiDecSize then
          raise Exception.Create('Internal Exception');


        { Packet is Complete! }
        fNextPacketIsFragment := False;
        fPrevFragment := '';
        fPrevFragmentDecSize := 0;

        { Consider The remaining bytes in recv buffer as another complete packet. }

        _c := '';

        if iI < Length(sRaw) then  for iJ := iI + 1 to Length(sRaw) do
            _c := _c + sRaw[iJ];


        fSavePacketPart := _c;

        Result := CMSG_UPDATE_ACCOUNT_DATA;

        Exit;
      except
        on Exception do
        begin
          { Nope, not complete yet }
        end;
      end;

    end;

   { If we got here, that means ... something is 80% wrong. But let's see
     1. This is another piece, following for another.
   }

    fPrevFragment := _c;
    Result := CMSG_UPDATE_ACCOUNT_DATA;

    Exit;
  end;

end;

procedure TSchWoWManager.HRU_NextOpcodeShouldBe(sRaw: String; var NowIndex: Integer);
var
  iSize, iHRSize: Integer;
begin
  iSize := Length(sRaw);
  iHRSize := iSize - 6;

  { 1 Packet }
  if (NowIndex = 0) then
  begin
    if iSize = 6 then { Assuming CMSG_CHAR_ENUM }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_CHAR_ENUM;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 2 Packet }
  if (NowIndex = 1) then
  begin
    if (iSize = 10) and (not fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] =
      CMSG_CHAR_ENUM) then { Assuming CMSG_NEW_WOW_TO_TBC_OPC_REALM }
    begin
      fLoggedIn := True;
      fKeyPacketOrder[NowIndex] := CMSG_NEW_WOW_TO_TBC_OPC_REALM;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 3 Packet }
  if (NowIndex = 2) then
  begin
    if (iSize = 10) and (not fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] =
      CMSG_NEW_WOW_TO_TBC_OPC_REALM) then { Assuming CMSG_GUILD_QUERY }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_GUILD_QUERY;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 4 Packet }
  if (NowIndex = 3) then
  begin
    if (iSize = 14) and (not fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] =
      CMSG_CHAR_ENUM) then { Assuming CMSG_PLAYER_LOGIN }
    begin
      fLoggedIn := True;
      fKeyPacketOrder[NowIndex] := CMSG_PLAYER_LOGIN;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 5 Packet }
  if (NowIndex = 4) then
  begin
    if (iSize = 14) and (fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] = CMSG_PLAYER_LOGIN)
    then { Assuming CMSG_NAME_QUERY }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_NAME_QUERY;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 6 Packet }
  if (NowIndex = 5) then
  begin
    if (iSize = 10) and (fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] = CMSG_NAME_QUERY)
    then { Assuming CMSG_GUILD_QUERY }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_GUILD_QUERY;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 7 Packet }
  if (NowIndex = 6) then
  begin

    if (iSize = 14) and (fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] = CMSG_GUILD_QUERY)
    then { Assuming CMSG_SET_ACTIVE_MOVER }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_SET_ACTIVE_MOVER;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 8 Packet }
  if (NowIndex = 7) then
  begin

    if (iSize = 6) and (fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] =
      CMSG_SET_ACTIVE_MOVER) then { Assuming CMSG_GMTICKET_GETTICKET }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_GMTICKET_GETTICKET;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 9 Packet }
  if (NowIndex = 8) then
  begin

    if (iSize = 6) and (fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] =
      CMSG_GMTICKET_GETTICKET) then { Assuming CMSG_QUERY_TIME }
    begin
      fKeyPacketOrder[NowIndex] := CMSG_QUERY_TIME;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

  { 10 Packet }
  if (NowIndex = 9) then
  begin

    if (iSize = 6) and (fLoggedIn) and (fKeyPacketOrder[NowIndex - 1] = CMSG_QUERY_TIME)
    then { Assuming MSG_LOOKING_FOR_GROUP }
    begin
      fKeyPacketOrder[NowIndex] := MSG_LOOKING_FOR_GROUP;
      fKeySizesOrder[NowIndex] := iHRSize;
    end;

    { There can't be anything else }
  end;

end;

function TSchWoWManager.Key: String;
begin
  Result := fCommKey;
end;

function TSchWoWManager.KeyAvailable: Boolean;
var
  iI: Integer;
begin
  if fKeyInitialized then
  begin
    Result := True;
    Exit;
  end;

  Result := False;

  for iI := 1 to 40 do if (not fCommKeyDecr[iI]) then Exit;

  Result := True;
end;

function TSchWoWManager.KeyBool: String;
var
  i: Integer;
begin
  SetLength(Result, 40);

  for i := 1 to 40 do if fCommKeyDecr[i] then Result[i] := '1'
    else
      Result[i] := '0';
end;

function TSchWoWManager.KeyPieces: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to 40 do if fCommKeyDecr[i] then Result := Result + 1;
end;

function TSchWoWManager.KeyText: String;
var
  i: Integer;
begin

  for i := 1 to 40 do if fCommKeyDecr[i] then
      Result := Result + IntToHex(Byte(fCommKey[i]), 2)
    else
      Result := Result + '--';
end;

procedure TSchWoWManager.ProcessData;
var
  BaseBuff: String;
  tmpStrBuff: TSchInOutStringBuffer;

  iPacketSize: Integer;
  iPacketCode: Integer;

  MyPacket: TSchWoWPacket;

  sCopyBuf: String;
begin

  { * Process Client Side Stored Packets * }

  while Length(fClientInputBuffer.StringBuffer) >= 6 do
    // Client Side headers are 6 bytes
  begin

    BaseBuff := Copy(fClientInputBuffer.StringBuffer, 1, 6);
    fClientDecoder.SavePosition();

    BaseBuff := fClientDecoder.DecryptString(BaseBuff);
    tmpStrBuff := TSchInOutStringBuffer.Create(BaseBuff);

    iPacketSize := ChangeByteOrder(tmpStrBuff.ReadInt16(), False);
    iPacketCode := tmpStrBuff.ReadInt32();


    if iPacketCode > BrokenPacketOpCode then
    begin
      InternalError := True;
      Break;
    end;
    if iPacketSize > BrokenPacketSize then
    begin
      InternalError := True;
      Break;
    end;

    tmpStrBuff.Destroy();
    fClientDecoder.RestorePosition();

    if Length(fClientInputBuffer.StringBuffer) < (iPacketSize + 2) then break;
    // No full packet in here ... waiting for a full one.

    sCopyBuf := fClientInputBuffer.ReadBuffer(iPacketSize + 2);

    MyPacket := TSchClientWoWPacket.Create(sCopyBuf, fClientDecoder);

    if Assigned(fOnDumpPacket) then  fOnDumpPacket(False, MyPacket);

    MyPacket.Destroy();
    fClientInputBuffer.ClearUsedChunk();
  end;

  while Length(fServerInputBuffer.StringBuffer) >= 4 do
    // Server Side headers are 4 bytes
  begin

    BaseBuff := Copy(fServerInputBuffer.StringBuffer, 1, 4);
    fServerDecoder.SavePosition();

    BaseBuff := fServerDecoder.DecryptString(BaseBuff);
    tmpStrBuff := TSchInOutStringBuffer.Create(BaseBuff);

    iPacketSize := ChangeByteOrder(tmpStrBuff.ReadInt16(), False);
    iPacketCode := tmpStrBuff.ReadInt16();


    if iPacketCode > BrokenPacketOpCode then
    begin
      InternalError := True;
      Break;
    end;
    if iPacketSize > BrokenPacketSize then
    begin
      InternalError := True;
      Break;
    end;

    tmpStrBuff.Destroy();
    fServerDecoder.RestorePosition();

    if Length(fServerInputBuffer.StringBuffer) < (iPacketSize + 2) then break;
    // No full packet ih here ... waiting for a full one.

    sCopyBuf := fServerInputBuffer.ReadBuffer(iPacketSize + 2);

    MyPacket := TSchServerWoWPacket.Create(sCopyBuf, fServerDecoder);

    if Assigned(fOnDumpPacket) then  fOnDumpPacket(True, MyPacket);

    MyPacket.Destroy();
    fServerInputBuffer.ClearUsedChunk();
  end;

end;

procedure TSchWoWManager.SetCommKeyStart(const Value: Boolean);
begin
  fCommKeyStart := Value;
end;

procedure TSchWoWManager.SetKey(sKey: String);
begin
  fCommKey := sKey;
  fKeyInitialized := True;
  fFirstClientPacket := False;

  fClientDecoder.SetKey(fCommKey);
  fServerDecoder.SetKey(fCommKey);

end;

procedure TSchWoWManager.SlowKeyDetect(sRaw: String);
var
  wSize: Word;
  _a: array[0..1] of Char absolute wSize;

  iKeyPart1, iKeyPart2: Integer;

  sKeyPart: String;
  sHdr: String;

begin

  ASSERT(Length(sRaw) >= 6); // Must be sure we do not get fragmented packets.

  _a[0] := sRaw[1];
  _a[1] := sRaw[2];

  // We have the encrypted packet size now. Let's try and get
  // some key parts from it:

  sKeyPart := fClientDecoder.DecryptKey(wSize, ChangeByteOrder(
    Length(sRaw) - 2, True), iKeyPart1, iKeyPart2);


  // Now lets See if everything is fine with those Parts.

  if fCommKeyDecr[iKeyPart1 + 1] then
    ASSERT(fCommKey[iKeyPart1 + 1] = sKeyPart[1]);

  if fCommKeyDecr[iKeyPart2 + 1] then
    ASSERT(fCommKey[iKeyPart2 + 1] = sKeyPart[2]);

  fCommKey[iKeyPart1 + 1] := sKeyPart[1];
  fCommKey[iKeyPart2 + 1] := sKeyPart[2];

  fCommKeyDecr[iKeyPart1 + 1] := True;
  fCommKeyDecr[iKeyPart2 + 1] := True;

  // We have gathered another pieces of the key :))
  // Lets set the last PrevCT for next decrypt...
  sHdr := Copy(sRaw, 1, 6);
  fClientDecoder.DecryptString(sHdr);

end;

end.
