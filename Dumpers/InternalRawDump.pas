unit InternalRawDump;

interface

uses
  Classes, LoggerDef,
  PluginDef,
  SysUtils, Utils, Version, Windows, WoWOpCodes;

type
  TSchInternalRawPlugin = class(TSchPlugin)
    procedure DecodePacket(iOpCode: Integer; sBody: String;
      bFromServer: Boolean; cLogger: TSchGenericLogger); override;
    function AcceptsPacket(iOp: Cardinal): TSchSelectionPower; override;
  end;

  TSchInternalDataPlugin = class(TSchPlugin)
    procedure DecodePacket(iOpCode: Integer; sBody: String;
      bFromServer: Boolean; cLogger: TSchGenericLogger); override;
    function AcceptsPacket(iOp: Cardinal): TSchSelectionPower; override;
  end;

implementation

{ TSchInternalRawPlugin }

function TSchInternalRawPlugin.AcceptsPacket(iOp: Cardinal): TSchSelectionPower;
begin
  { Accepts all packets for dumping ... but do not require them in any way ... }
  Result := spAcceptNeed;
end;

procedure TSchInternalRawPlugin.DecodePacket(iOpCode: Integer;
  sBody: String; bFromServer: Boolean; cLogger: TSchGenericLogger);
begin
  GenerateRawInfo(iOpCode, sBody, bFromServer, cLogger);
end;

{ TSchInternalDataPlugin }

function TSchInternalDataPlugin.AcceptsPacket(iOp: Cardinal): TSchSelectionPower;
begin
  { Accepts all packets for dumping ... but do not require them in any way ... }
  Result := spAcceptWhyNot;
end;

procedure TSchInternalDataPlugin.DecodePacket(iOpCode: Integer;
  sBody: String; bFromServer: Boolean; cLogger: TSchGenericLogger);
begin
  GenerateFormattedInfo(iOpCode, sBody, bFromServer, cLogger);
end;

initialization

  TSchInternalRawPlugin.Create(
    'Raw Data Dumper',
    'Dumps all data in form of hex-represented packet. Useful for parsing with another text-based tool',
    '1.1',
    'BFG Team',
    False
    );

  TSchInternalDataPlugin.Create(
    'Formatted Data Dumper',
    'Dumps all data in a readable form. Useful for raw development.',
    '1.1',
    'BFG Team',
    True
    );

end.
