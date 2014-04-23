unit ByteBuffer;

interface

uses
  Classes;

type
  TBufferSeekType = (bstForward, bstCurrent, bstBackward);

  TReadBuffer = class(TObject)
  protected
    fSize: Integer;
    fReadPos: Integer;
    fBuffer: PChar;
    function GetByte(iIndex: Integer): Byte; inline;
    procedure GetObjPlain(var xWhereToPut; iFromWhere: Integer;
      iSize: Integer); inline;
    procedure GetObj(var xWhereToPut; iFromWhere: Integer; iSize: Integer); inline;
    procedure SetSize(iSize: Integer); inline;
  public
    constructor Create(const xDataSource; iSize: Integer); overload;
    constructor Create(cStream: TStream); overload;
    destructor Destroy; override;

    function ReadUInt8: Byte; overload; inline;
    function ReadUInt16: Word; overload; inline;
    function ReadUInt32: Longword; overload; inline;
    function ReadUInt64: Int64; overload; inline;
    function ReadString: String; overload; inline;
    function ReadFloat: Single; overload; inline;
    procedure ReadStruct(var xData; iSize: Integer); overload; inline;
    procedure ReadPtrData(pData: Pointer; iSize: Integer); overload; inline;

    function GetPtr(iIndex: Integer): Pointer; inline;
    function GetCurrentReadPtr: Pointer; inline;
    function GetReadPtrOfSize(iExpectedSize: Integer): Pointer; inline;

    function SeekReadPointer(iType: TBufferSeekType; iCount: Integer): Integer;

    procedure Skip(iAmount: Integer);
    procedure SkipUInt8;
    procedure SkipUInt16;
    procedure SkipUInt32;
    procedure SkipUInt64;

    procedure Clear;

    property Size: Integer Read fSize Write SetSize;
    property ReadPosition: Integer Read fReadPos Write fReadPos;
    property Bytes[iIndex: Integer]: Byte Read GetByte; default;
  end;

implementation

uses
  Miscelaneous, SysUtils;

constructor TReadBuffer.Create(const xDataSource; iSize: Integer);
begin
  inherited Create;
  GetMem(fBuffer, iSize);
  Move(xDataSource, fBuffer[0], iSize);
end;

constructor TReadBuffer.Create(cStream: TStream);
var
  iSize: Integer;
begin
  inherited Create;
  iSize := cStream.Size;
  GetMem(fBuffer, iSize);
  cStream.ReadBuffer(fBuffer^, iSize);
  fSize := iSize;
end;

destructor TReadBuffer.Destroy;
begin
  FreeMem(fBuffer);
  inherited Destroy;
end;

procedure TReadBuffer.GetObjPlain(var xWhereToPut; iFromWhere: Integer; iSize: Integer);
begin
  { Copy iSize-bytes from the tail }
  Move(fBuffer[iFromWhere], xWhereToPut, iSize);
end;

procedure TReadBuffer.GetObj(var xWhereToPut; iFromWhere: Integer; iSize: Integer);
var
  iIncAmount: Integer;
begin
  iIncAmount := (iFromWhere + iSize) - fReadPos;
  { Copy iSize-bytes from the tail }
  Move(fBuffer[iFromWhere], xWhereToPut, iSize);
  { And increase increase fReadPos if required }
  Inc(fReadPos, iIncAmount);
end;

function TReadBuffer.SeekReadPointer(iType: TBufferSeekType; iCount: Integer): Integer;
begin
  case iType of
    bstForward:
    begin
      Inc(fReadPos, iCount);
    end;
    bstBackward:
    begin
      Dec(fReadPos, iCount);
    end;
    bstCurrent:
    begin
      fReadPos := iCount;
    end;
  end;
  Result := fReadPos;
end;

function TReadBuffer.GetByte(iIndex: Integer): Byte;
begin
  Result := Byte(fBuffer[iIndex]);
end;

procedure TReadBuffer.SetSize(iSize: Integer);
begin
  if iSize < fSize then
  begin
    FillChar(fBuffer[iSize], fSize - iSize, 0);
  end;
  fSize := iSize;
end;

procedure TReadBuffer.Skip(iAmount: Integer);
begin
  Inc(fReadPos, iAmount);
end;

procedure TReadBuffer.SkipUInt8;
begin
  Inc(fReadPos);
end;

procedure TReadBuffer.SkipUInt16;
begin
  Inc(fReadPos, 2);
end;

procedure TReadBuffer.SkipUInt32;
begin
  Inc(fReadPos, 4);
end;

procedure TReadBuffer.SkipUInt64;
begin
  Inc(fReadPos, 8);
end;

function TReadBuffer.GetPtr(iIndex: Integer): Pointer;
begin
  Result := @fBuffer[iIndex];
end;

function TReadBuffer.GetCurrentReadPtr: Pointer;
begin
  Result := @fBuffer[fReadPos];
end;

function TReadBuffer.GetReadPtrOfSize(iExpectedSize: Integer): Pointer;
begin
  Result := @fBuffer[fReadPos];
  Inc(fReadPos, iExpectedSize);
end;

procedure TReadBuffer.Clear;
begin
  FillChar(fBuffer[0], fSize, 0);
  fSize := 0;
  fReadPos := 0;
end;

function TReadBuffer.ReadUInt8: Byte;
begin
  Result := PByte(@fBuffer[fReadPos])^;
  Inc(fReadPos);
end;

function TReadBuffer.ReadUInt16: Word;
begin
  Result := PWord(@fBuffer[fReadPos])^;
  Inc(fReadPos, 2);
end;

function TReadBuffer.ReadUInt32: Longword;
begin
  Result := PLongword(@fBuffer[fReadPos])^;
  Inc(fReadPos, 4);
end;

function TReadBuffer.ReadUInt64: Int64;
begin
  Result := PInt64(@fBuffer[fReadPos])^;
  Inc(fReadPos, 8);
end;

function TReadBuffer.ReadString: String;
begin
  Inc(fReadPos, PCharToString(GetCurrentReadPtr, Result) + 1); { Count #0 also }
end;

function TReadBuffer.ReadFloat: Single;
begin
  Result := PSingle(@fBuffer[fReadPos])^;
  Inc(fReadPos, 4);
end;

procedure TReadBuffer.ReadStruct(var xData; iSize: Integer);
begin
  GetObj(xData, fReadPos, iSize);
end;

procedure TReadBuffer.ReadPtrData(pData: Pointer; iSize: Integer);
begin
  GetObj(pData^, fReadPos, iSize);
end;

end.
