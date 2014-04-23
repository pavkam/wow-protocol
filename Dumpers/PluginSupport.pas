Unit PluginSupport;

interface

uses BitBuffer, Classes, FlowProcess, Graphics, HashMap, LoggerDef,
  StringBuffer, SysUtils, Utils,
  Windows, WoWOpCodes, WoWTypes;

const

  VR_8  = 'uint8 ';
  VR_16 = 'uint16';
  VR_32 = 'uint32';
  VR_64 = 'uint64';
  VR_S  = 'string';
  VR_F  = 'float ';
  VR_G  = 'guid  ';

  UNK = 'Unknown';

type
  TSchPluginSupport = class(TObject)
  private
    fObjects: TStrIntPlatformHashMap;
    fComments: TStrStrPlatformHashMap;

    fInBuffer: TSchInOutStringBuffer;
    fLogger: TSchGenericLogger;

    fSpace: String;

    procedure LogString(sString: String; cColor: TSchLogColor;
      cStyles: TFontStyles; bNew: Boolean = False);
    procedure LogStringNoSpace(sString: String; cColor: TSchLogColor;
      cStyles: TFontStyles; bNew: Boolean = False);
    procedure LogDecode(sVarType, sVarName, sVarValue: String; sVarComment: String);

    function _Call(cC: TSchConstCallBack; iConst: Cardinal): String;
    function ParseString(sStr: String): String;

  public

    constructor Create();
    destructor Destroy(); override;

    { Registers a GUID with a type }
    procedure RegisterObject(iGUID: Int64; iType: Integer; sComment: String = '');

    { Returns the type/comment of an object }
    function GetObjectType(iGUID: Int64): Integer;
    function GetObjectComment(iGUID: Int64): String;

    { unregisters a GUID }
    procedure UnregisterObject(iGUID: Int64);

    { Decoding start/end sequence ... }
    procedure StartPacketDecoding(sPkt: String; iOp: Word; bFromServer: Boolean);
    procedure StopPacketDecoding(bForced: Boolean = False);

    function GetInt32(): Cardinal; overload;
    function GetString(): String; overload;
    function GetFloat(): Single; overload;
    function GetInt16(): Word; overload;
    function GetInt8(): Byte; overload;
    function GetInt64(): Int64; overload;

    function GetInt32(sVarName: String; CoCall: TSchConstCallBack = nil): Cardinal;
      overload;
    function GetString(sVarName: String): String; overload;
    function GetFloat(sVarName: String): Single; overload;
    function GetInt16(sVarName: String; CoCall: TSchConstCallBack = nil): Word;
      overload;
    function GetInt8(sVarName: String; CoCall: TSchConstCallBack = nil): Byte;
      overload;
    function GetInt64(sVarName: String): Int64; overload;

    function GetGUID(sVarName: String; bMasked: Boolean = False): Int64;

    function GetHexInt32(sVarName: String;
      CoCall: TSchConstCallBack = nil): Cardinal; overload;
    function GetHexInt16(sVarName: String; CoCall: TSchConstCallBack = nil): Word;
      overload;
    function GetHexInt8(sVarName: String; CoCall: TSchConstCallBack = nil): Byte;
      overload;
    function GetHexInt64(sVarName: String): Int64; overload;

    function GetBinaryInt32(sVarName: String;
      CoCall: TSchConstCallBack = nil): Cardinal; overload;
    function GetBinaryInt16(sVarName: String;
      CoCall: TSchConstCallBack = nil): Word;
      overload;
    function GetBinaryInt8(sVarName: String;
      CoCall: TSchConstCallBack = nil): Byte;
      overload;

    { Bytes control }
    function BytesLeft(): Cardinal;
    procedure SkipUnusefulData(iSize: Cardinal; sName: String);

    function GetBitBuffer(iBytes: Cardinal): TSchBitBuffer;

    { Flow Runner }
    procedure RunFlowDefinition(rFlow: array of TSchFlowEntry);

    { Bit Check }
    function CheckMask(iVal, iMask: Cardinal): Boolean;
    function ConvertToBinary(iNr: Cardinal; iBytes: Cardinal): String;

    { Grouping }
    procedure StartLogicalGroup(sName: String);
    procedure EndLogicalGroup();

    { Error }
    procedure LogDecodeError(sErr: String);

    { Decompressing }
    function DecompressPacket(iAssumedSize: Cardinal): Integer;

    property Logger: TSchGenericLogger Read fLogger Write fLogger;
  end;


implementation

{ TSchPluginSupport }

function TSchPluginSupport.ConvertToBinary(iNr: Cardinal; iBytes: Cardinal): String;
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
  if (iBytes > 3) or (iBytes < 1) then Exit;

  Delete(Result, 1, (4 - iBytes) * 8);

end;

function TSchPluginSupport.BytesLeft: Cardinal;
begin
  fInBuffer.ClearUsedChunk;
  Result := fInBuffer.Size;
end;

function TSchPluginSupport.CheckMask(iVal, iMask: Cardinal): Boolean;
begin
  Result := (iVal and iMask) <> 0;
end;

constructor TSchPluginSupport.Create();
begin
  fLogger := nil;
  fObjects := TStrIntPlatformHashMap.Create(False, $FFFF);
  fComments := TStrStrPlatformHashMap.Create(False, $FFFF);
  fInBuffer := TSchInOutStringBuffer.Create();
end;

function TSchPluginSupport.DecompressPacket(iAssumedSize: Cardinal): Integer;
var
  sBuff, sInBuff: String;
begin
  fInBuffer.ClearUsedChunk();
  sInBuff := fInBuffer.StringBuffer;

  sBuff := ZLibDecompressInternal(sInBuff, iAssumedSize);
  fInBuffer.StringBuffer := sBuff;
  Result := Length(sBuff);

  LogString(Format('>>> Decompressed %d bytes of data to %d bytes',
    [Length(sInBuff), Result]), lcTeal, [fsBold, fsItalic], True);
end;

destructor TSchPluginSupport.Destroy;
begin
  fObjects.Destroy;
  fComments.Destroy();

  fInBuffer.Destroy();
end;

procedure TSchPluginSupport.EndLogicalGroup;
const
  GroupFormat = '}';
begin
  Delete(fSpace, Length(fSpace), 1);
  LogString(GroupFormat, lcGray, [], True);

  Delete(fSpace, Length(fSpace) - 1, 2);
end;

function TSchPluginSupport.GetInt8: Byte;
begin
  Result := fInBuffer.ReadByte();
end;

function TSchPluginSupport.GetFloat: Single;
begin
  Result := fInBuffer.ReadFloat();
end;

function TSchPluginSupport.GetInt32: Cardinal;
begin
  Result := fInBuffer.ReadInt32();
end;

function TSchPluginSupport.GetInt64: Int64;
begin
  Result := fInBuffer.ReadInt64;
end;

function TSchPluginSupport.GetObjectComment(iGUID: Int64): String;
var
  sKey: String;
begin
  sKey := IntToStr(iGUID);

  if fObjects.ContainsKey(sKey) then  Result := fComments.GetValue(sKey)
  else
    Result := '';
end;

function TSchPluginSupport.GetObjectType(iGUID: Int64): Integer;
var
  sKey: String;
begin
  sKey := IntToStr(iGUID);

  if fObjects.ContainsKey(sKey) then  Result := fObjects.GetValue(sKey)
  else
    Result := -1;
end;

function TSchPluginSupport.GetString(sVarName: String): String;
begin
  Result := GetString();
  LogDecode(VR_S, sVarName, ParseString(Result), '');
end;

function TSchPluginSupport.GetString: String;
begin
  Result := fInBuffer.ReadString();
end;

procedure TSchPluginSupport.LogDecode(sVarType, sVarName, sVarValue: String;
  sVarComment: String);
const
  NoCommentFormat = '(%s) %s = "%s"';
  CommentFormat   = '(%s) %s = "%s" (%s)';

begin

  LogString('(' + sVarType + ')', lcGreen, [fsItalic]);
  LogStringNoSpace(' ' + sVarName, lcBlack, [fsBold]);
  LogStringNoSpace(' = "' + sVarValue + '"', lcMaroon, []);

  if Length(sVarComment) > 0 then
    LogStringNoSpace(' (' + sVarComment + ')', lcBlue, []);

  fLogger.NewLine();
end;

procedure TSchPluginSupport.LogDecodeError(sErr: String);
begin
  LogString('Error: "' + sErr + '"', lcRed, [fsBold], True);
end;

procedure TSchPluginSupport.LogString(sString: String; cColor: TSchLogColor;
  cStyles: TFontStyles; bNew: Boolean);
begin
  fLogger.Log(fSpace + sString, cColor, cStyles, bNew);
end;

procedure TSchPluginSupport.LogStringNoSpace(sString: String;
  cColor: TSchLogColor; cStyles: TFontStyles; bNew: Boolean);
begin
  fLogger.Log(sString, cColor, cStyles, bNew);
end;

function TSchPluginSupport.ParseString(sStr: String): String;
var
  i: Integer;
begin
  Result := '';

  if sStr = '' then Exit;
  for i := 1 to Length(sStr) do if sStr[i] = '\' then Result := Result + '\\'
    else if sStr[i] = '"' then Result := Result + '\"'
    else if not (sStr[i] in [#32..#127]) then
      Result := Result + '\0' + IntToHex(Byte(sStr[i]), 2)
    else
      Result := Result + sStr[i];

end;

function TSchPluginSupport.GetInt16: Word;
begin
  Result := fInBuffer.ReadInt16();
end;

procedure TSchPluginSupport.RegisterObject(iGUID: Int64; iType: Integer;
  sComment: String);
begin
  fObjects.PutValue(IntToStr(iGUID), iType);
  if sComment <> '' then fComments.PutValue(IntToStr(iGUID), sComment);
end;

procedure TSchPluginSupport.RunFlowDefinition(rFlow: array of TSchFlowEntry);
var
  i: Integer;

begin
  for i := 0 to Length(rFlow) - 1 do
  begin

    case rFlow[i].iType of
      ftInt64:
      begin
        if rFlow[i].iFormat = ffHex then  GetHexInt64(rFlow[i].sName)
        else
          GetInt64(rFlow[i].sName);
      end;

      ftInt32:
      begin
        if rFlow[i].iFormat = ffHex then  GetHexInt32(rFlow[i].sName, rFlow[i].cCall)
        else if rFlow[i].iFormat = ffDecimal then
          GetInt32(rFlow[i].sName, rFlow[i].cCall)
        else if rFlow[i].iFormat = ffBinary then
          GetBinaryInt32(rFlow[i].sName, rFlow[i].cCall);
      end;

      ftInt16:
      begin
        if rFlow[i].iFormat = ffHex then  GetHexInt16(rFlow[i].sName, rFlow[i].cCall)
        else if rFlow[i].iFormat = ffDecimal then
          GetInt16(rFlow[i].sName, rFlow[i].cCall)
        else if rFlow[i].iFormat = ffBinary then
          GetBinaryInt16(rFlow[i].sName, rFlow[i].cCall);
      end;

      ftInt8:
      begin
        if rFlow[i].iFormat = ffHex then  GetHexInt8(rFlow[i].sName, rFlow[i].cCall)
        else if rFlow[i].iFormat = ffDecimal then
          GetInt8(rFlow[i].sName, rFlow[i].cCall)
        else if rFlow[i].iFormat = ffBinary then
          GetBinaryInt8(rFlow[i].sName, rFlow[i].cCall);
      end;

      ftGUID:
      begin
        GetGUID(rFlow[i].sName, False);
      end;

      ftMaskedGUID:
      begin
        GetGUID(rFlow[i].sName, True);
      end;

      ftFloat:
      begin
        GetFloat(rFlow[i].sName);
      end;

      ftString:
      begin
        GetString(rFlow[i].sName);
      end;

    end;

  end;

end;

procedure TSchPluginSupport.SkipUnusefulData(iSize: Cardinal; sName: String);
const
  DataFormat = '(%s) %s = "%s"';

begin
  LogString('(skipped)', lcBlue, [fsItalic]);
  LogStringNoSpace(' ' + sName, lcBlack, [fsBold]);
  LogStringNoSpace(' = ' + IntToStr(iSize) + ' bytes', lcMaroon, []);

  fInBuffer.ReadBuffer(iSize);

  fLogger.NewLine();
end;

procedure TSchPluginSupport.StartLogicalGroup(sName: String);
const
  GroupFormat = '%s {';
begin
  fSpace := fSpace + '  ';
  LogString(Format(GroupFormat, [sName]), lcGray, [], True);

  fSpace := fSpace + ' ';
end;

procedure TSchPluginSupport.StartPacketDecoding(sPkt: String; iOp: Word;
  bFromServer: Boolean);
var
  sFrom: String;
begin
  fInBuffer.StringBuffer := sPkt;
  fLogger.GetLog(); // Clear

  fSpace := '';

  if bFromServer then sFrom := '{SERVER}'
  else
    sFrom := '{CLIENT}';

  LogString(sFrom, lcGreen, [fsBold]);
  LogStringNoSpace(' Packet: (0x' + IntToHex(iOp, 4) + ')', lcBlack, [fsBold]);
  LogStringNoSpace(' ' + GetOpCodeName(iOp), lcGreen, [fsBold]);
  LogStringNoSpace(' Size = ' + IntToStr(Length(sPkt)), lcBlack, [fsBold], True);

  LogString('-------------------------------------------------------------',
    lcBlack, [], True);
end;

procedure TSchPluginSupport.StopPacketDecoding(bForced: Boolean);
const
  LeftFormat = '>>>> Packet not fully decoded! %d bytes left in packet!';
var
  iLeftLen: Integer;

begin
  if not bForced then
  begin
    fInBuffer.ClearUsedChunk();
    iLeftLen := Length(fInBuffer.StringBuffer);

    if iLeftLen > 0 then
    begin
      fLogger.NewLine();
      LogStringNoSpace(Format(LeftFormat, [iLeftLen]), lcRed, [fsBold], True);
      GenerateBodyInfo(fInBuffer.StringBuffer, fLogger);
    end;
  end;

  fLogger.NewLine();
  fLogger.NewLine();
end;

procedure TSchPluginSupport.UnregisterObject(iGUID: Int64);
var
  sKey: String;
begin
  sKey := IntToStr(iGUID);

  if fObjects.ContainsKey(sKey) then
  begin
    fObjects.Remove(sKey);
    fComments.Remove(sKey);
  end;
end;

function TSchPluginSupport._Call(cC: TSchConstCallBack; iConst: Cardinal): String;
begin
  if Assigned(cC) then  Result := cC(iConst)
  else
    Result := '';
end;

function TSchPluginSupport.GetBinaryInt16(sVarName: String;
  CoCall: TSchConstCallBack): Word;
begin
  Result := GetInt16();
  LogDecode(VR_16, sVarName, ConvertToBinary(Result, 2), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetBinaryInt32(sVarName: String;
  CoCall: TSchConstCallBack): Cardinal;
begin
  Result := GetInt32();
  LogDecode(VR_32, sVarName, ConvertToBinary(Result, 4), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetBinaryInt8(sVarName: String;
  CoCall: TSchConstCallBack): Byte;
begin
  Result := GetInt8();
  LogDecode(VR_8, sVarName, ConvertToBinary(Result, 1), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetBitBuffer(iBytes: Cardinal): TSchBitBuffer;
begin
  Result := TSchBitBuffer.Create(fInBuffer.ReadBuffer(iBytes));
end;

function TSchPluginSupport.GetFloat(sVarName: String): Single;
begin
  Result := GetFloat();
  LogDecode(VR_F, sVarName, FloatToStr(Result), '');
end;

function TSchPluginSupport.GetGUID(sVarName: String; bMasked: Boolean): Int64;
const
  GUIDFormat = '{0x%s} 0x%s';
var
  iGUID: Int64;
  i32: array[0..1] of Cardinal absolute iGUID;
  iBytes: array[0..7] of Byte absolute iGUID;

  iMask, i: Integer;
begin

  if bMasked then
  begin
    iMask := GetInt8();

    for i := 0 to 7 do
    begin
      if (iMask and (1 shl i)) <> 0 then  iBytes[i] := GetInt8()
      else
        iBytes[i] := 0;
    end;
  end else
    iGUID := GetInt64();

  Result := iGUID;

  LogDecode(VR_G, sVarName, Format(
    GUIDFormat, [IntToHex(i32[1], 8), IntToHex(i32[0], 8)]),
    GetObjectComment(iGUID));
end;

function TSchPluginSupport.GetHexInt16(sVarName: String;
  CoCall: TSchConstCallBack): Word;
begin
  Result := GetInt16();
  LogDecode(VR_16, sVarName, '0x' + IntToHex(Result, 4), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetHexInt32(sVarName: String;
  CoCall: TSchConstCallBack): Cardinal;
begin
  Result := GetInt32();
  LogDecode(VR_32, sVarName, '0x' + IntToHex(Result, 8), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetHexInt64(sVarName: String): Int64;
begin
  Result := GetInt64();
  LogDecode(VR_64, sVarName, '0x' + IntToHex(Result, 16), '');
end;

function TSchPluginSupport.GetHexInt8(sVarName: String; CoCall: TSchConstCallBack): Byte;
begin
  Result := GetInt8();
  LogDecode(VR_16, sVarName, '0x' + IntToHex(Result, 2), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetInt16(sVarName: String; CoCall: TSchConstCallBack): Word;
begin
  Result := GetInt16();
  LogDecode(VR_16, sVarName, IntToStr(Result), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetInt32(sVarName: String;
  CoCall: TSchConstCallBack): Cardinal;
begin
  Result := GetInt32();
  LogDecode(VR_32, sVarName, IntToStr(Result), _Call(CoCall, Result));
end;

function TSchPluginSupport.GetInt64(sVarName: String): Int64;
begin
  Result := GetInt64();
  LogDecode(VR_64, sVarName, IntToStr(Result), '');
end;

function TSchPluginSupport.GetInt8(sVarName: String; CoCall: TSchConstCallBack): Byte;
begin
  Result := GetInt8();
  LogDecode(VR_8, sVarName, IntToStr(Result), _Call(CoCall, Result));
end;

end.
