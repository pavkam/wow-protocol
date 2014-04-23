unit ExtendablePlugin;

interface

uses
  Classes, LoggerDef, PluginDef, PluginSupport,
  SysUtils, zlibex;

type
  TSchExtendablePlugin = class(TSchPlugin)
  private
    fSupport: TSchPluginSupport;

  protected
    { Override this to implement your processing }
    procedure ProcessPacket(iOp: Word); virtual; abstract;

    property Packet: TSchPluginSupport Read fSupport;
  public
    procedure DecodePacket(iOpCode: Integer; sBody: String;
      bFromServer: Boolean; cLogger: TSchGenericLogger); override;

    constructor Create(sName, sInfo, sVer, sDev: String; bRTF: Boolean);
    destructor Destroy(); override;
  end;

implementation

{ TSchExtendablePlugin }

constructor TSchExtendablePlugin.Create(sName, sInfo, sVer, sDev: String;
  bRTF: Boolean);
begin
  inherited;
  fSupport := TSchPluginSupport.Create();
end;

procedure TSchExtendablePlugin.DecodePacket(iOpCode: Integer;
  sBody: String; bFromServer: Boolean; cLogger: TSchGenericLogger);
begin
  fSupport.Logger := cLogger;
  fSupport.StartPacketDecoding(sBody, iOpCode, bFromServer);

  try
    { Call override }
    ProcessPacket(iOpCode);
  except
    on EZLibError do
    begin
      fSupport.LogDecodeError('Packet decompression failed!');
      fSupport.StopPacketDecoding(True);
      exit;
    end;
    (*
    on ESchException do
    begin
      fSupport.LogDecodeError('Packet depleted! Wrong packet format assumed!');
      fSupport.StopPacketDecoding(True);
      exit;
    end;
    *)
    on Exception do
    begin
      fSupport.LogDecodeError('Decoder plugin "' + Name +
        '" performed an illegal operation!');
      fSupport.StopPacketDecoding(True);
      exit;
    end;
  end;

  fSupport.StopPacketDecoding();
end;

destructor TSchExtendablePlugin.Destroy;
begin
  fSupport.Destroy();
  inherited;
end;

end.
