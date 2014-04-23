unit DebugUFExport;

interface

uses Classes, FileParser, GenericUFExport, SysUtils, Utils;

type
  TSchDebugUFExporter = class(TSchGenericUFExporter)
  protected
    function ExporterName(): String; override;

  public
    procedure InsertHeader(sBuild, sVersion: String; iFileSize, iUFs: Cardinal);
      override;
    procedure InsertFooter(); override;

    procedure ProcessUpdateField(cUF: TSchUpdateField); override;
  end;

implementation

{ TSchGenericUFExporter }

function TSchDebugUFExporter.ExporterName: String;
begin
  Result := 'Debug (not useful)';
end;

procedure TSchDebugUFExporter.InsertFooter;
begin
  AddString('<-- Debug -->');
end;

procedure TSchDebugUFExporter.InsertHeader(sBuild, sVersion: String;
  iFileSize, iUFs: Cardinal);
begin
  AddString('<-- WoW Version: ' + sVersion + ', Build: ' + sBuild + ' -->');
  AddString('<-- Size:' + IntToStr(iFileSize) + ' bytes, UFs: ' +
    IntToStr(iUFs) + ' -->');
  AddString('<-- Debug -->');
end;

procedure TSchDebugUFExporter.ProcessUpdateField(cUF: TSchUpdateField);
var
  sPlus: String;
begin
  if cUF.sStart <> '' then  sPlus := ' + ' + cUF.sStart
  else
    sPlus := '';

  AddString(cUF.sName + ' = ' + IntToStr(cUF.iNr) + sPlus + ' at 0x' +
    IntToHex(cUF.uAddr, 8) + ' with ' + IntToStr(cUF._1) +
    '; Type:' + IntToStr(cUF.iSize) + '; Size:' + IntToStr(cUF.iType));
end;

initialization
  TSchDebugUFExporter.Create();

end.
