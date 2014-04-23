unit StringBuffer;

interface

uses
  SysUtils;

type
  EBufferDepleted = class(Exception);
  EBufferUnderflow = class(Exception);
  EBufferPosError = class(Exception);

  TSchStringBuffer = class(TObject)
  private
    fStringBuffer: String;
    function GetStringBuffer: String; virtual;
    procedure SetStringBuffer(const Value: String); virtual;

  public
    constructor Create(ABuffer: String); overload;
    constructor Create(); overload;
    destructor Destroy(); override;

    property StringBuffer: String
      Read GetStringBuffer Write SetStringBuffer;

  end;

  TSchReadStringBuffer = class(TSchStringBuffer)
  private
    fPosition: Integer;
    fBuffLength: Integer;

    procedure SetStringBuffer(const Value: String); override;
  public
    function ReadByte(): Byte;
    function ReadChar(): Char;
    function ReadWord(): Word;
    function ReadInteger(): Cardinal;
    function ReadString(): String;

    function ReadInt8(): Byte;
    function ReadInt16(): Word;
    function ReadInt32(): Cardinal;
    function ReadInt64(): Int64;

    function ReadFloat(): Single;

    function ReadBuffer(Size: Integer): String;

    property Size: Integer Read fBuffLength;
  end;


  TSchReadWriteStringBuffer = class(TSchReadStringBuffer)
  public
    procedure WriteByte(AByte: Byte);
    procedure WriteChar(AChar: Char);
    procedure WriteWord(AWord: Word);
    procedure WriteInteger(AInt: Cardinal);
    procedure WriteString(AStr: String);

    procedure WriteInt8(AByte: Byte);
    procedure WriteInt16(AWord: Word);
    procedure WriteInt32(AInt: Cardinal);
    procedure WriteFloat(AFt: Single);
    procedure WriteInt64(AWInt: Int64);
  end;

  TSchInOutStringBuffer = class(TSchReadWriteStringBuffer)
  private
    fSavedPosition: Integer;

    procedure SetStringBuffer(const Value: String); override;
  public
    procedure AddChunk(AChunk: String);

    procedure SavePosition();
    procedure RestorePosition();

    procedure ClearUsedChunk();
  end;

implementation

{ TSchStringBuffer }

constructor TSchStringBuffer.Create(ABuffer: String);
begin
  SetStringBuffer(ABuffer);
end;

constructor TSchStringBuffer.Create;
begin
  Create('');
end;

destructor TSchStringBuffer.Destroy;
begin
  fStringBuffer := '';
  inherited;
end;

function TSchStringBuffer.GetStringBuffer: String;
begin
  Result := fStringBuffer;
end;


procedure TSchStringBuffer.SetStringBuffer(const Value: String);
begin
  fStringBuffer := Value;
end;

{ TSchReadStringBuffer }


function TSchReadStringBuffer.ReadBuffer(Size: Integer): String;
var
  iI: Integer;
begin
  Result := '';

  for iI := 1 to Size do Result := Result + ReadChar();

end;

function TSchReadStringBuffer.ReadByte: Byte;
begin
  if fPosition > fBuffLength then
  begin
    raise EBufferDepleted.Create('String Buffer Depleted!');
    exit;
  end;

  Result := Byte(fStringBuffer[fPosition]);
  Inc(fPosition);
end;

function TSchReadStringBuffer.ReadChar: Char;
begin
  Result := Char(ReadByte());
end;

function TSchReadStringBuffer.ReadFloat: Single;
var
  Floaty: Single;
  _a: array[0..3] of Byte absolute Floaty;
begin
  _a[0] := ReadByte();
  _a[1] := ReadByte();
  _a[2] := ReadByte();
  _a[3] := ReadByte();

  Result := Floaty;
end;

function TSchReadStringBuffer.ReadInt16: Word;
begin
  Result := ReadWord();
end;

function TSchReadStringBuffer.ReadInt32: Cardinal;
begin
  Result := ReadInteger();
end;

function TSchReadStringBuffer.ReadInt64: Int64;
var
  _Int64: Int64;
  _a: array[0..7] of Byte absolute _Int64;
begin
  _a[0] := ReadByte();
  _a[1] := ReadByte();
  _a[2] := ReadByte();
  _a[3] := ReadByte();
  _a[4] := ReadByte();
  _a[5] := ReadByte();
  _a[6] := ReadByte();
  _a[7] := ReadByte();

  Result := _Int64;
end;

function TSchReadStringBuffer.ReadInt8: Byte;
begin
  Result := ReadByte();
end;

function TSchReadStringBuffer.ReadInteger: Cardinal;
var
  Int32: Cardinal;
  _a: array[0..3] of Byte absolute Int32;
begin
  _a[0] := ReadByte();
  _a[1] := ReadByte();
  _a[2] := ReadByte();
  _a[3] := ReadByte();

  Result := Int32;
end;

function TSchReadStringBuffer.ReadString: String;
var
  Ch: Char;
begin
  Result := '';

  while True do
  begin
    Ch := ReadChar();
    if Ch = #0 then break;

    Result := Result + Ch;
  end;
end;

function TSchReadStringBuffer.ReadWord: Word;
var
  Int16: Integer;
  _a: array[0..1] of Byte absolute Int16;
begin
  _a[0] := ReadByte();
  _a[1] := ReadByte();

  Result := Int16;
end;

procedure TSchReadStringBuffer.SetStringBuffer(const Value: String);
begin
  fPosition := 1;
  fBuffLength := Length(Value);
  inherited;
end;

{ TSchReadWriteStringBuffer }

procedure TSchReadWriteStringBuffer.WriteByte(AByte: Byte);
begin
  Insert(Char(AByte), fStringBuffer, fPosition);

  Inc(fPosition);
  Inc(fBuffLength);
end;

procedure TSchReadWriteStringBuffer.WriteChar(AChar: Char);
begin
  WriteByte(Byte(AChar));
end;

procedure TSchReadWriteStringBuffer.WriteFloat(AFt: Single);
var
  _a: array[0..3] of Byte absolute AFt;
begin
  WriteByte(_a[0]);
  WriteByte(_a[1]);
  WriteByte(_a[2]);
  WriteByte(_a[3]);
end;

procedure TSchReadWriteStringBuffer.WriteInt16(AWord: Word);
begin
  WriteWord(AWord);
end;

procedure TSchReadWriteStringBuffer.WriteInt32(AInt: Cardinal);
begin
  WriteInteger(AInt);
end;

procedure TSchReadWriteStringBuffer.WriteInt64(AWInt: Int64);
var
  _a: array[0..7] of Byte absolute AWInt;
begin
  WriteByte(_a[0]);
  WriteByte(_a[1]);
  WriteByte(_a[2]);
  WriteByte(_a[3]);

  WriteByte(_a[4]);
  WriteByte(_a[5]);
  WriteByte(_a[6]);
  WriteByte(_a[7]);
end;

procedure TSchReadWriteStringBuffer.WriteInt8(AByte: Byte);
begin
  WriteByte(AByte);
end;

procedure TSchReadWriteStringBuffer.WriteInteger(AInt: Cardinal);
var
  _a: array[0..3] of Byte absolute AInt;
begin
  WriteByte(_a[0]);
  WriteByte(_a[1]);
  WriteByte(_a[2]);
  WriteByte(_a[3]);
end;

procedure TSchReadWriteStringBuffer.WriteString(AStr: String);
var
  iI: Integer;
begin
  if Length(AStr) > 0 then  for iI := 1 to Length(AStr) do WriteChar(AStr[iI]);

  WriteChar(#0); // Null Terminator;  
end;

procedure TSchReadWriteStringBuffer.WriteWord(AWord: Word);
var
  _a: array[0..1] of Byte absolute AWord;
begin
  WriteByte(_a[0]);
  WriteByte(_a[1]);
end;

{ TSchInOutStringBuffer }

procedure TSchInOutStringBuffer.AddChunk(AChunk: String);
begin
  fStringBuffer := fStringBuffer + AChunk;
  Inc(fBuffLength, Length(AChunk));
end;

procedure TSchInOutStringBuffer.ClearUsedChunk;
begin
  if fSavedPosition > 0 then  fSavedPosition := fSavedPosition - fPosition;

  Delete(fStringBuffer, 1, fPosition - 1);

  fBuffLength := fBuffLength - fPosition + 1;
  fPosition := 1;
end;

procedure TSchInOutStringBuffer.RestorePosition;
begin
  if fSavedPosition = 0 then
  begin
    raise EBufferPosError.Create(
      'Unable to restore old position. Position hasn''t been saved priorly.');
    exit;
  end;

  if fSavedPosition > fBuffLength then
  begin
    raise EBufferUnderflow.Create('Unable to restore old position. The buffer is smaller.');
    exit;
  end;

  fPosition := fSavedPosition;
  fSavedPosition := 0;
end;

procedure TSchInOutStringBuffer.SavePosition;
begin
  fSavedPosition := fPosition;
end;

procedure TSchInOutStringBuffer.SetStringBuffer(const Value: String);
begin
  fSavedPosition := 0;

  inherited;
end;

end.
