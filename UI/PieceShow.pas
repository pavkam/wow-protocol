unit PieceShow;

interface

uses Classes, ComCtrls, Controls, ExtCtrls, Graphics, SysUtils, Windows;

type
  TPieceShow = class(TPanel)
  private
    fPieces: array of Boolean;
    function GetPiece(Index: Integer): Boolean;
    procedure SetPiece(Index: Integer; const Value: Boolean);

    function GetPieceCount: Integer;
    procedure SetPieceCount(const Value: Integer);

  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;

    procedure ClearPieces();
    procedure SetPieces();
    function AllPieces(): Boolean;

    procedure UpdatePieces(KeyPart: String);

    property PieceCount: Integer Read GetPieceCount Write SetPieceCount;
    property Pieces[Index: Integer]: Boolean Read GetPiece Write SetPiece;
  end;

implementation

{ TPieceShow }

function TPieceShow.AllPieces: Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to PieceCount do if not fPieces[i] then exit;

  Result := True;
end;

procedure TPieceShow.ClearPieces;
begin
  FillChar(fPieces[0], PieceCount, Ord(False));
  Repaint();
end;

constructor TPieceShow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  BorderWidth := 1;
  BevelEdges := [beLeft, beTop, beRight, beBottom];
  Color := clRed;

  PieceCount := 40;

  Parent := AOwner as TWinControl;
end;

function TPieceShow.GetPiece(Index: Integer): Boolean;
begin
  Result := False;
  if (Index < 0) or (Index >= PieceCount) then Exit;

  Result := fPieces[Index];
end;

function TPieceShow.GetPieceCount: Integer;
begin
  Result := Length(fPieces);
end;

procedure TPieceShow.Paint;
var
  X1, Y1, X2, Y2: Integer;
  i, XO: Integer;
  PieceDim: Integer;
  iCnt: Single;
  sTxt: String;
begin
  inherited;

  X1 := BorderWidth;
  Y1 := BorderWidth;
  X2 := Width - BorderWidth;
  Y2 := Height - BorderWidth;

  PieceDim := (X2 - X1) div PieceCount;
  iCnt := 0;
  for i := 0 to PieceCount - 1 do
  begin
    XO := X1 + (i * PieceDim);

    if fPieces[i] then
    begin
      Canvas.Pen.Color := clBlue;
      Canvas.Brush.Color := clBlue;
      iCnt := iCnt + 1;
    end else
    begin
      Canvas.Pen.Color := clRed;
      Canvas.Brush.Color := clRed;
    end;

    Canvas.Rectangle(XO, Y1, XO + PieceDim, Y2);
  end;

  if iCnt = 0 then
  begin
    sTxt := 'Nothing Yet!';

    Canvas.Font.Color := clWhite;
  end else if iCnt = PieceCount then
  begin
    sTxt := 'Full Key!';

    Canvas.Font.Color := clGray;
  end else if iCnt < PieceCount then
  begin
    sTxt := IntToStr(Round((iCnt * 100) / PieceCount)) + '%';
    if Length(sTxt) = 1 then  sTxt := '0' + sTxt;

    Canvas.Font.Color := clWhite;
  end;

  Canvas.Brush.Style := bsclear;
  Canvas.Font.Size := 8;
  Canvas.Font.Name := 'Lucida Console';

  Canvas.TextOut(((X2 - X1) - Canvas.TextWidth(sTxt)) div 2,
    Y1 + 0,
    sTxt
    );

end;

procedure TPieceShow.SetPiece(Index: Integer; const Value: Boolean);
begin
  if (Index < 0) or (Index >= PieceCount) then Exit;
  if fPieces[Index] = Value then Exit;
  fPieces[Index] := Value;

  Repaint();
end;

procedure TPieceShow.SetPieceCount(const Value: Integer);
begin
  SetLength(fPieces, Value);
  FillChar(fPieces[0], Value, Ord(False));

  Repaint();
end;

procedure TPieceShow.SetPieces;
begin
  FillChar(fPieces[0], PieceCount, Ord(True));
  Repaint();
end;

procedure TPieceShow.UpdatePieces(KeyPart: String);
var
  i: Integer;
begin
  if Length(KeyPart) <> PieceCount then exit;

  for i := 0 to PieceCount - 1 do
  begin
    if KeyPart[i + 1] = '1' then  fPieces[i] := True
    else
      fPieces[i] := False;
  end;

  Repaint();
end;

end.
