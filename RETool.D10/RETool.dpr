program RETool;

uses
  Forms,
  Windows,
  SysUtils,
  Classes,
  Math,
  Main in '..\UI\Main.pas' {WoWMain},
  Utils in '..\Utils\Utils.pas',
  ZLibEx in '..\ZLib\ZLibEx.pas',
  WoWOpCodes in '..\Decoders\WoWOpCodes.pas',
  WorldDecoder in '..\Decoders\WorldDecoder.pas',
  PluginMgr in '..\Dumpers\PluginMgr.pas',
  Version in '..\Utils\Version.pas',
  Debug in '..\Utils\Debug.pas',
  PluginDef in '..\Dumpers\PluginDef.pas',
  StringBuffer in '..\Utils\StringBuffer.pas',
  WoWManager in '..\Decoders\WoWManager.pas',
  WoWPacket in '..\Decoders\WoWPacket.pas',
  Globals in '..\Utils\Globals.pas',
  MainDecoder in '..\Decoders\MainDecoder.pas',
  InternalRawDump in '..\Dumpers\InternalRawDump.pas',
  PieceShow in '..\UI\PieceShow.pas',
  HashMap in '..\Utils\HashMap.pas',
  ContainerInterfaces in '..\Utils\ContainerInterfaces.pas',
  Miscelaneous in '..\Utils\Miscelaneous.pas',
  ArrayList in '..\Utils\ArrayList.pas',
  Sets in '..\Utils\Sets.pas',
  PluginSupport in '..\Dumpers\PluginSupport.pas',
  BitBuffer in '..\Utils\BitBuffer.pas',
  ExtendablePlugin in '..\Dumpers\ExtendablePlugin.pas',
  ObjectsPlugin in '..\Dumpers\ObjectsPlugin.pas',
  WoWTypes in '..\Dumpers\WoWTypes.pas',
  UpdateFields in '..\Dumpers\UpdateFields.pas',
  ControlPktPlugin in '..\Dumpers\ControlPktPlugin.pas',
  FlowProcess in '..\Dumpers\FlowProcess.pas',
  ByteDumpPlugin in '..\Dumpers\ByteDumpPlugin.pas',
  LoggerDef in '..\Loggers\LoggerDef.pas',
  TextLogger in '..\Loggers\TextLogger.pas',
  RTFLogger in '..\Loggers\RTFLogger.pas',
  FileParser in '..\Utils\FileParser.pas',
  GenericUFExport in '..\UFExport\GenericUFExport.pas',
  DebugUFExport in '..\UFExport\DebugUFExport.pas',
  CStyleUFExport in '..\UFExport\CStyleUFExport.pas',
  YaweUFExport in '..\UFExport\YaweUFExport.pas',
  MangosUFExport in '..\UFExport\MangosUFExport.pas',
  MPQHandle in '..\MPQ\MPQHandle.pas',
  DBCHandle in '..\MPQ\DBCHandle.pas',
  MapWork in '..\MPQ\MapWork.pas',
  ADTHandle in '..\MPQ\ADTHandle.pas',
  MapOutputStore in '..\MPQ\MapOutputStore.pas',
  MapShow in '..\UI\MapShow.pas',
  ByteBuffer in '..\Utils\ByteBuffer.pas',
  FileHandle in '..\Utils\FileHandle.pas';

{$R *.res}

var
  AppMutex: THandle;  { Main Mutex. Will help us stop other instances and uninstaller }

begin
  { Initializing the First Lock }
  Logger.Lock;

  { Check for acquired mutex }

  if OpenMutex(MUTEX_ALL_ACCESS, False, 'RETool_BFGMutex') <> 0 then
  begin
    Logger.UnLock;
    Exit;
  end else
  begin
    AppMutex := CreateMutex(nil, False, 'RETool_BFGMutex');
  end;

  { Initializing UI }
  Application.Initialize;
  Application.Title := 'WoW RE Tool';
  Application.CreateForm(TBFGMain, BFGMain);
  { Custom Run Parameters }

  { Creating Globals }
  InitializeGlobals;

  { Taking Plugin Information }
  if not Assigned(PluginManager) then
  begin
    Application.MessageBox('There was an error at plugin loading time! Please repair and try again.', 'Error', MB_OK or MB_ICONHAND);

    Logger.UnLock;

    ReleaseMutex(AppMutex);
    Exit;
  end;

  BFGMain.cbbPlugins.Items.Assign(PluginManager.Plugins);
  BFGMain.cbbPlugins.ItemIndex := 0;
  BFGMain.cbbPlugins.OnChange(BFGMain.cbbPlugins);

  BFGMain.cbbFormat.Items.Assign(GenericUFExport.GetExportersList);
  BFGMain.cbbFormat.ItemIndex := 0;
  
  { Proceeding with normal steps }
  Logger.UnLock;
  SetPrecisionMode(pmSingle);
  Application.Run;

  ReleaseMutex(AppMutex);
  
  { Destroying Globals }
  DestroyGlobals;
end.
