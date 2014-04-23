unit WoWPacket;

interface

uses StringBuffer, Utils;

type
  TDecoderPositionState = record
    fXCryptKeyPos: Integer;
    fXDecryptKeyPos: Integer;

    fXCryptByteCT: Byte;
    fXDecryptByteCT: Byte;
  end;

  TSchWoWDecoder = class(TObject)
  private
    fEncryptionKey: String;
    fKeyLength: Integer;

    fCurrentPos, fSavedPos:
    TDecoderPositionState;

  public

    constructor Create(AKey: String);
    procedure SetKey(AKey: String);

    function EncryptString(AString: String): String;
    function DecryptString(AString: String): String;

    function DecryptKey(wEncrSize, wGotSize: Word;
      var KeyPart1, KeyPart2: Integer): String;
    function DecryptKeyFast(wEncrSize, wGotSize: Word;
      iEncrOpCode, iGotOpCode: Integer;
      var KeyPart1, KeyPart2,
      KeyPart3, KeyPart4, KeyPart5, KeyPart6: Integer): String;

    procedure HardCodeEntryptPos();

    procedure SavePosition();
    procedure RestorePosition();

    property CurrentPos: TDecoderPositionState
      Read fCurrentPos Write fCurrentPos;
  end;


  TSchWoWPacket = class(TObject)
  private
    fStringBuffer: TSchInOutStringBuffer;

    fPacketSize: Integer;
    fPacketCmd: Integer;
    fPacketBody: TSchInOutStringBuffer;

    fDecoder: TSchWoWDecoder;

    procedure ExtractPktHeader(); virtual; abstract;

    function GetPacketOpcode: Integer; virtual;
    function GetPacketSize: Integer; virtual;
    function GetPacketBody: TSchInOutStringBuffer;

  public
    constructor Create(ABuffer: String; Decoder: TSchWoWDecoder);
    destructor Destroy(); override;

    property Size: Integer Read GetPacketSize;
    property OpCode: Integer Read GetPacketOpcode;
    property Body: TSchInOutStringBuffer Read GetPacketBody;
  end;

  TSchClientWoWPacket = class(TSchWoWPacket)
  private
    procedure ExtractPktHeader(); override;

  end;

  TSchServerWoWPacket = class(TSchWoWPacket)
  private
    procedure ExtractPktHeader(); override;

  end;

implementation

{ TSchWoWPacket }

constructor TSchWoWPacket.Create(ABuffer: String; Decoder: TSchWoWDecoder);
begin
  fStringBuffer := TSchInOutStringBuffer.Create(ABuffer);

  fPacketSize := 0;
  fDecoder := Decoder;
  fPacketCmd := 0;
  fPacketBody := nil;
end;

destructor TSchWoWPacket.Destroy;
begin
  fStringBuffer.Destroy();
  if fPacketBody <> nil then fPacketBody.Destroy();

  inherited;
end;

function TSchWoWPacket.GetPacketBody: TSchInOutStringBuffer;
var
  strBody: String;
begin
  if fPacketBody = nil then
  begin
    fStringBuffer.ClearUsedChunk();
    strBody := fStringBuffer.StringBuffer;

    fPacketBody := TSchInOutStringBuffer.Create(strBody);
  end;

  Result := fPacketBody;
end;

function TSchWoWPacket.GetPacketOpcode: Integer;
begin
  if fPacketSize = 0 then  ExtractPktHeader();

  Result := fPacketCmd;
end;

function TSchWoWPacket.GetPacketSize: Integer;
begin
  if fPacketSize = 0 then  ExtractPktHeader();

  Result := fPacketSize;
end;

{ TSchWoWDecoderBuffer }

constructor TSchWoWDecoder.Create(AKey: String);
begin
  SetKey(AKey);
end;


function TSchWoWDecoder.DecryptKey(wEncrSize, wGotSize: Word;
  var KeyPart1, KeyPart2: Integer): String;
var
  aEncr: array [0..1] of Byte absolute wEncrSize;
  aGot: array [0..1] of Byte absolute wGotSize;

  tXK: Byte;
  tBt: Byte;
  iPos: Integer;
begin
  Result := '';

  {----}
  iPos := fCurrentPos.fXDecryptKeyPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (aEncr[0] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = aGot[0] then Break;
  end;

  Result := Char(tXK);
  KeyPart1 := iPos;

  {=====}

  fCurrentPos.fXDecryptByteCT := aEncr[0];
  iPos := iPos + 1;
  iPos := iPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (aEncr[1] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = aGot[1] then Break;
  end;

  Result := Result + Char(tXK);
  KeyPart2 := iPos;
end;

function TSchWoWDecoder.DecryptKeyFast(wEncrSize, wGotSize: Word;
  iEncrOpCode, iGotOpCode: Integer;
  var KeyPart1, KeyPart2, KeyPart3, KeyPart4, KeyPart5, KeyPart6: Integer): String;
var
  aEncr: array [0..1] of Byte absolute wEncrSize;
  aGot: array [0..1] of Byte absolute wGotSize;

  bEncr: array [0..3] of Byte absolute iEncrOpCode;
  bGot: array [0..3] of Byte absolute iGotOpCode;

  tXK: Byte;
  tBt: Byte;
  iPos: Integer;
begin
  Result := '';

  { ==== Size[0] }
  iPos := fCurrentPos.fXDecryptKeyPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (aEncr[0] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = aGot[0] then Break;
  end;

  Result := Char(tXK);
  KeyPart1 := iPos;

  {===== Size[1] }

  fCurrentPos.fXDecryptByteCT := aEncr[0];
  iPos := iPos + 1;
  iPos := iPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (aEncr[1] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = aGot[1] then Break;
  end;

  Result := Result + Char(tXK);
  KeyPart2 := iPos;

  {===== OpCode[0]}
  fCurrentPos.fXDecryptByteCT := aEncr[1];
  iPos := iPos + 1;
  iPos := iPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (bEncr[0] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = bGot[0] then Break;
  end;

  Result := Result + Char(tXK);
  KeyPart3 := iPos;

  {===== OpCode[1]}
  fCurrentPos.fXDecryptByteCT := bEncr[0];
  iPos := iPos + 1;
  iPos := iPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (bEncr[1] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = bGot[1] then Break;
  end;

  Result := Result + Char(tXK);
  KeyPart4 := iPos;

  {===== OpCode[2]}
  fCurrentPos.fXDecryptByteCT := bEncr[1];
  iPos := iPos + 1;
  iPos := iPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (bEncr[2] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = bGot[2] then Break;
  end;

  Result := Result + Char(tXK);
  KeyPart5 := iPos;

  {===== OpCode[3]}
  fCurrentPos.fXDecryptByteCT := bEncr[2];
  iPos := iPos + 1;
  iPos := iPos mod 40;

  for tXK := 0 to 255 do
  begin
    tBt := (bEncr[3] - fCurrentPos.fXDecryptByteCT) xor tXK;
    if tBt = bGot[3] then Break;
  end;

  Result := Result + Char(tXK);
  KeyPart6 := iPos;

end;

function TSchWoWDecoder.DecryptString(AString: String): String;
var
  iI: Integer;
  tBt: Byte;
begin
  Result := '';

  if fKeyLength = 0 then
  begin
    Result := AString;
    fCurrentPos.fXDecryptByteCT := Byte(AString[Length(AString)]);
    fCurrentPos.fXDecryptKeyPos := fCurrentPos.fXDecryptKeyPos + Length(AString);
    Exit;
  end;

  for iI := 1 to Length(AString) do
  begin
    fCurrentPos.fXDecryptKeyPos := fCurrentPos.fXDecryptKeyPos mod fKeyLength;
    tBt := (Byte(AString[iI]) - fCurrentPos.fXDecryptByteCT) xor
      Byte(fEncryptionKey[fCurrentPos.fXDecryptKeyPos + 1]);
    Inc(fCurrentPos.fXDecryptKeyPos);

    fCurrentPos.fXDecryptByteCT := Byte(AString[iI]);
    Result := Result + Char(tBt);
  end;
end;

function TSchWoWDecoder.EncryptString(AString: String): String;
var
  iI: Integer;
  tBt: Byte;
begin
  Result := '';

  if fKeyLength = 0 then
  begin
    Result := AString;
    fCurrentPos.fXCryptByteCT := Byte(AString[Length(AString)]);
    fCurrentPos.fXCryptKeyPos := fCurrentPos.fXCryptKeyPos + Length(AString);
    Exit;
  end;

  for iI := 1 to Length(AString) do
  begin
    fCurrentPos.fXCryptKeyPos := fCurrentPos.fXCryptKeyPos mod fKeyLength;
    tBt := (Byte(AString[iI]) xor
      Byte(fEncryptionKey[fCurrentPos.fXCryptKeyPos + 1])) + fCurrentPos.fXCryptByteCT;
    Inc(fCurrentPos.fXCryptKeyPos);

    fCurrentPos.fXCryptByteCT := tBt;
    Result := Result + Char(tBt);
  end;

end;

procedure TSchWoWDecoder.HardCodeEntryptPos;
begin
  fCurrentPos.fXCryptKeyPos := fCurrentPos.fXDecryptKeyPos;
  fCurrentPos.fXCryptByteCT := fCurrentPos.fXDecryptByteCT;
end;

procedure TSchWoWDecoder.RestorePosition;
begin
  fCurrentPos := fSavedPos;
end;

procedure TSchWoWDecoder.SavePosition;
begin
  fSavedPos := fCurrentPos;
end;

procedure TSchWoWDecoder.SetKey(AKey: String);
begin
  fEncryptionKey := AKey;
  fKeyLength := Length(AKey);

  FillChar(fCurrentPos, SizeOf(fCurrentPos), 0);
  FillChar(fSavedPos, SizeOf(fCurrentPos), 0);
end;

{ TSchClientWoWPacket }

procedure TSchClientWoWPacket.ExtractPktHeader;
var
  BaseBuff: String;
  tmpStrBuff: TSchInOutStringBuffer;
begin
  BaseBuff := fStringBuffer.ReadBuffer(6); // Client Sends 6 bytes aways as header.
  BaseBuff := fDecoder.DecryptString(BaseBuff);

  tmpStrBuff := TSchInOutStringBuffer.Create(BaseBuff);

  // Client Header Structure
  fPacketSize := ChangeByteOrder(tmpStrBuff.ReadInt16(), False);
  fPacketCmd := tmpStrBuff.ReadInt32();

  tmpStrBuff.Destroy();
end;

{ TSchServerWoWPacket }

procedure TSchServerWoWPacket.ExtractPktHeader;
var
  BaseBuff: String;
  tmpStrBuff: TSchInOutStringBuffer;
begin
  BaseBuff := fStringBuffer.ReadBuffer(4); // Server Sends 4 bytes aways as header.
  BaseBuff := fDecoder.DecryptString(BaseBuff);

  tmpStrBuff := TSchInOutStringBuffer.Create(BaseBuff);

  // Client Header Structure
  fPacketSize := ChangeByteOrder(tmpStrBuff.ReadInt16(), False);
  fPacketCmd := tmpStrBuff.ReadInt16();

  tmpStrBuff.Destroy();
end;

end.
