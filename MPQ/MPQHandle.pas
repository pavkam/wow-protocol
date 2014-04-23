unit MPQHandle;
interface
uses Forms, Windows, SysUtils, Graphics, Dialogs, Classes,
     DBCHandle, ADTHandle;

Type
 TSchMPQArchive = class( TObject )
  private
   fMPQHandle : THandle;
   fFiles     : TStrings;

   function GetFileCount: Integer;
   function GetFileName(Index: Integer): String;

   function ReadFileToMemory( AFile : String ) : TMemoryStream;

  public
   constructor Create( MPQName : String );
    destructor Destroy(); override;

   function SaveFile( Index : Integer; AName : String ) : Boolean; overload;
   function SaveFile( ArcName, AName : String ) : Boolean; overload;

   function SaveToStream( Index : Integer ) : TMemoryStream; overload;
   function SaveToStream( ArcName : String ) : TMemoryStream; overload;

   function ExtractDBC( ArcName : String ) : TSchDBCFile; overload;
   function ExtractADT( ArcName : String ) : TSchADTMapFile; overload;

   function ContainsFile( ArcName : String ) : Boolean;

   property Files[ Index : Integer ] : String read GetFileName;
   property FileCount : Integer read GetFileCount;
 end;

 { Archive block }

 TSchMPQBlock = class( TObject )
  private
   fMPQArchives : array of TSchMPQArchive;

  public
   constructor Create( MPQNames : array of String );
    destructor Destroy(); override;

   function ExtractADT( ArcName : String ) : TSchADTMapFile; overload;
   function ExtractDBC( ArcName : String ) : TSchDBCFile; overload;

   function FileExists( ArcName : String ) : Boolean;
 end;

implementation

const
  ExtractDLL = 'StormLib.dll';

function SFileOpenArchive(lpFileName: PChar; dwMPQID, dwUnknown: DWord;
  lphMPQ: PHandle): BOOL; stdcall; external ExtractDLL;

function SFileCloseArchive (hMPQ: THandle): BOOL; stdcall; external ExtractDLL;

function SFileOpenFileEx(hMPQ: THandle; lpFileName: PChar;
  dwSearchScope: DWORD; hFile: PHandle): BOOL; stdcall; external ExtractDLL;

function SFileCloseFile(hFile: THandle): BOOL; stdcall; external ExtractDLL;

function SFileReadFile(hFile: THandle; var lpBuffer;
  nNumberOfBytesToRead: DWORD; var lpNumberOfBytesRead: DWORD;
  lpOverlapped: POVERLAPPED): BOOL; stdcall; external ExtractDLL;

function SFileGetFileSize(hFile: THandle;
  lpFileSizeHigh: LPDWORD): DWORD; stdcall; external ExtractDLL;

function SFileSetFilePointer(hFile: THandle; nDistanceToMove: Integer;
  lpDistanceToMoveHigh: Pointer; dwMoveMethod: DWORD): DWORD; stdcall;
  external ExtractDLL;

function MyGetCurrentDirectory: String;
var
  Len: Integer;
begin
  Result := '';
  Len := GetCurrentDirectory(0, PChar(Result));
  if Len > 0 then begin
    SetLength(Result, Len - 1);
    GetCurrentDirectory(Len, PChar(Result));
  end;
end;

function OpenMPQFile( const AMPQFile : String ) : THandle;
var
 hMPQ : THandle;
begin
 Result := 0;
 if not FileExists(AMPQFile) then exit;
 if not SFileOpenArchive(PChar(AMPQFile), 0, 0, @hMPQ) then exit;

 Result := hMPQ;
end;

procedure CloseMPQFile( const Handle : THandle );
begin
 SFileCloseArchive(Handle);
end;

function ExtractMPQFile(const AFile : String; const hMPQ : THandle; var AStream: TStream): Boolean;
const
  BufSize = 1024 * 4;
var
  hFile: THandle;
  dwBytesReaded, dwBytesWritten: DWORD;
  liBytesLeft: LARGE_INTEGER;
  Buf: Array [1..BufSize] of Char;
begin
  Result := False;

  if not SFileOpenFileEx(hMPQ, PChar(AFile), 0, @hFile) then Exit;

  liBytesLeft.LowPart := SFileGetFileSize(hFile, @liBytesLeft.HighPart);

  while liBytesLeft.QuadPart > 0 do
  begin
   SFileReadFile(hFile, Buf, BufSize, dwBytesReaded, nil);
   dwBytesWritten := AStream.Write(Buf, dwBytesReaded);

   if dwBytesReaded > dwBytesWritten then
   begin
    SFileCloseFile(hFile);
    Exit;
   end;

   Dec(liBytesLeft.QuadPart, dwBytesReaded);
  end;

  SFileCloseFile(hFile);
  AStream.Seek(0, soFromBeginning);

  Result := True;
end;

function ContainsMPQFile(const AFile : String; const hMPQ : THandle): Boolean;
var
  hFile: THandle;
  liBytesLeft: LARGE_INTEGER;
begin
  Result := False;

  if not SFileOpenFileEx(hMPQ, PChar(AFile), 0, @hFile) then Exit;
  liBytesLeft.LowPart := SFileGetFileSize(hFile, @liBytesLeft.HighPart);
  SFileCloseFile(hFile);

  if liBytesLeft.QuadPart > 0 then  
     Result := True;
end;

{ TSchMPQArchive }

function TSchMPQArchive.ContainsFile(ArcName: String): Boolean;
begin
 Result := ContainsMPQFile( ArcName, fMPQHandle );
end;

constructor TSchMPQArchive.Create(MPQName: String);
var
 ms : TMemoryStream;
begin

 { Try to open the arc }

 fMPQHandle := OpenMPQFile( MPQName );
 if fMPQHandle = 0 then
    raise EFileStreamError.CreateFmt( 'Unable to open the MPQ archive!', [] );

 fFiles   := TStringList.Create();

 ms := ReadFileToMemory( '(listfile)');

 if not Assigned(ms) then
    raise EFileStreamError.CreateFmt( 'Unable to extract file list from archive!', [] );

 fFiles.LoadFromStream( ms );
 ms.Destroy();
end;

destructor TSchMPQArchive.Destroy;
begin
 CloseMPQFile( fMPQHandle );
 fFiles.Free();
end;

function TSchMPQArchive.ExtractADT(ArcName: String): TSchADTMapFile;
var
 st : TStream;
begin

 Result := nil;

 try
  st := SaveToStream( ArcName);

  if st = nil then
     raise EAbstractError.Create( 'dummy' );

  if st.Size = 0 then
     raise EAbstractError.Create( 'dummy' );

 except
  Exit;
 end;

 try
  Result := TSchADTMapFile.Create( st );
 except
  st.Destroy();
  FreeAndNil( Result );
 end;

 st.Destroy();
end;

function TSchMPQArchive.ExtractDBC( ArcName : String ): TSchDBCFile;
var
 st : TStream;
begin

 Result := nil;

 try
  st := SaveToStream( ArcName);

  if st = nil then
     raise Exception.Create( 'dummy' );

 except

  Exit;
 end;

 try
  Result := TSchDBCFile.Create( st );
 except
  st.Destroy();
  FreeAndNil( Result );
 end;

 st.Destroy();
end;

function TSchMPQArchive.GetFileCount: Integer;
begin
 Result := fFiles.Count;
end;

function TSchMPQArchive.GetFileName(Index: Integer): String;
begin
 if (Index < (fFiles.Count)) and (Index >= 0) then
    Result := fFiles[Index] else
    raise EListError.Create( 'Attempt to access an unexisting file.' );
end;

function TSchMPQArchive.ReadFileToMemory(AFile: String): TMemoryStream;
var
 cSt : TStream;
begin
 cSt := TMemoryStream.Create();

 if not ExtractMPQFile( AFile, fMPQHandle, cSt ) then
    FreeAndNil( cSt );

 Result := cSt as TMemoryStream;
end;

function TSchMPQArchive.SaveFile(Index: Integer; AName: String) : Boolean;
begin
 Result := SaveFile( Files[Index], AName );
end;

function TSchMPQArchive.SaveFile(ArcName, AName: String) : Boolean;
var
 cSt : TStream;
begin
 cSt := TFileStream.Create( AName, fmCreate );

 Result := ExtractMPQFile( ArcName, fMPQHandle, cSt );

 FreeAndNil( cSt );
end;

function TSchMPQArchive.SaveToStream(Index: Integer): TMemoryStream;
begin
 Result := SaveToStream( Files[Index] );
end;

function TSchMPQArchive.SaveToStream(ArcName: String): TMemoryStream;
var
 cSt : TStream;
begin
 cSt := TMemoryStream.Create();
 if not ExtractMPQFile( ArcName, fMPQHandle, cSt ) then
    FreeAndNil( cSt );

 Result := cSt as TMemoryStream;   
end;

{ TSchMPQBlock }

constructor TSchMPQBlock.Create(MPQNames: array of String);
var
 arr     : array of TSchMPQArchive;
 i, o, k : Integer;
begin
 SetLength( arr, Length(MPQNames) );

 o := Length(MPQNames);

 for i := 0 to Length(MPQNames) - 1 do
 begin
 
  try
   arr[i] := TSchMPQArchive.Create( MPQNames[i] );
  except
   Dec( o );
   arr[i] := nil;
  end;

 end;

 { See what actually opened }
 SetLength( fMPQArchives, o );
 k := 0;
 if o > 0 then
    for i := 0 to Length(arr) - 1 do
        begin
         if arr[i] <> nil then begin fMPQArchives[k] := arr[i]; Inc(k); end;
        end;
end;

destructor TSchMPQBlock.Destroy;
var
 i : Integer;
begin

 for i := 0 to Length(fMPQArchives) - 1 do
     fMPQArchives[i].Destroy();

 fMPQArchives := nil;
 
end;

function TSchMPQBlock.ExtractADT(ArcName: String): TSchADTMapFile;
var
 i : Integer;
begin
 Result := nil;

 if Length(fMPQArchives) > 0 then
    for i := 0 to Length(fMPQArchives) - 1 do
    begin
      Result := fMPQArchives[i].ExtractADT( ArcName );
      if Result <> nil then break;
    end;
end;

function TSchMPQBlock.ExtractDBC(ArcName: String): TSchDBCFile;
var
 i : Integer;
begin
 Result := nil;

 if Length(fMPQArchives) > 0 then
    for i := 0 to Length(fMPQArchives) - 1 do
    begin
      Result := fMPQArchives[i].ExtractDBC( ArcName );
      if Result <> nil then break;
    end;
end;

function TSchMPQBlock.FileExists(ArcName: String): Boolean;
var
 i : Integer;
begin
 Result := false;

 if Length(fMPQArchives) > 0 then
    for i := 0 to Length(fMPQArchives) - 1 do
    begin
      Result := fMPQArchives[i].ContainsFile( ArcName );
      if Result then break;
    end;
end;

end.
