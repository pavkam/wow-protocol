unit Main;

interface

uses
  ADTHandle, Classes, ComCtrls, Controls, DBCHandle,
  Debug, Dialogs, ExtCtrls,
  FileCtrl, FileParser, Forms, GenericUFExport,
  Globals, Graphics, IdIntercept, IdMappedPortTCP, IdTCPServer, ImgList,
  jpeg, MapShow, Menus,
  Messages, MPQHandle, PieceShow, PluginDef, PluginMgr, StdCtrls,
  StringBuffer, SysUtils,
  Utils, Version, Windows, WorldDecoder, WoWManager, XPMan;

type
  TWdxNotificationType = (wntMapCount, wntNewMap, wntNewTile);
  TProgressCallback = procedure(AUserData: Pointer; AData: Pointer;
    NotificationType: TWdxNotificationType);

  TBFGMain = class(TForm)
    pgcMain: TPageControl;
    tbMain: TTabSheet;
    tbOptions: TTabSheet;
    btExit: TButton;
    btStartStop: TButton;
    edtLogonServer: TEdit;
    edtLogonPort: TEdit;
    edtWorldPort: TEdit;
    edtOutFile: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btBrowse: TButton;
    dlgSave: TSaveDialog;
    Label5: TLabel;
    Label6: TLabel;
    edtExternalIp: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    KeyTimer: TTimer;
    tbPlugins: TTabSheet;
    cbbPlugins: TComboBox;
    lbCurrPlug: TLabel;
    gbInfo: TGroupBox;
    cbEnabled: TCheckBox;
    mmInfo: TMemo;
    Label11: TLabel;
    edtConnTime: TEdit;
    tbHelp: TTabSheet;
    pmTray: TPopupMenu;
    miRestart: TMenuItem;
    miStop: TMenuItem;
    miStart: TMenuItem;
    N1: TMenuItem;
    miExit: TMenuItem;
    MenuImages: TImageList;
    N2: TMenuItem;
    miRestore: TMenuItem;
    cbMinimizeOnRun: TCheckBox;
    cbSaveRealm: TCheckBox;
    LogSwapper: TTimer;
    rgKey: TRadioGroup;
    mmLog: TRichEdit;
    cbLogVis: TCheckBox;
    Label19: TLabel;
    Label21: TLabel;
    lbPlugName: TLabel;
    lbPlugVersion: TLabel;
    lbPlugID: TLabel;
    lbPlugDev: TLabel;
    lbPlugInfo: TLabel;
    lbPackets: TLabel;
    mmPack: TMemo;
    edtYAWE: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    edtOpenLogonPort: TEdit;
    Label22: TLabel;
    Panel1: TPanel;
    tbPost: TTabSheet;
    Label18: TLabel;
    Label20: TLabel;
    edtPostInFile: TEdit;
    edtPostOutFile: TEdit;
    btStartProcess: TButton;
    btBrowseIn: TButton;
    btBrowseOut: TButton;
    dlgOpen: TOpenDialog;
    pgMain: TProgressBar;
    cbLogRTF: TCheckBox;
    lbFormat: TLabel;
    btSelNone: TButton;
    btSelRTFed: TButton;
    tbUpdateExtract: TTabSheet;
    Label23: TLabel;
    edtWoWPath: TEdit;
    btBrowseWoW: TButton;
    btBrowseUFOut: TButton;
    edtUFPath: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    cbbFormat: TComboBox;
    btExtractUF: TButton;
    cbUnixLines: TCheckBox;
    tbMPQExtract: TTabSheet;
    Label26: TLabel;
    edtMPQPath: TEdit;
    btBrowseMPQPath: TButton;
    btExtractSelectedFiles: TButton;
    btLoadMPQ: TButton;
    lbxFiles: TListBox;
    Label27: TLabel;
    btCloseArchive: TButton;
    tbMapExtractor: TTabSheet;
    Label28: TLabel;
    edtWoWDataPath: TEdit;
    btBrowseWoWDir: TButton;
    Label29: TLabel;
    edtOutTTFile: TEdit;
    btBrowseOutTTFile: TButton;
    btExtractMaps: TButton;
    pgMaps: TProgressBar;
    lbMap: TLabel;
    lbMemory: TLabel;
    cbXCompress: TCheckBox;
    tbDataCheck: TTabSheet;
    Label30: TLabel;
    edtValCardinal: TEdit;
    Label31: TLabel;
    edtValDecimal: TEdit;
    Label32: TLabel;
    edtBinaryValue: TEdit;
    Label33: TLabel;
    edt4Chars: TEdit;
    Panel2: TPanel;
    Label34: TLabel;
    edt4CharsRev: TEdit;
    Label35: TLabel;
    edt4Bytes: TEdit;
    edt4BytesRev: TEdit;
    Label36: TLabel;
    Panel3: TPanel;
    Label37: TLabel;
    edtValFloat: TEdit;
    Label38: TLabel;
    edtValFloatRev: TEdit;
    Panel4: TPanel;
    Label39: TLabel;
    edtValCTime: TEdit;
    btGetValCTime: TButton;
    Label40: TLabel;
    Label41: TLabel;
    edtHexValue: TEdit;
    Label42: TLabel;
    edtHexPktVal: TEdit;
    pnlPlaceKeyPieces: TPanel;
    pnlPlaceMapDraw: TPanel;
    pnlPlaceRealms: TPanel;
    btToTray: TButton;
    Panel5: TPanel;
    Image2: TImage;
    Panel6: TPanel;
    Label15: TLabel;
    Image1: TImage;
    Label17: TLabel;
    Label16: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    procedure edtHexPktValChange(Sender: TObject);
    procedure edt4CharsRevChange(Sender: TObject);
    procedure edt4CharsChange(Sender: TObject);
    procedure edtValFloatChange(Sender: TObject);
    procedure btGetValCTimeClick(Sender: TObject);
    procedure edtHexValueChange(Sender: TObject);
    procedure edtValDecimalChange(Sender: TObject);
    procedure edtValCardinalChange(Sender: TObject);
    procedure btExtractMapsClick(Sender: TObject);
    procedure btBrowseOutTTFileClick(Sender: TObject);
    procedure btBrowseWoWDirClick(Sender: TObject);
    procedure btExtractSelectedFilesClick(Sender: TObject);
    procedure btCloseArchiveClick(Sender: TObject);
    procedure btLoadMPQClick(Sender: TObject);
    procedure edtMPQPathChange(Sender: TObject);
    procedure btBrowseMPQPathClick(Sender: TObject);
    procedure btExtractUFClick(Sender: TObject);
    procedure btBrowseUFOutClick(Sender: TObject);
    procedure btBrowseWoWClick(Sender: TObject);
    procedure btSelRTFedClick(Sender: TObject);
    procedure btSelNoneClick(Sender: TObject);
    procedure btStartProcessClick(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure btBrowseOutClick(Sender: TObject);
    procedure btBrowseInClick(Sender: TObject);
    procedure edtLogonPortKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btBrowseClick(Sender: TObject);
    procedure btStartStopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btExitClick(Sender: TObject);
    procedure srvLogonException(AThread: TIdPeerThread; AException: Exception);
    procedure srvLogonConnect(AThread: TIdMappedPortThread);
    procedure srvLogonOutboundConnect(AThread: TIdMappedPortThread;
      AException: Exception);
    procedure cbbRealmsChange(Sender: TObject);
    procedure srvRealmConnect(AThread: TIdMappedPortThread);
    procedure srvRealmException(AThread: TIdPeerThread; AException: Exception);
    procedure srvRealmOutboundConnect(AThread: TIdMappedPortThread;
      AException: Exception);
    procedure edtKeyPiecesEnter(Sender: TObject);
    procedure KeyTimerTimer(Sender: TObject);
    procedure cbbPluginsChange(Sender: TObject);
    procedure btToTrayClick(Sender: TObject);
    procedure miRestartClick(Sender: TObject);
    procedure miStopClick(Sender: TObject);
    procedure miStartClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure pmTrayPopup(Sender: TObject);
    procedure miRestoreClick(Sender: TObject);
    procedure srvRealmDisconnect(AThread: TIdMappedPortThread);
    procedure srvLogonDisconnect(AThread: TIdMappedPortThread);
    procedure srvLogonOutboundDisconnect(AThread: TIdMappedPortThread);
    procedure srvRealmOutboundDisconnect(AThread: TIdMappedPortThread);
    procedure tiTrayDblClick(Sender: TObject);
    procedure cbSaveRealmClick(Sender: TObject);
    procedure cbEnabledClick(Sender: TObject);
    procedure LogSwapperTimer(Sender: TObject);
    procedure cbLogVisClick(Sender: TObject);
    procedure mmLogEnter(Sender: TObject);

    procedure YAWESentUserDate(var Msg: TMessage); message WM_USER + 1;
    procedure MpqExtractionCallback(AData: Pointer;
      NotificationType: TWdxNotificationType);
  private
    { Private declarations }

    cbbRealms: TComboBox;
    srvLogon: TIdMappedPortTCP;
    srvRealm: TIdMappedPortTCP;
    tiTray: TTrayIcon;
    { ... }

    cCurrentMPQ: TSchMPQArchive;

    SPiece: TPieceShow;
    SMap: TMapShow;
    bUpdating: Boolean;

    sLastK: String;

    SavedRealm: WideString;

    ClientIntercept: TIdConnectionIntercept;
    ServerIntercept: TIdConnectionIntercept;

    WSClientIntercept: TIdConnectionIntercept;
    WSServerIntercept: TIdConnectionIntercept;

    { Saved Options }

    soLogonServerName, soPosX, soPosY, soExternalIp,
    soLogonPort, soLogonOpenPort, soWorldPort,
    soOutFileName, soConnTime, soMinimizeOnRun,
    soLogRTF, soSaveRealm, soSavedRealm,
    soPrecisePack: TSchSavedOption;

    bWSOccupied: Boolean;

    { ............. }

    procedure InitListeningSockets();
    procedure KillAllSockets();

    function CheckEnvironment(): Boolean;
    procedure SaveOptions();

    procedure ReceiveClientData(ASender: TIdConnectionIntercept; AStream: TStream);
    procedure ReceiveServerData(ASender: TIdConnectionIntercept; AStream: TStream);

    procedure WSReceiveClientData(ASender: TIdConnectionIntercept; AStream: TStream);
    procedure WSReceiveServerData(ASender: TIdConnectionIntercept; AStream: TStream);

    procedure ifaceControlsMPQTab();
    procedure ifaceControlsValues(Sender: TObject; iVal: Cardinal);
  public
    { Public declarations }
    bStarted: Boolean;
    bPostStarted: Boolean;
    iUsage: Integer;

    procedure BaloonHint(const Text: string; Delay: Integer = 5000);

    procedure LogLine(const Texts: array of string; const Colors: array of TColor;
      const Styles: array of TFontStyles);
    procedure LogError(const ErrorString: string);
    procedure LogWS(const WSMsg: string);

    procedure LogWSError(const WSErrorMsg: string);
    procedure LogWSSuccess(const WSOkMsg: string);
    procedure LogWSBytes(iBytes: Integer; bFromClient: Boolean);

    procedure LogLS(const LSMsg: string);
    procedure LogLSError(const LSErrorMsg: string);
    procedure LogLSSuccess(const LSOkMsg: string);

    procedure LogWSOpcode(const OpcodeName: string; iOp: Integer; bClient: Boolean);

    procedure LogAction(const ActionMsg: string);
  end;

var
  BFGMain: TBFGMain;

implementation

{$R *.dfm}

procedure TBFGMain.edtLogonPortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0' .. '9', #8]) then Key := #0;
end;

procedure TBFGMain.edtMPQPathChange(Sender: TObject);
begin
  ifaceControlsMPQTab();
end;

procedure TBFGMain.edtValCardinalChange(Sender: TObject);
var
  i: Cardinal;
begin
  i := StrToInt64Def(edtValCardinal.Text, 0);
  ifaceControlsValues(Sender, i);
end;

procedure TBFGMain.edtValDecimalChange(Sender: TObject);
var
  u: Cardinal;
  i: Integer absolute u;
begin
  i := StrToIntDef(edtValDecimal.Text, 0);
  ifaceControlsValues(Sender, u);
end;

procedure TBFGMain.edtValFloatChange(Sender: TObject);
var
  f: Single;
  i: Cardinal absolute f;
begin
  f := StrToFloatDef(StringReplace(edtValFloat.Text, '.', ',', [rfReplaceAll]), 0);
  ifaceControlsValues(Sender, i);
end;

procedure TBFGMain.FormCreate(Sender: TObject);
begin
  Caption := 'WoW RE Tool (ver. ' + ToolVersion + ')';
  Application.Title := 'WoW RE Tool ' + ToolVersion;

  { Add our Component }
  SPiece := TPieceShow.Create(tbMain);
  SPiece.Left := pnlPlaceKeyPieces.Left;
  SPiece.Top := pnlPlaceKeyPieces.Top;
  SPiece.Width := pnlPlaceKeyPieces.Width;
  SPiece.Height := pnlPlaceKeyPieces.Height;
  { ... }

  { Add our Component }
  SMap := TMapShow.Create(tbMapExtractor);
  SMap.Left := pnlPlaceMapDraw.Left;
  SMap.Top := pnlPlaceMapDraw.Top;
  SMap.Width := pnlPlaceMapDraw.Width;
  SMap.Height := pnlPlaceMapDraw.Height;
  { ... }

  cbbRealms := TComboBox.Create(tbMain);
  cbbRealms.Left := pnlPlaceRealms.Left;
  cbbRealms.Top := pnlPlaceRealms.Top;
  cbbRealms.Width := pnlPlaceRealms.Width;
  cbbRealms.Height := pnlPlaceRealms.Height;
  cbbRealms.Style := csDropDownList;
  cbbRealms.Enabled := False;
  cbbRealms.ItemHeight := 13;
  cbbRealms.Parent := tbMain;
  cbbRealms.OnChange := cbbRealmsChange;

  { Servers }
  srvLogon := TIdMappedPortTCP.Create(Self);
  srvLogon.OnConnect := srvLogonConnect;
  srvLogon.OnDisconnect := srvLogonDisconnect;
  srvLogon.OnException := srvLogonException;
  srvLogon.OnOutboundConnect := srvLogonOutboundConnect;
  srvLogon.OnOutboundDisconnect := srvLogonOutboundDisconnect;

  srvLogon.MaxConnections := 1;

  srvRealm := TIdMappedPortTCP.Create(Self);
  srvRealm.OnConnect := srvRealmConnect;
  srvRealm.OnDisconnect := srvRealmDisconnect;
  srvRealm.OnException := srvRealmException;
  srvRealm.OnOutboundConnect := srvRealmOutboundConnect;
  srvRealm.OnOutboundDisconnect := srvRealmOutboundDisconnect;

  srvRealm.MaxConnections := 1;

  { System Tray }
  tiTray := TTrayIcon.Create(Self);
  tiTray.Icon := Self.Icon;
  tiTray.IconIndex := -1;
  tiTray.PopupMenu := pmTray;
  tiTray.OnDblClick := tiTrayDblClick;
  tiTray.Visible := True;

  cCurrentMPQ := nil;
  bUpdating := False;

  pgcMain.ActivePageIndex := 0;

  bStarted := False;
  bPostStarted := False;
  btStartStop.Caption := 'Start';

  soLogonServerName := TSchSavedOption.Create(KeyOptions, 'LGServ',
    False, 'us.logon.worldofwarcraft.com');
  soExternalIp := TSchSavedOption.Create(KeyOptions, 'SFServ',
    False, 'localhost');
  soLogonPort := TSchSavedOption.Create(KeyOptions, 'LGPort', False, '3724');
  soLogonOpenPort := TSchSavedOption.Create(KeyOptions, 'LGOPort', False, '3724');
  soWorldPort := TSchSavedOption.Create(KeyOptions, 'WSPort', False, '3725');
  soOutFileName := TSchSavedOption.Create(KeyOptions, 'OutFile',
    False, LocalPath() + 'Logs\Dump_%d_.log');
  soConnTime := TSchSavedOption.Create(KeyOptions, 'ConnTime', False, '5000');
  soMinimizeOnRun := TSchSavedOption.Create(KeyOptions, 'MinRun', False, '0');
  soSaveRealm := TSchSavedOption.Create(KeyOptions, 'RealmRun', False, '0');
  soSavedRealm := TSchSavedOption.Create(KeyOptions, 'RealmSaved', False, '');
  soPrecisePack := TSchSavedOption.Create(KeyOptions, 'Precise', False, '0');
  soLogRTF := TSchSavedOption.Create(KeyOptions, 'RTF', False, '0');

  soPosX := TSchSavedOption.Create(KeyOptions, 'LastWX', False, '300');
  soPosY := TSchSavedOption.Create(KeyOptions, 'LastWY', False, '300');

  Left := soPosX.AsInteger;
  Top := soPosY.AsInteger;

  edtLogonServer.Text := soLogonServerName.AsString;
  edtExternalIp.Text := soExternalIp.AsString;
  edtLogonPort.Text := soLogonPort.AsString;
  edtOpenLogonPort.Text := soLogonOpenPort.AsString;
  edtWorldPort.Text := soWorldPort.AsString;
  edtOutFile.Text := soOutFileName.AsString;
  edtConnTime.Text := soConnTime.AsString;

  cbMinimizeOnRun.Checked := soMinimizeOnRun.AsBoolean;
  cbSaveRealm.Checked := soSaveRealm.AsBoolean;
  cbLogRTF.Checked := soLogRTF.AsBoolean;

  if cbSaveRealm.Checked then  SavedRealm := soSavedRealm.AsUnicode;

  try
    rgKey.ItemIndex := soPrecisePack.AsInteger;
  except
    rgKey.ItemIndex := 0;
  end;

  ClientIntercept := TIdConnectionIntercept.Create(nil);
  ClientIntercept.OnReceive := ReceiveClientData;

  ServerIntercept := TIdConnectionIntercept.Create(nil);
  ServerIntercept.OnReceive := ReceiveServerData;

  WSClientIntercept := TIdConnectionIntercept.Create(nil);
  WSClientIntercept.OnReceive := WSReceiveClientData;

  WSServerIntercept := TIdConnectionIntercept.Create(nil);
  WSServerIntercept.OnReceive := WSReceiveServerData;

end;

procedure TBFGMain.FormDestroy(Sender: TObject);
begin
  SaveOptions();

  ClientIntercept.Free();
  ServerIntercept.Free();

  WSClientIntercept.Free();
  WSServerIntercept.Free();

  soLogRTF.Free();
  soPosX.Free();
  soPosY.Free();
  soLogonServerName.Free();
  soExternalIp.Free();
  soLogonPort.Free();
  soWorldPort.Free();
  soOutFileName.Free();
  soConnTime.Free();
  soMinimizeOnRun.Free();
  soSaveRealm.Free();
  soSavedRealm.Free();
  soPrecisePack.Free();

end;

procedure TBFGMain.ifaceControlsMPQTab;
begin
  if not Assigned(cCurrentMPQ) then
  begin
    edtMPQPath.Enabled := True;
    btBrowseMPQPath.Enabled := True;

    lbxFiles.Enabled := False;
    btExtractSelectedFiles.Enabled := False;
    btCloseArchive.Enabled := False;

    if FileExists(edtMPQPath.Text) then  btLoadMPQ.Enabled := True
    else
      btLoadMPQ.Enabled := False;

  end else
  begin

    lbxFiles.Enabled := True;
    btExtractSelectedFiles.Enabled := (lbxFiles.ItemIndex > -1);
    btCloseArchive.Enabled := True;

    edtMPQPath.Enabled := False;
    btLoadMPQ.Enabled := False;
    btBrowseMPQPath.Enabled := False;
  end;
end;



procedure TBFGMain.ifaceControlsValues(Sender: TObject; iVal: Cardinal);
var
  c: array[0..3] of Char absolute iVal;

  f2: Single;
  c2: array[0..3] of Char absolute f2;

  f: Single absolute iVal;
begin
  if bUpdating then Exit;
  bUpdating := True;

  if Sender <> edtValCardinal then  edtValCardinal.Text := IntToStr(iVal);

  if Sender <> edtValDecimal then  edtValDecimal.Text := IntToStr(Integer(iVal));

  if Sender <> edtHexValue then  edtHexValue.Text := IntToHex(iVal, 8);

  if Sender <> edt4Chars then
  begin
    edt4Chars.Text := (c[0]) + (c[1]) + (c[2]) + (c[3]);
  end;

  if Sender <> edt4CharsRev then
  begin
    edt4CharsRev.Text := (c[3]) + (c[2]) + (c[1]) + (c[0]);
  end;

  if Sender <> edt4Bytes then
  begin
    edt4Bytes.Text := IntToStr(Ord(c[0])) + ' ' +
      IntToStr(Ord(c[1])) + ' ' +
      IntToStr(Ord(c[2])) + ' ' +
      IntToStr(Ord(c[3]));
  end;

  if Sender <> edt4BytesRev then
  begin
    edt4BytesRev.Text := IntToStr(Ord(c[3])) + ' ' +
      IntToStr(Ord(c[2])) + ' ' +
      IntToStr(Ord(c[1])) + ' ' +
      IntToStr(Ord(c[0]));
  end;

  if Sender <> edtHexPktVal then
  begin
    edtHexPktVal.Text := IntToHex(Ord(c[0]), 2) + ' ' +
      IntToHex(Ord(c[1]), 2) + ' ' +
      IntToHex(Ord(c[2]), 2) + ' ' +
      IntToHex(Ord(c[3]), 2);
  end;

  if Sender <> edtValFloat then
  begin
    edtValFloat.Text := StringReplace(FloatToStr(f), ',', '.', [rfReplaceAll]);
  end;

  if Sender <> edtValFloatRev then
  begin
    c2[0] := c[3];
    c2[1] := c[2];
    c2[2] := c[1];
    c2[3] := c[0];

    edtValFloatRev.Text := StringReplace(FloatToStr(f2), ',', '.', [rfReplaceAll]);
  end;

  if Sender <> btGetValCTime then
  begin
    edtValCTime.Text := DateTimeToStr(POSIXToDateTime(iVal));
  end;

  if Sender <> edtBinaryValue then
  begin
    edtBinaryValue.Text := IntToBinary(iVal, 4);
  end;

  bUpdating := False;
end;

procedure TBFGMain.btBrowseClick(Sender: TObject);
begin
  dlgSave.Filter := 'Log Files (*.log)|*.log|All Files (*.*)|*.*';
  dlgSave.FileName := edtOutFile.Text;

  if dlgSave.Execute then
  begin
    if (ExtractFileExt(dlgSave.FileName) = '') and (dlgSave.FilterIndex = 1) then
      dlgSave.FileName := dlgSave.FileName + '.log';

    edtOutFile.Text := dlgSave.FileName;
  end;

end;

procedure TBFGMain.btBrowseInClick(Sender: TObject);
begin
  dlgOpen.Filter := 'Log Files (*.log)|*.log|All Files (*.*)|*.*';
  dlgOpen.FileName := edtPostInFile.Text;

  if dlgOpen.Execute then  edtPostInFile.Text := dlgOpen.FileName;
end;

procedure TBFGMain.btBrowseMPQPathClick(Sender: TObject);
begin
  dlgOpen.Filter := 'MPQ Archives (*.mpq)|*.mpq';
  dlgOpen.FileName := edtMPQPath.Text;

  if dlgOpen.Execute then  edtMPQPath.Text := dlgOpen.FileName;
end;

procedure TBFGMain.btBrowseOutClick(Sender: TObject);
begin
  dlgSave.Filter := 'Log Files (*.log)|*.log|All Files (*.*)|*.*';
  dlgSave.FileName := edtPostOutFile.Text;

  if dlgSave.Execute then
  begin
    if (ExtractFileExt(dlgSave.FileName) = '') and (dlgSave.FilterIndex = 1) then
      dlgSave.FileName := dlgSave.FileName + '.log';

    edtPostOutFile.Text := dlgSave.FileName;
  end;
end;

procedure TBFGMain.btBrowseOutTTFileClick(Sender: TObject);
begin
  dlgSave.Filter := 'YMF Files (*.ymf)|*.ymf';
  dlgSave.FileName := edtOutTTFile.Text;

  if dlgSave.Execute then
  begin
    if (ExtractFileExt(dlgSave.FileName) = '') then
      dlgSave.FileName := dlgSave.FileName + '.ymf';

    edtOutTTFile.Text := dlgSave.FileName;
  end;
end;

procedure TBFGMain.btBrowseUFOutClick(Sender: TObject);
begin
  dlgSave.Filter := 'Output Files (*.txt)|*.txt|All Files (*.*)|*.*';
  dlgSave.FileName := edtUFPath.Text;

  if dlgSave.Execute then
  begin
    if (ExtractFileExt(dlgSave.FileName) = '') and (dlgSave.FilterIndex = 1) then
      dlgSave.FileName := dlgSave.FileName + '.txt';

    edtUFPath.Text := dlgSave.FileName;
  end;
end;

procedure TBFGMain.btBrowseWoWClick(Sender: TObject);
begin
  dlgOpen.Filter := 'WoW Executable (*.exe)|*.exe';
  dlgOpen.FileName := edtWoWPath.Text;

  if dlgOpen.Execute then  edtWoWPath.Text := dlgOpen.FileName;
end;

procedure TBFGMain.btBrowseWoWDirClick(Sender: TObject);
var
  sDir: String;
  soWoW: TSchSavedOption;
begin
  sDir := edtWoWDataPath.Text;

  if sDir = '' then
  begin
    soWoW := TSchSavedOption.Create('\SOFTWARE\Blizzard Entertainment\World of Warcraft',
      'InstallPath', True);
    sDir := soWoW.AsString;

    if sDir <> '' then  sDir := sDir + 'data\';

    soWoW.Free();
  end;

  SelectDirectory('Select WoW Data Folder', '', sDir);

  edtWoWDataPath.Text := sDir;
end;

procedure TBFGMain.btCloseArchiveClick(Sender: TObject);
begin
  FreeAndNil(cCurrentMPQ);
  lbxFiles.Clear();

  ifaceControlsMPQTab();
end;

function sCut(var sLine: String): String;
var
  i: Integer;
begin
  Result := '';
  i := Pos('|', sLine);
  if i <= 1 then Exit;

  Result := Copy(sLine, 1, i - 1);
  Delete(sLine, 1, i);
end;

procedure TBFGMain.btSelNoneClick(Sender: TObject);
begin
  PluginManager.DisableAllPlugins();
  cbbPlugins.OnChange(cbbPlugins);
end;

procedure TBFGMain.btSelRTFedClick(Sender: TObject);
begin
  PluginManager.DisableAllPlugins();
  PluginManager.EnableAllFormatting();
  cbbPlugins.OnChange(cbbPlugins);
end;

procedure TBFGMain.btStartProcessClick(Sender: TObject);
var
  iLines: Integer;
  fIn: TextFile;
  sLine: String;

  bDirection: Boolean;
  iOp: Cardinal;
  sBody: String;
begin
  { Checks }

  FileClose(FileCreate(edtPostOutFile.Text));

  if not FileExists(edtPostOutFile.Text) then
  begin
    Application.MessageBox(
      'The output log file cannot be created! Please check the correct path and try again!',
      'Error', MB_OK or MB_ICONHAND);
    Exit;
  end;

  if not FileExists(edtPostInFile.Text) then
  begin
    Application.MessageBox(
      'The input log file cannot be accesed! Please check the correct path and try again!',
      'Error', MB_OK or MB_ICONHAND);
    Exit;
  end;

  iLines := FileLines(edtPostInFile.Text);

  if iLines = 0 then
  begin
    Application.MessageBox('The input log file is invalid!', 'Error',
      MB_OK or MB_ICONHAND);
    Exit;
  end;

  { -- }

  bPostStarted := True;
  pgcMain.Enabled := False;

  { Processing }

  pgMain.Max := iLines;
  pgMain.Position := 0;

  AssignFile(fIn, edtPostInFile.Text);
 {$I-}
  Reset(fIn);
 {$I+}

  PluginManager.MainLog := edtPostOutFile.Text;
  PluginManager.ToRTF := cbLogRTF.Checked;
  if PluginManager.ToRTF then PluginManager.InitializeCaches;


  while not EOF(fIn) do
  begin
    ReadLn(fIn, sLine);
    pgMain.Position := pgMain.Position + 1;

    bDirection := StrToIntDef(sCut(sLine), 0) > 0;
    iOp := StrToIntDef(sCut(sLine), 0);
    sBody := htoa(sLine);

    if (iOp = 0) then
    begin
      Application.MessageBox('Invalid input format! Expected Raw Dump!',
        'Error', MB_OK or MB_ICONHAND);
      Break;
    end;

    PluginManager.ProcessPacket(iOp, bDirection, sBody);
    Application.ProcessMessages();
  end;

  CloseFile(fIn);

  Application.MessageBox('Parsing Complete OK! You can now look at the log files :)',
    'Succes', MB_OK or MB_ICONEXCLAMATION);
  pgMain.Position := 0;

  pgcMain.Enabled := True;
  bPostStarted := False;
end;

procedure TBFGMain.btStartStopClick(Sender: TObject);
begin
  Logger.Lock();

  cbbRealms.Clear();

  if not bStarted then
  begin // Start Socket

    if not CheckEnvironment() then
    begin
      Logger.UnLock();

      Exit;
    end;

    InitListeningSockets();

    if (cbMinimizeOnRun.Checked) and (not tiTray.Visible) then
      btToTray.OnClick(btToTray);

    bWSOccupied := False;
    bStarted := True;
    btStartStop.Caption := 'Stop';
    iUsage := 0;

    tbOptions.Enabled := False;
    tbPost.Enabled := False;
    tbUpdateExtract.Enabled := False;
    tbMPQExtract.Enabled := False;
    tbMapExtractor.Enabled := False;
    tbDataCheck.Enabled := False;
    btExit.Enabled := False;
    cbbRealms.Enabled := False;

    cbbPlugins.Enabled := False;
    cbEnabled.Enabled := False;

    rgKey.Enabled := False;
    cbSaveRealm.Enabled := False;
    cbMinimizeOnRun.Enabled := False;

  end else
  begin // End Socket
    Logger.AbortPendingThreads();
    PluginManager.EmptyCaches(True);

    KillAllSockets();

    SPiece.ClearPieces();
    KeyTimer.Enabled := False;

    bStarted := False;
    btStartStop.Caption := 'Start';
    tbOptions.Enabled := True;
    tbPost.Enabled := True;
    tbUpdateExtract.Enabled := True;
    tbMPQExtract.Enabled := True;
    tbMapExtractor.Enabled := True;
    tbDataCheck.Enabled := True;


    btExit.Enabled := True;
    cbbRealms.Enabled := False;

    iUsage := 0;

    cbbPlugins.Enabled := True;
    cbEnabled.Enabled := True;

    rgKey.Enabled := True;
    cbSaveRealm.Enabled := True;
    cbMinimizeOnRun.Enabled := True;

  end;

  Logger.UnLock();
end;

procedure TBFGMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if bPostStarted then
  begin
    CanClose := False;
    Exit;
  end;

  if bStarted then  btStartStop.OnClick(btStartStop);

  CanClose := True;
end;

procedure TBFGMain.btExitClick(Sender: TObject);
begin
  Logger.Lock();

  Close();

  Logger.UnLock();
end;

(*
type
  TExtractionOption = (eoCompressed);
  TExtractionOptions = set of TExtractionOption;

function WdxExtractAdtInfoEx(const AFile: String; const ASource: String;
  AOptions: TExtractionOptions; AProgressCallback: TProgressCallback;
  AProgressUserData: Pointer): Integer;
  external 'wdx32.dll' Name 'WdxExtractAdtInfoEx';

function WdxGetWoWDataPath(var AString: String): Integer;
  external 'wdx32.dll' Name 'WdxGetWoWDataPath';
*)

procedure TBFGMain.MpqExtractionCallback(AData: Pointer;
  NotificationType: TWdxNotificationType);
type
  TTerrainType = (ttWater, ttLand);

  PTileData = ^TTileData;

  TTileData = record
    X, Y: Byte;
    TerrainType: TTerrainType;
    Name: PChar;
  end;

  TMapData = record
    Id: Longword;
    Name: PChar;
  end;
var
  pData: PTileData;
begin
  case NotificationType of
    wntMapCount:
    begin
      pgMaps.Max := 64 * 64 * PLongword(AData)^;
    end;
    wntNewMap:
    begin
      SMap.ClearBlocks;
    end;
    wntNewTile:
    begin
      pData := AData;
      lbMap.Caption := pData^.Name;
      case pData^.TerrainType of
        ttLand: SMap.Blocks[pData^.X, pData^.Y] := clMaroon;
        ttWater: SMap.Blocks[pData^.X, pData^.Y] := clBlue;
      end;
      pgMaps.Position := pgMaps.Position + 1;
    end;
  end;
  lbMemory.Caption := 'Mem: ' + IntToStr((GetHeapStatus().TotalAllocated) div
    1024) + ' Kb';
  Application.ProcessMessages;
end;

procedure TBFGMain.btExtractMapsClick(Sender: TObject);
var
  //iOpts: TExtractionOptions;
  sPath: String;
begin
  lbMap.Visible := True;
  lbMap.Caption := '';

  lbMemory.Visible := True;
  lbMemory.Caption := '';

  //iOpts := [];
  //if cbXCompress.Checked then Include(iOpts, eoCompressed);
  //WdxGetWoWDataPath(sPath);

  //WdxExtractAdtInfoEx(edtOutTTFile.Text, sPath, iOpts,
  //  @TBFGMain.MpqExtractionCallback, Self);

  SMap.ClearBlocks;

  pgMaps.Position := 0;

  lbMap.Visible := False;
  lbMemory.Visible := False;

  bPostStarted := False;
  pgcMain.Enabled := True;
end;

procedure TBFGMain.btExtractSelectedFilesClick(Sender: TObject);
var
  sFile: string;
begin
  sFile := lbxFiles.Items[lbxFiles.ItemIndex];

  dlgSave.Filter := 'All Files (*.*)|*.*';
  dlgSave.FileName := ExtractFileName(sFile);

  if dlgSave.Execute then
  begin
    bPostStarted := True;
    pgcMain.Enabled := False;

    if not cCurrentMPQ.SaveFile(lbxFiles.ItemIndex, dlgSave.FileName) then
      Application.MessageBox(
        'The selected file could not be saved! Please check your drive.',
        'Error', MB_OK or MB_ICONHAND);

    bPostStarted := False;
    pgcMain.Enabled := True;
  end;
end;

procedure TBFGMain.btExtractUFClick(Sender: TObject);
var
  fp: TSchFileParser;
  i: Integer;
  cObj: TSchGenericUFExporter;
begin
  FileClose(FileCreate(edtUFPath.Text));

  if not FileExists(edtUFPath.Text) then
  begin
    Application.MessageBox(
      'The output file could not be created! Please select a correct path and try again!',
      'Error', MB_OK or MB_ICONHAND);
    Exit;
  end;

  if not FileExists(edtWoWPath.Text) then
  begin
    Application.MessageBox('Specified WoW executable is unreadable or in use!',
      'Error', MB_OK or MB_ICONHAND);
    Exit;
  end;

  fp := TSchFileParser.Create(edtWoWPath.Text);
  fp.Load();

  if not fp.ProcessWoWFile() then
  begin
    fp.Destroy();
    Application.MessageBox('Specified WoW executable is in wrong format or corrupt',
      'Attention', MB_OK or MB_ICONEXCLAMATION);

    exit;
  end;

  cObj := cbbFormat.Items.Objects[cbbFormat.ItemIndex] as TSchGenericUFExporter;
  cObj.InsertHeader(fp.Build, fp.Version, fp.FileSize, fp.UFCount);

  for i := 0 to fp.UFCount - 1 do cObj.ProcessUpdateField(fp.UF[i]);

  cObj.InsertFooter();
  cObj.Save(edtUFPath.Text, not cbUnixLines.Checked);

  fp.Destroy();

  Application.MessageBox(
    'Update Fields Extraction finished OK! You can now enjoy the data :)',
    'Succes', MB_OK or MB_ICONEXCLAMATION);
end;

procedure TBFGMain.btGetValCTimeClick(Sender: TObject);
var
  iT: Cardinal;
begin
  iT := DateTimeToPOSIX(Now());

  edtValCTime.Text := DateTimeToStr(POSIXToDateTime(iT));
  ifaceControlsValues(Sender, iT);
end;

procedure TBFGMain.btLoadMPQClick(Sender: TObject);
var
  i: Integer;
begin
  { Load selected MPQ Archive }

  try
    cCurrentMPQ := TSchMPQArchive.Create(edtMPQPath.Text);

    if cCurrentMPQ.FileCount = 0 then  raise Exception.Create('Dummy!');

  except
    Application.MessageBox(
      'Invalid or Empty MPQ archive specified or another error occured!',
      'Error', MB_OK or MB_ICONHAND);
    cCurrentMPQ := nil;
    Exit;
  end;

  if cCurrentMPQ.FileCount > 0 then  for i := 0 to cCurrentMPQ.FileCount - 1 do
    begin
      lbxFiles.AddItem(cCurrentMPQ.Files[i], nil);
    end;

  lbxFiles.ItemIndex := 0;
  ifaceControlsMPQTab();
end;

procedure TBFGMain.InitListeningSockets;
begin

  LogAction('Initializing Sockets ...');

  srvLogon.DefaultPort := atoi(edtLogonPort.Text);
  srvLogon.MappedHost := edtLogonServer.Text;
  srvLogon.MappedPort := atoi(edtOpenLogonPort.Text);
  srvLogon.Active := True;

  srvRealm.DefaultPort := atoi(edtWorldPort.Text);
  srvRealm.MappedPort := atoi(edtWorldPort.Text);

  LogAction('Operation Complete!');

end;

procedure TBFGMain.KillAllSockets;
begin

  LogAction('Shutting Down Sockets ...');

  try
    srvLogon.Active := False;
  except
    on Exception do ;
  end;

  try
    srvRealm.Active := False;
  except
    on Exception do ;
  end;

  LogAction('Operation Complete!');

end;

procedure TBFGMain.srvLogonException(AThread: TIdPeerThread; AException: Exception);
begin
  Logger.Lock();

  LogLSError('Connection Exception (' + AException.ClassName + ':"' +
    AException.Message + '")... And?');
  BaloonHint('Client "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '" raised exception "' +
    AException.ClassName + '" on LS. Disconnected!');

  Logger.UnLock();
end;

procedure TBFGMain.srvLogonConnect(AThread: TIdMappedPortThread);
begin
  Logger.Lock();

  LogLSSuccess('Connected "' + AThread.Connection.Socket.Binding.PeerIP + ':' +
    IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '"');
  BaloonHint('Client Connected on LS from ' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort));

  AThread.ConnectTimeOut := atoi(edtConnTime.Text);


  MainDecoder.ExternalIP := edtExternalIP.Text;
  MainDecoder.ExternalPort := atoi(edtWorldPort.Text);

  SPiece.ClearPieces();
  sLastK := '';

  KeyTimer.Enabled := True;

  AThread.Connection.Intercept := ClientIntercept;

  if srvRealm.Active then
  begin
    try
      srvRealm.Active := False;
    except
      on Exception do ;
    end;
  end;

  Logger.UnLock();
end;

procedure TBFGMain.ReceiveClientData(ASender: TIdConnectionIntercept; AStream: TStream);
begin
  Logger.Lock();

  iUsage := iUsage + AStream.Size;

  LogLS('Read From Client ' + IntToStr(AStream.Size) + ' Bytes.');
  MainDecoder.AddClientSentRawData(ReadFromStream(AStream));

  if MainDecoder.VersionFailed() then
  begin
    BaloonHint(
      'Wrong Client Version. We have a strict range of versions that we support. Halting !'
      );

    btStartStop.OnClick(btStartStop);
  end;

  Logger.UnLock();
end;

procedure TBFGMain.ReceiveServerData(ASender: TIdConnectionIntercept; AStream: TStream);
var
  i: Integer;

begin
  Logger.Lock();

  iUsage := iUsage + AStream.Size;

  LogLS('Read From Server ' + IntToStr(AStream.Size) + ' Bytes.');
  MainDecoder.AddServerSentRawData(ReadFromStream(AStream));

  if MainDecoder.PartialRealmList() then
  begin
    LogLS('Partial RS Detected. Clearing Buffer and Waiting ...');
    AStream.Size := 0;
  end;

  if MainDecoder.FullRealmList() then
  begin
    WriteToStream(AStream, MainDecoder.GeneratedRealmList());

    if cbbRealms.ItemIndex < 1 then
    begin

      cbbRealms.Items.Assign(MainDecoder.RealmNames);
      cbbRealms.Items.Insert(0, 'Choose realm here before in game ...');
      cbbRealms.ItemIndex := 0;
      cbbRealms.Enabled := True;

      i := cbbRealms.Items.IndexOf(SavedRealm);
      if i <> -1 then
      begin
        cbbRealms.ItemIndex := i;

        BaloonHint('Realm List received from the server. Sniffer has selected the last used one!'
          );

        cbbRealms.OnChange(cbbRealms);
      end;

      BaloonHint(
        'Realm List received from the server. Please select the realm you desire from within the Sniffer!'
        );
    end;
  end;

  Logger.UnLock();
end;

procedure TBFGMain.SaveOptions;
begin
  soPosX.AsInteger := Left;
  soPosY.AsInteger := Top;

  soLogonServerName.AsString := edtLogonServer.Text;
  soExternalIp.AsString := edtExternalIp.Text;
  soLogonPort.AsString := edtLogonPort.Text;
  soLogonOpenPort.AsString := edtOpenLogonPort.Text;

  soWorldPort.AsString := edtWorldPort.Text;
  soOutFileName.AsString := edtOutFile.Text;
  soConnTime.AsString := edtConnTime.Text;
  soMinimizeOnRun.AsBoolean := cbMinimizeOnRun.Checked;
  soSaveRealm.AsBoolean := cbSaveRealm.Checked;
  soSavedRealm.AsUnicode := SavedRealm;
  soPrecisePack.AsInteger := rgKey.ItemIndex;
  soLogRTF.AsBoolean := cbLogRTF.Checked;
end;

procedure TBFGMain.srvLogonOutboundConnect(AThread: TIdMappedPortThread;
  AException: Exception);
begin
  Logger.Lock();

  AThread.OutboundClient.Intercept := ServerIntercept;

  Logger.UnLock();
end;

procedure TBFGMain.cbbRealmsChange(Sender: TObject);
var
  RlmIp: String;
  RlmPort: Integer;

  Rlm: String;
begin
  Logger.Lock();

  if cbbRealms.ItemIndex < 1 then
  begin
    Logger.UnLock();
    Exit;
  end;

  LogAction('Initializing Realm Sockets ...');

  SavedRealm := cbbRealms.Items[cbbRealms.ItemIndex];

  Rlm := MainDecoder.Realms.Strings[cbbRealms.ItemIndex - 1];

  RlmIp := Copy(Rlm, 1, Pos(':', Rlm) - 1);
  RlmPort := atoi(Copy(Rlm, Pos(':', Rlm) + 1, Length(Rlm)));

  srvRealm.MappedHost := RlmIp;
  srvRealm.MappedPort := RlmPort;
  srvRealm.Active := True;

  LogAction('Operation Complete!');

  cbbRealms.Enabled := False;

  Logger.UnLock();
end;

procedure TBFGMain.srvRealmConnect(AThread: TIdMappedPortThread);
begin
  Logger.Lock();

  LogWSSuccess('Connected "' + AThread.Connection.Socket.Binding.PeerIP + ':' +
    IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '"');

  BaloonHint('Client Connected on WS from ' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort));

  AThread.Connection.Intercept := WSClientIntercept;
  AThread.ConnectTimeOut := atoi(edtConnTime.Text);

  PluginManager.MainLog :=
    StringReplace(edtOutFile.Text, '%d', GenerateFileStyleDate(), [rfReplaceAll]);
  PluginManager.ToRTF := cbLogRTF.Checked;
  PluginManager.InitializeCaches();

  WorldPacketsDecoder.ResetDecoder();

  case rgKey.ItemIndex of
    0: MainDecoder.ResetDecoder(False);
    1: MainDecoder.ResetDecoder(True);
    else
      MainDecoder.ResetDecoder(False);
  end;

  Logger.UnLock();
end;

procedure TBFGMain.srvRealmException(AThread: TIdPeerThread; AException: Exception);
begin
  Logger.Lock();

  LogWSError('Connection Exception (' + AException.ClassName + ':"' +
    AException.Message + '")... And?');
  BaloonHint('Client "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '" raised exception "' +
    AException.ClassName + '" on WS. Disconnected!');

  Logger.UnLock();
end;

procedure TBFGMain.WSReceiveClientData(ASender: TIdConnectionIntercept; AStream: TStream);
begin
  Logger.Lock();

  while bWSOccupied do Sleep(10);
  bWSOccupied := True;

  iUsage := iUsage + AStream.Size;

  LogWSBytes(AStream.Size, True);
  MainDecoder.AddWSClientSentRawData(ReadFromStream(AStream));

  if MainDecoder.KeyFailed() then
  begin
    LogWSError('Key Invalid. Halting !');
    BaloonHint('Invalid Key Detected! Halting WS Connection! Please Try again.');

    btStartStop.OnClick(btStartStop);
  end;

  bWSOccupied := False;
  Logger.UnLock();
end;

procedure TBFGMain.WSReceiveServerData(ASender: TIdConnectionIntercept; AStream: TStream);
begin
  Logger.Lock();

  while bWSOccupied do Sleep(10);
  bWSOccupied := True;

  iUsage := iUsage + AStream.Size;

  LogWSBytes(AStream.Size, False);
  MainDecoder.AddWSServerSentRawData(ReadFromStream(AStream));

  if MainDecoder.KeyFailed() then
  begin
    LogWSError('Key Invalid. Halting !');
    BaloonHint('Invalid Key Detected! Halting WS Connection! Please Try again.');

    btStartStop.OnClick(btStartStop);
  end;

  bWSOccupied := False;
  Logger.UnLock();
end;

procedure TBFGMain.YAWESentUserDate(var Msg: TMessage);
var
  sUser, sHash: String;
begin
  // Do stuff :)

  sUser := htoa(Copy(edtYAWE.Text, 1, Pos(':', edtYAWE.Text) - 1));
  sHash := Copy(edtYAWE.Text, Pos(':', edtYAWE.Text) + 1, Length(edtYAWE.Text));
  edtYAWE.Text := 'YAWE';

  if rgKey.ItemIndex <> 2 then exit; // Ignore otherwise


  if UpperCase(sUser) = UpperCase(MainDecoder.ClientName) then
  begin
    LogWSSuccess('YAWE sent the hash key: ' + sHash);
    MainDecoder.WoWManager.SetKey(htoa(sHash));
  end;
end;

procedure TBFGMain.srvRealmOutboundConnect(AThread: TIdMappedPortThread;
  AException: Exception);
begin
  Logger.Lock();

  AThread.OutboundClient.Intercept := WSServerIntercept;

  Logger.UnLock();
end;

procedure TBFGMain.edt4CharsChange(Sender: TObject);
var
  s: String;
  c: array[0..3] of Char;
  u: Cardinal absolute c;
begin
  s := Copy(edt4Chars.Text, 1, 4);
  while Length(s) < 4 do s := #0 + s;

  c[0] := s[1];
  c[1] := s[2];
  c[2] := s[3];
  c[3] := s[4];

  ifaceControlsValues(Sender, u);
end;

procedure TBFGMain.edt4CharsRevChange(Sender: TObject);
var
  s: String;
  c: array[0..3] of Char;
  u: Cardinal absolute c;
begin
  s := Copy(edt4CharsRev.Text, 1, 4);
  while Length(s) < 4 do s := s + #0;

  c[3] := s[1];
  c[2] := s[2];
  c[1] := s[3];
  c[0] := s[4];

  ifaceControlsValues(Sender, u);
end;

procedure TBFGMain.edtHexPktValChange(Sender: TObject);
var
  i: Cardinal;
begin
  i := StrToInt64Def('$' + StringReplace(edtHexPktVal.Text, ' ', '',
    [rfReplaceAll]), 0);
  ifaceControlsValues(Sender, i);
end;

procedure TBFGMain.edtHexValueChange(Sender: TObject);
var
  i: Cardinal;
begin
  i := StrToInt64Def('$' + edtHexValue.Text, 0);
  ifaceControlsValues(Sender, i);
end;

procedure TBFGMain.edtKeyPiecesEnter(Sender: TObject);
begin
  ActiveControl := nil;
end;

procedure TBFGMain.KeyTimerTimer(Sender: TObject);
var
  Kps: String;
begin
  Logger.Lock();

  if MainDecoder.WowManager = nil then
  begin
    Logger.UnLock();
    Exit;
  end;

  Kps := MainDecoder.WowManager.KeyBool();

  if sLastK <> Kps then  SPiece.UpdatePieces(Kps);

  sLastK := Kps;

  if (MainDecoder.WowManager.KeyAvailable()) and (not SPiece.AllPieces()) then
  begin
    SPiece.SetPieces();

    BFGMain.BaloonHint('Key Acquired! We''ll see in a few moments if it''s valid ...',
      3000);
  end;

  if MainDecoder.WowManager.KeyAvailable() then KeyTimer.Enabled := False;

  Logger.UnLock();
end;

procedure TBFGMain.cbbPluginsChange(Sender: TObject);
var
  Obj: TSchPlugin;
begin
  Logger.Lock();

  if cbbPlugins.ItemIndex = -1 then
  begin
    mmInfo.Clear;

    lbPlugName.Caption := 'Name:';
    lbPlugVersion.Caption := 'Version:';
    lbPlugID.Caption := 'ID:';
    lbPlugDev.Caption := 'Developer:';
    lbFormat.Caption := 'No Info';

    Logger.UnLock();

    Exit;
  end;

  Obj := (cbbPlugins.Items.Objects[cbbPlugins.ItemIndex] as TSchPlugin);

  lbPlugName.Caption := 'Name    : ' + Obj.Name;
  lbPlugVersion.Caption := 'Version : ' + Obj.Version;

  lbPlugID.Caption := 'ID        : ' + IntToHex(Obj.ID, 8);
  lbPlugDev.Caption := 'Developer : ' + Obj.Developer;

  if Obj.SupportsRTF then
  begin
    lbFormat.Font.Color := clBlue;
    lbFormat.Caption := 'Formatting';
  end else
  begin
    lbFormat.Font.Color := clRed;
    lbFormat.Caption := 'No Formatting';
  end;



  mmInfo.Clear;
  mmInfo.Lines.Add(Obj.Info);

  mmPack.Lines.Assign(Obj.DecodesPackets);

  cbEnabled.Checked := Obj.Enabled;

  Logger.UnLock();
end;

procedure TBFGMain.btToTrayClick(Sender: TObject);
begin
  Logger.Lock();

  tiTray.Visible := True;
  Hide;

  Logger.UnLock();
end;

procedure TBFGMain.miRestartClick(Sender: TObject);
begin
  Logger.Lock();

  btStartStop.OnClick(btStartStop);
  btStartStop.OnClick(btStartStop);

  Logger.UnLock();
end;

procedure TBFGMain.miStopClick(Sender: TObject);
begin
  Logger.Lock();

  btStartStop.OnClick(btStartStop);

  Logger.UnLock();
end;

procedure TBFGMain.miStartClick(Sender: TObject);
begin
  btStartStop.OnClick(btStartStop);
end;

procedure TBFGMain.miExitClick(Sender: TObject);
begin
  btExit.OnClick(btExit);
end;

procedure TBFGMain.pgcMainChange(Sender: TObject);
begin
  if pgcMain.ActivePage = tbMPQExtract then  ifaceControlsMPQTab();

  SaveOptions();
end;

procedure TBFGMain.pmTrayPopup(Sender: TObject);
begin
  Logger.Lock();

  miRestart.Enabled := bStarted;
  miStart.Enabled := not bStarted;
  miStop.Enabled := bStarted;

  miExit.Enabled := not bStarted;

  Logger.UnLock();
end;

procedure TBFGMain.miRestoreClick(Sender: TObject);
begin
  Logger.Lock();

  tiTray.Visible := False;
  Show;

  Logger.UnLock();
end;

procedure TBFGMain.BaloonHint(const Text: String; Delay: Integer);
begin
  Logger.Lock();

  if tiTray.Visible then
  begin
    tiTray.BalloonTitle := 'Sniffer Report';
    tiTray.BalloonHint := Text;
    tiTray.BalloonTimeout := Delay;
    tiTray.BalloonFlags := bfInfo;
    tiTray.ShowBalloonHint;
  end;

  Logger.UnLock();
end;

procedure TBFGMain.srvRealmDisconnect(AThread: TIdMappedPortThread);
begin
  Logger.Lock();

  LogWSSuccess('Disconnected "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '"');
  BaloonHint('Client "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '" disconnected from WS.');
  PluginManager.EmptyCaches(True);

  Logger.UnLock();
end;

procedure TBFGMain.srvLogonDisconnect(AThread: TIdMappedPortThread);
begin
  Logger.Lock();

  LogLSSuccess('Disconnected "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '"');
  BaloonHint('Client "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '" disconnected from LS.');

  Logger.UnLock();
end;

procedure TBFGMain.srvLogonOutboundDisconnect(AThread: TIdMappedPortThread);
begin
  Logger.Lock();

  LogLSSuccess('Disconnected "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '" from Mapped LS!');
  BaloonHint('Client "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) +
    '" disconnected from Mapped LS.');

  Logger.UnLock();
end;

procedure TBFGMain.srvRealmOutboundDisconnect(AThread: TIdMappedPortThread);
begin
  Logger.Lock();

  LogWSSuccess('Disconnected "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) + '" from Mapped WS!');
  BaloonHint('Client "' + AThread.Connection.Socket.Binding.PeerIP +
    ':' + IntToStr(AThread.Connection.Socket.Binding.PeerPort) +
    '" disconnected from Mapped WS.');
  PluginManager.EmptyCaches(True);

  Logger.UnLock();
end;

procedure TBFGMain.tiTrayDblClick(Sender: TObject);
begin
  Logger.Lock();

  tiTray.Visible := False;
  Show;

  Logger.UnLock();
end;

procedure TBFGMain.cbSaveRealmClick(Sender: TObject);
begin
  SavedRealm := '';
end;

function TBFGMain.CheckEnvironment(): Boolean;
var
  sFl: String;
begin
  sFl := StringReplace(edtOutFile.Text, '%d', GenerateFileStyleDate(), [rfReplaceAll]);
  FileClose(FileCreate(sFl));

  if not FileExists(sFl) then
  begin
    Application.MessageBox(
      'The log file cannot be created! Please check the correct path and try again!',
      'Error', MB_OK or MB_ICONHAND);
    Result := False;
    Exit;
  end;

  if rgKey.ItemIndex = 2 then
  begin
    if FindWindow('YInvisibleMessageWindow', nil) = 0 then
    begin
      Application.MessageBox(
        'The key option "YAWE" has been selected and YAWE is not running on local PC!',
        'Error', MB_OK or MB_ICONHAND);
      Result := False;
      Exit;
    end;
  end;

  if (PluginManager.RTFConflicts) and (cbLogRTF.Checked) then
  begin
    Application.MessageBox(
      'There are plugins enabled that do not support RTF logging and the option to use it is enabled! Please check again!',
      'Error', MB_OK or MB_ICONHAND);
    Result := False;
    Exit;
  end;

  Result := True;

end;

procedure TBFGMain.cbEnabledClick(Sender: TObject);
var
  Obj: TSchPlugin;
begin

  Obj := (cbbPlugins.Items.Objects[cbbPlugins.ItemIndex] as TSchPlugin);
  Obj.Enabled := cbEnabled.Checked;

end;

procedure TBFGMain.LogSwapperTimer(Sender: TObject);
begin
  Logger.Lock();
  if srvRealm.Active then  PluginManager.EmptyCaches(False);

  Logger.UnLock();
end;

procedure TBFGMain.LogLine(const Texts: array of string; const Colors: array of TColor;
  const Styles: array of TFontStyles);
var
  i: Integer;
begin

  if not cbLogVis.Checked then exit;

  if ((length(Texts) <> length(Colors)) or (length(Texts) <> length(Styles)) or
    (length(Texts) = 0)) then
  begin
    mmLog.Lines.Add('');

    mmLog.SelStart := Length(mmLog.Text);
    mmLog.SelLength := 0;

    exit;
  end;

  for i := 0 to Length(Texts) - 1 do
  begin
    mmLog.SelStart := Length(mmLog.Text);
    mmLog.SelLength := 0;

    mmLog.SelAttributes.Color := Colors[i];
    mmLog.SelAttributes.Style := Styles[i];
    mmLog.SelText := Texts[i];
  end;

  mmLog.Lines.Add('');

  mmLog.SelStart := Length(mmLog.Text);
  mmLog.SelLength := 0;
end;

procedure TBFGMain.LogError(const ErrorString: string);
begin
  LogLine(['[Error]: ', ErrorString], [clRed, clMaroon], [[], [fsBold]]);
end;

procedure TBFGMain.LogWS(const WSMsg: string);
begin
  LogLine(['[WS]: ', WSMsg], [clBlue, clBlack], [[], []]);
end;

procedure TBFGMain.LogLS(const LSMsg: string);
begin
  LogLine(['[LS]: ', LSMsg], [clGreen, clBlack], [[], []]);
end;

procedure TBFGMain.LogAction(const ActionMsg: string);
begin
  LogLine(['[App]: ', ActionMsg], [clGray, clBlack], [[], [fsBold]]);
end;

procedure TBFGMain.LogLSError(const LSErrorMsg: string);
begin
  LogLine(['[LS Error]: ', LSErrorMsg], [clRed, clBlack], [[fsBold], [fsBold]]);
end;

procedure TBFGMain.LogLSSuccess(const LSOkMsg: string);
begin
  LogLine(['[LS]: ', LSOkMsg], [clGreen, clBlack], [[fsBold], [fsBold]]);
end;

procedure TBFGMain.LogWSOpcode(const OpcodeName: string; iOp: Integer; bClient: Boolean);
var
  sF: String;
begin
  if bClient then  sF := '{Client} '
  else
    sF := '{Server} ';

  LogLine(['[WS Code]: ', sF, 'Received "', OpcodeName, '" (', '0x' +
    IntToHex(iOp, 4), ')'],
    [clBlue, clGray, clBlack, clGreen, clBlack, clMaroon, clBlack],
    [[], [fsBold], [], [fsItalic, fsBold], [], [fsBold], []]
    );
end;

procedure TBFGMain.LogWSError(const WSErrorMsg: string);
begin
  LogLine(['[WS Error]: ', WSErrorMsg], [clRed, clBlack], [[fsBold], [fsBold]]);
end;

procedure TBFGMain.LogWSSuccess(const WSOkMsg: string);
begin
  LogLine(['[WS]: ', WSOkMsg], [clBlue, clBlack], [[fsBold], [fsBold]]);
end;

procedure TBFGMain.LogWSBytes(iBytes: Integer; bFromClient: Boolean);
var
  sF, sM: string;
begin
  if bFromClient then
  begin
    sM := ' (' + IntToStr(iBytes - 6) + ') ';
    sF := '{Client}';
  end else
  begin
    sM := '';
    sF := '{Server}';
  end;

  LogLine(['[WS]: ', 'Received ', IntToStr(iBytes), sM, ' from ', sF],
    [clBlue, clBlack, clMaroon, clMaroon, clBlack, clGray],
    [[fsBold], [], [fsBold], [], [], []]);
end;

procedure TBFGMain.cbLogVisClick(Sender: TObject);
begin
  mmLog.Visible := cbLogVis.Checked;
end;

procedure TBFGMain.mmLogEnter(Sender: TObject);
begin
  mmLog.SelStart := Length(mmLog.Text);
  mmLog.SelLength := 0;
end;

end.
