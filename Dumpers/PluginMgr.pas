unit PluginMgr;

interface

uses
  Classes, Debug,
  LoggerDef, PluginDef, RTFLogger, StringBuffer, SysUtils,
  TextLogger, Utils, Version, Windows, WoWOpCodes;

type
  ESchPluginManagerError = class(Exception);

  { Class Used to Manage all Plugin Related Calls }
  TRtPluginManager = class(TObject)
  private
    fLoadedPlugins: TStrings;
    fMainLog: String;
    fLogFiles: TStrings;
    fLocked: Boolean;
    fRTF: Boolean;

    fLogger: TSchGenericLogger;

    procedure SetRTF(const Value: Boolean);
    function GetRTFConflicts: Boolean;

    procedure WriteToLog(sBuff: String;
      bForceWrite: Boolean = False);
    function GetPluginList: TStrings;

  public
    constructor Create();
    destructor Destroy(); override;

    procedure ProcessPacket(iOpCode: Integer;
      bFromServer: Boolean; sBody: String);

    procedure InitializeCaches();
    procedure EmptyCaches(bHeader: Boolean);

    procedure DisableAllPlugins();
    procedure EnableAllFormatting();

    property Plugins: TStrings Read GetPluginList;
    property MainLog: String Read fMainLog Write fMainLog;
    property ToRTF: Boolean Read fRTF Write SetRTF;
    property RTFConflicts: Boolean Read GetRTFConflicts;
  end;

implementation

uses Globals;

{ TSchPluginManager }

constructor TRtPluginManager.Create();
begin
  fLocked := False;
  fLogFiles := TStringList.Create();
  fRTF := False;
  fLogger := nil;

  fLoadedPlugins := PluginDef.GetPluginList();
end;

destructor TRtPluginManager.Destroy;
var
  iI: Integer;
begin

  { Releasing Log Files }
  if fLogFiles.Count > 0 then  for iI := 0 to fLogFiles.Count - 1 do
      fLogFiles.Objects[iI].Free();

  fLogFiles.Free();

  inherited;

end;

procedure TRtPluginManager.DisableAllPlugins;
var
  i: Integer;
  Obj: TSchPlugin;
begin

  if (fLoadedPlugins.Count > 0) then  for i := 0 to fLoadedPlugins.Count - 1 do
    begin
      Obj := fLoadedPlugins.Objects[i] as TSchPlugin;
      Obj.Enabled := False;
    end;
end;

procedure TRtPluginManager.EmptyCaches(bHeader: Boolean);
begin
  if fLogger = nil then exit;

  if bHeader then fLogger.FinalizeHeader();
  WriteToLog(fLogger.GetLog(), True);
end;

procedure TRtPluginManager.EnableAllFormatting;
var
  i: Integer;
  Obj: TSchPlugin;
begin

  if (fLoadedPlugins.Count > 0) then  for i := 0 to fLoadedPlugins.Count - 1 do
    begin
      Obj := fLoadedPlugins.Objects[i] as TSchPlugin;

      if Obj.SupportsRTF then  Obj.Enabled := True;
    end;
end;

function TRtPluginManager.GetPluginList: TStrings;
begin

  Result := TStringList.Create();
  Result.Assign(fLoadedPlugins);

end;

function TRtPluginManager.GetRTFConflicts: Boolean;
var
  i: Integer;
  Obj: TSchPlugin;
begin

  if (fLoadedPlugins.Count > 0) then  for i := 0 to fLoadedPlugins.Count - 1 do
    begin
      Obj := fLoadedPlugins.Objects[i] as TSchPlugin;
      if (Obj.Enabled) and (not Obj.SupportsRTF) then
      begin
        Result := True;
        Exit;
      end;
    end;

  Result := False;
end;

procedure TRtPluginManager.InitializeCaches;
begin
  if fLogger = nil then exit;

  fLogger.InitializeHeader();
  WriteToLog(fLogger.GetLog());
end;

procedure TRtPluginManager.ProcessPacket(iOpCode: Integer;
  bFromServer: Boolean; sBody: String);
var
  i: Integer;
  Obj: TSchPlugin;

  iWant: TSchSelectionPower;
  iMostWant: TSchSelectionPower;
  cMostWant: TSchPlugin;
begin

  cMostWant := nil;
  iMostWant := spNotAccept;

  { Selects the plugin that will require the packet the most }
  if (fLoadedPlugins.Count > 0) then  for i := 0 to fLoadedPlugins.Count - 1 do
    begin
      Obj := fLoadedPlugins.Objects[i] as TSchPlugin;
      if (not Obj.Enabled) then Continue;

      // See plugin's desires now ...
      iWant := Obj.AcceptsPacket(iOpCode);
      if iWant > iMostWant then
      begin
        iMostWant := iWant;
        cMostWant := Obj;

        if iMostWant = spAcceptNeed then  break;
        { If we have a plugin that needs this packet most do not iterate more ... }

      end;
    end;

  // Now, iMostWant/cMostWant will contain the plugins that will actually want
  // the packet for itself ...

  if cMostWant = nil then exit;
  cMostWant.DecodePacket(iOpCode, sBody, bFromServer, fLogger);
  WriteToLog(fLogger.GetLog());

   { Yeah .. the system is quite retarded :) It was using multimple plugins with different log channels etc ...
     but now it's cut and only a few stupid things remains :)
   }

end;

procedure TRtPluginManager.SetRTF(const Value: Boolean);
begin
  fRTF := Value;

  if fRTF then  fLogger := TSchRTFLogger.Create()
  else
    fLogger := TSchTextLogger.Create();
end;

procedure TRtPluginManager.WriteToLog(sBuff: String; bForceWrite: Boolean);
var
  FOut: TextFile;

  Idx: Integer;
  Prov: TSchCacheProvider;
begin
  while (fLocked) do Sleep(20);
  fLocked := True;


  if fLogFiles.Count = 1 then Idx := 0
  else
    Idx := -1;
  if Idx = -1 then Idx := fLogFiles.AddObject('', TSchCacheProvider.Create(
      MaxCacheSize));
  Prov := (fLogFiles.Objects[Idx] as TSchCacheProvider);

  Prov.Cache := sBuff;
  if Prov.CanGetCache() and (not bForceWrite) then
  begin
    fLocked := False;
    Exit;
  end;

  sBuff := Prov.Cache;

  AssignFile(FOut, fMainLog);
 {$I-}
  if FileExists(fMainLog) then  Append(FOut)
  else
    Rewrite(FOut);

 {$I-}
  if IOResult <> 0 then
  begin
    fLocked := False;
    Exit;
  end;

  Write(FOut, sBuff);

  CloseFile(FOut);

  fLocked := False;
end;


end.
