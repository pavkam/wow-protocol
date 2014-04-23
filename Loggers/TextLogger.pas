unit TextLogger;

interface

uses
  Classes, Graphics, LoggerDef, SysUtils, Utils, Windows;

type
  TSchTextLogger = class(TSchGenericLogger)
  public
    procedure Log(sString: String; cColor: TSchLogColor; cStyle: TFontStyles;
      bNewLine: Boolean = False); override;
    procedure NewLine(); override;

    procedure InitializeHeader(); override;
    procedure FinalizeHeader(); override;
  end;


implementation

{ TSchTextLogger }

procedure TSchTextLogger.FinalizeHeader;
begin

end;

procedure TSchTextLogger.InitializeHeader;
begin
  // Nothing !
end;

procedure TSchTextLogger.Log(sString: String; cColor: TSchLogColor;
  cStyle: TFontStyles; bNewLine: Boolean);
begin
  if bNewLine then  AddLog(sString + #13#10)
  else
    AddLog(sString);
end;

procedure TSchTextLogger.NewLine;
begin
  AddLog(#13#10);
end;

end.
