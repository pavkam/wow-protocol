unit MapShow;

interface

uses Classes, ComCtrls, Controls, ExtCtrls, Graphics, SysUtils, Windows;

type
  TMapShow = class(TPanel)
  private
    fPieces: array[0..63, 0..63] of TColor;

    function GetBlock(X, Y: Integer): TColor;
    procedure SetBlock(X, Y: Integer; const Value: TColor);

  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;

    procedure ClearBlocks();

    property Blocks[X, Y: Integer]: TColor Read GetBlock Write SetBlock;
  end;

implementation

{ TMapShow }

procedure TMapShow.ClearBlocks;
var
  X, Y: Integer;
begin
  for X := 0 to 63 do for Y := 0 to 63 do fPieces[X, Y] := clWhite;

  Repaint();
end;

constructor TMapShow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  BorderWidth := 1;
  BevelEdges := [beLeft, beTop, beRight, beBottom];
  Color := clWhite;

  ClearBlocks();

  Parent := AOwner as TWinControl;
end;

function TMapShow.GetBlock(X, Y: Integer): TColor;
begin
  Result := fPieces[X, Y];
end;

procedure TMapShow.Paint;
var
  X1, Y1, X2, Y2: Integer;
  x, y, XO, YO: Integer;
  PieceDim: Integer;

begin
  inherited;

  X1 := BorderWidth;
  Y1 := BorderWidth;
  X2 := Width - BorderWidth;
  Y2 := Height - BorderWidth;

  PieceDim := (X2 - X1) div 64;

  for x := 0 to 64 - 1 do for y := 0 to 64 - 1 do
    begin
      XO := X1 + (x * PieceDim);
      YO := Y1 + (y * PieceDim);

      Canvas.Pen.Color := fPieces[X, Y];
      Canvas.Brush.Color := fPieces[X, Y];
      Canvas.Rectangle(XO, YO, XO + PieceDim, YO + PieceDim);
    end;

end;

procedure TMapShow.SetBlock(X, Y: Integer; const Value: TColor);
var
  X1, Y1, X2, Y2: Integer;
  XO, YO: Integer;
  PieceDim: Integer;

begin
  fPieces[X, Y] := Value;

  X1 := BorderWidth;
  Y1 := BorderWidth;
  X2 := Width - BorderWidth;
  Y2 := Height - BorderWidth;

  PieceDim := (X2 - X1) div 64;

  XO := X1 + (x * PieceDim);
  YO := Y1 + (y * PieceDim);

  Canvas.Pen.Color := fPieces[X, Y];
  Canvas.Brush.Color := fPieces[X, Y];
  Canvas.Rectangle(XO, YO, XO + PieceDim, YO + PieceDim);
end;

end.
