unit GenericUFExport;

interface

uses Classes, FileParser, SysUtils, Utils;

type
  TSchGenericUFExporter = class(TObject)
  private
    fLogString: String;

  protected
    procedure AddString(sTxt: String; bNewLine: Boolean = True);
    function ExporterName(): String; virtual; abstract;
  public
    constructor Create();

    procedure InsertHeader(sBuild, sVersion: String; iFileSize, iUFs: Cardinal);
      virtual; abstract;
    procedure InsertFooter(); virtual; abstract;

    procedure ProcessUpdateField(cUF: TSchUpdateField); virtual; abstract;
    procedure Save(sFile: String; bWinStyleNewLine: Boolean); virtual;
  end;

function GetExportersList(): TStrings;

{ Utils }
function StringFillTo(sStr: String; iMaxCnt: Integer): String;
function GetUFPrefix(sUF: String): String;
function UFTypeToName(iType: Cardinal): String;

implementation

var
  cExporters: TStrings;

function GetExportersList(): TStrings;
begin
  Result := cExporters;
end;

function StringFillTo(sStr: String; iMaxCnt: Integer): String;
begin
  if Length(sStr) >= iMaxCnt then
  begin
    Result := sStr;
    Exit;
  end;

  SetLength(Result, iMaxCnt);
  FillChar(Result[1], iMaxCnt, #32);
  Move(sStr[1], Result[1], Length(sStr));
end;

function GetUFPrefix(sUF: String): String;
begin
  if sUF = 'OBJECT_FIELD_CREATED_BY' then  Result := 'GAMEOBJECT'
  else
    Result := Copy(sUF, 1, Pos('_', sUF) - 1);
end;

function UFTypeToName(iType: Cardinal): String;
begin
  case iType of
    5: Result := 'bytes';
    4: Result := 'guid';
    3: Result := 'float';
    2: Result := 'bytes';
    1: Result := 'uint32';
    else
      Result := 'unknown ' + IntToStr(iType);
  end;
end;

{ TSchGenericUFExporter }

procedure TSchGenericUFExporter.AddString(sTxt: String; bNewLine: Boolean);
begin
  fLogString := fLogString + sTxt;

  if bNewLine then  fLogString := fLogString + #13#10;

end;

constructor TSchGenericUFExporter.Create();
begin

  fLogString := '';
  cExporters.AddObject(ExporterName(), Self);
end;

procedure TSchGenericUFExporter.Save(sFile: String; bWinStyleNewLine: Boolean);
var
  fs: TFileStream;
  sT: String;
begin
  if not bWinStyleNewLine then  sT :=
      StringReplace(fLogString, #13#10, #10, [rfReplaceAll])
  else
    sT := fLogString;

  fs := TFileStream.Create(sFile, fmOpenWrite);
  fs.WriteBuffer(sT[1], Length(sT));

  fs.Free();
end;

initialization
  cExporters := TStringList.Create();

end.
