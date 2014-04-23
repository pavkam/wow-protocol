unit ControlPktPlugin;

interface

uses
  BitBuffer, Classes, ExtendablePlugin, PluginDef, SysUtils, Utils, WoWOpCodes,
  WoWTypes;

type
  TSchControlPktPlugin = class(TSchExtendablePlugin)
  private
    { Ping/Pong }
    procedure DecodePongPacket();
    procedure DecodePingPacket();

    { Auth Response }
    procedure DecodeAuthResponse();

    { Auth Init }
    procedure DecodeAuthInit();

    { Auth client }
    procedure DecodeAuthClient();

    { Addon Info }
    procedure DecodeAddonInfo();

    { Hdw Survey }
    procedure DecodeHdwSurvey();

  protected
    procedure ProcessPacket(iOp: Word); override;

  public
    function AcceptsPacket(iOp: Cardinal): TSchSelectionPower; override;

  end;

implementation

uses PluginSupport;

{ TSchControlPktPlugin }

function TSchControlPktPlugin.AcceptsPacket(iOp: Cardinal): TSchSelectionPower;
begin
  case iOp of
    CMSG_HARDWARE_SURVEY_RESULTS,
    SMSG_HARDWARE_SURVEY_REQUEST,
    CMSG_PING,
    CMSG_AUTH_SESSION,
    SMSG_AUTH_CHALLENGE,
    SMSG_AUTH_RESPONSE,
    SMSG_ADDON_INFORMATION,
    SMSG_PONG:
      Result := spAcceptNeed;
    else
      Result := spNotAccept;
  end;
end;

procedure TSchControlPktPlugin.DecodeAddonInfo;
var
  i: Integer;
begin
  for i := 0 to 11 do
  begin
    Packet.StartLogicalGroup('Group(' + IntToStr(i) + ')');
    Packet.GetInt32(UNK);
    Packet.GetInt32(UNK);
    Packet.EndLogicalGroup();
  end;
end;

procedure TSchControlPktPlugin.DecodeAuthClient;
var
  i: Integer;
begin
  Packet.GetInt32('ClientBuild');
  Packet.GetHexInt32(UNK);

  Packet.GetString('AccountName');
  Packet.GetHexInt32('ClientSeed');

  Packet.SkipUnusefulData(20, 'KeyDigest');

  i := Packet.GetInt32();
  Packet.DecompressPacket(i);

  Packet.StartLogicalGroup('AddOns');
  i := 0;

  while Packet.BytesLeft > 0 do
  begin
    Packet.StartLogicalGroup('AddOn(' + IntToStr(i) + ')');

    Packet.GetString('Name');
    Packet.GetInt8('Enabled');
    Packet.GetHexInt32('ProviderID');
    Packet.GetInt32(UNK);

    Packet.EndLogicalGroup();

    Inc(i);
  end;

  Packet.EndLogicalGroup();
end;

procedure TSchControlPktPlugin.DecodeAuthInit;
begin
  Packet.GetInt32('ServerSeed');
end;

procedure TSchControlPktPlugin.DecodeAuthResponse;
var
  iError: Cardinal;
begin
  iError := Packet.GetInt8('ErrorCode', __AUTHCODE);

  if iError = AUTH_OK then
  begin
    Packet.GetInt32(UNK);
    Packet.GetInt32(UNK);
    Packet.GetInt8(UNK);
  end;

  if iError = AUTH_WAIT_QUEUE then
  begin
    Packet.GetInt32('QueuePosition');
  end;

end;

procedure TSchControlPktPlugin.DecodeHdwSurvey;
begin
  Packet.SkipUnusefulData(Packet.BytesLeft, 'WardenData');
end;

procedure TSchControlPktPlugin.DecodePingPacket;
begin
  Packet.GetInt32('TimeOption');
  Packet.GetInt32('PreviousLatency');
end;

procedure TSchControlPktPlugin.DecodePongPacket;
begin
  Packet.GetInt32('TimeOption');
end;

procedure TSchControlPktPlugin.ProcessPacket(iOp: Word);
begin

  case iOp of
    CMSG_PING: DecodePingPacket();
    SMSG_PONG: DecodePongPacket();
    CMSG_AUTH_SESSION: DecodeAuthClient();
    SMSG_AUTH_CHALLENGE: DecodeAuthInit();
    SMSG_AUTH_RESPONSE: DecodeAuthResponse();
    SMSG_ADDON_INFORMATION: DecodeAddonInfo();
    CMSG_HARDWARE_SURVEY_RESULTS: DecodeHdwSurvey();
    SMSG_HARDWARE_SURVEY_REQUEST: DecodeHdwSurvey();
  end;

end;

initialization
  TSchControlPktPlugin.Create(
    'Control Packets Decoder',
    'All control flow packets are supported by this plugin.',
    '0.1',
    'BFG Team',
    True
    );

end.
