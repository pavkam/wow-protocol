unit BitBuffer;

interface

uses Classes, SysUtils, Windows;

type
  TSchBitBuffer = class(TObject)
  private
    fByteArray: array of Byte;
    function GetBuffer: String;
    procedure SetBuffer(const Value: String);

    procedure SetBit(Index: Cardinal; const Value: Boolean);
    function GetBit(Index: Cardinal): Boolean;

  public
    constructor Create(sBuffer: String);
    destructor Destroy(); override;

    property Bit[Index: Cardinal]: Boolean Read GetBit Write SetBit; default;
    property Buffer: String Read GetBuffer Write SetBuffer;
  end;

implementation

{ TSchBitBuffer }

constructor TSchBitBuffer.Create(sBuffer: String);
begin
  Buffer := sBuffer;
end;

destructor TSchBitBuffer.Destroy;
begin
  fByteArray := nil;
end;

function TSchBitBuffer.GetBit(Index: Cardinal): Boolean;
var
  wByte, rByte: Integer;
begin
  Result := False;

  wByte := (Index div 8);
  rByte := (Index mod 8);

  if wByte >= Length(fByteArray) then
    raise Exception.Create('Invalid bit queried!');

  if (fByteArray[wByte] and (1 shl rByte)) <> 0 then  Result := True;
end;

function TSchBitBuffer.GetBuffer: String;
begin

  if Length(fByteArray) > 0 then
  begin
    SetLength(Result, Length(fByteArray));
    Move(fByteArray[0], Result[1], Length(fByteArray));
  end else
    Result := '';

end;

procedure TSchBitBuffer.SetBit(Index: Cardinal; const Value: Boolean);
var
  wByte, rByte: Integer;

begin
  wByte := (Index div 8);
  rByte := (Index mod 8);

  if wByte >= Length(fByteArray) then
    raise Exception.Create('Invalid bit queried!');

  if Value then  fByteArray[wByte] := fByteArray[wByte] or (1 shl rByte)
  else
    fByteArray[wByte] := fByteArray[wByte] and (not (1 shl rByte));
end;

procedure TSchBitBuffer.SetBuffer(const Value: String);
begin

  if Length(Value) > 0 then
  begin
    SetLength(fByteArray, Length(Value));
    Move(Value[1], fByteArray[0], Length(Value));
  end else
    fByteArray := nil;

end;

end.
