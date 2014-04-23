unit ByteDumpPlugin;

interface

uses
  Classes, LoggerDef,
  PluginDef, SysUtils,
  Utils, Version, Windows, WoWOpCodes;

type
  TSchByteDumpPlugin = class(TSchPlugin)
    procedure DecodePacket(iOpCode: Integer; sBody: String;
      bFromServer: Boolean; cLogger: TSchGenericLogger); override;
    function AcceptsPacket(iOp: Cardinal): TSchSelectionPower; override;
  end;

implementation

{ TSchByteDumpPlugin }

function TSchByteDumpPlugin.AcceptsPacket(iOp: Cardinal): TSchSelectionPower;
begin
  { Accepts all packets for dumping ... but do not require them in any way ... }
  Result := spAcceptNeed;
end;

procedure TSchByteDumpPlugin.DecodePacket(iOpCode: Integer; sBody: String;
  bFromServer: Boolean; cLogger: TSchGenericLogger);
var
  aTime: Int64;
  aCh: array[0..7] of Char absolute aTime;

  aLen: Cardinal;
  aLch: array[0..3] of Char absolute aLen;
begin
  aTime := DateTimeToPOSIX(Now());
  aLen := Length(sBody);

  cLogger.Log(Chr(Integer(bFromServer)) + // Direction
    aCh[0] + aCh[1] + aCh[2] + aCh[3] +   // Timestamp
    aCh[4] + aCh[5] + aCh[6] + aCh[7] + aLch[0] +
    aLch[1] + aLch[2] + aLch[3] + // Length of the packet
    sBody // Body;
    );

end;

initialization

  TSchByteDumpPlugin.Create(
    'Byte Dumper',
    'Dumps all data in a raw (byte-style) order with only a few data line direction, timestamp and length of the packet. `Komdori` request.',
    '0.5',
    'BFG Team',
    False
    );

end.
