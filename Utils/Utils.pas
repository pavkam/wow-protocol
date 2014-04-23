unit Utils;

interface

uses Classes, Debug, Math, MMSystem,
  Registry, SysUtils, Windows,
  WinSock, ZLibEx;

type
  TProcessCallback = function(FileName: String): Boolean of object;

  { Class to link a File with a Cache }
  TSchCacheProvider = class(TObject)
  private
    fCache: String;
    fMaxSize: Integer;

    function GetCache: String;
    procedure SetCache(const Value: String);

  public
    constructor Create(iMaxSize: Integer);

    function CanGetCache(): Boolean;
    property Cache: String Read GetCache Write SetCache;
  end;

  { Provides an Easy way to maintain Registry-Saved Options }
  TSchSavedOption = class(TObject)
  private
    fKey, fName: String;
    fDefault: String;

    fHKEY: Cardinal;

    function LoadFromRegistry(sDefault: String): String;
    procedure SaveToRegistry(sValue: String);

    function GetAsBoolean: Boolean;
    function GetAsInteger: Integer;
    function GetAsString: String;
    function GetAsUnicode: WideString;

    procedure SetAsBoolean(const Value: Boolean);
    procedure SetAsInteger(const Value: Integer);
    procedure SetAsString(const Value: String);
    procedure SetAsUnicode(const Value: WideString);

  public
    constructor Create(sKey, sName: String;
      bGlobal: Boolean; sDefault: String = '');

    property AsInteger: Integer Read GetAsInteger Write SetAsInteger;
    property AsString: String Read GetAsString Write SetAsString;
    property AsBoolean: Boolean Read GetAsBoolean Write SetAsBoolean;
    property AsUnicode: WideString
      Read GetAsUnicode Write SetAsUnicode;

  end;


{ Convertion Utilities }
function atoi(Ascii: String): Integer;
function atof(Ascii: String): Double;
function atoint64(Ascii: String): Int64;
function ftoa(fT: Single): String;

function DecToBase(WhatNumber: Integer; Base: Word): String;
function BaseToDec(WhatNumber: String; Base: Word): String;
function BaseToAnotherBase(WhatNumber: String;
  InitialBase, ConvertionBase: Word): String;
function ConvertRestToString(Rest: Integer): String;
function ConvertCharToInteger(Char: String): String;

{ Changes the Byte order }
function ChangeByteOrder(wToChange: Word; bToNetworkOrder: Boolean): Word;

{ Generates a HexRep from a string }
function ToHexRep(sData: String): String;
function FromHexRep(sData: String): String;

function htoa(const sIn: String): String;

{ Helper Functions }
function GenerateFileStyleDate(): String;
function ZLibDecompressInternal(sBuff: String; BuffSize: Integer): String;

procedure RecursDirectory(InitDir: String; CallMe: TProcessCallback);

{ Stream Operations }
function ReadFromStream(AStream: TStream): String;
procedure WriteToStream(AStream: TStream; sBuf: String);

{ Gets the path the main Exe is ran from }
function LocalPath(): String;
function FileInBaseDir(sFile, sBaseDir: String): Boolean;

function CRLFToMacroB(St: String): String;
function LongToFloat(Long: Integer): Single;
function FloatToULong(Flt: Single): Cardinal;
function LongToULong(Long: Integer): Cardinal;
function StrLongToFloat(sLong: String): String;

function StrFloatRound(sFloat: String; iRnd: Integer): String;
function StrLongToHex(sLong: String): String;

function OneSpace(sStr: String): String;
function ToSQL(St: String): String;

function IntToBinary(iNr: Cardinal; iBytes: Cardinal): String;
function FileLines(sFile: String): Cardinal;
function POSIXToDateTime(iPos: Cardinal): TDateTime;
function DateTimeToPOSIX(dt: TDateTime): Cardinal;

implementation

uses Globals;

function AddBinaryDots(s: String): String;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Length(s) do
  begin
    Result := Result + s[i];
    if ((i mod 8) = 0) and (i < Length(s)) then Result := Result + '.';
  end;
end;

function IntToBinary(iNr: Cardinal; iBytes: Cardinal): String;
const
  Digits: array[0..1] of Char = ('0', '1');
var
  iDigit: Integer;

begin
  SetLength(Result, 8 * 4);

  for iDigit := 1 to Length(Result) do Result[iDigit] := '0';

  iDigit := Length(Result);

  while iNr > 1 do
  begin
    Result[iDigit] := Digits[iNr mod 2];
    iNr := iNr div 2;

    Dec(iDigit);
  end;

  Result[iDigit] := Digits[iNr];
  if (iBytes > 3) or (iBytes < 1) then
  begin
    Result := AddBinaryDots(Result);
    Exit;
  end;

  Delete(Result, 1, (4 - iBytes) * 8);
  Result := AddBinaryDots(Result);
end;

function POSIXToDateTime(iPos: Cardinal): TDateTime;
const
  f1970: Double = 25569;
  iSecInDay     = 60 * 60 * 24;
  iSecInHour    = 60 * 60;
  iSecInMin     = 60;

var
  fHours: Double;
  fMins: Double;
  fSec: Double;
begin
  Result := f1970 + (iPos div iSecInDay);
  iPos := (iPos mod iSecInDay); { Remaining seconds }

  fHours := (1 / 24) * (iPos div iSecInHour);

  iPos := (iPos mod iSecInHour);
  fMins := (1 / (24 * 60)) * (iPos div iSecInMin);

  iPos := (iPos mod iSecInMin);
  fSec := (1 / iSecInDay) * iPos;

  Result := Result + fHours + fMins + fSec;
end;

function DateTimeToPOSIX(dt: TDateTime): Cardinal;
const
  f1970: Cardinal = 25569;

var
  iDays: Cardinal;
  st: TSystemTime;
begin
  iDays := Trunc(dt) - f1970;
  DateTimeToSystemTime(dt, st);

  // ((1/24) * st.wHour)

  Result := (iDays * 60 * 60 * 24) + ((60 * 60) * st.wHour) +
    ((60) * st.wMinute) + (st.wSecond);
end;

function FileLines(sFile: String): Cardinal;
var
  fIn: TextFile;
begin
  Result := 0;
  AssignFile(fIn, sFile);
 {$I-}
  Reset(fIn);
 {$I+}

  if IOResult <> 0 then exit;

  while not EOF(fIn) do
  begin
    Inc(Result);
    ReadLn(fIn);
  end;

  CloseFile(fIn);
end;

function htoa(const sIn: String): String;
var
  iIn: Integer;
  iIdx: Integer;
  iLen: Integer;
begin
  Result := '';

  if sIn = '' then Exit;

  iLen := Length(sIn) shr 1;
  SetLength(Result, iLen);
  iIn := 1;

  for iIdx := 1 to iLen do
  begin
    Result[iIdx] := Chr(StrToIntDef('$' + sIn[iIn] + sIn[iIn + 1], 0));
    Inc(iIn, 2);
  end;
end;

function LongToULong(Long: Integer): Cardinal;
var
  Rs: Cardinal absolute Long;
begin
  Result := Rs;
end;

function FloatToULong(Flt: Single): Cardinal;
var
  Rs: Cardinal absolute Flt;
begin
  Result := Rs;
end;

function ToSQL(St: String): String;
var
  i: Integer;
begin
  Result := '';

  if St = '' then Exit;

  for i := 1 to Length(st) do if St[i] = '''' then Result := Result + '\'''
    else if St[i] = '\' then Result := Result + '\\'
    else if St[i] = #13 then Result := Result + '\n'
    else if St[i] = #10 then Result := Result + '\r'
    else if St[i] = '"' then Result := Result + '\"'
    else
      Result := Result + St[i];

end;

function OneSpace(sStr: String): String;
begin
  while Pos('  ', sStr) > 0 do sStr := StringReplace(sStr, '  ', ' ', [rfReplaceAll]);
  Result := sStr;
end;

function StrFloatRound(sFloat: String; iRnd: Integer): String;
begin
  if Pos('.', sFloat) > 0 then  Result := Copy(sFloat, 1, Pos('.', sFloat) + iRnd)
  else
    Result := sFloat;
end;

function LongToFloat(Long: Integer): Single;
var
  ft: Single absolute Long;
begin
  Result := ft;
end;

function StrLongToFloat(sLong: String): String;
begin
  if Pos('0x', sLong) = 1 then
  begin
    Delete(sLong, 1, 2);
    sLong := '$' + sLong;
  end;

  Result := ftoa(LongToFloat(atoi(sLong)));
end;

function StrLongToHex(sLong: String): String;
begin
  if Pos('0x', sLong) = 1 then
  begin
    Delete(sLong, 1, 2);
    sLong := '$' + sLong;
  end;

  Result := '0x' + IntToHex(atoi(sLong), 8);
end;

function CRLFToMacroB(St: String): String;
begin
  Result := StringReplace(St, #13 + #13 + #10, '$b', [rfReplaceAll]);
  Result := StringReplace(Result, #13 + #10, '$b', [rfReplaceAll]);
end;

function FileInBaseDir(sFile, sBaseDir: String): Boolean;
var
  sRelPath: String;
  iI: Integer;
begin
  { Relative Path From sFile to sBaseDir }
  sRelPath := ExtractRelativePath(IncludeTrailingPathDelimiter(sFile),
    IncludeTrailingPathDelimiter(sBaseDir));

  { Contains anything else ? }
  if Length(sRelPath) = 0 then
  begin
    Result := True;
    Exit;
  end; { File in Base }

  for iI := 1 to Length(sRelPath) do if not (sRelPath[iI] in ['.', '\', '/']) then
    begin
      Result := False;
      Exit;
    end; { File not in base }

  Result := True;
end;

procedure RecursDirectory(InitDir: String; CallMe: TProcessCallback);
var
  SrcRec: TSearchRec;
begin
  if FindFirst(InitDir + '\*.*', 255, SrcRec) = 0 then  repeat
      if ((SrcRec.Attr and faDirectory) = faDirectory) and
        (SrcRec.Name <> '.') and (SrcRec.Name <> '..') then
        RecursDirectory(InitDir + '\' + SrcRec.Name, CallMe);

      if (SrcRec.Name <> '.') and (SrcRec.Name <> '..') then
        CallMe(InitDir + '\' + SrcRec.Name);

    until FindNext(SrcRec) <> 0;
  SysUtils.FindClose(SrcRec);
end;


procedure WriteToStream(AStream: TStream; sBuf: String);
var
  St: array[0..100000] of Char;
  i: Integer;
begin
  AStream.Seek(0, soFromBeginning);

  if Length(sBuf) = 0 then Exit;

  for i := 1 to Length(sBuf) do St[i - 1] := sBuf[i];

  AStream.Write(St, Length(sBuf));
end;

function ReadFromStream(AStream: TStream): String;
var
  St: array[0..100000] of Char;
  ln, i: Integer;
begin
  Result := '';

  repeat
    ln := AStream.Read(St, SizeOf(St));
    if ln > 0 then  for i := 0 to ln - 1 do Result := Result + St[i];
  until (ln = 0);

end;

function ToHexRep(sData: String): String;
var
  i: Integer;
begin
  Result := '';
  if sData = '' then Exit;

  for i := 1 to Length(sData) do Result := Result + IntToHex(Byte(sData[i]), 2);
end;

function FromHexRep(sData: String): String;
var
  i: Integer;
begin
  Result := '';
  if sData = '' then Exit;

  for i := 1 to (Length(sData) div 2) do
    Result := Result + Char(atoi('$' + sData[(i * 2) - 1] + sData[(i * 2)]));
end;


function ChangeByteOrder(wToChange: Word; bToNetworkOrder: Boolean): Word;
begin
  if bToNetworkOrder then  Result := htons(wToChange)
  else
    Result := ntohs(wToChange);
end;

function LocalPath(): String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function ZLibDecompressInternal(sBuff: String; BuffSize: Integer): String;
var
  Buff: array[0..100000] of Char;
  i, u: Integer;
  Py: Pointer;
begin
  Result := '';
  if sBuff = '' then Exit;

  for i := 1 to Length(sBuff) do Buff[i - 1] := sBuff[i];

  ZDecompress(@Buff, Length(sBuff), Py, i, BuffSize);

  Move(Py^, Buff[0], i);

  for u := 0 to i - 1 do Result := Result + Buff[u];

end;

function GenerateFileStyleDate(): String;
var
  ST: TSystemTime;
begin
  GetLocalTime(ST);

  Result := IntToStr(ST.wYear) + '.' + IntToStr(ST.wMonth) + '.' +
    IntToStr(ST.wDay) + '.' + IntToStr(ST.wHour) + '.' +
    IntToStr(ST.wMinute);
end;

function ftoa(fT: Single): String;
begin
  Result := StrFloatRound(StringReplace(FloatToStr(fT), ',', '.',
    [rfReplaceAll]), 2);
end;

function atoi(Ascii: String): Integer;
var
  Error: Integer;
begin
  Ascii := StringReplace(UpperCase(Ascii), '0x', '$', [rfReplaceAll]);
  Val(Ascii, Result, Error);
end;

function atof(Ascii: String): Double;
var
  Error: Integer;
begin
  Val(Ascii, Result, Error);
end;

function atoint64(Ascii: String): Int64;
var
  Error: Integer;
begin
  Val(Ascii, Result, Error);
end;

procedure SaveOption(Name, Key, Value: String; Root: HKey);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := root;

    if Reg.OpenKey(key, True) then
    begin
      Reg.WriteString(Name, Value);
      Reg.CloseKey;
    end;

  finally
    Reg.Free;
  end;
end;

function LoadOption(Name, Key, Default: String; Root: HKey): String;
var
  Reg: TRegistry;
begin
  Result := default;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := root;

    if Reg.OpenKey(Key, True) then
    begin
      if Reg.ValueExists(Name) then Result := Reg.ReadString(Name)
      else
        Result := default;
      Reg.CloseKey;
    end;

  finally
    Reg.Free;
  end;
end;

procedure DelOption(Name, Key: String; Root: HKey);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := root;

    if Reg.OpenKey(Key, True) then
    begin
      if Reg.ValueExists(Name) then  Reg.DeleteValue(Name);
      Reg.CloseKey;
    end;

  finally
    Reg.Free;
  end;
end;


{ TSchSavedOption }

constructor TSchSavedOption.Create(sKey, sName: String; bGlobal: Boolean;
  sDefault: String = '');
begin
  fKey := sKey;
  fName := sName;
  fDefault := sDefault;

  if bGlobal then  fHKEY := HKEY_LOCAL_MACHINE
  else
    fHKEY := HKEY_CURRENT_USER;

  if (sKey = '') or (sName = '') then
    raise Exception.Create('Invalid Key or Name specified for a saved option!');
end;

function TSchSavedOption.GetAsBoolean: Boolean;
begin
  Result := (LoadFromRegistry(fDefault) = '1');
end;

function TSchSavedOption.GetAsInteger: Integer;
begin
  Result := atoi(LoadFromRegistry(fDefault));
end;

function TSchSavedOption.GetAsString: String;
begin
  Result := LoadFromRegistry(fDefault);
end;

function TSchSavedOption.GetAsUnicode: WideString;
begin
  Result := UTF8Decode(GetAsString());
end;

function TSchSavedOption.LoadFromRegistry(sDefault: String): String;
begin
  Result := LoadOption(fName, fKey, sDefault, fHKEY);
end;

procedure TSchSavedOption.SaveToRegistry(sValue: String);
begin
  SaveOption(fName, fKey, sValue, fHKEY);
end;

procedure TSchSavedOption.SetAsBoolean(const Value: Boolean);
begin
  SaveToRegistry(IntToStr(Integer(Value)));
end;

procedure TSchSavedOption.SetAsInteger(const Value: Integer);
begin
  SaveToRegistry(IntToStr(Value));
end;

procedure TSchSavedOption.SetAsString(const Value: String);
begin
  SaveToRegistry(Value);
end;

procedure TSchSavedOption.SetAsUnicode(const Value: WideString);
begin
  SetAsString(UTF8Encode(Value));
end;

{ TCacheProvider }

function TSchCacheProvider.CanGetCache: Boolean;
begin
  Result := Length(fCache) >= fMaxSize;
end;

constructor TSchCacheProvider.Create(iMaxSize: Integer);
begin
  fCache := '';
  fMaxSize := iMaxSize;
end;

function TSchCacheProvider.GetCache: String;
begin
  Result := fCache;
  fCache := '';
end;

procedure TSchCacheProvider.SetCache(const Value: String);
begin
  fCache := fCache + Value;
end;

function DecToBase(WhatNumber: Integer; Base: Word): String;
var
  iTemp: Integer;
  rest: Integer;
  tehResult: String;
begin
  if (Base > 16) or (Base < 2) then
  begin
    Result := 'ERROR: The base should be an integer between 2 and 16';
    exit;
  end;

  Result := '';
  iTemp := WhatNumber;
  tehResult := '';

  repeat
    rest := iTemp mod Base;
    tehResult := ConvertRestToString(Rest) + (tehResult);
    iTemp := iTemp div Base;
  until iTemp = 0;


  Result := tehResult;

end;
//--------------------------------------------------------------------------------------------------------       
//  This function converts an integer char into it's corespondent for bases relative scripting.
//--------------------------------------------------------------------------------------------------------       
function ConvertRestToString(Rest: Integer): String;
begin
  case Rest of
    0: Result := '0';
    1: Result := '1';
    2: Result := '2';
    3: Result := '3';
    4: Result := '4';
    5: Result := '5';
    6: Result := '6';
    7: Result := '7';
    8: Result := '8';
    9: Result := '9';
    10: Result := 'A';
    11: Result := 'B';
    12: Result := 'C';
    13: Result := 'D';
    14: Result := 'E';
    15: Result := 'F';
  end;
end;
//--------------------------------------------------------------------------------------------------------       
//  This function converts a char in it's integer corespondent for use in hexadecimal to dec conversions
//--------------------------------------------------------------------------------------------------------       
function ConvertCharToInteger(Char: String): String;
begin
  case Char[1] of
    '0': Result := '0';
    '1': Result := '1';
    '2': Result := '2';
    '3': Result := '3';
    '4': Result := '4';
    '5': Result := '5';
    '6': Result := '6';
    '7': Result := '7';
    '8': Result := '8';
    '9': Result := '9';
    'A': Result := '10';
    'B': Result := '11';
    'C': Result := '12';
    'D': Result := '13';
    'E': Result := '14';
    'F': Result := '15';
  end;
end;
//--------------------------------------------------------------------------------------------------------       
//  This function converts a number in a base in a decimal number
//--------------------------------------------------------------------------------------------------------
function BaseToDec(WhatNumber: String; Base: Word): String;
var
  sTemp: String;
  i: Integer;
  FinalNumber, iTemp: Extended;
  iBase, iExponent: Integer;
begin
  if (Base > 16) or (Base < 2) then
  begin
    Result := 'ERROR: The base should be an integer between 2 and 16';
    exit;
  end;

  FinalNumber := 0;
  sTemp := Uppercase(WhatNumber);
  Result := '';

  for i := 0 to (length(sTemp) - 1) do
  begin
    iBase := StrToInt(ConvertCharToInteger(sTemp[i + 1]));
    //10110101 ---> iBase       = 1
    iExponent := length(sTemp) - i - 1;
    //10110101 ---> iExponent   = 7
    iTemp := Power(Base, iExponent);
    //10110101 ---> iTemp       = 2^7
    FinalNumber := FinalNumber + (iBase * iTemp);
    //10110101 ---> FinalNumber = 0 + (1 * 2^7)
  end;

  Result := ftoa(FinalNumber);

end;
//--------------------------------------------------------------------------------------------------------       
//  This function converts a number in a base in it's corespondent in another desired base
//--------------------------------------------------------------------------------------------------------
function BaseToAnotherBase(WhatNumber: String;
  InitialBase, ConvertionBase: Word): String;
begin
  if (InitialBase > 16) or (InitialBase < 2) or (ConvertionBase > 16) or
    (ConvertionBase < 2) then
  begin
    Result := 'ERROR: The bases should be an integer between 2 and 16';
    exit;
  end;
  Result := '';

  Result := DecToBase(StrToInt(BaseToDec(WhatNumber, InitialBase)), ConvertionBase);

end;

end.
