unit ADTHandle;

interface

uses SysUtils, Utils, Classes, ByteBuffer, Miscelaneous;

type
  TSchADTMapFile = class(TObject)
    private
      fFileData: TReadBuffer;
      function GetPosition: Longword;
    public
      constructor Create(const AFile: string); overload;
      constructor Create(AStream: TStream); overload;
      destructor Destroy; override;

      function ReadUInt32: Longword;
      function ReadFloat: Single;

      procedure ReadVar(x: Pointer; iSize: Longword);

      function CurrentChunkIdent: Longword;
      function CurrentChunkSize: Longword;

      procedure SkipToChunkAt(iPos: Longword);

      procedure SkipChunk;

      property Position: Longword read GetPosition;
 end;

implementation

uses
  Math;

{ TSchADTMapFile }

constructor TSchADTMapFile.Create(const AFile: string);
var
  fs: TFileStream;
begin
  fs := nil;
 
  try
    fs := TFileStream.Create(AFile, fmOpenRead);
    Create(fs);
  except
    FreeAndNil(fs);
    raise EStreamError.Create('Invalid Input ADT File!');
  end;

  fs.Free;
end;

constructor TSchADTMapFile.Create(AStream: TStream);
begin
  fFileData := TReadBuffer.Create(AStream);

  if fFileData.Size < 10 then
    raise EStreamError.Create('Invalid Input ADT File!');
end;

function TSchADTMapFile.CurrentChunkIdent: Longword;
begin
  Result := ReadUInt32;
  fFileData.ReadPosition := fFileData.ReadPosition - 4;
end;

function TSchADTMapFile.CurrentChunkSize: Cardinal;
begin
  ReadUInt32;
  Result := ReadUInt32;
  fFileData.SeekReadPointer(bstBackward, 8);
end;

destructor TSchADTMapFile.Destroy;
begin
  fFileData.Free;
  inherited Destroy;
end;

function TSchADTMapFile.GetPosition: Longword;
begin
  Result := fFileData.ReadPosition;
end;

function TSchADTMapFile.ReadFloat: Single;
begin
  Result := fFileData.ReadFloat;
end;
function TSchADTMapFile.ReadUInt32: Cardinal;
begin
  Result := fFileData.ReadUInt32;
end;

procedure TSchADTMapFile.ReadVar(x : Pointer; iSize: Cardinal);
begin
  fFileData.ReadPtrData(x, iSize);
end;

procedure TSchADTMapFile.SkipChunk;
begin
  fFileData.SkipUInt32;
  fFileData.Skip(ReadUInt32);
end;

procedure TSchADTMapFile.SkipToChunkAt(iPos: Cardinal);
begin
  fFileData.ReadPosition := iPos;
end;

end.
