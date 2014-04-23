unit MainDecoder;

interface

uses Classes, Debug,
  StringBuffer, SysUtils, Utils, Version,
  Windows, WorldDecoder,
  WowManager, WoWOpCodes;

type
  TSchMainDecoder = class(TObject)
  private
    fServerBuffer, fClientBuffer:
    TSchInOutStringBuffer;

    fRealms: TStrings;
    fRealmsName: TStrings;

    fRealmInject: String;
    fB, fN, fA: String;

    fUserName: String;

    fWoWManager: TSchWoWManager;
    fRealmPart: Boolean;

    fInternalError: Boolean;

    fExternalIP: String;
    fExternalPort: Integer;

    function CanSkipClientUnusefulPackets(): Boolean;
    function CanSkipServerUnusefulPackets(): Boolean;

    function CanExtractFullRealmList(): Boolean;
    procedure ExtractFullRealmList();
  public
    constructor Create(bUseFastKey: Boolean);
    destructor Destroy(); override;

    procedure AddServerSentRawData(sData: String);
    procedure AddClientSentRawData(sData: String);

    procedure AddWSServerSentRawData(sData: String);
    procedure AddWSClientSentRawData(sData: String);

    procedure ResetDecoder(bKeyMethod: Boolean);

    function PartialRealmList(): Boolean;
    function FullRealmList(): Boolean;

    function GeneratedRealmList(): String;

    function KeyFailed(): Boolean;
    function VersionFailed(): Boolean;

    property ExternalIP: String
      Read fExternalIP Write fExternalIP;
    property ExternalPort: Integer
      Read fExternalPort Write fExternalPort;

    property RealmNames: TStrings Read fRealmsName;
    property Realms: TStrings Read fRealms;
    property WoWManager: TSchWoWManager Read fWoWManager;
    property ClientName: String Read fUserName;
  end;

implementation

uses Globals, Main;

{ TSchMainDecoder }

procedure TSchMainDecoder.AddClientSentRawData(sData: String);
begin
  fClientBuffer.AddChunk(sData);

  while CanSkipClientUnusefulPackets() do fClientBuffer.ClearUsedChunk();

end;

procedure TSchMainDecoder.AddServerSentRawData(sData: String);
begin

  fServerBuffer.AddChunk(sData);

  while CanSkipServerUnusefulPackets() do fServerBuffer.ClearUsedChunk();
  if CanExtractFullRealmList() then
  begin
    ExtractFullRealmList();
    fServerBuffer.ClearUsedChunk();
  end;

end;

procedure TSchMainDecoder.AddWSClientSentRawData(sData: String);
begin

  fWoWManager.AddClientSentRawData(sData);
  fInternalError := fWoWManager.InternalError;

end;

procedure TSchMainDecoder.AddWSServerSentRawData(sData: String);
begin

  WowManager.AddServerSentRawData(sData);
  fInternalError := fWoWManager.InternalError;

end;

function TSchMainDecoder.CanExtractFullRealmList: Boolean;
var
  cCmd: Byte;
  Sz, pSz: Word;
begin

  Result := False;

  if fServerBuffer.Size < 3 then                            { Not Full Packet }
  begin
    Exit;
  end;

  fServerBuffer.SavePosition();

  cCmd := fServerBuffer.ReadInt8();
  Sz := fServerBuffer.ReadInt16();
  pSz := fServerBuffer.Size;

  fServerBuffer.RestorePosition();

  fRealmPart := False;

  if cCmd <> CMD_REALM_LIST then
    { If it's not our packet, ignore }
  begin
    Exit;
  end;

  fRealmPart := True;

  if Sz <= (pSz - 3) then Result := True;

end;

function TSchMainDecoder.CanSkipClientUnusefulPackets: Boolean;
var
  cCmd: Byte;
  Sz, i: Word;
  Ver: array[1..3] of Byte;
  CliVer: String;
begin
  Result := False;

  if fClientBuffer.Size < 1 then     { Not enough data to process }
  begin
    Exit;
  end;

  { Etracting the Command Id and restore pointer state }
  fClientBuffer.SavePosition();
  cCmd := fClientBuffer.ReadInt8();
  fClientBuffer.RestorePosition();

  { CMD_AUTH_LOGON_CHALLENGE || CMD_AUTH_RECONNECT_CHALLENGE }
  if (cCmd = CMD_AUTH_LOGON_CHALLENGE) or (cCmd = CMD_AUTH_RECONNECT_CHALLENGE) then
  begin
    if fClientBuffer.Size < 4 then              { Still not enough data }
    begin
      Exit;
    end;

    fClientBuffer.SavePosition();
    fClientBuffer.ReadInt16(); { Skip Command and an Unk. }
    Sz := fClientBuffer.ReadInt16();
    fClientBuffer.RestorePosition();

    if fClientBuffer.Size < Sz + 4 then          { Not a full packet ... still waiting }
    begin
      Exit;
    end;

    { Skipping ... }

    for i := 1 to 8 do fClientBuffer.ReadInt8();

    Ver[1] := fClientBuffer.ReadInt8();
    Ver[2] := fClientBuffer.ReadInt8();
    Ver[3] := fClientBuffer.ReadInt8();

    Sz := Sz - (4 + 3);

    fUserName := '';
    for i := 1 to 22 do
    begin
      fClientBuffer.ReadInt8();
      Dec(Sz);
    end;

    Dec(Sz);

    for i := 1 to fClientBuffer.ReadInt8() do
    begin
      fUserName := fUserName + fClientBuffer.ReadChar();
      Dec(Sz);
    end;

    { Read the leftovers }
    if Sz > 0 then  for i := 1 to Sz do fClientBuffer.ReadInt8();

    CliVer := IntToStr(Ver[1]) + '.' + IntToStr(Ver[2]) + '.' + IntToStr(Ver[3]);

    Sz := 0;
    for i := 1 to WoWClients do if WoWClientsVer[i] = CliVer then Sz := 1;

    if Sz = 0 then
    begin
      Main.BFGMain.LogLSError('Incompatible Client Version [' + CliVer + ']');
      fInternalError := True;

      Exit;
    end;

    Main.BFGMain.LogLSSuccess('Client Name is [' + fUserName + ']');

    Main.BFGMain.LogLSSuccess('Client Version is [' + CliVer + ']');
    Main.BFGMain.LogLS('Skipping CMD_AUTH_LOGON_CHALLENGE (Client).');
  end;

  { CMD_AUTH_LOGON_PROOF || CMD_AUTH_RECONNECT_PROOF }
  if (cCmd = CMD_AUTH_LOGON_PROOF) or (cCmd = CMD_AUTH_RECONNECT_PROOF) then
  begin
    if fClientBuffer.Size < 75 then             { Not Full Packet } {in 1.10.X it was 74}
    begin
      Exit;
    end;

    fA := '';

    fClientBuffer.ReadInt8();

    for i := 1 to 32 do fA := fA + fClientBuffer.ReadChar();
    for i := 1 to 42 do fClientBuffer.ReadInt8();

    Main.BFGMain.LogLSSuccess('A = "' + ToHexRep(fA) + '"');
    Main.BFGMain.LogLS('Skipping CMD_AUTH_LOGON(RECONNECT)_PROOF (Client).');
  end;

  { CMD_REALM_LIST }
  if (cCmd = CMD_REALM_LIST) then
  begin
    if fClientBuffer.Size < 5 then               { Not Full Packet }
    begin
      Exit;
    end;

    for i := 1 to 5 do fClientBuffer.ReadInt8();

    Main.BFGMain.LogLS('Skipping CMD_REALM_LIST (Client).');
  end;

  { CMD_XFER_ACCEPT || CMD_XFER_CANCEL }
  if (cCmd = CMD_XFER_ACCEPT) or (cCmd = CMD_XFER_CANCEL) then
  begin
    fClientBuffer.ReadInt8();

    Main.BFGMain.LogLS('Skipping CMD_XFER_ACCEPT(CANCEL) (Client).');
  end;

  { CMD_AUTH_UNKNOWN }
  if (cCmd = CMD_AUTH_UNKNOWN) then
  begin
    if fClientBuffer.Size < 8 then                  { Not Full Packet }
    begin
      Exit;
    end;

    for i := 1 to 8 do fClientBuffer.ReadInt8();

    Main.BFGMain.LogLS('Skipping CMD_AUTH_UNKNOWN (Client).');
  end;

  { CMD_XFER_RESUME }
  if (cCmd = CMD_XFER_RESUME) then
  begin
    if fClientBuffer.Size < 10 then                  { Not Full Packet }
    begin
      Exit;
    end;

    for i := 1 to 10 do fClientBuffer.ReadInt8();

    Main.BFGMain.LogLS('Skipping CMD_XFER_RESUME (Client).');
  end;

end;


function TSchMainDecoder.CanSkipServerUnusefulPackets: Boolean;
var
  cCmd: Byte;
  Sz: Word;
begin
  Result := False;

  if fServerBuffer.Size < 1 then                           { Not Full Packet }
  begin
    Exit;
  end;

  fServerBuffer.SavePosition();
  cCmd := fServerBuffer.ReadInt8();
  fServerBuffer.RestorePosition();

  if (cCmd = CMD_AUTH_LOGON_CHALLENGE) then
  begin
    if fServerBuffer.Size < 2 then                           { Not Full Packet }
    begin
      Exit;
    end;

    fServerBuffer.SavePosition();
    fServerBuffer.ReadInt8();
    fServerBuffer.ReadInt8(); //added


    if fServerBuffer.ReadInt8() <> 0 then
    begin
      Main.BFGMain.LogLSError('Corrupted CMD_AUTH_LOGON_CHALLENGE.');
      fServerBuffer.RestorePosition();
      fServerBuffer.ReadInt16();

      Result := True;

      Exit;
    end;

    fB := '';
    fN := '';

    if fServerBuffer.Size < 118 then                           { Not Full Packet }
    begin
      fServerBuffer.RestorePosition();

      Exit;
    end;

    fServerBuffer.RestorePosition();

    fServerBuffer.ReadInt8();
    fServerBuffer.ReadInt8();
    fServerBuffer.ReadInt8();

    for Sz := 1 to 32 do fB := fB + fServerBuffer.ReadChar();

    fServerBuffer.ReadInt8();
    fServerBuffer.ReadInt8();
    fServerBuffer.ReadInt8();

    for Sz := 1 to 32 do fN := fN + fServerBuffer.ReadChar();
    for Sz := 1 to 49 do fServerBuffer.ReadInt8();

    Main.BFGMain.LogLSSuccess('N = "' + ToHexRep(fN) + '"');
    Main.BFGMain.LogLSSuccess('B = "' + ToHexRep(fB) + '"');

    Main.BFGMain.LogLSSuccess('Skipped CMD_AUTH_LOGON_CHALLENGE.');
    Result := True;

    Exit;
  end;

  { CMD_AUTH_LOGON_PROOF }
  if (cCmd = CMD_AUTH_LOGON_PROOF) then
  begin

    if fServerBuffer.Size < 2 then                           { Not Full Packet }
    begin
      Exit;
    end;

    fServerBuffer.SavePosition();

    fServerBuffer.ReadInt8();

    if fServerBuffer.ReadInt8 <> 0 then
    begin
      Main.BFGMain.LogLSError('Corrupted/Incompatible CMD_AUTH_LOGON_PROOF.');
      fServerBuffer.RestorePosition();
      fServerBuffer.ReadInt16();

      Result := True;

      Exit;
    end;

    fServerBuffer.RestorePosition();

    if fServerBuffer.Size < 28 then                                    { Not Full Packet }
    begin
      Exit;
    end;

    Main.BFGMain.LogLSSuccess('Skipped CMD_AUTH_LOGON_PROOF.');
    for Sz := 1 to 28 do fServerBuffer.ReadInt8();

    Result := True;

    Exit;
  end;

  { CMD_XFER_INITIATE }
  if (cCmd = CMD_XFER_INITIATE) then
  begin
    if fServerBuffer.Size < 32 then                           { Not Full Packet }
    begin
      Exit;
    end;

    Main.BFGMain.LogLS('Skipping CMD_XFER_INITIATE (Server).');
    for Sz := 1 to 32 do fServerBuffer.ReadInt8();

    Result := True;

    Exit;
  end;

end;


constructor TSchMainDecoder.Create(bUseFastKey: Boolean);
begin

  fServerBuffer := TSchInOutStringBuffer.Create('');
  fClientBuffer := TSchInOutStringBuffer.Create('');
  fRealms := TStringList.Create();
  fRealmsName := TStringList.Create();
  fWoWManager := nil;
  fUserName := '';

  ResetDecoder(bUseFastKey);

end;

destructor TSchMainDecoder.Destroy;
begin

  fServerBuffer.Destroy();
  fClientBuffer.Destroy();
  fRealms.Destroy();
  fRealmsName.Destroy();

  if Assigned(fWoWManager) then  fWoWManager.Free();

end;

procedure TSchMainDecoder.ExtractFullRealmList;
var
  bRealms: Integer;
  i: Integer;
  rm: String;

  ct: Char;
  ci: Integer;
  cu: Word;
  uf: Single;

  tpSB, oSB: TSchInOutStringBuffer;

begin

  tpSB := TSchInOutStringBuffer.Create('');
  oSB := TSchInOutStringBuffer.Create('');

  fRealms.Clear();
  fRealmsName.Clear();

  ct := fServerBuffer.ReadChar();
  fServerBuffer.ReadInt16();

  ci := fServerBuffer.ReadInt32();

  tpSB.WriteChar(ct); //modificat

  oSB.WriteInt32(ci);

  bRealms := fServerBuffer.ReadInt16();

  oSB.WriteInt16(bRealms);

  Main.BFGMain.LogLS('Server Realms : ' + IntToStr(bRealms));

  for i := 0 to bRealms - 1 do
  begin

    ci := fServerBuffer.ReadInt16();
    ct := fServerBuffer.ReadChar();

    rm := fServerBuffer.ReadString();
    fRealmsName.Add(UTF8Decode(rm));

    oSB.WriteInt16(ci);
    oSB.WriteChar(ct);

    (*oSB.WriteString( 'BFG Sniffer ' + ToolVersion  );*)
    oSB.WriteString(rm);

    Main.BFGMain.LogLS('(' + IntToStr(i) + ') Realm : "' + Utf8ToAnsi(rm) + '"');

    rm := fServerBuffer.ReadString();
    oSB.WriteString(fExternalIP + ':' + IntToStr(fExternalPort));
    (*oSB.WriteString(rm);*)

    fRealms.Add(rm);

    uf := fServerBuffer.ReadFloat();
    ct := fServerBuffer.ReadChar();
    oSB.WriteFloat(uf);
    oSB.WriteChar(ct);

    ct := fServerBuffer.ReadChar();
    oSB.WriteChar(ct);

    ct := fServerBuffer.ReadChar();
    oSB.WriteChar(ct);
  end;

  Main.BFGMain.LogLSSuccess('All realms redirected to "' + fExternalIP +
    ':' + IntToStr(fExternalPort) + '"');

  cu := fServerBuffer.ReadInt16();
  oSB.WriteInt16(cu);

  tpSB.WriteInt16(oSB.Size);
  tpSB.AddChunk(oSB.StringBuffer);

  oSB.Free();
  fRealmInject := tpSB.StringBuffer;
  tpSB.Free();

end;


function TSchMainDecoder.FullRealmList: Boolean;
begin
  Result := (Length(fRealmInject) > 0);
end;

function TSchMainDecoder.GeneratedRealmList: String;
begin
  Result := fRealmInject;
  fRealmInject := '';
end;

function TSchMainDecoder.KeyFailed: Boolean;
begin
  Result := fInternalError;
end;

function TSchMainDecoder.PartialRealmList: Boolean;
begin
  Result := (fRealmPart) and (Length(fRealmInject) = 0);
end;

procedure TSchMainDecoder.ResetDecoder(bKeyMethod: Boolean);
begin

  fServerBuffer.StringBuffer := '';
  fClientBuffer.StringBuffer := '';

  fRealms.Clear();
  fRealmsName.Clear();

  fRealmInject := '';
  fB := '';
  fN := '';
  fA := '';

  fInternalError := False;
  fRealmPart := False;

  if Assigned(fWoWManager) then fWoWManager.Free();
  fWoWManager := TSchWoWManager.Create();

  fWoWManager.OnDumpPacket := WorldPacketsDecoder.DecodePacket;

  fWoWManager.FastKey := bKeyMethod;

end;

function TSchMainDecoder.VersionFailed: Boolean;
begin
  Result := fInternalError;
end;

end.
