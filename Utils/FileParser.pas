unit FileParser;

interface

uses Classes, SysUtils, Windows;

type
  TSchUpdateField = record
    uAddr: Cardinal;
    sName: String;
    sStart: String;
    iNr: Cardinal;
    _1: Cardinal;

    iSize, iType: Cardinal;

    bFake: Boolean;
  end;

  TSchFileParser = class(TObject)
  private
    fFile: String;
    fPointer: Longword;
    fFileName: String;

    fFields: array of TSchUpdateField;
    fPrevPref: String;

    fBuild: String;
    fVersion: String;
    fFileSize: Cardinal;

    fFakes: Integer;

    function GetUF(Index: Integer): TSchUpdateField;
    function GetUFCount: Integer;

    procedure AddUF(sName: String; iAddr: Cardinal);
    function UpdateUF(iAddr, iNr, _1, _2, _3: Cardinal): Boolean;

    function IntToRString(i: Cardinal): String;
  public
    constructor Create(fName: String);
    destructor Destroy(); override;

    procedure Load();
    function SeekToString(sStr: String): Boolean;

    function ReadBackString(): String; overload;
    function ReadBackString(sEnd: String): String; overload;
    function ReadBufferedString(iC: Integer): String;
    function ReadBackInt(): Cardinal;
    function ReadFwdInt(): Cardinal;

    function ProcessWoWFile(): Boolean;

    property UF[Index: Integer]: TSchUpdateField Read GetUF;
    property UFCount: Integer Read GetUFCount;
    property Build: String Read fBuild;
    property Version: String Read fVersion;
    property FileSize: Cardinal Read fFileSize;
  end;

implementation

uses GenericUFExport;

{ TSchFileParser }

procedure TSchFileParser.AddUF(sName: String; iAddr: Cardinal);
var
  i: Integer;
  sPrefix: String;
begin
  i := Length(fFields);
  SetLength(fFields, i + 1);

  sPrefix := GetUFPrefix(sName);

  if (fPrevPref <> sPrefix) then
  begin
    Inc(fFakes);
    fFields[i].sName := fPrevPref + '_END';
    fFields[i].uAddr := 0;
    fFields[i].iNr := 0;
    fFields[i].sStart := '';

    if i > 0 then  fFields[i].sStart := fFields[i - 1].sName;

    fFields[i].bFake := True;

    if sName = '' then Exit; // To add the last fake end.


    i := Length(fFields);
    SetLength(fFields, i + 1);
  end;

  begin

    fFields[i].sName := sName;
    fFields[i].uAddr := iAddr + $400000; { Base start }
    fFields[i].bFake := False;

    if sPrefix = 'OBJECT' then  fFields[i].sStart := '';

    if sPrefix = 'ITEM' then  fFields[i].sStart := 'OBJECT_END';

    if sPrefix = 'CONTAINER' then  fFields[i].sStart := 'ITEM_END';

    if sPrefix = 'UNIT' then  fFields[i].sStart := 'OBJECT_END';

    if sPrefix = 'PLAYER' then  fFields[i].sStart := 'UNIT_END';

    if sPrefix = 'GAMEOBJECT' then  fFields[i].sStart := 'OBJECT_END';

    if sPrefix = 'DYNAMICOBJECT' then  fFields[i].sStart := 'OBJECT_END';

    if sPrefix = 'CORPSE' then  fFields[i].sStart := 'OBJECT_END';
  end;

  fPrevPref := sPrefix;

end;

constructor TSchFileParser.Create(fName: String);
begin
  fFile := '';
  fFields := nil;
  fPointer := 1;
  fFileName := fName;
end;

destructor TSchFileParser.Destroy;
begin
  fFile := '';
  fFields := nil;
end;

function TSchFileParser.GetUF(Index: Integer): TSchUpdateField;
begin
  Result := fFields[Index];
end;

function TSchFileParser.GetUFCount: Integer;
begin
  Result := Length(fFields);
end;

function TSchFileParser.IntToRString(i: Cardinal): String;
var
  c: array[0..3] of Char absolute i;
begin
  Result := c[0] + c[1] + c[2] + c[3];
end;

procedure TSchFileParser.Load;
var
  fStream: TFileStream;
begin
  fStream := TFileStream.Create(fFileName, fmOpenRead);
  SetLength(fFile, fStream.Size);

  fStream.ReadBuffer(fFile[1], fStream.Size);
  fStream.Destroy();
end;

function TSchFileParser.ProcessWoWFile: Boolean;
const
  StartField = 'OBJECT_FIELD_GUID' + #0;
  EndField   = 'CORPSE_FIELD_PAD';
  BuildStart = 'RELEASE_BUILD' + #0;

var
  sFieldName: String;
  x: Integer;

  _1, _2, _3, iNr, uAddr: Cardinal;
begin
  Result := False;

  { Seek to Build Number }

  SeekToString(BuildStart);
  Dec(fPointer);
  fVersion := ReadBackString();
  fBuild := ReadBackString();
  fFakes := 0;
  fFileSize := Length(fFile);

  for x := 1 to Length(fBuild) do if not (fBuild[x] in ['0'..'9']) then exit;

  { Seek to first UPD_FLD }
  if not SeekToString(StartField) then Exit;
  Inc(fPointer, Length(StartField));

  fPrevPref := 'OBJECT';

  { Extract all UPDs }
  while True do
  begin
    sFieldName := ReadBackString(EndField);
    if (Length(sFieldName) > 50) or (Length(sFieldName) < 5) then
    begin
      Exit;
    end;

    AddUF(sFieldName, fPointer); { -1 not required ;) }

    if sFieldName = EndField then
    begin
      break;
    end;
  end;

  AddUF('', 0); { Add last UF }

  if UFCount < 200 then Exit; { Sure an error }

  { Find the UPDF table start }

  if not SeekToString(                   { Seek to first (known) type UPDF }
    IntToRString(UF[0].uAddr) + IntToRString(0) + IntToRString(
    2) + IntToRString(4) + IntToRString(1)) then Exit;

  x := UFCount - 1 - fFakes;

  { Extract all UF Data }
  while True do
  begin
    uAddr := ReadFwdInt();
    while (uAddr = 0) do uAddr := ReadFwdInt();

    iNr := ReadFwdInt();
    _3 := ReadFwdInt();
    _2 := ReadFwdInt();
    _1 := ReadFwdInt();

    if not UpdateUF(uAddr, iNr, _1, _2, _3) then
    begin
      Result := False;
      Exit;
    end;

    if x = 0 then break;

    Dec(x);
  end;

  Result := True;
end;

function TSchFileParser.ReadBackInt: Cardinal;
var
  i: Cardinal;
  c: array[0..3] of Char absolute i;
begin
  Dec(fPointer, 4);
  c[0] := fFile[fPointer + 0];
  c[1] := fFile[fPointer + 1];
  c[2] := fFile[fPointer + 2];
  c[3] := fFile[fPointer + 3];

  Result := i;
end;

function TSchFileParser.ReadBackString(sEnd: String): String;
begin
  Result := '';
  while fFile[fPointer] = #0 do Dec(fPointer);

  while (fFile[fPointer] <> #0) and (Result <> sEnd) do
  begin
    Result := fFile[fPointer] + Result;
    Dec(fPointer);
  end;
end;

function TSchFileParser.ReadBackString: String;
begin
  Result := '';
  while fFile[fPointer] = #0 do Dec(fPointer);

  while fFile[fPointer] <> #0 do
  begin
    Result := fFile[fPointer] + Result;
    Dec(fPointer);
  end;
end;

function TSchFileParser.ReadBufferedString(iC: Integer): String;
var
  i: Integer;
begin
  SetLength(Result, iC);
  for i := 1 to iC do
  begin
    Result[i] := fFile[fPointer];
    Inc(fPointer);
  end;
end;

function TSchFileParser.ReadFwdInt: Cardinal;
var
  i: Cardinal;
  c: array[0..3] of Char absolute i;
begin
  c[0] := fFile[fPointer + 0];
  c[1] := fFile[fPointer + 1];
  c[2] := fFile[fPointer + 2];
  c[3] := fFile[fPointer + 3];

  Inc(fPointer, 4);

  Result := i;
end;

function TSchFileParser.SeekToString(sStr: String): Boolean;
var
  i: Integer;
begin
  i := Pos(sStr, fFile);
  if i < 1 then
  begin
    Result := False;
    exit;
  end;

  fPointer := i;
  Result := True;
end;

function TSchFileParser.UpdateUF(iAddr, iNr, _1, _2, _3: Cardinal): Boolean;
var
  i: Integer;
begin
  Result := True;

  for i := 0 to UFCount - 1 do
  begin
    if fFields[i].uAddr = iAddr then
    begin
      fFields[i].iNr := iNr;
      fFields[i]._1 := _1;
      fFields[i].iSize := _3;
      fFields[i].iType := _2;

      if (i < (UFCount - 1)) and (fFields[i + 1].sStart = fFields[i].sName) then
        fFields[i + 1].iNr := fFields[i].iSize;

      Exit;
    end;
  end;

  Result := False;
end;

end.
