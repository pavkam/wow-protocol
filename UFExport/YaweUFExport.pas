unit YaweUFExport;

interface

uses Classes, FileParser, GenericUFExport, SysUtils, Utils, Version;

type
  TSchYaweUFExporter = class(TSchGenericUFExporter)
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

function TSchYaweUFExporter.ExporterName: String;
begin
  Result := 'Yawe/Delphi Style';
end;

procedure TSchYaweUFExporter.InsertFooter;
begin
  AddString('{$ENDREGION}');
end;

procedure TSchYaweUFExporter.InsertHeader(sBuild, sVersion: String;
  iFileSize, iUFs: Cardinal);
begin
  AddString('(*');
  AddString(' * This file has been created by using the RE Tool Version ' +
    ToolVersion);
  AddString(' * Usage of this file for emulation purposes is higly prohibited.');
  AddString(' *');
  AddString(' * World Of Warcraft Client Information:');
  AddString(' *   - Size:          ' + IntToStr(iFileSize div 1024) + ' KBytes');
  AddString(' *   - Update Fileds: ' + IntToStr(iUFs));
  AddString(' *   - Build:         ' + sBuild);
  AddString(' *   - Version:       ' + sVersion);
  AddString(' *)');
  AddString('');
  AddString('');
  AddString('{$DEFINE UPDATE_FIELDS_' + sBuild + '}');

  fPrevPrefix := '';
end;

procedure TSchYaweUFExporter.ProcessUpdateField(cUF: TSchUpdateField);
const
  CountFormat    = #13#10 + '  { Repeat %d Times }' + #13#10 +
    '  __%s =  %d;' + #13#10;
  CountEndFormat = #13#10 + '  { ... }' + #13#10;

  StartFieldFormat  = '  %s =  $%s; { Type: %s }';
  EndFieldFormat    = '  %s =  %s + %d;';
  NewFieldFormat    = '  %s =  %s;';
  NormalFieldFormat = '  %s =  %s + $%s; { Type: %s }';

  FillNameTo = 47;
  DigitCount = 4;
var
  sRes, sPref: String;

begin
  sRes := '';
  if cUF.sStart = '' then
  begin
    if ((cUF.iSize > 1) and (cUF.iType <> 4)) or (cUF.iSize > 2) then
      sRes := Format(CountFormat, [cUF.iSize, StringFillTo(
        cUF.sName, FillNameTo - 2), cUF.iSize]);

    sRes := sRes + Format(StartFieldFormat, [StringFillTo(
      cUF.sName, FillNameTo), IntToHex(cUF.iNr, DigitCount), UFTypeToName(cUF.iType)]);

    if ((cUF.iSize > 1) and (cUF.iType <> 4)) or (cUF.iSize > 2) then
      sRes := sRes + CountEndFormat;
  end else if cUF.bFake then
    sRes := Format(EndFieldFormat, [StringFillTo(cUF.sName, FillNameTo),
      cUf.sStart, cUf.iNr])
  else
  begin
    if ((cUF.iSize > 1) and (cUF.iType <> 4)) or (cUF.iSize > 2) then
      sRes := Format(CountFormat, [cUF.iSize, StringFillTo(
        cUF.sName, FillNameTo - 2), cUF.iSize]);

    sRes := sRes + Format(NormalFieldFormat,
      [StringFillTo(cUF.sName, FillNameTo), cUF.sStart, IntToHex(
      cUF.iNr, DigitCount), UFTypeToName(cUF.iType)]);

    if ((cUF.iSize > 1) and (cUF.iType <> 4)) or (cUF.iSize > 2) then
      sRes := sRes + CountEndFormat;
  end;

  sPref := GetUFPrefix(cUF.sName);
  if sPref <> fPrevPrefix then
  begin
    if fPrevPrefix <> '' then  AddString('{$ENDREGION}');

    AddString('');
    AddString('');
    AddString('{$REGION ''' + sPref + ' Update Fields' + ''' }');
    AddString('{ ' + sPref + ' object type update fields }');
    AddString('Const');

    if cUf.sStart <> '' then
      AddString(Format(NewFieldFormat,
        [StringFillTo(sPref + '_START', FillNameTo), cUf.sStart]))
    else
      AddString(Format(NewFieldFormat,
        [StringFillTo(sPref + '_START', FillNameTo), '0']));
  end;

  fPrevPrefix := sPref;

  AddString(sRes);
end;

initialization
  TSchYaweUFExporter.Create();

end.
