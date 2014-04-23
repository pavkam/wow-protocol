unit MapOutputStore;
interface
Uses Utils, SysUtils, Classes, ArrayList, Math;

Const
 MapBlocksDim      =   64;
 
 MapChunkCell      =   16;
 MapChunckVertices =    8;

 ZResolution       =   256;

 TileSize          =   533.33333;
 ChunkSize         =   TileSize / MapChunkCell;
 UnitSize          =   ChunkSize / MapChunckVertices;

 NoLiquid          =   NaN;
 NoAreaFlag        =   $FFFF;

Type
 TSchDoublePoint = record
   fX, fY, fZ : Single;
 end;

 TSchMapChunk  = record
  fVertices_9  : array[ 0 .. 8, 0 .. 8 ] of Single;
  fVertices_8  : array[ 0 .. 7, 0 .. 7 ] of Single;
  iAreaID      : Cardinal;
  fWaterLevels : array[ 0 .. 8, 0 .. 8 ] of Single;
  iFlag        : Byte;

  rTopLeft     : TSchDoublePoint;
 end;

 PSchMapBlock = ^TSchMapBlock;
 TSchMapBlock = record
   aCells : array[ 0 .. MapChunkCell - 1, 0 .. MapChunkCell - 1 ] of TSchMapChunk;
 end;

 PSchStoredMapBlock = ^TSchStoredMapBlock;
 TSchStoredMapBlock = record
   aCellLiquid     : array[ 0 .. (MapChunkCell*8) - 1, 0 .. (MapChunkCell*8) - 1 ] of Single;
   aCellLiquidFlag : array[ 0 .. MapChunkCell - 1, 0 .. MapChunkCell - 1 ] of Byte;
   aCellAreaFlag   : array[ 0 .. MapChunkCell - 1, 0 .. MapChunkCell - 1 ] of Cardinal;
   aCellZ          : array[ 0 .. ZResolution - 1, 0 .. ZResolution - 1 ] of Single;
 end;


 TSchTransformationCell = record
  fVertices_9  : array[ 0 .. MapChunkCell * 8, 0 .. MapChunkCell * 8 ] of Single;
  fVertices_8  : array[ 0 .. (MapChunkCell * 8) - 1, 0 .. (MapChunkCell * 8) - 1 ] of Single;
 end;


implementation


end.
