unit CStyleUFExport;

interface

uses Classes, FileParser, GenericUFExport, SysUtils, Utils, Version;

type
  TSchCStyleUFExporter = class(TSchGenericUFExporter)
  protected
    fPrevPrefix: String;

    function ExporterName(): String; override;

  public
    procedure InsertHeader(sBuild, sVersion: String; iFileSize, iUFs: Cardinal);
      override;
    procedure InsertFooter(); override;

    procedure ProcessUpdateField(cUF: TSchUpdateField); override;
  end;

implementation

{ TSchGenericUFExporter }

function TSchCStyleUFExporter.ExporterName: String;
begin
  Result := 'C/C++ Style';
end;

procedure TSchCStyleUFExporter.InsertFooter;
begin
  AddString('');
  AddString('');
  AddString('#endif');
end;

procedure TSchCStyleUFExporter.InsertHeader(sBuild, sVersion: String;
  iFileSize, iUFs: Cardinal);
begin
  AddString('/*');
  AddString(' * This file has been created by using the RE Tool Version ' +
    ToolVersion);
  AddString(' * Usage of this file for emulation purposes is higly prohibited.');
  AddString(' *');
  AddString(' * World Of Warcraft Client Information:');
  AddString(' *   - Size:          ' + IntToStr(iFileSize div 1024) + ' KBytes');
  AddString(' *   - Update Fileds: ' + IntToStr(iUFs));
  AddString(' *   - Build:         ' + sBuild);
  AddString(' *   - Version:       ' + sVersion);
  AddString(' */');
  AddString('');
  AddString('');
  AddString('#ifndef _UPDATE_FIELDS_' + sBuild + '_');
  AddString('#define _UPDATE_FIELDS_' + sBuild + '_');

  fPrevPrefix := '';
end;

procedure TSchCStyleUFExporter.ProcessUpdateField(cUF: TSchUpdateField);
const
  StartFieldFormat  = '#define   %s 0x%s // Size: %s, Type: %s';
  EndFieldFormat    = '#define   %s %s + %d';
  NormalFieldFormat = '#define   %s %s + 0x%s // Size: %s, Type: %s';

  FillNameTo = 45;
  DigitCount = 4;
var
  sRes, sPref: String;

begin
  if cUF.sStart = '' then  sRes :=
      Format(StartFieldFormat, [StringFillTo(cUF.sName, FillNameTo),
      IntToHex(cUF.iNr, DigitCount), IntToStr(cUF.iSize), UFTypeToName(cUF.iType)])
  else if cUF.bFake then  sRes :=
      Format(EndFieldFormat, [StringFillTo(cUF.sName, FillNameTo), cUf.sStart, cUf.iNr])
  else
    sRes := Format(NormalFieldFormat, [StringFillTo(cUF.sName, FillNameTo),
      cUF.sStart, IntToHex(cUF.iNr, DigitCount), IntToStr(cUF.iSize),
      UFTypeToName(cUF.iType)]);

  sPref := GetUFPrefix(cUF.sName);
  if sPref <> fPrevPrefix then
  begin
    AddString('');
    AddString('');
    AddString('// ''' + sPref + ''' object type update fields');
  end;

  fPrevPrefix := sPref;

  AddString(sRes);
end;

initialization
  TSchCStyleUFExporter.Create();

end.
