unit DBCHandle;
interface
Uses SysUtils, Classes, Windows, Utils, ByteBuffer, Miscelaneous;

Type
 TSchDBCFile   = class; // predef

 { Record }
 TSchDBCRecord = record
  private
   iOffset : Cardinal;
   cParent : TSchDBCFile;

  public

   function ReadUInt32 ( iField : Cardinal ) : Cardinal;
   function ReadFloat  ( iField : Cardinal ) : Single;
   function ReadString ( iField : Cardinal ) : string;

   function Fields() : Cardinal;
 end;

 { Main Class }
 TSchDBCFile = class( TObject )
  private
   fArray     : TReadBuffer;

   fRecordNumber,
    fNumberOfFields,
     fRecordSize,
      fStrOffset,
       fDataOffset,
        fStringBlockSize : Cardinal;

   function GetRecord(Index: Cardinal): TSchDBCRecord;
   
  public
   constructor Create(const AFile : string ); overload;
   constructor Create( AStream : TStream ); overload;
    destructor Destroy(); override;

   property RecordCount : Cardinal read fRecordNumber;
   property Records[ Index : Cardinal ] : TSchDBCRecord read GetRecord;
   property RecordSize  : Cardinal read fRecordSize;
   property FieldCount  : Cardinal read fNumberOfFields;
 end;

implementation

{ TSchDBCFile }

constructor TSchDBCFile.Create(const AFile: string);
var
 fs : TFileStream;

begin

 fs := nil;
 
 try
  fs := TFileStream.Create( AFile, fmOpenRead );
  Create( fs );
 except
  FreeAndNil( fs );
  raise EStreamError.Create( 'Invalid Input DBC File!' );
 end;

 fs.Destroy();

end;

constructor TSchDBCFile.Create(AStream: TStream);
var
 i, u  : Cardinal;
 c  : array[0..3] of Byte absolute i;
begin
 inherited Create;
 fArray := TReadBuffer.Create(AStream);

 if fArray.Size < 20 then
    raise EStreamError.Create( 'Invalid Input DBC File!' );

 { Now extract data }

  u := 0;

  c[0] := fArray[u + 0];
  c[1] := fArray[u + 1];
  c[2] := fArray[u + 2];
  c[3] := fArray[u + 3];

  if (c[0] <> Ord('W')) or (c[1] <> Ord('D')) or (c[2] <> Ord('B')) or (c[3] <> Ord('C')) then
     raise EStreamError.Create( 'Invalid Input DBC File!' );

  Inc( u, 4 );
  c[0] := fArray[u + 0];
  c[1] := fArray[u + 1];
  c[2] := fArray[u + 2];
  c[3] := fArray[u + 3];
  fRecordNumber := i;

  Inc( u, 4 );
  c[0] := fArray[u + 0];
  c[1] := fArray[u + 1];
  c[2] := fArray[u + 2];
  c[3] := fArray[u + 3];
  fNumberOfFields := i;

  Inc( u, 4 );
  c[0] := fArray[u + 0];
  c[1] := fArray[u + 1];
  c[2] := fArray[u + 2];
  c[3] := fArray[u + 3];
  fRecordSize := i;

  Inc( u, 4 );
  c[0] := fArray[u + 0];
  c[1] := fArray[u + 1];
  c[2] := fArray[u + 2];
  c[3] := fArray[u + 3];
  fStringBlockSize := i;

  if (fNumberOfFields * SizeOf(Cardinal)) <> fRecordSize then
     raise EStreamError.Create( 'Invalid Input DBC File!' );

  Inc( u, 4 );
  fDataOffset := u;
  fStrOffset  := fDataOffset + (fRecordSize * fRecordNumber);
end;

destructor TSchDBCFile.Destroy;
begin
 fArray.Free;
 inherited Destroy;
end;

function TSchDBCFile.GetRecord(Index: Cardinal): TSchDBCRecord;
begin
 Result.iOffset := fDataOffset + (Index * fRecordSize);
 Result.cParent := Self;
end;

{ TSchDBCRecord }

function TSchDBCRecord.Fields: Cardinal;
begin
 Result := cParent.fNumberOfFields;
end;

function TSchDBCRecord.ReadFloat(iField: Cardinal): Single;
begin
  Result := PSingle(cParent.fArray.GetPtr(iOffset + iField * SizeOf(Single)))^;
end;

function TSchDBCRecord.ReadString(iField: Cardinal): string;
begin
  PCharToString(cParent.fArray.GetPtr(ReadUInt32(iField) + cParent.fStrOffset), Result);
end;

function TSchDBCRecord.ReadUInt32(iField: Cardinal): Cardinal;
begin
  Result := PLongword(cParent.fArray.GetPtr(iOffset + iField * SizeOf(Integer)))^;
end;

end.
