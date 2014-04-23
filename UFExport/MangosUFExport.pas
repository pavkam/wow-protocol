unit MangosUFExport;

interface

uses Classes, FileParser, GenericUFExport, SysUtils, Utils, Version;

type
  TSchMangosUFExporter = class(TSchGenericUFExporter)
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

function TSchMangosUFExporter.ExporterName: String;
begin
  Result := 'MaNGOS Style';
end;

procedure TSchMangosUFExporter.InsertFooter;
begin
  AddString('}');
  AddString('');
  AddString('#endif');
end;

procedure TSchMangosUFExporter.InsertHeader(sBuild, sVersion: String;
  iFileSize, iUFs: Cardinal);
begin
  AddString('/*');
  AddString(' * Copyright (C) 2005,2006 MaNGOS <http://www.mangosproject.org/>.');
  AddString(' * Information updates by BFG Team. Last updated on ' +
    DateToStr(Date()));
  AddString(' * Client data information:');
  AddString(' *   - Size:          ' + IntToStr(iFileSize div 1024) + ' KBytes');
  AddString(' *   - Update Fileds: ' + IntToStr(iUFs));
  AddString(' *   - Build:         ' + sBuild);
  AddString(' *   - Version:       ' + sVersion);
  AddString(' *');
  AddString(' *');
  AddString(' * This program is free software; you can redistribute it and/or modify');
  AddString(' * it under the terms of the GNU General Public License as published by');
  AddString(' * the Free Software Foundation; either version 2 of the License, or');
  AddString(' * (at your option) any later version.');
  AddString(' *');
  AddString(' * This program is distributed in the hope that it will be useful,');
  AddString(' * but WITHOUT ANY WARRANTY; without even the implied warranty of');
  AddString(' * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the');
  AddString(' * GNU General Public License for more details.');
  AddString(' *');
  AddString(' * You should have received a copy of the GNU General Public License');
  AddString(' * along with this program; if not, write to the Free Software');
  AddString(' * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA'
    );
  AddString(' */');
  AddString('');
  AddString('#include "Common.h"');
  AddString('');
  AddString('#ifndef _UPDATEFIELDS_AUTO_H');
  AddString('#define _UPDATEFIELDS_AUTO_H');

  fPrevPrefix := '';
end;

procedure TSchMangosUFExporter.ProcessUpdateField(cUF: TSchUpdateField);
const
  StartFieldFormat  = '    %s = 0x%s,     // %s<%s>';
  EndFieldFormat    = '    %s = %s + %d,';
  NormalFieldFormat = '    %s = %s + 0x%s,     // %s<%s>';

  FillNameTo = 45;
  DigitCount = 4;
var
  sRes, sPref: String;

begin
  if cUF.sStart = '' then  sRes :=
      Format(StartFieldFormat, [StringFillTo(cUF.sName, FillNameTo),
      IntToHex(cUF.iNr, DigitCount), UFTypeToName(cUF.iType), IntToStr(cUF.iSize)])
  else if cUF.bFake then  sRes :=
      Format(EndFieldFormat, [StringFillTo(cUF.sName, FillNameTo), cUf.sStart, cUf.iNr])
  else
    sRes := Format(NormalFieldFormat, [StringFillTo(cUF.sName, FillNameTo),
      cUF.sStart, IntToHex(cUF.iNr, DigitCount), UFTypeToName(cUF.iType),
      IntToStr(cUF.iSize)]);

  sPref := GetUFPrefix(cUF.sName);
  if sPref <> fPrevPrefix then
  begin
    if fPrevPrefix <> '' then  AddString('}');

    AddString('');

    if sPref = 'OBJECT' then  AddString('enum EObjectFields');
    if sPref = 'ITEM' then  AddString('enum EItemFields');
    if sPref = 'CONTAINER' then  AddString('enum EContainerFields');
    if sPref = 'UNIT' then  AddString('enum EUnitFields');
    if sPref = 'PLAYER' then  AddString('enum EPlayerFields');
    if sPref = 'GAMEOBJECT' then  AddString('enum EGameObjectFields');
    if sPref = 'DYNAMICOBJECT' then  AddString('enum EDynamicObjectFields');
    if sPref = 'CORPSE' then  AddString('enum ECorpseFields');

    AddString('{');
  end;

  fPrevPrefix := sPref;

  AddString(sRes);
end;

initialization
  TSchMangosUFExporter.Create();

end.
