unit WorldDecoder;

interface

uses Classes, Debug, PluginMgr, SysUtils,
  WoWOpCodes, WowPacket;

type
  { World Decoder Class. }
  TSchWorldDecoder = class(TObject)
  private
    fPluginManager: TRtPluginManager;

    procedure DecodeClientPacket(iCmd: Integer; sPacket: String);
    procedure DecodeServerPacket(iCmd: Integer; sPacket: String);
  public
    constructor Create(APluginManager: TRtPluginManager);
    destructor Destroy(); override;

    procedure ResetDecoder();
    procedure DecodePacket(bFromServer: Boolean;
      tPacket: TSchWoWPacket);
  end;

implementation

uses Globals, Main;

{ TSchWorldDecoder }

constructor TSchWorldDecoder.Create(APluginManager: TRtPluginManager);
begin

  fPluginManager := APluginManager;

  ResetDecoder();

end;

procedure TSchWorldDecoder.DecodeClientPacket(iCmd: Integer; sPacket: String);
var
  Name: String;
begin

  Name := GetOpcodeName(iCmd);
  Main.BFGMain.LogWSOpcode(Name, iCmd, True);

  fPluginManager.ProcessPacket(iCmd, False, sPacket);

end;

procedure TSchWorldDecoder.DecodePacket(bFromServer: Boolean; tPacket: TSchWoWPacket);
var
  OpCode: Integer;

begin
  OpCode := tPacket.OpCode;

  if bFromServer then  DecodeServerPacket(OpCode, tPacket.Body.StringBuffer)
  else
    DecodeClientPacket(OpCode, tPacket.Body.StringBuffer);

end;

procedure TSchWorldDecoder.DecodeServerPacket(iCmd: Integer; sPacket: String);
var
  Name: String;
begin

  Name := GetOpcodeName(iCmd);
  Main.BFGMain.LogWSOpcode(Name, iCmd, False);

  fPluginManager.ProcessPacket(iCmd, True, sPacket);

end;

destructor TSchWorldDecoder.Destroy;
begin

  inherited;

end;

procedure TSchWorldDecoder.ResetDecoder;
begin
end;

end.
