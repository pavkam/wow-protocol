unit RTFLogger;

interface

uses
  Classes, Graphics, LoggerDef, SysUtils, Utils, Windows;

type
  TSchRTFLogger = class(TSchGenericLogger)
  private
    fInited: Boolean;

    function ColorToRTF(cC: TColor): String;

  public
    constructor Create();

    procedure Log(sString: String; cColor: TSchLogColor; cStyle: TFontStyles;
      bNewLine: Boolean = False); override;
    procedure NewLine(); override;

    procedure InitializeHeader(); override;
    procedure FinalizeHeader(); override;
  end;


implementation

{ TSchTRTFLogger }

function TSchRTFLogger.ColorToRTF(cC: TColor): String;
const
  RTFFormat = '\red%d\green%d\blue%d;';

var
  iCol: Integer;
  iR, iG, iB: Byte;
begin
  iCol := ColorToRGB(cC);

  iR := (iCol and $FF);
  iG := ((iCol shr 8) and $FF);
  iB := ((iCol shr 16) and $FF);

  Result := Format(RTFFormat, [iR, iG, iB]);
end;

constructor TSchRTFLogger.Create;
begin
  inherited;
  fInited := False;
end;

procedure TSchRTFLogger.FinalizeHeader;
begin
  if not fInited then Exit;

  fInited := False;
  AddLog('}');
end;

procedure TSchRTFLogger.InitializeHeader;
begin
  if fInited then exit;
  fInited := True;

  AddLog('{\rtf1\ansi\deff0');
  AddLog('{\fonttbl{\f0\fmodern\fprq1\fcharset0 Lucida Console;}}');
  AddLog('{\colortbl ;');

  { Colors }
  AddLog(ColorToRTF(clBlack));
  AddLog(ColorToRTF(clGreen));
  AddLog(ColorToRTF(clRed));
  AddLog(ColorToRTF(clBlue));

  AddLog(ColorToRTF(clMaroon));
  AddLog(ColorToRTF(clTeal));
  AddLog(ColorToRTF(clNavy));
  AddLog(ColorToRTF(clGray));

  AddLog('}\viewkind4\uc1\pard\lang1033\f0\fs20' + #13#10);
end;

procedure TSchRTFLogger.Log(sString: String; cColor: TSchLogColor;
  cStyle: TFontStyles; bNewLine: Boolean);
var
  sST_B, sST_E: String;
  sCL_B, sCL_E: String;
begin
  sST_B := '';
  sST_E := '';
  sCL_B := '';
  sCL_E := '';

  if fsBold in cStyle then
  begin
    sST_B := sST_B + '\b';
    sST_E := sST_E + '\b0';
  end;

  if fsItalic in cStyle then
  begin
    sST_B := sST_B + '\i';
    sST_E := sST_E + '\i0';
  end;

  if fsUnderline in cStyle then
  begin
    sST_B := sST_B + '\ul';
    sST_E := sST_E + '\ulnone';
  end;

  sCL_B := '\cf' + IntToStr(Ord(cColor) + 1);
  sCL_E := '\cf0';

  sString := StringReplace(sString, '\', '\\', [rfReplaceAll]);
  sString := StringReplace(sString, '{', '\{', [rfReplaceAll]);
  sString := StringReplace(sString, '}', '\}', [rfReplaceAll]);

  AddLog(sST_B + sCL_B + ' ' + sString + sCL_E + sST_E);

  if bNewLine then  NewLine();
end;

procedure TSchRTFLogger.NewLine;
begin
  AddLog('\par' + #13#10);
end;

end.
