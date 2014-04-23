unit LoggerDef;

interface

uses
  Classes, Graphics, SysUtils, Utils, Windows;

type
  TSchLogColor = (lcBlack, lcGreen, lcRed, lcBlue, lcMaroon,
    lcTeal, lcNavy, lcGray);

  TSchGenericLogger = class(TObject)
  private
    fLog: String;

  protected
    procedure AddLog(sStr: String);

  public
    constructor Create();
    destructor Destroy(); override;

    { Override this }
    procedure Log(sString: String; cColor: TSchLogColor; cStyle: TFontStyles;
      bNewLine: Boolean = False); overload; virtual; abstract;

    { Override this to init the formatted header }
    procedure InitializeHeader(); virtual; abstract;
    procedure FinalizeHeader(); virtual; abstract;

    procedure Log(sString: String; cColor: TSchLogColor;
      bNewLine: Boolean = False); overload;
    procedure Log(sString: String; cStyle: TFontStyles;
      bNewLine: Boolean = False); overload;
    procedure Log(sString: String; bNewLine: Boolean = False); overload;

    procedure NewLine(); virtual; abstract;

    function GetLog(): String;
  end;

implementation

{ TSchGenericLogger }

procedure TSchGenericLogger.AddLog(sStr: String);
begin
  fLog := fLog + sStr;
end;

constructor TSchGenericLogger.Create;
begin
  fLog := '';
end;

destructor TSchGenericLogger.Destroy;
begin
  inherited;
end;

function TSchGenericLogger.GetLog: String;
begin
  Result := fLog;
  fLog := '';
end;

procedure TSchGenericLogger.Log(sString: String; cColor: TSchLogColor;
  bNewLine: Boolean);
begin
  Log(sString, cColor, [], bNewLine);
end;

procedure TSchGenericLogger.Log(sString: String; cStyle: TFontStyles; bNewLine: Boolean);
begin
  Log(sString, lcBlack, cStyle, bNewLine);
end;

procedure TSchGenericLogger.Log(sString: String; bNewLine: Boolean);
begin
  Log(sString, lcBlack, [], bNewLine);
end;

end.
