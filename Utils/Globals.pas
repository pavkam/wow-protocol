unit Globals;

interface

uses
  Debug,
  Forms,
  MainDecoder, PluginMgr, SysUtils, Utils, Version, WorldDecoder;

procedure InitializeGlobals;
{ Internal !}

procedure DestroyGlobals;
{ Internal !}

var
  PluginManager: TRtPluginManager;   { Global Plugin Manager }
  WorldPacketsDecoder: TSchWorldDecoder;    { Global World Decoder  }
  MainDecoder: TSchMainDecoder;     { Global Main Decoder   }
  Logger: TDebugLogger;        { Global Debug Logger   }

implementation

procedure InitializeGlobals;
begin
  { Creating Globals }
  PluginManager := TRtPluginManager.Create;

  WorldPacketsDecoder := TSchWorldDecoder.Create(PluginManager);

  MainDecoder := TSchMainDecoder.Create(False);
end;

procedure DestroyGlobals;
begin
  WorldPacketsDecoder.Free;
  PluginManager.Free;
  MainDecoder.Free;
end;

initialization
  Logger := TDebugLogger.Initialize;
  InitializeGlobals;

finalization
  Logger.Finalize;
  Logger.Free;

end.
