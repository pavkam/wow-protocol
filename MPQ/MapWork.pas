unit MapWork;

interface

Uses SysUtils, Classes, Utils, DBCHandle, HashMap, ArrayList,
     ADTHandle, MapOutputStore, Miscelaneous, Math, FileHandle;

Const
 BlizzMapName      =   'World\Maps\%s\%s_%d_%d.adt';
 MapVersion        =   1;  

type
 TSchTerrainType = ( ttWater, ttLand );

 TSch3DoublePointArray = array[0..2] of TSchDoublePoint;

 PSchAreaRecord = ^TSchAreaRecord;
 TSchAreaRecord = record
  iID    : Cardinal;
  iFlag  : Cardinal;
  iMap   : Cardinal;
  iZone  : Cardinal;
  iLevel : Cardinal;
  sName  : String;
 end;

 PSchMapRecord = ^TSchMapRecord;
 TSchMapRecord = record
  iID     : Cardinal;
  sInName : String;
  sName   : String;
 end;

 TSchMapChunkHeader = record
  flags, ix, iy, nLayers,
  nDoodadRefs, ofsHeight, ofsNormal,
  ofsLayer, ofsRefs, ofsAlpha, sizeAlpha,
  ofsShadow, sizeShadow, areaid, nMapObjRefs,
  holes : Cardinal;

  s1, s2 : Word;

  d1, d2, d3, predTex, nEffectDoodad, ofsSndEmitters,
  nSndEmitters, ofsLiquid, sizeLiquid,

  zpos, xpos, ypos : Single;

  textureId, props, effectId : Cardinal;
 end;

 TSchMapWorker = class( TObject )
  private
   fILiquid, fIZ, fIArea : Boolean;

   fAreaHashMap   : TIntPtrPlatformHashMap;
   fAreaList      : TPtrPlatformArrayList;

   fMapHashMap    : TIntPtrPlatformHashMap;
   fMapList       : TPtrPlatformArrayList;

   fOutFile       : String;
   fFile          : TFileHandle;

   fBlockIndex    : Cardinal;
   fFirstIndex    : Boolean;

   function GetMapRecord(Index: Integer): TSchMapRecord;
   function GetMapCount: Cardinal;

   { Internal stuff }

   function LoadMapChunk( const ADTFile : TSchADTMapFile ) : TSchMapChunk;
   function CalculateZ( const tc : TSchTransformationCell; const x, z : Single ) : Single;

   procedure SolvePlane( const v : TSch3DoublePointArray; const p : TSchDoublePoint; var Result: Single);

  public
   constructor Create( OutFile : String; bILiquid, bIZ, bIArea : Boolean );
    destructor Destroy(); override;

   { Processing }
    function CheckAreaDBCFormat(  const cEntry : TSchDBCRecord  ) : Boolean;
   procedure AddAreaDBCEntry( const cEntry : TSchDBCRecord );

    function CheckMapDBCFormat(  const cEntry : TSchDBCRecord  ) : Boolean;
   procedure AddMapDBCEntry( const cEntry : TSchDBCRecord );

   function ProcessADTMapFile( const ADTFile : TSchADTMapFile; const iX, iY : Cardinal ) : TSchTerrainType;

   { File stuff }
   procedure InsertYMFHeader();
   procedure InsertMapHeader( const MapID, iBlocks : Cardinal );
   procedure InsertMapBlock ( pBlock : PSchStoredMapBlock; const X, Y : Cardinal );

   property MapCount : Cardinal read GetMapCount;
   property Maps[ Index: Integer ] : TSchMapRecord read GetMapRecord;
 end;

implementation

{ TSchMapWorker }

procedure TSchMapWorker.AddAreaDBCEntry(const cEntry: TSchDBCRecord);
var
 rc : PSchAreaRecord;

begin
 New( rc );

 rc.iID    := cEntry.ReadUInt32( 0 );
 rc.iMap   := cEntry.ReadUInt32( 1 );
 rc.iZone  := cEntry.ReadUInt32( 2 );
 rc.iFlag  := cEntry.ReadUInt32( 3 );
 rc.sName  := cEntry.ReadString( 11 );

 fAreaHashMap.PutValue( rc.iID, rc );
 fAreaList.Add( rc );
end;

procedure TSchMapWorker.AddMapDBCEntry(const cEntry: TSchDBCRecord);
var
 rc : PSchMapRecord;

begin
 New( rc );

 rc.iID     := cEntry.ReadUInt32( 0 );
 rc.sInName := cEntry.ReadString( 1 );
 rc.sName   := cEntry.ReadString( 4 );

 fMapHashMap.PutValue( rc.iID, rc );
 fMapList.Add( rc );
end;

function TSchMapWorker.CalculateZ(const tc: TSchTransformationCell; const x, z: Single): Single;
var
 v : TSch3DoublePointArray;
 p : TSchDoublePoint;

 iCx, iCz : Cardinal;
 fDx, fDz : Single;
begin

 { Find the square that contains the given coords }
 iCx := Round(x / UnitSize);
 iCz := Round(z / UnitSize);

 if iCx > (MapChunkCell * 8) - 1 then iCx := (MapChunkCell * 8) - 1;
 if iCz > (MapChunkCell * 8) - 1 then iCz := (MapChunkCell * 8) - 1;

 fDx := x - (iCx * UnitSize);
 fDz := z - (iCz * UnitSize);

 p.fX := fDx;
 p.fZ := fDz;

 v[0].fX := UnitSize / 2;
 v[0].fY := tc.fVertices_8[iCx, iCz];
 v[0].fZ := UnitSize / 2;

 if fDx > fDz then
 begin
  v[1].fX := UnitSize;
  v[1].fY := tc.fVertices_9[iCx + 1, iCz];
  v[1].fZ := 0;
 end else
 begin
  v[1].fX := 0;
  v[1].fY := tc.fVertices_9[iCx, iCz+1];
  v[1].fZ := UnitSize;
 end;

 if fDz > UnitSize - fDx then
 begin
  v[2].fX := UnitSize;
  v[2].fY := tc.fVertices_9[iCx + 1, iCz + 1];
  v[2].fZ := UnitSize;
 end else
 begin
  v[2].fX := 0;
  v[2].fY := tc.fVertices_9[iCx, iCz];
  v[2].fZ := 0;
 end;

 SolvePlane( v, p, Result );
end;

function TSchMapWorker.CheckAreaDBCFormat(const cEntry: TSchDBCRecord): Boolean;
begin
 if cEntry.Fields() <> 25 then
    Result := False else Result := True;
end;

function TSchMapWorker.CheckMapDBCFormat(const cEntry: TSchDBCRecord): Boolean;
begin
 if cEntry.Fields() <> 42 then
    Result := False else Result := True;
end;

constructor TSchMapWorker.Create(OutFile: String; bILiquid, bIZ, bIArea : Boolean);
begin
 fFile := TFileHandle.Create(OutFile, True);
 fFile.WriteCacheSize := 1 shl 20;
 if not fFile.CreateFile(True, False) then raise EStreamError.Create('Cannot create ouput file!');

 fBlockIndex  := 0;

 fAreaHashMap := TIntPtrPlatformHashMap.Create();
 fAreaList    := TPtrPlatformArrayList.Create();

 fMapHashMap := TIntPtrPlatformHashMap.Create();
 fMapList    := TPtrPlatformArrayList.Create();

 fILiquid := bILiquid;
 fIZ      := bIZ;
 fIArea   := bIArea;

 fOutFile := OutFile;
end;

destructor TSchMapWorker.Destroy;
var
 i  : Integer;
 rc : PSchMapRecord;
begin
 fFile.Free();

 { Dispose Blocks }
 if fAreaList.Size > 0 then
    for i := 0 to fAreaList.Size - 1 do
        FreeMem( fAreaList[i] );

 if fMapList.Size > 0 then
    for i := 0 to fMapList.Size - 1 do
    begin
     rc := fMapList.Items[i];
     FreeMem( rc );
    end;

 { Data Freeing }
 fAreaList.Destroy();
 fAreaHashMap.Destroy();

 fMapList.Destroy();
 fMapHashMap.Destroy();
end;

function TSchMapWorker.GetMapCount: Cardinal;
begin
 Result := fMapList.Size;
end;

function TSchMapWorker.GetMapRecord(Index: Integer): TSchMapRecord;
var
 rc : PSchMapRecord;
begin
 rc := fMapList.Items[Index];
 Result := rc^;
end;

procedure TSchMapWorker.InsertMapBlock(pBlock: PSchStoredMapBlock; const X, Y : Cardinal);
var
 i : Cardinal;
 iOff : Cardinal;
begin

 iOff := fFile.Position;
 
 i := X;
 fFile.WriteData( i, SizeOf(i) );

 i := Y;
 fFile.WriteData( i, SizeOf(i) );

 if fILiquid then
 begin
  fFile.WriteData( pBlock^.aCellLiquid, SizeOf(pBlock^.aCellLiquid) );
  fFile.WriteData( pBlock^.aCellLiquidFlag, SizeOf(pBlock^.aCellLiquidFlag) );
 end;

 if fIArea then
    fFile.WriteData( pBlock^.aCellAreaFlag, SizeOf(pBlock^.aCellAreaFlag) );

 if fIZ then
    fFile.WriteData( pBlock^.aCellZ, SizeOf(pBlock^.aCellZ) );

 fFile.Seek( fBlockIndex + ( (( x * MapBlocksDim ) + y) * SizeOf(Cardinal) ), fspStart, nil );
 fFile.WriteData( iOff, SizeOf(iOff) );

 fFile.SeekEnd;
end;

procedure TSchMapWorker.InsertMapHeader(const MapID, iBlocks : Cardinal);
var
 MagicID : array[0..2] of Char;
 mc      : PSchMapRecord;

 iCt     : Cardinal;
begin
 MagicId[0] := 'M';
 MagicId[1] := 'A';
 MagicId[2] := 'P';

 mc := fMapHashMap[MapID];

 iCt := iBlocks;

 fFile.WriteData( MagicID, SizeOf(MagicID) );
 fFile.WriteData( mc^.iID, SizeOf(mc^.iID) );
 fFile.WriteData( iCt, SizeOf(iCt) );

 if fFirstIndex then
    fFirstIndex := False else
    fBlockIndex := fBlockIndex + (MapBlocksDim * MapBlocksDim * SizeOf(Cardinal));
end;

procedure TSchMapWorker.InsertYMFHeader;
Var
 MagicID : array[0..2] of Char;

 iNrMaps : Cardinal;
 iTempF  : Single;
 iTempC, i  : Cardinal;
 iOff    : Cardinal;
 
 aEmpty  : array of byte;
begin
 MagicId[0] := 'Y';
 MagicId[1] := 'M';
 MagicId[2] := 'F';

 iNrMaps := MapCount;

 fFile.WriteData( MagicID, SizeOf(MagicID) );

 iTempC := MapVersion;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempC := Integer( fILiquid ) ;
 fFile.WriteData( iTempC, SizeOf(iTempC) );
 iTempC := Integer( fIZ ) ;
 fFile.WriteData( iTempC, SizeOf(iTempC) );
 iTempC := Integer( fIArea ) ;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 fFile.WriteData( iNrMaps, SizeOf(iNrMaps) );

 iTempF := TileSize;
 fFile.WriteData( iTempF, SizeOf(iTempF) );

 iTempC := MapBlocksDim;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempC := MapChunkCell;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempC := MapChunkCell;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempC := MapChunkCell * MapChunckVertices;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempC := ZResolution;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempC := NoAreaFlag;
 fFile.WriteData( iTempC, SizeOf(iTempC) );

 iTempF := NoLiquid;
 fFile.WriteData( iTempF, SizeOf(iTempF) );

 SetLength( aEmpty, MapBlocksDim * MapBlocksDim * SizeOf(Cardinal) );
 FillChar( aEmpty[1], Length(aEmpty), 0 );

 { MapTable }
 iOff        := fFile.Position + (iNrMaps * SizeOf(Cardinal) * 2);
 fBlockIndex := iOff;
 fFirstIndex := True;
 for i := 0 to iNrMaps - 1 do
 begin
      iTempC := Maps[i].iID;
      fFile.WriteData( iTempC, SizeOf(iTempC) );

      iTempC := iOff;
      fFile.WriteData( iTempC, SizeOf(iTempC) );

      Inc( iOff, Length(aEmpty) );
 end;

 { Write the empty offset header }
 for i := 0 to iNrMaps - 1 do
     fFile.WriteData( aEmpty[1], Length(aEmpty) );

 aEmpty := nil;
end;

const
  MCVT = Ord('M') shl 24 + Ord('C') shl 16 + Ord('V') shl 8 + Ord('T');
  MCNR = Ord('M') shl 24 + Ord('C') shl 16 + Ord('N') shl 8 + Ord('R');
  MCLQ = Ord('M') shl 24 + Ord('C') shl 16 + Ord('L') shl 8 + Ord('Q');
  MCSE = Ord('M') shl 24 + Ord('C') shl 16 + Ord('S') shl 8 + Ord('E');
  MCLY = Ord('M') shl 24 + Ord('C') shl 16 + Ord('L') shl 8 + Ord('Y');
  MCAL = Ord('M') shl 24 + Ord('C') shl 16 + Ord('A') shl 8 + Ord('L');
  MCIN = Ord('M') shl 24 + Ord('C') shl 16 + Ord('I') shl 8 + Ord('N');

function TSchMapWorker.LoadMapChunk(const ADTFile: TSchADTMapFile): TSchMapChunk;
var
  iChunkSize, iChunkEnd: Cardinal;

  iNextChunk, iCurrSize: Cardinal;
  iChunkName: Longword;

  rHeader: TSchMapChunkHeader;

  iTextures: Cardinal;

  i, v: Cardinal;
  fH, fZ: Single;
begin
  { Load the real data header from the Chunk }
  ADTFile.ReadUInt32; { Skip Chunk Name }
  iChunkSize := ADTFile.ReadUInt32;

  { Calculate chunk end }
  iChunkEnd := ADTFile.Position + iChunkSize;

  { Read chunk header }
  ADTFile.ReadVar(@rHeader, SizeOf(rHeader));

  FillChar(Result, SizeOf(Result), 0);

  { Initializing our export entry }
  Result.iAreaID := rHeader.areaid;
  Result.iFlag := 0;

  Result.rTopLeft.fX := (TileSize * 32) - rHeader.xpos;
  Result.rTopLeft.fZ := (TileSize * 32) - rHeader.zpos;
  Result.rTopLeft.fY := rHeader.ypos;

  iTextures := 0;
 
  while (ADTFile.Position < iChunkEnd) do
  begin
    iChunkName := ADTFile.ReadUInt32;
    iCurrSize := ADTFile.ReadUInt32;
    iNextChunk := iCurrSize + ADTFile.Position;

    case iChunkName of
      MCVT:
      begin
        { Read the vertices:
          There are 17 rows to read.
          The (2n+1) rows are 9 float wide, the (2n) are 8
        }

        for i := 0 to 16 do
        begin
          for v := 0 to 7 + Integer(not Odd(i)) do
          begin
            fZ := ADTFile.ReadFloat + Result.rTopLeft.fY;

            if Odd(i) then
              Result.fVertices_8[v, (i shr 1)] := fZ
            else
              Result.fVertices_9[v, (i shr 1)] := fZ;
          end;
        end;
      end;
      MCNR:
      begin
        iNextChunk := ADTFile.Position + $1C0; { This chunk's size is wrong so manual adjust required }
      end;
      MCLQ:
      begin
        { Liquid extraction }

        if ADTFile.CurrentChunkIdent = MCSE then
        begin
          { Yet another Blizzard hack. If there is no liquid, after size follows an empty MCSE block! }
          { Mark the liquid spots as NoLiquid-ed :) }
          for i := 0 to 8 do
          begin
            Result.fWaterLevels[i, 0] := NoLiquid;
            Result.fWaterLevels[i, 1] := NoLiquid;
            Result.fWaterLevels[i, 2] := NoLiquid;
            Result.fWaterLevels[i, 3] := NoLiquid;
            Result.fWaterLevels[i, 4] := NoLiquid;
            Result.fWaterLevels[i, 5] := NoLiquid;
            Result.fWaterLevels[i, 6] := NoLiquid;
            Result.fWaterLevels[i, 7] := NoLiquid;
            Result.fWaterLevels[i, 8] := NoLiquid;
          end;

        end else
        begin
          { There is liquid indeed in this cell. }
          ADTFile.ReadUInt32; { An unknown uint32 }
          fZ := ADTFile.ReadFloat; { this is the max height }

          for i := 0 to 8 do
          begin
            for v := 0 to 8 do
            begin
              ADTFile.ReadUInt32;
              fH := ADTFile.ReadFloat(); { Don't ask me why :) }

              if fH > fZ then
                Result.fWaterLevels[i, v] := NoLiquid
              else
                Result.fWaterLevels[i, v] := fH;
            end;
          end;

          { Now check the liquid type }

          if (rHeader.flags and 12) <> 0 then
            Result.iFlag := Result.iFlag or 1;

          if (rHeader.flags and 16) <> 0 then
            Result.iFlag := Result.iFlag or 2;
        end;

        Break; { We need no more data }
      end;
      MCLY:
      begin
        iTextures := Integer(iCurrSize); { The size of this chunk is the number of textures }
      end;
      MCAL:
      begin
        if iTextures <= 0 then Continue; { This chunk is also broken for zero size }
      end;
    end;

    ADTFile.SkipToChunkAt(iNextChunk);
  end;
end;

function TSchMapWorker.ProcessADTMapFile(const ADTFile: TSchADTMapFile; const iX, iY: Cardinal): TSchTerrainType;
var
  MapChunkOffsets: array[0..(MapChunkCell * MapChunkCell)- 1] of Cardinal;
  MapChunkSizes: array[0..(MapChunkCell * MapChunkCell)- 1] of Cardinal;

  MapChunks: TSchMapBlock;
  StoredMap: PSchStoredMapBlock;
  i, x, y: Integer;
  rc: PSchAreaRecord;

  tc: TSchTransformationCell;
  iWP: Integer;
  iX1, iX2, iY1, iY2: Integer;
begin
  { Search the MCIN chunk to extract the offsets/sizes of MCNK chunks }

  while ADTFile.CurrentChunkIdent <> MCIN do ADTFile.SkipChunk;

  { MCIN Found ... let's extract MCNK data block info }
  ADTFile.ReadUInt32();
  ADTFile.ReadUInt32(); { Skip header }

  for i := 0 to (MapChunkCell * MapChunkCell) - 1 do
  begin
    MapChunkOffsets[i] := ADTFile.ReadUInt32;
    MapChunkSizes[i] := ADTFile.ReadUInt32;

    ADTFile.ReadUInt32; { Skip 4 bytes }
    ADTFile.ReadUInt32; { Skip 4 bytes }
  end;

  { We have all the date we need to start collecting MCNK chunks that contain the actual stuff we need }

  New(StoredMap);

  for x := 0 to MapChunkCell - 1 do
  begin
    for y := 0 to MapChunkCell - 1 do
    begin
      ADTFile.SkipToChunkAt( MapChunkOffsets[(x * MapChunkCell) + y] );
      MapChunks.aCells[x, y] := LoadMapChunk( ADTFile );
      { Transforming the 16x16 with 8x8 inside it to a general 128x128 resolution map for liquid }
      { Copy the 16x16 resolution liquid type }
      StoredMap^.aCellLiquidFlag[x, y] := MapChunks.aCells[x, y].iFlag;
      { Look-up the Area flags for each cell }
      rc := fAreaHashMap[ MapChunks.aCells[x, y].iAreaID ];
      if rc <> nil then
      begin
        StoredMap^.aCellAreaFlag[x, y] := rc^.iFlag;
      end else StoredMap^.aCellAreaFlag[x, y] := NoAreaFlag;
    end;
  end;

  iWP := 0;
  { 1. Changing the resolution of 16x16 with 8x8 or 9x9 to 128x128 and more }


  for x := 0 to (MapChunkCell * 8) - 1 do
  begin
    iX1 := DivModPowerOf2(x, 3, iX2);
    for y := 0 to (MapChunkCell * 8) - 1 do
    begin
      iY1 := DivModPowerOf2(y, 3, iY2);

      StoredMap^.aCellLiquid[x, y] := MapChunks.aCells[iX1, iY1].fWaterLevels[iX2, iY2];
      if not IsNan(Single(StoredMap^.aCellLiquid[x, y])) then Inc(iWP);

      tc.fVertices_8[x, y] := MapChunks.aCells[iX1, iY1].fVertices_8[iX2, iY2];
      tc.fVertices_9[x, y] := MapChunks.aCells[iX1, iY1].fVertices_9[iX2, iY2];
    end;

    { Last points for 9 vertices }
    tc.fVertices_9[x, (MapChunkCell * 8)] := MapChunks.aCells[iX1, MapChunkCell - 1].fVertices_9[iX2, 8];
    tc.fVertices_9[(MapChunkCell * 8), x] := MapChunks.aCells[MapChunkCell - 1, iX1].fVertices_9[8, iX2];
  end;

  { the last corner }
  tc.fVertices_9[(MapChunkCell * 8), (MapChunkCell * 8)] := MapChunks.aCells[MapChunkCell - 1, MapChunkCell - 1].fVertices_9[8, 8];

  { 2. Using a special utility function to calculate the Z }

  for x := 0 to ZResolution - 1 do
  begin
    for y := 0 to ZResolution - 1 do
    begin
      StoredMap^.aCellZ[x, y] := CalculateZ(tc, (y * TileSize) / (ZResolution - 1),
        (x * TileSize) / (ZResolution - 1));
    end;
  end;

  if (iWP/(MapChunkCell*MapChunkCell*8*8)) > 0.3 then
    Result := ttWater
  else
    Result := ttLand;

  InsertMapBlock(StoredMap, iX, iY);
  Dispose(StoredMap);
end;

procedure TSchMapWorker.SolvePlane(const v: TSch3DoublePointArray; const p: TSchDoublePoint; var Result: Single);
var
  a, b, c: Single;
begin
  a := v[0].fY *(v[1].fZ - v[2].fZ) + v[1].fY *(v[2].fZ - v[0].fZ) + v[2].fY *(v[0].fZ - v[1].fZ);
  b := v[0].fZ *(v[1].fX - v[2].fX) + v[1].fZ *(v[2].fX - v[0].fX) + v[2].fZ *(v[0].fX - v[1].fX);
  c := v[0].fX *(v[1].fY - v[2].fY) + v[1].fX *(v[2].fY - v[0].fY) + v[2].fX *(v[0].fY - v[1].fY);
  Result := v[0].fX *(v[1].fY*v[2].fZ - v[2].fY*v[1].fZ) + v[1].fX* (v[2].fY*v[0].fZ - v[0].fY*v[2].fZ) + v[2].fX* (v[0].fY*v[1].fZ - v[1].fY*v[0].fZ);

  Result := -((a*p.fX+c*p.fZ-Result)/b);
end;

end.
