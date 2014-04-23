unit FileHandle;

interface

const
  BOUNDARY = 4096;
  DEFAULT_CACHE_SIZE = BOUNDARY * 4;

type
  PFileCache = ^TFileCache;

  TFileCache = record
    Cache: PChar;
    CachePos: Integer;
    CacheSize: Integer;
    CacheCapacity: Integer;
    Enabled: Boolean;
  end;

  {$Z4}
  TFileAccessMode = (famNone, famRead, famWrite, famReadWrite);
  TFileSeekPoint = (fspStart, fspCurrent, fspEnd);
  TFileAttribute = (faReadonly, faSystem, faHidden, faDirectory, faArchive,
    faDevice, faNormal, faTemporary, faSparse, faReparsePoint, faCompressed,
    faOffline { Remote }, faEncrypted, faNotContentIndexed);
  TFileAttributes = set of TFileAttribute;
  {$Z1}

  TFileHandle = class(TObject)
  protected
    fFileHandle: THandle;
    fFileName: String;
    fFileAccess: TFileAccessMode;
    fFileAttributes: TFileAttributes;
    fFileSize: Int64;
    fFilePosition: Int64;
    fWriteBuffer: TFileCache;
    fReadBuffer: TFileCache;
    fCached: Boolean;

    function GetEof: Boolean; inline;

    procedure SetCachedReads;
    procedure SetCachedWrites;

    procedure SetReadCacheSize(iSize: Integer);
    procedure SetWriteCacheSize(iSize: Integer);

    procedure SeekDirect(const liNewPos: Int64);

    procedure FlushWriteCache;
    procedure FillReadCache;

    procedure InternalGetFileSizeAndAttributes;

    function ReadDataCached(var xBuffer; iSize: Integer;
      pBytesRead: PInteger): Boolean;
    function ReadDataRaw(var xBuffer; iSize: Integer; pBytesRead: PInteger): Boolean;

    function WriteDataCached(const xBuffer; iSize: Integer;
      pBytesWritten: PInteger): Boolean;
    function WriteDataRaw(const xBuffer; iSize: Integer;
      pBytesWritten: PInteger): Boolean;
  public
    constructor Create(const sFileName: String; bCached: Boolean = True);
    destructor Destroy; override;

    function CreateFile(bOverwrite, bAllowHandleSharing: Boolean): Boolean;
    function OpenFile(iFileAccessType: TFileAccessMode;
      bAllowHandleSharing: Boolean): Boolean;
    function TryOpenFile(iFileAccessType: TFileAccessMode;
      bAllowHandleSharing: Boolean): Boolean;

    function Truncate: Boolean;
    procedure ForceFlush;

    function Seek(const liDistance: Int64; iSeekPoint: TFileSeekPoint;
      pNewPosition: PInt64 = nil): Boolean;
    procedure SeekEnd;
    procedure SeekStart;

    function WriteData(const xBuffer; iSize: Integer;
      pBytesWritten: PInteger = nil): Boolean;
    function ReadData(var xBuffer; iSize: Integer;
      pBytesRead: PInteger = nil): Boolean;

    property FileName: String Read fFileName;
    property Handle: THandle Read fFileHandle;
    property FileAttributes: TFileAttributes Read fFileAttributes;
    property FileSize: Int64 Read fFileSize;
    property Position: Int64 Read fFilePosition Write SeekDirect;
    property EOF: Boolean Read GetEof;
    property WriteCacheSize: Integer Read fWriteBuffer.CacheSize
      Write SetWriteCacheSize;
    property ReadCacheSize: Integer Read fReadBuffer.CacheSize Write SetReadCacheSize;
  end;

implementation

uses
  Miscelaneous, Utils, Windows;

type
  PLockedRegionInfo = ^TLockedRegionInfo;

  TLockedRegionInfo = record
    Offset: Int64;
    Count: Int64;
  end;

const
  Access: array[0..3] of Longword = (
    0,
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE
    );

  Share: array[Boolean, 0..3] of Longword = (
    ( { if sharing is false }
    0,
    0,
    0,
    0
    ),
    ( { else }
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE
    )
    );

  CreationType: array[Boolean] of Longword = (
    CREATE_NEW,
    CREATE_ALWAYS
    );

constructor TFileHandle.Create(const sFileName: String; bCached: Boolean);
begin
  inherited Create;
  fFileName := sFileName;
  fFileHandle := INVALID_HANDLE_VALUE;
  fCached := bCached;
end;

destructor TFileHandle.Destroy;
begin
  if fCached then
  begin
    if fWriteBuffer.Enabled then
    begin
      FlushWriteCache;
      FreeMem(fWriteBuffer.Cache);
    end;
    if fReadBuffer.Enabled then
    begin
      FreeMem(fReadBuffer.Cache);
    end;
  end;
  if fFileHandle <> INVALID_HANDLE_VALUE then CloseHandle(fFileHandle);
  inherited Destroy;
end;

function TFileHandle.GetEof: Boolean;
begin
  Result := fFilePosition = fFileSize;
end;

procedure TFileHandle.InternalGetFileSizeAndAttributes;
var
  tInfo: TByHandleFileInformation;
  dwAttr: Longword;
begin
  GetFileInformationByHandle(fFileHandle, tInfo);
  dwAttr := tInfo.dwFileAttributes;
  if (dwAttr and FILE_ATTRIBUTE_READONLY) <> 0 then
  begin
    Include(fFileAttributes, faReadonly);
  end;
  if (dwAttr and FILE_ATTRIBUTE_HIDDEN) <> 0 then
  begin
    Include(fFileAttributes, faHidden);
  end;
  if (dwAttr and FILE_ATTRIBUTE_SYSTEM) <> 0 then
  begin
    Include(fFileAttributes, faSystem);
  end;
  if (dwAttr and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
  begin
    Include(fFileAttributes, faDirectory);
  end;
  if (dwAttr and FILE_ATTRIBUTE_ARCHIVE) <> 0 then
  begin
    Include(fFileAttributes, faArchive);
  end;
  if (dwAttr and FILE_ATTRIBUTE_DEVICE) <> 0 then
  begin
    Include(fFileAttributes, faDevice);
  end;
  if (dwAttr and FILE_ATTRIBUTE_NORMAL) <> 0 then
  begin
    Include(fFileAttributes, faNormal);
  end;
  if (dwAttr and FILE_ATTRIBUTE_TEMPORARY) <> 0 then
  begin
    Include(fFileAttributes, faTemporary);
  end;
  if (dwAttr and FILE_ATTRIBUTE_SPARSE_FILE) <> 0 then
  begin
    Include(fFileAttributes, faSparse);
  end;
  if (dwAttr and FILE_ATTRIBUTE_REPARSE_POINT) <> 0 then
  begin
    Include(fFileAttributes, faReparsePoint);
  end;
  if (dwAttr and FILE_ATTRIBUTE_COMPRESSED) <> 0 then
  begin
    Include(fFileAttributes, faCompressed);
  end;
  if (dwAttr and FILE_ATTRIBUTE_OFFLINE) <> 0 then
  begin
    Include(fFileAttributes, faOffline);
  end;
  if (dwAttr and FILE_ATTRIBUTE_ENCRYPTED) <> 0 then
  begin
    Include(fFileAttributes, faEncrypted);
  end;
  if (dwAttr and FILE_ATTRIBUTE_NOT_CONTENT_INDEXED) <> 0 then
  begin
    Include(fFileAttributes, faNotContentIndexed);
  end;
  fFileSize := tInfo.nFileSizeLow or (tInfo.nFileSizeHigh shl 32);
end;

procedure TFileHandle.SetCachedReads;
begin
  fReadBuffer.Enabled := True;
  fReadBuffer.CacheCapacity := DEFAULT_CACHE_SIZE;
  GetMem(fReadBuffer.Cache, DEFAULT_CACHE_SIZE);
end;

procedure TFileHandle.SetCachedWrites;
begin
  fWriteBuffer.Enabled := True;
  fWriteBuffer.CacheCapacity := DEFAULT_CACHE_SIZE;
  fWriteBuffer.CacheSize := fWriteBuffer.CacheCapacity;
  GetMem(fWriteBuffer.Cache, DEFAULT_CACHE_SIZE);
end;

procedure TFileHandle.SetReadCacheSize(iSize: Integer);
begin
  if fReadBuffer.Enabled then
  begin
    if iSize > 0 then
    begin
      ForceAlignment(Longword(iSize), BOUNDARY);
      if iSize <> fReadBuffer.CacheCapacity then
      begin
        fReadBuffer.CacheCapacity := iSize;
        //if fReadBuffer.CachePos > iSize then
        //begin
        //  fReadBuffer.CachePos := 0;
        //end;
        ReallocMem(fWriteBuffer.Cache, iSize);
      end;
    end;
  end;
end;

procedure TFileHandle.SetWriteCacheSize(iSize: Integer);
begin
  if fWriteBuffer.Enabled then
  begin
    if iSize > 0 then
    begin
      ForceAlignment(Longword(iSize), BOUNDARY);
      if iSize <> fWriteBuffer.CacheCapacity then
      begin
        if iSize < fWriteBuffer.CacheCapacity - 1 then FlushWriteCache;
        fWriteBuffer.CacheCapacity := iSize;
        fWriteBuffer.CacheSize := iSize;
        fWriteBuffer.CachePos := 0;
        ReallocMem(fWriteBuffer.Cache, iSize);
      end;
    end;
  end;
end;

procedure TFileHandle.FlushWriteCache;
begin
  WriteDataRaw(fWriteBuffer.Cache[0], fWriteBuffer.CachePos, nil);
  fWriteBuffer.CachePos := 0;
end;

procedure TFileHandle.ForceFlush;
begin
  if ((Integer(fFileAccess) and Integer(famWrite)) <> 0) and fCached then
  begin
    FlushWriteCache;
  end;
end;

procedure TFileHandle.FillReadCache;
begin
  ReadDataRaw(fReadBuffer.Cache[0], fReadBuffer.CacheCapacity, @fReadBuffer.CacheSize);
  fReadBuffer.CachePos := 0;
end;

function TFileHandle.ReadDataRaw(var xBuffer; iSize: Integer;
  pBytesRead: PInteger): Boolean;
var
  iOut: Longword;
begin
  if (Integer(fFileAccess) and Integer(famRead)) <> 0 then
  begin
    Result := ReadFile(fFileHandle, xBuffer, iSize, iOut, nil);
    if pBytesRead <> nil then pBytesRead^ := iOut;
  end else
    Result := False;
end;

function TFileHandle.ReadDataCached(var xBuffer; iSize: Integer;
  pBytesRead: PInteger): Boolean;
var
  iPrevCnt: Integer;
begin
  if fReadBuffer.CachePos = fReadBuffer.CacheSize then FillReadCache;
  if iSize <= fReadBuffer.CacheSize then
  begin
    if fReadBuffer.CachePos + iSize > fReadBuffer.CacheSize then
    begin
      iPrevCnt := fReadBuffer.CacheSize - fReadBuffer.CachePos;
      Move(fReadBuffer.Cache[fReadBuffer.CachePos], xBuffer, iPrevCnt);
      FillReadCache;
      fReadBuffer.CachePos := iSize - iPrevCnt;
      OffsetMove(fReadBuffer.Cache[0], xBuffer, fReadBuffer.CachePos, 0, iPrevCnt);
    end else
    begin
      Move(fReadBuffer.Cache[fReadBuffer.CachePos], xBuffer, iSize);
      Inc(fReadBuffer.CachePos, iSize);
    end;
    if pBytesRead <> nil then pBytesRead^ := iSize;
  end else
  begin
    iPrevCnt := fReadBuffer.CacheSize - fReadBuffer.CachePos;
    Move(fReadBuffer.Cache[fReadBuffer.CachePos], xBuffer, iPrevCnt);
    ReadDataRaw(Pointer(Integer(@xBuffer) + iPrevCnt)^, iSize - iPrevCnt, pBytesRead);
    if pBytesRead <> nil then Inc(pBytesRead^, iPrevCnt);
    FillReadCache;
  end;
  Result := True;
end;

function TFileHandle.WriteDataRaw(const xBuffer; iSize: Integer;
  pBytesWritten: PInteger): Boolean;
var
  iOut: Longword;
begin
  if (Integer(fFileAccess) and Integer(famWrite)) <> 0 then
  begin
    Result := WriteFile(fFileHandle, xBuffer, iSize, iOut, nil);
    if pBytesWritten <> nil then pBytesWritten^ := iOut;
  end else
    Result := False;
end;

function TFileHandle.WriteDataCached(const xBuffer; iSize: Integer;
  pBytesWritten: PInteger): Boolean;
begin
  if iSize <= fWriteBuffer.CacheSize then
  begin
    if fWriteBuffer.CachePos + iSize > fWriteBuffer.CacheSize then
    begin
      FlushWriteCache;
      fWriteBuffer.CachePos := iSize;
      Move(xBuffer, fWriteBuffer.Cache[0], iSize);
    end else
    begin
      Move(xBuffer, fWriteBuffer.Cache[fWriteBuffer.CachePos], iSize);
      Inc(fWriteBuffer.CachePos, iSize);
    end;
    if pBytesWritten <> nil then pBytesWritten^ := iSize;
  end else
  begin
    FlushWriteCache;
    WriteDataRaw(xBuffer, iSize, pBytesWritten);
  end;
  Result := True;
end;

procedure TFileHandle.SeekDirect(const liNewPos: Int64);
begin
  if fWriteBuffer.Enabled then FlushWriteCache;
  Seek(liNewPos, fspStart, nil);
end;

function TFileHandle.CreateFile(bOverwrite: Boolean;
  bAllowHandleSharing: Boolean): Boolean;
begin
  fFileHandle := Windows.CreateFile(PChar(fFileName), Access[3],
    Share[bAllowHandleSharing, 3], nil, CreationType[bOverwrite],
    FILE_ATTRIBUTE_NORMAL, 0);
  Result := fFileHandle <> INVALID_HANDLE_VALUE;
  if Result then
  begin
    fFileAccess := famReadWrite;
    if fCached = True then
    begin
      SetCachedWrites;
      SetCachedReads;
    end;
  end;
end;

function TFileHandle.OpenFile(iFileAccessType: TFileAccessMode;
  bAllowHandleSharing: Boolean): Boolean;
begin
  fFileHandle := Windows.CreateFile(PChar(fFileName),
    Access[Integer(iFileAccessType) and 3], Share[bAllowHandleSharing,
    Integer(iFileAccessType) and 3], nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := fFileHandle <> INVALID_HANDLE_VALUE;
  if Result then
  begin
    InternalGetFileSizeAndAttributes;
    fFileAccess := iFileAccessType;
    if fCached = True then
    begin
      case iFileAccessType of
        famRead: SetCachedReads;
        famWrite: SetCachedWrites;
        famReadWrite:
        begin
          SetCachedReads;
          SetCachedWrites;
        end;
      end;
    end;
  end;
end;

function TFileHandle.TryOpenFile(iFileAccessType: TFileAccessMode;
  bAllowHandleSharing: Boolean): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(fFileName));
  if (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code = 0) then
  begin
    Result := OpenFile(iFileAccessType, bAllowHandleSharing);
  end else
  begin
    Result := CreateFile(False, bAllowHandleSharing);
  end;
end;

function TFileHandle.Truncate: Boolean;
begin
  ForceFlush;
  fFileSize := Position;
  Result := SetEndOfFile(fFileHandle);
end;

function SetFilePointerEx(hFile: THandle; liDistanceToMove: LARGE_INTEGER;
  lpNewFilePointer: PLargeInteger; dwMoveMethod: DWORD): BOOL; stdcall;
  external 'kernel32.dll' Name 'SetFilePointerEx';

function TFileHandle.Seek(const liDistance: Int64; iSeekPoint: TFileSeekPoint;
  pNewPosition: PInt64): Boolean;
begin
  if fWriteBuffer.Enabled then FlushWriteCache;
  Result := SetFilePointerEx(fFileHandle, LARGE_INTEGER(liDistance),
    PLargeInteger(@fFilePosition), Integer(iSeekPoint));
  if pNewPosition <> nil then pNewPosition^ := fFilePosition;
end;

procedure TFileHandle.SeekEnd;
begin
  Seek(0, fspEnd, nil);
end;

procedure TFileHandle.SeekStart;
begin
  Seek(0, fspStart, nil);
end;

function TFileHandle.WriteData(const xBuffer; iSize: Integer;
  pBytesWritten: PInteger): Boolean;
asm
  PUSH  EBX
  PUSH  pBytesWritten
  xor   EBX, EBX
  ADD[EAX].TFileHandle.fFilePosition.Longword[0], ECX
  ADC[EAX].TFileHandle.fFilePosition.Longword[1], EBX
  CMP   Byte PTR [EAX].TFileHandle.fCached, 0
  JNZ   @@Cache
  CALL  TFileHandle.WriteDataRaw
  JMP   @@Exit
  @@Cache:
  CALL  TFileHandle.WriteDataCached
  @@Exit:
  POP   EBX
end;

function TFileHandle.ReadData(var xBuffer; iSize: Integer;
  pBytesRead: PInteger): Boolean;
asm
  PUSH  EBX
  PUSH  pBytesRead
  xor   EBX, EBX
  ADD[EAX].TFileHandle.fFilePosition.Longword[0], ECX
  ADC[EAX].TFileHandle.fFilePosition.Longword[1], EBX
  CMP   Byte PTR [EAX].TFileHandle.fCached, 0
  JNZ   @@Cache
  CALL  TFileHandle.ReadDataRaw
  JMP   @@Exit
  @@Cache:
  CALL  TFileHandle.ReadDataCached
  @@Exit:
  POP   EBX
end;

end.
