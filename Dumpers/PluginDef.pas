unit PluginDef;

interface

uses
  Classes, LoggerDef, SysUtils,
  Utils, Version, Windows, WoWOpcodes;

type
  { Selector }
  TSchSelectionPower = (spNotAccept, spAcceptWhyNot, spAcceptNeed);

  { Internal Exception }
  ESchPluginError = class(Exception);

  { Decoder Class }
  TSchPlugin = class(TObject)
  private
    fOption: TSchSavedOption;
    fEnabled: Boolean;

    fName: String;
    fInfo: String;
    fVer, fDev: String;
    fID: Cardinal;
    fSuppRTF: Boolean;

    fPacketsDec: TStrings;

    function GetDecCount: TStrings;

    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);

  public

    constructor Create(sName, sInfo, sVer, sDev: String; bRTF: Boolean);
    destructor Destroy(); override;

    procedure DecodePacket(iOpCode: Integer; sBody: String;
      bFromServer: Boolean; cLogger: TSchGenericLogger); virtual; abstract;

    function AcceptsPacket(iOp: Cardinal): TSchSelectionPower;
      virtual; abstract;

    property Name: String Read fName;
    property ID: Cardinal Read fID;
    property Info: String Read fInfo;
    property Version: String Read fVer;
    property Developer: String Read fDev;

    property SupportsRTF: Boolean Read fSuppRTF;
    property DecodesPackets: TStrings Read GetDecCount;

    property Enabled: Boolean Read GetEnabled Write SetEnabled;
  end;

function GetPluginList(): TStrings;

implementation

var
  Plugins: TStrings;
  iLastID: Cardinal;


function GetPluginList(): TStrings;
begin
  Result := Plugins;
end;

{ TSchDecoder }

constructor TSchPlugin.Create(sName, sInfo, sVer, sDev: String; bRTF: Boolean);
begin
  Inc(iLastID);

  fName := sName;
  fInfo := sInfo;
  fID := iLastID;
  fVer := sVer;
  fDev := sDev;
  fSuppRTF := bRTF;

  fPacketsDec := nil;

  fOption := TSchSavedOption.Create(KeyName, Format(
    ValuePluginEnabled, [fID]), False, '0');
  fEnabled := fOption.AsBoolean;

  Plugins.AddObject(fName, Self);
end;

destructor TSchPlugin.Destroy;
begin
  fOption.Destroy();

  if Assigned(fPacketsDec) then  fPacketsDec.Destroy();
end;

function TSchPlugin.GetDecCount: TStrings;
var
  i: Integer;
begin
  if Assigned(fPacketsDec) then
  begin
    Result := fPacketsDec;
    Exit;
  end;

  fPacketsDec := TStringList.Create;

  for i := 1 to MAX_OPCODES do if AcceptsPacket(OpcodeToString[i].wMsg) =
      spAcceptWhyNot then  fPacketsDec.AddObject(
        'Accepts:  ' + OpcodeToString[i].sName, Ptr(OpcodeToString[i].wMsg))
    else if AcceptsPacket(OpcodeToString[i].wMsg) = spAcceptNeed then
      fPacketsDec.AddObject('Requires: ' + OpcodeToString[i].sName,
        Ptr(OpcodeToString[i].wMsg));

  Result := fPacketsDec;
end;

function TSchPlugin.GetEnabled: Boolean;
begin
  Result := fEnabled;
end;

procedure TSchPlugin.SetEnabled(const Value: Boolean);
begin
  fOption.AsBoolean := Value;
  fEnabled := Value;
end;

initialization
  Plugins := TStringList.Create();
  iLastID := $F0000100;

end.
