{$DEFINE MMX}
unit Miscelaneous;

interface

uses
  SysUtils,
  TypInfo, Windows;

type
  PBytes = ^TBytes;

  TBytes = record
    Values: array[0..MaxInt - 1] of Byte;
  end;

  PBools = ^TBools;

  TBools = record
    Values: array[0..MaxInt - 1] of Boolean;
  end;

  PLongs = ^TLongs;

  TLongs = record
    Values: array[0..MaxWord - 1] of Longword;
  end;

  PSingles = ^TSingles;

  TSingles = record
    Values: array[0..MaxWord - 1] of Single;
  end;

  TByteArray = array of Byte;
  TBooleanArray = array of Boolean;
  TLongwordArray = array of Longword;
  TQuadwordArray = array of Int64;
  TSingleArray = array of Single;
  TStringArray = array of String;

  {$NODEFINE TLargeInteger}
  TLargeInteger = _LARGE_INTEGER;
  PLargeInteger = ^TLargeInteger;
  LARGE_INTEGER = _LARGE_INTEGER;
  {$EXTERNALSYM LARGE_INTEGER}

  PWordRec = ^TWordRec;
  TWordRec = packed record
    case Integer of
      0: (Bytes: array[0..1] of Byte);
      1: (Full: Word);
  end;

  PLongwordRec = ^TLongwordRec;
  TLongwordRec = record
    case Integer of
      0: (Bytes: array[0..3] of Byte);
      1: (Words: array[0..1] of Word);
      2: (Full: Longword);
  end;

  PQuadwordRec = ^TQuadwordRec;
  TQuadwordRec = record
    case Integer of
      0: (Bytes: array[0..7] of Byte);
      1: (Words: array[0..3] of Word);
      2: (Longs: array[0..1] of Longword);
      3: (Full: Int64);
  end;

  PMultiPtr = ^MultiPtr;
  MultiPtr = record
    case Byte of
      0: (Quad: PInt64);
      1: (Long: PLongword);
      2: (Flt: PSingle);
      3: (Word: PWord);
      4: (Byte: PByte);
      5: (Char: PChar);
      6: (Str: PString);
      7: (Ptr: Pointer);
  end;

{ Type Convertion }
function atoi8(const sString: String): Byte;
function atoi16(const sString: String): Word;
function atoi32(const sString: String): Longword;
function atoi64(const sString: String): Int64;
function atof(const sString: String): Single;

function itoa(iNumber: Int64): String; overload;
function itoa(iNumber: Longword): String; overload;
function itoa(iNumber: Word): String; overload;
function itoa(iNumber: Byte): String; overload;
function ftoa(fNumber: Single): String;

function itoh(iNumber: Byte): String; overload;
function itoh(iNumber: Word): String; overload;
function itoh(iNumber: Longword): String; overload;
function itoh(iNumber: Int64): String; overload;

function ftopki(fNumber: Single): Longword;
function pkitof(iNumber: Longword): Single;

function atoh(const sIn: String): String;
function htoa(const sIn: String): String;

function NilOrString(iInt: Longword): String; overload; inline;
function NilOrString(fFlt: Single): String; overload; inline;
function NilOrString(bBool: Boolean): String; overload; inline;

{ String-related routines }
function ArrayToString(const aArr: array of Longword): String; overload;
function ArrayToString(const aArr: array of Single): String; overload;

procedure StringToDynArray(const sData: String; var aArr: TLongwordArray); overload;
procedure StringToDynArray(const sData: String; var aArr: TSingleArray); overload;
procedure StringToDynArray(const sData: String; var aArr: TLongwordArray;
  cSeparator: Char); overload;
procedure StringToDynArray(const sData: String; var aArr: TSingleArray;
  cSeparator: Char); overload;
procedure StringToArray(const sData: String; var aArr: array of Longword); overload;
procedure StringToArray(const sData: String; var aArr: array of Single); overload;

function StringsEqual(const sStr1, sStr2: String): Boolean;
function StringsEqualNoCase(const sStr1, sStr2: String): Boolean;
function StringSplit(const sStr: String; var aArr: array of String;
  cDelim: Char = ' '): Boolean; overload;
function StringSplit(const sStr: String; cDelim: Char = ' '): TStringArray; overload;
function StrLen(const pStr: PChar): Longword;
function PCharToString(const pSource: PChar; var sDest: String): Integer;
procedure TrimStr(var sStr: String);

function CharPos(cChr: Char; const sStr: String): Integer;
function CharPosEx(cChr: Char; const sStr: String; iOffset: Integer): Integer;
function GetStrRef(const sStr: String): Integer; inline;
procedure IncStrRef(const sStr: String; iAddend: Integer);
procedure DecStrRef(const sStr: String; iAddend: Integer);

function FileNameToOS(const sName: String): String;

{ Bit-Wise }
function GetBit32(lwValue: Longword; iBit: Integer): Boolean; overload; inline;
function OnBit32(lwValue: Longword; iBit: Integer): Longword; overload; inline;
function OffBit32(lwValue: Longword; iBit: Integer): Longword; overload; inline;
function ToggleBit32(lwValue: Longword; iBit: Integer): Longword; overload; inline;

function GetBit32(pData: Pointer; iBit: Integer): Boolean; overload;
procedure OnBit32(pData: Pointer; iBit: Integer); overload;
procedure OffBit32(pData: Pointer; iBit: Integer); overload;
procedure ToggleBit32(pData: Pointer; iBit: Integer); overload;

function OnBits32(lwValue: Longword; iFirstBit, iLastBit: Integer): Longword; overload;
function OffBits32(lwValue: Longword; iFirstBit, iLastBit: Integer): Longword; overload;
function ToggleBits32(lwValue: Longword; iFirstBit, iLastBit: Integer): Longword;
  overload;

procedure OnBits32(pPtr: Pointer; iFirstBit, iLastBit: Integer); overload;
procedure OffBits32(pPtr: Pointer; iFirstBit, iLastBit: Integer); overload;
procedure ToggleBits32(pPtr: Pointer; iFirstBit, iLastBit: Integer); overload;

procedure XorBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
procedure OrBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
procedure AndBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
procedure AndNotBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
procedure NotBuffer(const xSrc; var xDest; iCount: Integer);

{ Generic routines }
procedure OutputToLog(const sLogName, sMsg: String; bAddDate: Boolean = True;
  iLimit: Integer = $4000);
//procedure DumpPacket(cPkt: YPacket);

type
  PThreadData = ^YThreadData;

  YThreadData = record
    Param: Pointer;
    Handle: THandle;
    ThreadId: Longword;
  end;

  YThreadProc = function(pThrdData: PThreadData): Longword;
  YThreadPriority = (ytpIdle, ytpLowest, ytpLower, ytpNormal, ytpHigher,
    ytpHighest, ytpTimeCritical);

const
  Priorities: array[YThreadPriority] of Integer = (
    THREAD_PRIORITY_IDLE, THREAD_PRIORITY_LOWEST, THREAD_PRIORITY_BELOW_NORMAL,
    THREAD_PRIORITY_NORMAL, THREAD_PRIORITY_ABOVE_NORMAL,
    THREAD_PRIORITY_HIGHEST, THREAD_PRIORITY_TIME_CRITICAL
    );

function StartThreadAtAddress(pAddr: YThreadProc; pParam: Pointer;
  bSuspended: Boolean = True): PThreadData;
procedure ThreadExit(lwResult: Longword);
procedure ThreadPrio(hHandle: THandle; var iPrio: YThreadPriority; bChange: Boolean);
procedure ThreadExec(hHandle: THandle; bSuspend: Boolean);
function TotalThreadCount: Integer;

procedure CloseKernelHandle(hHandle: THandle); inline;

function InterlockedPeek(pVolatile: PLongword): Longword;
function InterlockedPeekW(pVolatile: PWord): Word;
function InterlockedPeekB(pVolatile: PByte): Byte;

procedure ForceAlignment(var lwValue: Longword; lwAlignment: Longword);
function IsObject(pPtr: Pointer): Boolean;

procedure AssignIfZero(pTarget: PLongword; lwValue: Longword); overload; inline;
procedure AssignIfZero(pTarget: PSingle; fValue: Single); overload; inline;

function CheckZeroByteOccurence(pSrc: Pointer): Integer;
{
  This function returns index of first $00 byte of value pSrc points to.
  If you have a boolean array like aBools: array[0..3] of Boolean and you would
  initialize it to False and then pass it to this routine (@aBools[0]), returned
  index would be 0 (aBools[0]). When the a DWORD does not contain a zero byte,
  result is set to -1.
}

procedure StartExecutionTimer; overload;
procedure StartExecutionTimer(var liDest: Int64); overload;
function StopExecutionTimer: Single; overload;
function StopExecutionTimer(var liSrc: Int64): Single; overload;
procedure CalcOverhead;
{
  These 2 functions are used to measure time which takes to execute a routine.
  If you want accurate results, run the routine more times until the total
  execution takes at least 500 ms, otherwise the result may vary a lot. Thread-safe.
}
function ReadCPUTicks: Int64;

function GetTypeName(pTypInfo: PTypeInfo): String;

procedure OffsetMove(const Source; var Dest;
  Count, SourceOffset, DestOffset: Integer); inline;
procedure CopyRecord(pSource, pDest: Pointer; pTypInfo: PTypeInfo);

function Ceil32(const X: Single): Integer;
function Floor32(const X: Single): Integer;
function Trunc32(const X: Single): Integer;
function DivMod(Dividend, Divisor: Integer; out Remainder: Integer): Integer;
function DivModPowerOf2(Dividend: Integer; Power: Longword;
  out Remainder: Integer): Integer;
function DivModPowerOf2Inc(Dividend: Integer; Power: Longword): Integer;
function DivModU(Dividend, Divisor: Longword; out Remainder: Longword): Longword;
function DivModUPowerOf2(Dividend, Power: Longword; out Remainder: Longword): Longword;
{ For use with the exception raising }
function GetCurrentReturnAddress: Pointer;

{$IFDEF PIC}
function GetGOT: Longword; export;
{$ENDIF}

function WindowsExit(lwRebootParam: Longword): Boolean;
{$EXTERNALSYM WindowsExit}
function ValidateHandle(hHandle: THandle): Boolean; inline;
{$EXTERNALSYM ValidateHandle}
procedure InvalidateHandle(var hHandle: THandle); inline;
{$EXTERNALSYM InvalidateHandle}
function InterlockedIncrement(Addend: PInteger): Integer; stdcall;
{$EXTERNALSYM InterlockedIncrement}
function InterlockedDecrement(Addend: PInteger): Integer; stdcall;
{$EXTERNALSYM InterlockedDecrement}
function InterlockedExchange(Target: PInteger; Value: Integer): Integer; stdcall;
{$EXTERNALSYM InterlockedExchange}
function InterlockedCompareExchange(Destination: PInteger; Exchange: Integer;
  Comperand: Integer): Integer stdcall;
{$EXTERNALSYM InterlockedCompareExchange}
function InterlockedExchangeAdd(Addend: PInteger; Value: Integer): Integer stdcall;
{$EXTERNALSYM InterlockedExchangeAdd}

{$EXTERNALSYM OpenThread}
function OpenThread(dwDesiredAccess: DWORD; bInheritHandle: BOOL;
  dwThreadId: DWORD): THandle; stdcall;
{$EXTERNALSYM GetQueuedCompletionStatus}
function GetQueuedCompletionStatus(CompletionPort: THandle;
  lpNumberOfBytesTransferred: PDWORD; lpCompletionKey: PDWORD;
  var lpOverlapped: POverlapped; dwMilliseconds: DWORD): BOOL; stdcall;

{$EXTERNALSYM ReadProcessMemory}
function ReadProcessMemory(hProcess: THandle; const lpBaseAddress: Pointer;
  lpBuffer: Pointer; nSize: DWORD; lpNumberOfBytesRead: PDWORD): BOOL; stdcall;
{$EXTERNALSYM WriteProcessMemory}
function WriteProcessMemory(hProcess: THandle; const lpBaseAddress: Pointer;
  lpBuffer: Pointer; nSize: DWORD; lpNumberOfBytesWritten: PDWORD): BOOL; stdcall;

type
  WAITORTIMERCALLBACK = procedure(lpParameter: Pointer;
    TimerOrWaitFired: Boolean); stdcall;
  TWaitOrTimerCallback = WAITORTIMERCALLBACK;

{$EXTERNALSYM RegisterWaitForSingleObject}
function RegisterWaitForSingleObject(phNewWaitObject: PHandle;
  hObject: THandle; Callback: WAITORTIMERCALLBACK; Context: Pointer;
  dwMiliseconds: Longword; dwFlags: Longword): BOOL; stdcall;
{$EXTERNALSYM UnregisterWait}
function UnregisterWait(WaitHandle: THandle): BOOL; stdcall;
{$EXTERNALSYM UnregisterWaitEx}
function UnregisterWaitEx(WaitHandle: THandle; CompletionEvent: THandle): BOOL; stdcall;
{$EXTERNALSYM GetFileSize}
function GetFileSize(hFile: THandle; lpFileSizeHigh: PDWORD): DWORD; stdcall;
{$EXTERNALSYM GetFileSizeEx}
function GetFileSizeEx(hFile: THandle; lpFileSize: PLargeInteger): BOOL; stdcall;
{$EXTERNALSYM WriteFile}
function WriteFile(hFile: THandle; const Buffer; nNumberOfBytesToWrite: DWORD;
  lpNumberOfBytesWritten: PDWORD; lpOverlapped: POverlapped): BOOL; stdcall;
{$EXTERNALSYM ReadFile}
function ReadFile(hFile: THandle; var Buffer; nNumberOfBytesToRead: DWORD;
  lpNumberOfBytesRead: PDWORD; lpOverlapped: POverlapped): BOOL; stdcall;
{$EXTERNALSYM SetFilePointerEx}
function SetFilePointerEx(hFile: THandle; liDistanceToMove: TLargeInteger;
  lpNewFilePointer: PLargeInteger; dwMoveMethod: DWORD): BOOL; stdcall;
{$EXTERNALSYM WriteFileEx}
function WriteFileEx(hFile: THandle; lpBuffer: Pointer; nNumberOfBytesToWrite: DWORD;
  const lpOverlapped: TOverlapped;
  lpCompletionRoutine: TPROverlappedCompletionRoutine): BOOL; stdcall;
{$EXTERNALSYM CreateTimerQueue}
function CreateTimerQueue: THandle; stdcall;
{$EXTERNALSYM CreateTimerQueueTimer}
function CreateTimerQueueTimer(phNewTimer: PHandle; TimerQueue: THandle;
  Callback: WAITORTIMERCALLBACK; Parameter: Pointer; DueTime: DWORD;
  Period: DWORD; Flags: ULONG): BOOL; stdcall;
{$EXTERNALSYM ChangeTimerQueueTimer}
function ChangeTimerQueueTimer(TimerQueue: THandle; Timer: THandle;
  DueTime: DWORD; Period: DWORD): BOOL; stdcall;
{$EXTERNALSYM DeleteTimerQueue}
function DeleteTimerQueue(TimerQueue: THandle): BOOL; stdcall;
{$EXTERNALSYM DeleteTimerQueueEx}
function DeleteTimerQueueEx(TimerQueue: THandle;
  CompletionEvent: THandle): BOOL; stdcall;
{$EXTERNALSYM DeleteTimerQueueTimer}
function DeleteTimerQueueTimer(TimerQueue: THandle; Timer: THandle;
  CompletionEvent: THandle): BOOL; stdcall;
{$EXTERNALSYM GetConsoleWindow}
function GetConsoleWindow: HWND; stdcall;
{$EXTERNALSYM GetProcessId}
function GetProcessId(hProcess: THandle): Longword; stdcall;
{$EXTERNALSYM AdjustTokenPrivileges}
function AdjustTokenPrivileges(TokenHandle: THandle; DisableAllPrivileges: BOOL;
  const NewState: TTokenPrivileges; BufferLength: DWORD;
  PreviousState: PTokenPrivileges; ReturnLength: PDWORD): BOOL; stdcall;

implementation

uses
  Classes;

{$REGION 'Globals and threadvars'}
var
  ThreadCount: Integer;
  CPUFrequency: Int64;
  Overhead: Single;

threadvar
  Start, Stop: Int64;

{$ENDREGION}

{$REGION 'Uncategorized routines'}
{ Locked read - read a volatile value }
{ This is maybe more a hack than a good solution, but entering a critical section
  each time you just want to read value of a simple variable is too costly }
function InterlockedPeek(pVolatile: PLongword): Longword;
asm
  MOV   EDX, EAX
  xor   EAX, EAX
  LOCK  XADD [EDX], EAX
end;

function InterlockedPeekW(pVolatile: PWord): Word;
asm
  MOV   EDX, EAX
  xor   EAX, EAX
  LOCK  XADD Word PTR [EDX], AX
end;

function InterlockedPeekB(pVolatile: PByte): Byte;
asm
  MOV   EDX, EAX
  xor   EAX, EAX
  LOCK  XADD Byte PTR [EDX], AL
end;

procedure ForceAlignment(var lwValue: Longword; lwAlignment: Longword);
asm
  PUSH  EBX
  MOV   ECX, EAX
  MOV   EAX, [EAX]
  MOV   EBX, EDX
  xor   EDX, EDX
  div   EBX
  TEST  EDX, EDX
  JZ    @@Aligned
  INC   EAX
  MUL   EBX
  MOV[ECX], EAX
  @@Aligned:
  POP   EBX
end;

function IsObject(pPtr: Pointer): Boolean;
type
  TBytes = array of Byte;
var
  pName: Pointer;
  pTemp: Pointer;
  pCls: Pointer;
const
  ClsMaxLen   = 40;
  ClassRefLen = -vmtSelfPtr;
  TObjectName: PChar = 'TObject';
begin
  if pPtr <> nil then
  begin
    GetMem(pTemp, 4);
    if not ReadProcessMemory(GetCurrentProcess, pPtr, pTemp, 4, nil) then
    begin
      FreeMem(pTemp, 4);
      Result := False;
      Exit;
    end else
    begin
      ReallocMem(pTemp, ClassRefLen);
      pCls := Pointer(pPtr^);
      if not ReadProcessMemory(GetCurrentProcess, Pointer(Longword(pCls) - ClassRefLen),
        pTemp, ClassRefLen, nil) then
      begin
        FreeMem(pTemp, ClassRefLen);
        Result := False;
        Exit;
      end;
      FreeMem(pTemp, ClassRefLen);
      pName := Pointer(PPointer(Pointer(Integer(pCls) + vmtClassName))^);
      if PByte(pName)^ > ClsMaxLen then
      begin
        Result := False;
        Exit;
      end;
      if TClass(pCls).ClassParent = nil then
      begin
        { Only TObject has no parent }
        Result := CompareMem(@TBytes(pName)[1], TObjectName, 7);
        Exit;
      end;
      Result := True;
    end;
  end else
    Result := False;
end;

function CheckZeroByteOccurence(pSrc: Pointer): Integer;
asm
  PUSH  EBX
  MOV   EDX, EAX
  MOV   EBX, [EAX]
  ADD   EAX, 3
  LEA   ECX, [EBX-$01010101]
  or    ECX, EBX
  not   EBX
  and   ECX, EBX
  and   ECX, $80808080
  JZ    @@NoZero
  TEST  ECX, $00008080
  JZ    @@Found
  shl   ECX, 16
  SUB   EAX, 2
  @@Found:
  shl   ECX, 9
  SBB   EAX, EDX
  JMP   @@Exit
  @@NoZero:
  or    EAX, -1
  @@Exit:
  POP   EBX
end;

procedure StartExecutionTimer;
begin
  QueryPerformanceCounter(Start);
end;

procedure StartExecutionTimer(var liDest: Int64);
begin
  QueryPerformanceCounter(liDest);
end;

function StopExecutionTimer: Single;
begin
  QueryPerformanceCounter(Stop);
  if CPUFrequency = 0 then
  begin
    QueryPerformanceFrequency(CPUFrequency);
    CalcOverhead;
  end;
  Result := (Stop - Start - Overhead) / CPUFrequency * 1000; { miliseconds }
end;

function StopExecutionTimer(var liSrc: Int64): Single;
var
  liDest: Int64;
begin
  QueryPerformanceCounter(liDest);
  if CPUFrequency = 0 then
  begin
    QueryPerformanceFrequency(CPUFrequency);
    CalcOverhead;
  end;
  Result := (liDest - liSrc - Overhead) / CPUFrequency * 1000; { miliseconds }
end;

function ReadCPUTicks: Int64;
asm
  RDTSC
end;
{$ENDREGION}

{$REGION 'Bitwise routines'}
function GetBit32(lwValue: Longword; iBit: Integer): Boolean;
begin
  Result := (lwValue and (1 shl iBit)) <> 0;
end;

function OnBit32(lwValue: Longword; iBit: Integer): Longword;
begin
  Result := lwValue or (1 shl iBit);
end;

function OffBit32(lwValue: Longword; iBit: Integer): Longword;
begin
  Result := lwValue and not (1 shl iBit);
end;

function ToggleBit32(lwValue: Longword; iBit: Integer): Longword;
begin
  Result := lwValue xor (1 shl iBit);
end;

function GetBit32(pData: Pointer; iBit: Integer): Boolean;
asm
  { Test bit }
  BT[EAX], EDX
  SETC AL
end;

procedure OnBit32(pData: Pointer; iBit: Integer);
asm
  { Set bit }
  BTS[EAX], EDX
end;

procedure OffBit32(pData: Pointer; iBit: Integer);
asm
  { Reset bit }
  BTR[EAX], EDX
end;

procedure ToggleBit32(pData: Pointer; iBit: Integer);
asm
  { Change bit }
  BTC[EAX], EDX
end;


function OnBits32(lwValue: Longword; iFirstBit, iLastBit: Integer): Longword;
asm
  PUSH  EBX
  MOV   EBX, ECX
  MOV   ECX, 31
  SUB   ECX, EBX
  MOV   EBX, $FFFFFFFF
  shr   EBX, CL
  MOV   ECX, EDX
  MOV   EDX, EBX
  shl   EBX, CL
  and   EDX, EBX
  or    EAX, EDX
  POP   EBX
end;

function OffBits32(lwValue: Longword; iFirstBit, iLastBit: Integer): Longword;
asm
  PUSH  EBX
  MOV   EBX, ECX
  MOV   ECX, 31
  SUB   ECX, EBX
  MOV   EBX, $FFFFFFFF
  shr   EBX, CL
  MOV   ECX, EDX
  MOV   EDX, EBX
  shl   EBX, CL
  and   EDX, EBX
  not   EDX
  and   EAX, EDX
  POP   EBX
end;

function ToggleBits32(lwValue: Longword; iFirstBit, iLastBit: Integer): Longword;
asm
  PUSH  EBX
  MOV   EBX, ECX
  MOV   ECX, 31
  SUB   ECX, EBX
  MOV   EBX, $FFFFFFFF
  shr   EBX, CL
  MOV   ECX, EDX
  MOV   EDX, EBX
  shl   EBX, CL
  and   EDX, EBX
  xor   EAX, EDX
  POP   EBX
end;

procedure OnBits32(pPtr: Pointer; iFirstBit, iLastBit: Integer);
asm
  CMP   ECX, EDX
  JL    @@Quit
  PUSH  EBX
  PUSH  ESI
  PUSH  EDI
  MOV   EBX, $FFFFFFFF
  MOV   ESI, ECX
  MOV   EDI, $0000001F
  and   ECX, EDI
  and   ESI, $FFFFFFE0
  SUB   EDI, ECX
  shr   ESI, 5
  MOV   ECX, EDI
  MOV   EDI, EBX
  shr   EDI, CL
  MOV   ECX, EDX
  and   EDX, $FFFFFFE0
  and   ECX, $0000001F
  shr   EDX, 5
  shl   EBX, CL
  SUB   ESI, EDX
  JE    @@Equal1
  or    [EAX+EDX*4], EBX
  INC   EDX
  DEC   ESI
  JE    @@Equal2
  MOV   EBX, $FFFFFFFF
  @@Loop:
  MOV[EAX+EDX*4], EBX
  INC   EDX
  DEC   ESI
  JNE   @@Loop
  @@Equal1:
  and   EDI, EBX
  @@Equal2:
  or    [EAX+EDX*4], EDI
  POP   EDI
  POP   ESI
  POP   EBX
  @@Quit:
end;

procedure OffBits32(pPtr: Pointer; iFirstBit, iLastBit: Integer);
asm
  CMP   ECX, EDX
  JL    @@Quit
  PUSH  EBX
  PUSH  ESI
  PUSH  EDI
  MOV   EBX, $FFFFFFFF
  MOV   ESI, ECX
  MOV   EDI, $0000001F
  and   ECX, EDI
  and   ESI, $FFFFFFE0
  SUB   EDI, ECX
  shr   ESI, 5
  MOV   ECX, EDI
  MOV   EDI, EBX
  shr   EDI, CL
  MOV   ECX, EDX
  and   EDX, $FFFFFFE0
  and   ECX, $0000001F
  shr   EDX, 5
  shl   EBX, CL
  MOV   ECX, EDX
  and   EDX, $FFFFFFE0
  and   ECX, $0000001F
  shr   EDX, 5
  shl   EBX, CL
  not   EDI
  not   EBX
  SUB   ESI, EDX
  JE    @@Equal1
  and   [EAX+EDX*4], EBX
  INC   EDX
  DEC   ESI
  JE    @@Equal2
  xor   EBX, EBX
  @@Loop:
  MOV[EAX+EDX*4], EBX
  INC   EDX
  DEC   ESI
  JNE   @@Loop
  @@Equal1:
  or    EDI, EBX
  @@Equal2:
  and   [EAX+EDX*4], EDI
  POP   EDI
  POP   ESI
  POP   EBX
  @@Quit:
end;

procedure ToggleBits32(pPtr: Pointer; iFirstBit, iLastBit: Integer);
asm
  CMP   ECX, EDX
  JL    @@Quit
  PUSH  EBX
  PUSH  ESI
  PUSH  EDI
  MOV   EBX, $FFFFFFFF
  MOV   ESI, ECX
  MOV   EDI, $0000001F
  and   ECX, EDI
  and   ESI, $FFFFFFE0
  SUB   EDI, ECX
  shr   ESI, 5
  MOV   ECX, EDI
  MOV   EDI, EBX
  shr   EDI, CL
  MOV   ECX, EDX
  and   EDX, $FFFFFFE0
  and   ECX, $0000001F
  shr   EDX, 5
  shl   EBX, CL
  MOV   ECX, EDX
  and   EDX, $FFFFFFE0
  and   ECX, $0000001F
  shr   EDX, 5
  shl   EBX, CL
  SUB   ESI, EDX
  JE    @@Equal1
  xor   [EAX+EDX*4], EBX
  INC   EDX
  DEC   ESI
  JE    @@Equal2
  MOV   EBX, $FFFFFFFF
  @@Loop:
  not   [EAX+EDX*4]
  INC   EDX
  DEC   ESI
  JNE   @@Loop
  @@Equal1:
  and   EDI, EBX
  @@Equal2:
  xor   [EAX+EDX*4], EDI
  POP   EDI
  POP   ESI
  POP   EBX
  @@Quit:
end;

{$IFNDEF MMX}
procedure XorBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ELSE}

procedure XorBuffersBlended(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ENDIF}
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 3
  shr   ESI, 2
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes
  @@3Bytes:
  MOV   BL, Byte PTR [EAX+2]
  xor   BL, Byte PTR [EDX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EAX]
  xor   BX, Word PTR [EDX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EAX]
  xor   BX, Word PTR [EDX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EAX]
  xor   BL, Byte PTR [EDX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  @@Loop:
  MOV   EBX, [EAX+ESI*4]
  xor   EBX, [EDX+ESI*4]
  MOV[ECX+ESI*4], EBX
  DEC   ESI
  JNS   @@Loop
  @@Exit:
  POP   ESI
  POP   EBX
end;

{$IFNDEF MMX}
procedure OrBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ELSE}

procedure OrBuffersBlended(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ENDIF}
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 3
  shr   ESI, 2
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes
  @@3Bytes:
  MOV   BL, Byte PTR [EAX+2]
  or    BL, Byte PTR [EDX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EAX]
  or    BX, Word PTR [EDX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EAX]
  or    BX, Word PTR [EDX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EAX]
  or    BL, Byte PTR [EDX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  @@Loop:
  MOV   EBX, [EAX+ESI*4]
  or    EBX, [EDX+ESI*4]
  MOV[ECX+ESI*4], EBX
  DEC   ESI
  JNS   @@Loop
  @@Exit:
  POP   ESI
  POP   EBX
end;

{$IFNDEF MMX}
procedure AndBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ELSE}

procedure AndBuffersBlended(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ENDIF}
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 3
  shr   ESI, 2
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes
  @@3Bytes:
  MOV   BL, Byte PTR [EAX+2]
  and   BL, Byte PTR [EDX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EAX]
  and   BX, Word PTR [EDX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EAX]
  and   BX, Word PTR [EDX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EAX]
  and   BL, Byte PTR [EDX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  @@Loop:
  MOV   EBX, [EAX+ESI*4]
  and   EBX, [EDX+ESI*4]
  MOV[ECX+ESI*4], EBX
  DEC   ESI
  JNS   @@Loop
  @@Exit:
  POP   ESI
  POP   EBX
end;

{$IFNDEF MMX}
procedure AndNotBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ELSE}

procedure AndNotBuffersBlended(const xSrc1, xSrc2; var xDest; iCount: Integer);
{$ENDIF}
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 3
  shr   ESI, 2
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes
  @@3Bytes:
  MOV   BL, Byte PTR [EDX+2]
  not   BL
  and   BL, Byte PTR [EAX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EDX]
  not   BX
  and   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EDX]
  not   BX
  and   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EDX]
  not   BL
  and   BL, Byte PTR [EAX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  @@Loop:
  MOV   EBX, [EDX+ESI*4]
  not   EBX
  and   EBX, [EAX+ESI*4]
  MOV[ECX+ESI*4], EBX
  DEC   ESI
  JNS   @@Loop
  @@Exit:
  POP   ESI
  POP   EBX
end;

{$IFNDEF MMX}
procedure NotBuffer(const xSrc; var xDest; iCount: Integer);
{$ELSE}

procedure NotBufferBlended(const xSrc; var xDest; iCount: Integer);
{$ENDIF}
asm
  {
    EAX = xSrc
    EDX = xDest
    ECX = iCount
  }
  PUSH  EBX
  MOV   EBX, ECX
  shr   ECX, 2
  and   EBX, 3
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes
  @@3Bytes:
  MOV   BL, Byte PTR [EAX+2]
  not   BL
  MOV   Byte PTR [EDX+2], BL
  MOV   BX, Word PTR [EAX]
  not   BX
  MOV   Word PTR [EDX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EAX]
  not   BX
  MOV   Word PTR [EDX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EAX]
  not   BL
  MOV   Byte PTR [EDX], BL
  INC   EAX
  INC   EDX
  @@Aligned:
  DEC   ECX
  JS    @@Exit
  @@Loop:
  MOV   EBX, [EAX+ECX*4]
  not   EBX
  MOV[EDX+ECX*4], EBX
  DEC   ECX
  JNS   @@Loop
  @@Exit:
  POP   EBX
end;

{$IFDEF MMX}
procedure XorBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  CMP   iCount, 512
  JAE   @@UseMMX
  POP   EBP
  JMP   XorBuffersBlended { Blended version }
  @@UseMMX:
  { MMX Version }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 7
  shr   ESI, 3
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes, @@4Bytes, @@5Bytes, @@6Bytes, @@7Bytes
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  LEA   EBX, [ESI+1]
  and   EBX, 3
  JMP   DWORD PTR [@@MMXTable+EBX*4]
  @@MMXTable:
  DD    @@Start, @@MMX_8, @@MMX_16, @@MMX_24
  @@Start:
  LEA   ESI, [ESI*8]
  @@Loop:
  MOVQ  MM0, [EDX+ESI]
  MOVQ  MM1, [EDX+ESI-8]
  PXOR  MM0, [EAX+ESI]
  PXOR  MM1, [EAX+ESI-8]
  MOVQ[ECX+ESI], MM0
  MOVQ[ECX+ESI-8], MM1
  MOVQ  MM0, [EDX+ESI-16]
  MOVQ  MM1, [EDX+ESI-24]
  PXOR  MM0, [EAX+ESI-16]
  PXOR  MM1, [EAX+ESI-24]
  MOVQ[ECX+ESI-16], MM0
  MOVQ[ECX+ESI-24], MM1
  SUB   ESI, 32
  JNS   @@Loop
  JMP   @@Exit
  @@MMX_8:
  MOVQ  MM0, [EDX+ESI*8]
  PXOR  MM0, [EAX+ESI*8]
  MOVQ[ECX+ESI*8], MM0
  DEC   ESI
  JMP   @@Start
  @@MMX_16:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  PXOR  MM0, [EAX+EBX]
  PXOR  MM1, [EAX+EBX-8]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  SUB   ESI, 2
  JMP   @@Start
  @@MMX_24:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  MOVQ  MM2, [EDX+EBX-16]
  PXOR  MM0, [EAX+EBX]
  PXOR  MM1, [EAX+EBX-8]
  PXOR  MM2, [EAX+EBX-16]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  MOVQ[ECX+EBX-16], MM2
  SUB   ESI, 3
  JMP   @@Start
  @@7Bytes:
  MOV   EBX, [EDX]
  xor   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  xor   BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  MOV   BL, Byte PTR [EDX+6]
  xor   BL, Byte PTR [EAX+6]
  MOV   Byte PTR [ECX+6], BL
  ADD   EAX, 7
  ADD   EDX, 7
  ADD   ECX, 7
  JMP   @@Aligned
  @@6Bytes:
  MOV   EBX, [EDX]
  xor   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  xor   BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  ADD   EAX, 6
  ADD   EDX, 6
  ADD   ECX, 6
  JMP   @@Aligned
  @@5Bytes:
  MOV   EBX, [EDX]
  xor   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BL, Byte PTR [EDX+5]
  xor   BL, Byte PTR [EAX+5]
  MOV   Byte PTR [ECX+5], BL
  ADD   EAX, 5
  ADD   EDX, 5
  ADD   ECX, 5
  JMP   @@Aligned
  @@4Bytes:
  MOV   EBX, [EDX]
  xor   EBX, [EAX]
  MOV[ECX], EBX
  ADD   EAX, 4
  ADD   EDX, 4
  ADD   ECX, 4
  JMP   @@Aligned
  @@3Bytes:
  MOV   BL, Byte PTR [EDX+2]
  xor   BL, Byte PTR [EAX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EDX]
  xor   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EDX]
  xor   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EDX]
  xor   BL, Byte PTR [EAX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  JMP   @@Aligned
  @@Exit:
  EMMS
  POP   ESI
  POP   EBX
end;

procedure OrBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  CMP   iCount, 512
  JAE   @@UseMMX
  POP   EBP
  JMP   OrBuffersBlended { Blended version }
  @@UseMMX:
  { MMX Version }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 7
  shr   ESI, 3
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes, @@4Bytes, @@5Bytes, @@6Bytes, @@7Bytes
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  LEA   EBX, [ESI+1]
  and   EBX, 3
  JMP   DWORD PTR [@@MMXTable+EBX*4]
  @@MMXTable:
  DD    @@Start, @@MMX_8, @@MMX_16, @@MMX_24
  @@Start:
  LEA   ESI, [ESI*8]
  @@Loop:
  MOVQ  MM0, [EDX+ESI]
  MOVQ  MM1, [EDX+ESI-8]
  POR   MM0, [EAX+ESI]
  POR   MM1, [EAX+ESI-8]
  MOVQ[ECX+ESI], MM0
  MOVQ[ECX+ESI-8], MM1
  MOVQ  MM0, [EDX+ESI-16]
  MOVQ  MM1, [EDX+ESI-24]
  POR   MM0, [EAX+ESI-16]
  POR   MM1, [EAX+ESI-24]
  MOVQ[ECX+ESI-16], MM0
  MOVQ[ECX+ESI-24], MM1
  SUB   ESI, 32
  JNS   @@Loop
  JMP   @@Exit
  @@MMX_8:
  MOVQ  MM0, [EDX+ESI*8]
  POR   MM0, [EAX+ESI*8]
  MOVQ[ECX+ESI*8], MM0
  DEC   ESI
  JMP   @@Start
  @@MMX_16:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  POR   MM0, [EAX+EBX]
  POR   MM1, [EAX+EBX-8]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  SUB   ESI, 2
  JMP   @@Start
  @@MMX_24:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  MOVQ  MM2, [EDX+EBX-16]
  POR   MM0, [EAX+EBX]
  POR   MM1, [EAX+EBX-8]
  POR   MM2, [EAX+EBX-16]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  MOVQ[ECX+EBX-16], MM2
  SUB   ESI, 3
  JMP   @@Start
  @@7Bytes:
  MOV   EBX, [EDX]
  or    EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  or    BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  MOV   BL, Byte PTR [EDX+6]
  or    BL, Byte PTR [EAX+6]
  MOV   Byte PTR [ECX+6], BL
  ADD   EAX, 7
  ADD   EDX, 7
  ADD   ECX, 7
  JMP   @@Aligned
  @@6Bytes:
  MOV   EBX, [EDX]
  or    EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  or    BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  ADD   EAX, 6
  ADD   EDX, 6
  ADD   ECX, 6
  JMP   @@Aligned
  @@5Bytes:
  MOV   EBX, [EDX]
  or    EBX, [EAX]
  MOV[ECX], EBX
  MOV   BL, Byte PTR [EDX+5]
  or    BL, Byte PTR [EAX+5]
  MOV   Byte PTR [ECX+5], BL
  ADD   EAX, 5
  ADD   EDX, 5
  ADD   ECX, 5
  JMP   @@Aligned
  @@4Bytes:
  MOV   EBX, [EDX]
  or    EBX, [EAX]
  MOV[ECX], EBX
  ADD   EAX, 4
  ADD   EDX, 4
  ADD   ECX, 4
  JMP   @@Aligned
  @@3Bytes:
  MOV   BL, Byte PTR [EDX+2]
  or    BL, Byte PTR [EAX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EDX]
  or    BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EDX]
  or    BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EDX]
  or    BL, Byte PTR [EAX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  JMP   @@Aligned
  @@Exit:
  EMMS
  POP   ESI
  POP   EBX
end;

procedure AndBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  CMP   iCount, 512
  JAE   @@UseMMX
  POP   EBP
  JMP   AndBuffersBlended { Blended version }
  @@UseMMX:
  { MMX Version }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 7
  shr   ESI, 3
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes, @@4Bytes, @@5Bytes, @@6Bytes, @@7Bytes
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  LEA   EBX, [ESI+1]
  and   EBX, 3
  JMP   DWORD PTR [@@MMXTable+EBX*4]
  @@MMXTable:
  DD    @@Start, @@MMX_8, @@MMX_16, @@MMX_24
  @@Start:
  LEA   ESI, [ESI*8]
  @@Loop:
  MOVQ  MM0, [EDX+ESI]
  MOVQ  MM1, [EDX+ESI-8]
  PAND  MM0, [EAX+ESI]
  PAND  MM1, [EAX+ESI-8]
  MOVQ[ECX+ESI], MM0
  MOVQ[ECX+ESI-8], MM1
  MOVQ  MM0, [EDX+ESI-16]
  MOVQ  MM1, [EDX+ESI-24]
  PAND  MM0, [EAX+ESI-16]
  PAND  MM1, [EAX+ESI-24]
  MOVQ[ECX+ESI-16], MM0
  MOVQ[ECX+ESI-24], MM1
  SUB   ESI, 32
  JNS   @@Loop
  JMP   @@Exit
  @@MMX_8:
  MOVQ  MM0, [EDX+ESI*8]
  PAND  MM0, [EAX+ESI*8]
  MOVQ[ECX+ESI*8], MM0
  DEC   ESI
  JMP   @@Start
  @@MMX_16:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  PAND  MM0, [EAX+EBX]
  PAND  MM1, [EAX+EBX-8]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  SUB   ESI, 2
  JMP   @@Start
  @@MMX_24:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  MOVQ  MM2, [EDX+EBX-16]
  PAND  MM0, [EAX+EBX]
  PAND  MM1, [EAX+EBX-8]
  PAND  MM2, [EAX+EBX-16]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  MOVQ[ECX+EBX-16], MM2
  SUB   ESI, 3
  JMP   @@Start
  @@7Bytes:
  MOV   EBX, [EDX]
  and   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  and   BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  MOV   BL, Byte PTR [EDX+6]
  and   BL, Byte PTR [EAX+6]
  MOV   Byte PTR [ECX+6], BL
  ADD   EAX, 7
  ADD   EDX, 7
  ADD   ECX, 7
  JMP   @@Aligned
  @@6Bytes:
  MOV   EBX, [EDX]
  and   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  and   BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  ADD   EAX, 6
  ADD   EDX, 6
  ADD   ECX, 6
  JMP   @@Aligned
  @@5Bytes:
  MOV   EBX, [EDX]
  and   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BL, Byte PTR [EDX+5]
  and   BL, Byte PTR [EAX+5]
  MOV   Byte PTR [ECX+5], BL
  ADD   EAX, 5
  ADD   EDX, 5
  ADD   ECX, 5
  JMP   @@Aligned
  @@4Bytes:
  MOV   EBX, [EDX]
  and   EBX, [EAX]
  MOV[ECX], EBX
  ADD   EAX, 4
  ADD   EDX, 4
  ADD   ECX, 4
  JMP   @@Aligned
  @@3Bytes:
  MOV   BL, Byte PTR [EDX+2]
  and   BL, Byte PTR [EAX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EDX]
  and   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EDX]
  and   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EDX]
  and   BL, Byte PTR [EAX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  JMP   @@Aligned
  @@Exit:
  EMMS
  POP   ESI
  POP   EBX
end;

procedure AndNotBuffers(const xSrc1, xSrc2; var xDest; iCount: Integer);
asm
  {
    EAX = xSrc1
    EDX = xSrc2
    ECX = xDest
    [EBP+8] = iCount
  }
  CMP   iCount, 512
  JAE   @@UseMMX
  POP   EBP
  JMP   AndNotBuffersBlended { Blended version }
  @@UseMMX:
  { MMX Version }
  PUSH  EBX
  PUSH  ESI

  MOV   ESI, iCount
  MOV   EBX, ESI
  and   EBX, 7
  shr   ESI, 3
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes, @@4Bytes, @@5Bytes, @@6Bytes, @@7Bytes
  @@Aligned:
  DEC   ESI
  JS    @@Exit
  LEA   EBX, [ESI+1]
  and   EBX, 3
  JMP   DWORD PTR [@@MMXTable+EBX*4]
  @@MMXTable:
  DD    @@Start, @@MMX_8, @@MMX_16, @@MMX_24
  @@Start:
  LEA   ESI, [ESI*8]
  @@Loop:
  MOVQ  MM0, [EDX+ESI]
  MOVQ  MM1, [EDX+ESI-8]
  PANDN MM0, [EAX+ESI]
  PANDN MM1, [EAX+ESI-8]
  MOVQ[ECX+ESI], MM0
  MOVQ[ECX+ESI-8], MM1
  MOVQ  MM0, [EDX+ESI-16]
  MOVQ  MM1, [EDX+ESI-24]
  PANDN MM0, [EAX+ESI-16]
  PANDN MM1, [EAX+ESI-24]
  MOVQ[ECX+ESI-16], MM0
  MOVQ[ECX+ESI-24], MM1
  SUB   ESI, 32
  JNS   @@Loop
  JMP   @@Exit
  @@MMX_8:
  MOVQ  MM0, [EDX+ESI*8]
  PANDN MM0, [EAX+ESI*8]
  MOVQ[ECX+ESI*8], MM0
  DEC   ESI
  JMP   @@Start
  @@MMX_16:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  PANDN MM0, [EAX+EBX]
  PANDN MM1, [EAX+EBX-8]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  SUB   ESI, 2
  JMP   @@Start
  @@MMX_24:
  LEA   EBX, [ESI*8]
  MOVQ  MM0, [EDX+EBX]
  MOVQ  MM1, [EDX+EBX-8]
  MOVQ  MM2, [EDX+EBX-16]
  PANDN MM0, [EAX+EBX]
  PANDN MM1, [EAX+EBX-8]
  PANDN MM2, [EAX+EBX-16]
  MOVQ[ECX+EBX], MM0
  MOVQ[ECX+EBX-8], MM1
  MOVQ[ECX+EBX-16], MM2
  SUB   ESI, 3
  JMP   @@Start
  @@7Bytes:
  MOV   EBX, [EDX]
  not   EBX
  and   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  not   BX
  and   BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  MOV   BL, Byte PTR [EDX+6]
  not   BL
  and   BL, Byte PTR [EAX+6]
  MOV   Byte PTR [ECX+6], BL
  ADD   EAX, 7
  ADD   EDX, 7
  ADD   ECX, 7
  JMP   @@Aligned
  @@6Bytes:
  MOV   EBX, [EDX]
  not   EBX
  and   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BX, Word PTR [EDX+4]
  not   BX
  and   BX, Word PTR [EAX+4]
  MOV   Word PTR [ECX+4], BX
  ADD   EAX, 6
  ADD   EDX, 6
  ADD   ECX, 6
  JMP   @@Aligned
  @@5Bytes:
  MOV   EBX, [EDX]
  not   EBX
  and   EBX, [EAX]
  MOV[ECX], EBX
  MOV   BL, Byte PTR [EDX+5]
  not   BL
  and   BL, Byte PTR [EAX+5]
  MOV   Byte PTR [ECX+5], BL
  ADD   EAX, 5
  ADD   EDX, 5
  ADD   ECX, 5
  JMP   @@Aligned
  @@4Bytes:
  MOV   EBX, [EDX]
  not   EBX
  and   EBX, [EAX]
  MOV[ECX], EBX
  ADD   EAX, 4
  ADD   EDX, 4
  ADD   ECX, 4
  JMP   @@Aligned
  @@3Bytes:
  MOV   BL, Byte PTR [EDX+2]
  not   BL
  and   BL, Byte PTR [EAX+2]
  MOV   Byte PTR [ECX+2], BL
  MOV   BX, Word PTR [EDX]
  not   BX
  and   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  ADD   ECX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EDX]
  not   BX
  and   BX, Word PTR [EAX]
  MOV   Word PTR [ECX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  ADD   ECX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EDX]
  not   BL
  and   BL, Byte PTR [EAX]
  MOV   Byte PTR [ECX], BL
  INC   EAX
  INC   EDX
  INC   ECX
  JMP   @@Aligned
  @@Exit:
  EMMS
  POP   ESI
  POP   EBX
end;

procedure NotBuffer(const xSrc; var xDest; iCount: Integer);
const
  NotTable: array[0..1] of Longword = ($FFFFFFFF, $FFFFFFFF);
asm
  {
    EAX = xSrc
    EDX = xDest
    ECX = iCount
  }
  CMP   iCount, 512
  JL    NotBufferBlended { Blended version }

  { MMX version }
  PUSH  EBX
  MOV   EBX, ECX
  shr   ECX, 3
  and   EBX, 7
  JMP   DWORD PTR [@@JumpTable+EBX*4]
  @@JumpTable:
  DD    @@Aligned, @@1Byte, @@2Bytes, @@3Bytes, @@4Bytes, @@5Bytes, @@6Bytes, @@7Bytes
  @@Aligned:
  DEC   ECX
  JS    @@Exit
  MOVQ  MM0, NotTable
  LEA   EBX, [ECX+1]
  and   EBX, 3
  JMP   DWORD PTR [@@MMXTable+EBX*4]
  @@MMXTable:
  DD    @@Start, @@MMX_8, @@MMX_16, @@MMX_24
  @@Start:
  LEA   ECX, [ECX*8]
  @@Loop:
  MOVQ  MM1, [EAX+ECX]
  MOVQ  MM2, [EAX+ECX-8]
  PXOR  MM1, MM0
  PXOR  MM2, MM0
  MOVQ[EDX+ECX], MM1
  MOVQ[EDX+ECX-8], MM2
  MOVQ  MM3, [EAX+ECX-16]
  MOVQ  MM4, [EAX+ECX-24]
  PXOR  MM3, MM0
  PXOR  MM4, MM0
  MOVQ[EDX+ECX-16], MM3
  MOVQ[EDX+ECX-24], MM4
  SUB   ECX, 32
  JNS   @@Loop
  @@Exit:
  EMMS
  POP   EBX
  RET
  @@MMX_8:
  MOVQ  MM1, [EAX+ECX*8]
  PXOR  MM1, MM0
  MOVQ[EDX+ECX*8], MM1
  DEC   ECX
  JMP   @@Start
  @@MMX_16:
  LEA   EBX, [ECX*8]
  MOVQ  MM1, [EAX+EBX]
  MOVQ  MM2, [EAX+EBX-8]
  PXOR  MM1, MM0
  PXOR  MM2, MM0
  MOVQ[EDX+EBX], MM1
  MOVQ[EDX+EBX-8], MM2
  SUB   ECX, 2
  JMP   @@Start
  @@MMX_24:
  LEA   EBX, [ECX*8]
  MOVQ  MM1, [EAX+EBX]
  MOVQ  MM2, [EAX+EBX-8]
  MOVQ  MM3, [EAX+EBX-16]
  PXOR  MM1, MM0
  PXOR  MM2, MM0
  PXOR  MM3, MM0
  MOVQ[EDX+EBX], MM1
  MOVQ[EDX+EBX-8], MM2
  MOVQ[EDX+EBX-16], MM3
  SUB   ECX, 3
  JMP   @@Start
  @@7Bytes:
  MOV   EBX, [EAX]
  not   EBX
  MOV[EDX], EBX
  MOV   BX, Word PTR [EAX+4]
  not   BX
  MOV   Word PTR [EDX+4], BX
  MOV   BL, Byte PTR [EAX+6]
  not   BL
  MOV   Byte PTR [EDX+6], BL
  ADD   EAX, 7
  ADD   EDX, 7
  JMP   @@Aligned
  @@6Bytes:
  MOV   EBX, [EAX]
  not   EBX
  MOV[EDX], EBX
  MOV   BX, Word PTR [EAX+4]
  not   BX
  MOV   Word PTR [EDX+4], BX
  ADD   EAX, 6
  ADD   EDX, 6
  JMP   @@Aligned
  @@5Bytes:
  MOV   EBX, [EAX]
  not   EBX
  MOV[EDX], EBX
  MOV   BL, Byte PTR [EAX+5]
  not   BL
  MOV   Byte PTR [EDX+5], BL
  ADD   EAX, 5
  ADD   EDX, 5
  JMP   @@Aligned
  @@4Bytes:
  MOV   EBX, [EAX]
  not   EBX
  MOV[EDX], EBX
  ADD   EAX, 4
  ADD   EDX, 4
  JMP   @@Aligned
  @@3Bytes:
  MOV   BL, Byte PTR [EAX+2]
  not   BL
  MOV   Byte PTR [EDX+2], BL
  MOV   BX, Word PTR [EAX]
  not   BX
  MOV   Word PTR [EDX], BX
  ADD   EAX, 3
  ADD   EDX, 3
  JMP   @@Aligned
  @@2Bytes:
  MOV   BX, Word PTR [EAX]
  not   BX
  MOV   Word PTR [EDX], BX
  ADD   EAX, 2
  ADD   EDX, 2
  JMP   @@Aligned
  @@1Byte:
  MOV   BL, Byte PTR [EAX]
  not   BL
  MOV   Byte PTR [EDX], BL
  INC   EAX
  INC   EDX
  JMP   @@Aligned
end;
{$ENDIF}

{$ENDREGION}

{$REGION 'Conversion routines and related'}
function UIntToStr(lwL: Longword): String;
asm
  PUSH   ESI
  PUSH   EDI
  MOV    ESI, EAX
  MOV    EDI, EDX
  MOV    EAX, EDX
  xor    EDX, EDX
  CMP    ESI, 1000
  JNB    @@Large
  MOV    ECX, $03
  JMP    @@Main
  @@Medium:
  CMP    ESI, 10000000
  JNB    @@Large
  MOV    ECX, $07
  JMP    @@Main
  @@Large:
  MOV    ECX, $0B
  @@Main:
  CALL   System.@LStrFromPCharLen
  MOV    EAX, ESI
  MOV    ESI, [EDI]
  MOV    EDI, ESI
  TEST   EAX, EAX
  JE     @@Equal
  MOV    ECX, $0A
  @@Loop1:
  xor    EDX, EDX
  div    ECX
  ADD    DL, $30
  MOV    Byte PTR [ESI], DL
  INC    ESI
  TEST   EAX, EAX
  JNE    @@Loop1
  MOV    Byte PTR [ESI], 0
  LEA    ECX, [ESI-1]
  SUB    ESI, EDI
  MOV    DWORD PTR [EDI-4], ESI
  @@Loop2:
  CMP    EDI, ECX
  JAE    @@Quit
  MOV    AH, Byte PTR [EDI]
  MOV    AL, Byte PTR [ECX]
  MOV    Byte PTR [ECX], AH
  MOV    Byte PTR [EDI], AL
  INC    EDI
  DEC    ECX
  JMP    @@Loop2
  @@Equal:
  MOV    Word PTR [ESI], $0030
  MOV    DWORD PTR [ESI-4], 1
  @@Quit:
  POP    EDI
  POP    ESI
end;

const
  ValidHexChars: array[Char] of Byte = (
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, 0, 1,
    2, 3, 4, 5, 6, 7, 8, 9, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, 10, 11, 12, 13, 14,
    15, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, 10, 11, 12,
    13, 14, 15, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF,
    $FF, $FF, $FF, $FF, $FF, 0
    );

function StrToUInt(const sStr: String): Longword;
asm
  TEST   EAX, EAX
  JZ     @@StringInvalid
  MOV    EDX, EAX
  xor    EAX, EAX
  xor    ECX, ECX
  DEC    EDX
  @@SkipSpace:
  INC    EDX
  CMP    Byte PTR [EDX], ' '
  JE     @@SkipSpace
  MOV    AL, Byte PTR [EDX]
  INC    EDX
  CMP    AL, '-'
  JNE    @@CheckPlusSign
  INC    ECX
  MOV    AL, Byte PTR [EDX]
  INC    EDX
  JMP    @@NoExtra
  @@CheckPlusSign:
  CMP    AL, '+'
  JNE    @@CheckHex
  MOV    AL, Byte PTR [EDX]
  INC    EDX
  JMP    @@NoExtra
  @@CheckHex:
  CMP    Word PTR [EDX], '0x'
  JE     @@Hexadecimal
  CMP    AL, '$'
  JE     @@HexadecimalPascal
  @@NoExtra:
  PUSH   ECX
  xor    ECX, ECX
  @@MainLoop:
  TEST   AL, AL
  JZ     @@ReachedNull
  SUB    AL, '0'
  JC     @@InvalidChar
  CMP    AL, 10
  JAE    @@InvalidChar
  LEA    ECX, [ECX+ECX*4]
  LEA    ECX, [EAX+ECX*2]
  MOV    AL, Byte PTR [EDX]
  INC    EDX
  JMP    @@MainLoop
  @@ReachedNull:
  MOV    EAX, ECX
  POP    ECX
  shr    ECX, 1
  JNC    @@Positive
  NEG    EAX
  @@Positive:
  RET
  @@InvalidChar:
  ADD    ESP, 4
  @@StringInvalid:
  xor    EAX, EAX
  RET
  @@Hexadecimal:
  INC    EDX
  @@HexadecimalPascal:
  INC    EDX
  {$IFDEF PIC}
  PUSH   EBX
  MOV    EBX, EAX
  CALL   GetGOT
  XCHG   EAX, EBX
  LEA    EBX, [EBX].OFFSET ValidHexChars
  {$ENDIF}
  xor    ECX, ECX
  MOV    AL, Byte PTR [EDX]
  INC    EDX
  @@HexLoop:
  TEST   AL, AL
  JZ     @@ReachedNullHex
  {$IFDEF PIC}
  MOV    AL, BYTE PTR [EBX+EAX]
  {$ELSE}
  MOV    AL, Byte PTR [ValidHexChars+EAX]
  {$ENDIF}
  CMP    AL, $FF
  JE     @@InvalidHexChar
  LEA    ECX, [ECX*8]
  LEA    ECX, [EAX+ECX*2]
  MOV    AL, Byte PTR [EDX]
  INC    EDX
  JMP    @@HexLoop
  @@ReachedNullHex:
  MOV    EAX, ECX
  {$IFDEF PIC}
  POP    EBX
  {$ENDIF}
  RET
  @@InvalidHexChar:
  xor    EAX, EAX
  {$IFDEF PIC}
  POP    EBX
  {$ENDIF}
end;

function atof(const sString: String): Single;
begin
  Result := StrToFloatDef(sString, 0);
end;

function atoi16(const sString: String): Word;
begin
  Result := StrToIntDef(sString, 0);
end;

function atoi32(const sString: String): Longword;
begin
  Result := StrToUInt(sString);
end;

function atoi64(const sString: String): Int64;
begin
  Result := StrToInt64Def(sString, 0);
end;

function atoi8(const sString: String): Byte;
begin
  Result := StrToIntDef(sString, 0);
end;

function ftoa(fNumber: Single): String;
begin
  Result := FloatToStr(fNumber);
end;

function itoa(iNumber: Word): String;
begin
  Result := UIntToStr(iNumber);
end;

function ftopki(fNumber: Single): Longword;
var
  iPk: Longword absolute fNumber;
begin
  Result := iPk;
end;

function pkitof(iNumber: Longword): Single;
var
  fPk: Single absolute iNumber;
begin
  Result := fPk;
end;

function htoa(const sIn: String): String;
var
  iIn: Integer;
  iIdx: Integer;
  iLen: Integer;
begin
  Result := '';

  if sIn = '' then Exit;

  iLen := Length(sIn) shr 1;
  SetLength(Result, iLen);
  iIn := 1;

  for iIdx := 1 to iLen do
  begin
    Result[iIdx] := Chr(StrToInt('$' + sIn[iIn] + sIn[iIn + 1]));
    Inc(iIn, 2);
  end;
end;

function atoh(const sIn: String): String;
var
  iIn: Integer;
  iLen: Integer;
  sRes: String;
begin
  Result := '';

  iLen := Length(sIn);
  if iLen = 0 then Exit;

  SetLength(Result, iLen shl 1);

  for iIn := 1 to iLen do
  begin
    sRes := itoh(Byte(sIn[iIn]));
    Result[iIn * 2 - 1] := sRes[1];
    Result[iIn * 2] := sRes[2];
  end;
end;

function itoa(iNumber: Byte): String;
begin
  Result := UIntToStr(iNumber);
end;

function itoa(iNumber: Int64): String;
begin
  Result := IntToStr(iNumber);
end;

function itoa(iNumber: Longword): String;
begin
  Result := UIntToStr(iNumber);
end;

function itoh(iNumber: Byte): String;
begin
  Result := IntToHex(iNumber, 2);
end;

function itoh(iNumber: Word): String;
begin
  Result := IntToHex(iNumber, 4);
end;

function itoh(iNumber: Longword): String;
begin
  Result := IntToHex(iNumber, 8);
end;

function itoh(iNumber: Int64): String;
begin
  Result := IntToHex(iNumber, 16);
end;

function NilOrString(iInt: Longword): String;
begin
  if iInt <> 0 then Result := itoa(iInt)
  else
    Result := '';
end;

function NilOrString(fFlt: Single): String;
begin
  if fFlt <> 0 then Result := ftoa(fFlt)
  else
    Result := '';
end;

function NilOrString(bBool: Boolean): String;
begin
  if bBool then Result := '1'
  else
    Result := '';
end;

function ArrayToString(const aArr: array of Longword): String;
var
  iInt: Integer;
  iLen: Integer;
begin
  Result := '';
  iLen := Length(aArr);
  if iLen = 0 then Exit;
  for iInt := 0 to iLen - 1 do
  begin
    Result := Result + itoa(aArr[iInt]) + ' ';
  end;
  Delete(Result, Length(Result), 1);
end;

function ArrayToString(const aArr: array of Single): String;
var
  iInt: Integer;
  iLen: Integer;
begin
  Result := '';
  iLen := Length(aArr);
  if iLen = 0 then Exit;
  for iInt := 0 to iLen - 1 do
  begin
    Result := Result + ftoa(aArr[iInt]) + ' ';
  end;
  Delete(Result, Length(Result), 1);
end;

procedure StringToDynArray(const sData: String; var aArr: TLongwordArray);
var
  pCopy, pCursor: PChar;
  iLen: Integer;
  iCounter, iIdx, iInt: Integer;
begin
  if sData = '' then Exit;
  iLen := Length(sData);
  Inc(iLen);
  GetMem(pCopy, iLen);
  Move(Pointer(sData)^, pCopy^, iLen);
  pCursor := pCopy;
  SetLength(aArr, 0);
  iIdx := 0;
  iInt := 1;
  for iCounter := 1 to iLen do
  begin
    if (sData[iCounter] = ' ') or (iCounter = iLen) then
    begin
      pCopy[iCounter - 1] := #0;
      if pCursor^ <> #0 then
      begin
        SetLength(aArr, iIdx + 1);
        aArr[iIdx] := atoi32(pCursor);
        Inc(iIdx);
      end;
      Inc(pCursor, iInt);
      iInt := 0;
    end;
    Inc(iInt);
  end;
  FreeMem(pCopy, iLen);
end;

procedure StringToDynArray(const sData: String; var aArr: TSingleArray);
var
  pCopy, pCursor: PChar;
  iLen: Integer;
  iCounter, iIdx, iInt: Integer;
begin
  if sData = '' then Exit;
  iLen := Length(sData);
  Inc(iLen);
  GetMem(pCopy, iLen);
  Move(Pointer(sData)^, pCopy^, iLen);
  pCursor := pCopy;
  SetLength(aArr, 0);
  iIdx := 0;
  iInt := 1;
  for iCounter := 1 to iLen do
  begin
    if (sData[iCounter] = ' ') or (iCounter = iLen) then
    begin
      pCopy[iCounter - 1] := #0;
      if pCursor^ <> #0 then
      begin
        SetLength(aArr, iIdx + 1);
        aArr[iIdx] := atof(pCursor);
        Inc(iIdx);
      end;
      Inc(pCursor, iInt);
      iInt := 0;
    end;
    Inc(iInt);
  end;
  FreeMem(pCopy, iLen);
end;

procedure StringToDynArray(const sData: String; var aArr: TLongwordArray;
  cSeparator: Char);
var
  pCopy, pCursor: PChar;
  iLen: Integer;
  iCounter, iIdx, iInt: Integer;
begin
  if sData = '' then Exit;
  iLen := Length(sData);
  Inc(iLen);
  GetMem(pCopy, iLen);
  Move(Pointer(sData)^, pCopy^, iLen);
  pCursor := pCopy;
  SetLength(aArr, 0);
  iIdx := 0;
  iInt := 1;
  for iCounter := 1 to iLen do
  begin
    if (sData[iCounter] = cSeparator) or (iCounter = iLen) then
    begin
      pCopy[iCounter - 1] := #0;
      if pCursor^ <> #0 then
      begin
        SetLength(aArr, iIdx + 1);
        aArr[iIdx] := atoi32(pCursor);
        Inc(iIdx);
      end;
      Inc(pCursor, iInt);
      iInt := 0;
    end;
    Inc(iInt);
  end;
  FreeMem(pCopy, iLen);
end;

procedure StringToDynArray(const sData: String; var aArr: TSingleArray;
  cSeparator: Char);
var
  pCopy, pCursor: PChar;
  iLen: Integer;
  iCounter, iIdx, iInt: Integer;
begin
  if sData = '' then Exit;
  iLen := Length(sData);
  Inc(iLen);
  GetMem(pCopy, iLen);
  Move(Pointer(sData)^, pCopy^, iLen);
  pCursor := pCopy;
  SetLength(aArr, 0);
  iIdx := 0;
  iInt := 1;
  for iCounter := 1 to iLen do
  begin
    if (sData[iCounter] = cSeparator) or (iCounter = iLen) then
    begin
      pCopy[iCounter - 1] := #0;
      if pCursor^ <> #0 then
      begin
        SetLength(aArr, iIdx + 1);
        aArr[iIdx] := atof(pCursor);
        Inc(iIdx);
      end;
      Inc(pCursor, iInt);
      iInt := 0;
    end;
    Inc(iInt);
  end;
  FreeMem(pCopy, iLen);
end;

procedure StringToArray(const sData: String; var aArr: array of Longword);
var
  pCopy, pCursor: PChar;
  iLen: Integer;
  iCounter, iIdx, iInt: Integer;
begin
  if sData = '' then Exit;
  iLen := Length(sData);
  Inc(iLen);
  pCopy := AllocMem(iLen);
  Move(Pointer(sData)^, pCopy^, iLen);
  pCursor := pCopy;
  iIdx := 0;
  iInt := 1;
  for iCounter := 1 to iLen do
  begin
    if (sData[iCounter] = ' ') or (iCounter = iLen) then
    begin
      pCopy[iCounter - 1] := #0;
      if pCursor^ <> #0 then
      begin
        aArr[iIdx] := atoi32(pCursor);
        Inc(iIdx);
      end;
      Inc(pCursor, iInt);
      iInt := 0;
    end;
    Inc(iInt);
  end;
  FreeMem(pCopy, iLen);
end;

procedure StringToArray(const sData: String; var aArr: array of Single);
var
  pCopy, pCursor: PChar;
  iLen: Integer;
  iCounter, iIdx, iInt: Integer;
begin
  if sData = '' then Exit;
  iLen := Length(sData);
  Inc(iLen);
  pCopy := AllocMem(iLen);
  Move(Pointer(sData)^, pCopy^, iLen);
  pCursor := pCopy;
  iIdx := 0;
  iInt := 1;
  for iCounter := 1 to iLen do
  begin
    if (sData[iCounter] = ' ') or (iCounter = iLen) then
    begin
      pCopy[iCounter - 1] := #0;
      if pCursor^ <> #0 then
      begin
        aArr[iIdx] := atof(pCursor);
        Inc(iIdx);
      end;
      Inc(pCursor, iInt);
      iInt := 0;
    end;
    Inc(iInt);
  end;
  FreeMem(pCopy, iLen);
end;

{$ENDREGION}

{$REGION 'String routines'}
function StringsEqual(const sStr1, sStr2: String): Boolean;
asm
  CMP   EAX, EDX
  JE    @@CompareDoneNoPop
  TEST  EAX, EDX
  JZ    @@PossibleNilString
  @@BothStringsNonNil:
  MOV   ECX, [EAX-4]
  CMP   ECX, [EDX-4]
  JNE   @@CompareDoneNoPop
  PUSH  EBX
  LEA   EDX, [EDX+ECX-4]
  LEA   EBX, [EAX+ECX-4]
  NEG   ECX
  MOV   EAX, [EBX]
  CMP   EAX, [EDX]
  JNE   @@CompareDonePop
  @@CompareLoop:
  ADD   ECX, 4
  JNS   @@Match
  MOV   EAX, [EBX+ECX]
  CMP   EAX, [EDX+ECX]
  JE    @@CompareLoop
  @@CompareDonePop:
  POP   EBX
  @@CompareDoneNoPop:
  SETZ  AL
  RET
  @@Match:
  MOV   AL, 1
  POP   EBX
  RET
  @@PossibleNilString:
  TEST  EAX, EAX
  JZ    @@FirstStringNil
  TEST  EDX, EDX
  JNZ   @@BothStringsNonNil
  CMP[EAX-4], EDX
  SETZ  AL
  RET
  @@FirstStringNil:
  CMP   EAX, [EDX-4]
  SETZ  AL
end;

function StringsEqualNoCase(const sStr1, sStr2: String): Boolean;
asm
  CMP   EAX, EDX
  JE    @@CompareDoneNoPop
  TEST  EAX, EDX
  JZ    @@PossibleNilString
  @@BothStringsNonNil:
  MOV   ECX, [EAX-4]
  CMP   ECX, [EDX-4]
  JNE   @@CompareDoneNoPop
  PUSH  EBX
  PUSH  ESI
  PUSH  EDI
  PUSH  EBP
  LEA   EDX, [EDX+ECX-4]
  LEA   EBX, [EAX+ECX-4]
  NEG   ECX
  MOV   ESI, [EBX]
  MOV   EBP, $7F7F7F7F
  MOV   EDI, ESI
  not   EDI
  and   EBP, ESI
  and   EDI, $80808080
  ADD   EBP, $05050505
  and   EBP, $7F7F7F7F
  ADD   EBP, $1A1A1A1A
  and   EBP, EDI
  shr   EBP, 2
  SUB   ESI, EBP
  MOV   EAX, [EDX]
  MOV   EBP, $7F7F7F7F
  MOV   EDI, EAX
  not   EDI
  and   EBP, EAX
  and   EDI, $80808080
  ADD   EBP, $05050505
  and   EBP, $7F7F7F7F
  ADD   EBP, $1A1A1A1A
  and   EBP, EDI
  shr   EBP, 2
  SUB   EAX, EBP
  CMP   EAX, ESI
  JNE   @@CompareDonePop
  @@CompareLoop:
  ADD   ECX, 4
  JNS   @@Match
  MOV   ESI, [EBX+ECX]
  MOV   EBP, $7F7F7F7F
  MOV   EDI, ESI
  not   EDI
  and   EBP, ESI
  and   EDI, $80808080
  ADD   EBP, $05050505
  and   EBP, $7F7F7F7F
  ADD   EBP, $1A1A1A1A
  and   EBP, EDI
  shr   EBP, 2
  SUB   ESI, EBP
  MOV   EAX, [EDX+ECX]
  MOV   EBP, $7F7F7F7F
  MOV   EDI, EAX
  not   EDI
  and   EBP, EAX
  and   EDI, $80808080
  ADD   EBP, $05050505
  and   EBP, $7F7F7F7F
  ADD   EBP, $1A1A1A1A
  and   EBP, EDI
  shr   EBP, 2
  SUB   EAX, EBP
  CMP   EAX, ESI
  JE    @@CompareLoop
  @@CompareDonePop:
  POP   EBP
  POP   EDI
  POP   ESI
  POP   EBX
  @@CompareDoneNoPop:
  SETZ  AL
  RET
  @@Match:
  MOV   AL, 1
  POP   EBP
  POP   EDI
  POP   ESI
  POP   EBX
  RET
  @@PossibleNilString:
  TEST  EAX, EAX
  JZ    @@FirstStringNil
  TEST  EDX, EDX
  JNZ   @@BothStringsNonNil
  CMP[EAX-4], EDX
  SETZ  AL
  RET
  @@FirstStringNil:
  CMP   EAX, [EDX-4]
  SETZ  AL
end;

function StringSplit(const sStr: String; var aArr: array of String;
  cDelim: Char = ' '): Boolean;
var
  iLen: Integer;
  iCounter, iIdx, iLast: Integer;
  sTemp: String;
begin
  if sStr = '' then
  begin
    Result := True;
    Exit;
  end;
  iCounter := 0;
  iLen := High(aArr);
  iLast := 1;
  iIdx := CharPos(cDelim, sStr);
  while iIdx <> 0 do
  begin
    sTemp := Copy(sStr, iLast, iIdx - iLast);
    if sTemp <> '' then
    begin
      if iCounter > iLen then
      begin
        Result := False;
        Exit;
      end;
      aArr[iCounter] := sTemp;
      Inc(iCounter);
    end;
    Inc(iIdx);
    iLast := iIdx;
    iIdx := CharPosEx(cDelim, sStr, iIdx);
  end;
  iLen := Length(sStr);
  if iLen <> 0 then
  begin
    aArr[iCounter] := Copy(sStr, iLast, iLen);
  end;
  Result := True;
end;

function StringSplit(const sStr: String; cDelim: Char = ' '): TStringArray;
var
  iLen: Integer;
  iCounter, iIdx, iLast: Integer;
  sTemp: String;
begin
  if sStr = '' then
  begin
    Result := nil;
    Exit;
  end;
  iCounter := 0;
  iLast := 1;
  iIdx := CharPos(cDelim, sStr);
  while iIdx <> 0 do
  begin
    sTemp := Copy(sStr, iLast, iIdx - iLast);
    if sTemp <> '' then
    begin
      SetLength(Result, iCounter + 1);
      Result[iCounter] := sTemp;
      Inc(iCounter);
    end;
    Inc(iIdx);
    iLast := iIdx;
    iIdx := CharPosEx(cDelim, sStr, iIdx);
  end;
  iLen := Length(sStr);
  if iLen <> 0 then
  begin
    SetLength(Result, iCounter + 1);
    Result[iCounter] := Copy(sStr, iLast, iLen);
  end;
end;

function StrLen(const pStr: PChar): Longword;
asm
  CMP   Byte PTR [EAX], 0
  JE    @@0
  CMP   Byte PTR [EAX+1], 0
  JE    @@1
  CMP   Byte PTR [EAX+2], 0
  JE    @@2
  CMP   Byte PTR [EAX+3], 0
  JE    @@3
  PUSH  EAX
  SUB   EAX, 4
  @@Loop:
  ADD   EAX, 4
  MOV   EDX, [EAX]
  LEA   ECX, [EDX-$01010101]
  not   EDX
  and   EDX, ECX
  and   EDX, $80808080
  JZ    @@Loop
  @@SetResult:
  POP   ECX
  BSF   EDX, EDX
  shr   EDX, 3
  ADD   EAX, EDX
  SUB   EAX, ECX
  RET
  @@0:
  xor   EAX, EAX
  RET
  @@1:
  MOV   EAX, 1
  RET
  @@2:
  MOV   EAX, 2
  RET
  @@3:
  MOV   EAX, 3
end;

function PCharToString(const pSource: PChar; var sDest: String): Integer;
begin
  Result := StrLen(pSource);
  if Result <> 0 then
  begin
    SetLength(sDest, Result);
    Move(pSource^, Pointer(sDest)^, Result);
  end else
    sDest := '';
end;

procedure TrimStr(var sStr: String);
const
  ResTable: array[Boolean, Boolean] of Integer = (
    (0, 1),
    (2, 3)
    );
var
  iStart1, iStart2: Integer;
  iEnd1, iEnd2: Integer;
begin
  if sStr = '' then Exit;
  iEnd2 := Length(sStr);
  iStart1 := 1;

  for iEnd1 := 1 to iEnd2 do
  begin
    if sStr[iEnd1] <> ' ' then
    begin
      Break;
    end;
  end;
  Dec(iEnd1);

  if iEnd1 = iEnd2 then
  begin
    sStr := '';
    Exit;
  end;

  for iStart2 := iEnd2 downto 1 do
  begin
    if sStr[iStart2] <> ' ' then
    begin
      Break;
    end;
  end;
  Inc(iStart2);

  case ResTable[iEnd1 = 0, iStart2 = iEnd2 + 1] of
    0:
    begin
      { Whitespace both before and after the text }
      UniqueString(sStr);
      OffsetMove(Pointer(sStr)^, Pointer(sStr)^, iStart2 - iEnd1, iEnd1, 0);
      SetLength(sStr, iEnd2 - (iEnd2 - iStart2) - (iEnd1 - iStart1) - 2);
    end;
    1:
    begin
      { Whitespace only before the text }
      UniqueString(sStr);
      OffsetMove(Pointer(sStr)^, Pointer(sStr)^, iStart2 - iEnd1, iEnd1, 0);
      SetLength(sStr, iEnd2 - (iEnd2 - iStart2) - 2);
    end;
    2:
    begin
      { Whitespace only after the text }
      SetLength(sStr, iEnd2 - (iEnd1 - iStart1) - 2);
    end;
    3: { No whitespace at all };
  end;
end;

function CharPos(cChr: Char; const sStr: String): Integer;
asm
  TEST  EDX, EDX
  JZ    @@Ret0
  PUSH  EBP
  PUSH  EBX
  PUSH  EDX
  PUSH  ESI
  PUSH  EDI
  MOV   ECX, [EDX-4]
  not   ECX
  JZ    @@Pop0
  MOV   AH, AL
  ADD   ECX, 1
  MOVZX EDI, AX
  and   ECX, -4
  shl   EAX, 16
  SUB   EDX, ECX
  or    EDI, EAX
  MOV   EBP, $80808080
  MOV   EAX, EDI
  xor   EDI, [ECX+EDX]
  MOV   ESI, EAX
  LEA   EBX, [EDI-$01010101]
  not   EDI
  and   EBX, EDI
  ADD   ECX, 4
  JGE   @@Last1
  and   EBX,EBP
  JNZ   @@Found4
  xor   ESI, [ECX+EDX]
  MOV   EBP, EBP
  @@Find:
  LEA   EBX, [ESI-$01010101]
  not   ESI
  and   EBX, ESI
  MOV   EDI, [ECX+EDX+4]
  ADD   ECX, 8
  JGE   @@Last2
  xor   EDI, EAX
  and   EBX, EBP
  MOV   ESI, [ECX+EDX]
  JNZ   @@Found0
  LEA   EBX, [EDI-$01010101]
  not   EDI
  and   EBX, EDI
  xor   ESI, EAX
  and   EBX, EBP
  JZ    @@Find
  @@Found4:
  ADD   ECX, 4
  @@Found0:
  shr   EBX, 8
  JC    @@Inc0
  shr   EBX, 8
  JC    @@Inc1
  shr   EBX, 8
  JC    @@Inc2
  @@Inc3:
  INC   ECX
  @@Inc2:
  INC   ECX
  @@Inc1:
  INC   ECX
  @@Inc0:
  POP   EDI
  POP   ESI
  LEA   EAX, [ECX+EDX-7]
  POP   EDX
  POP   EBX
  SUB   EAX, EDX
  POP   EBP
  CMP   EAX, [EDX-4]
  JG    @@Ret0
  RET
  @@Last2:
  and   EBX, EBP
  JNZ   @@Found0
  xor   EDI, EAX
  LEA   EBX, [EDI-$01010101]
  not   EDI
  and   EBX, EDI
  @@Last1:
  and   EBX, EBP
  JNZ   @@Found4
  @@Pop0:
  POP   EDI
  POP   ESI
  POP   EDX
  POP   EBX
  POP   EBP
  @@Ret0:
  xor   EAX, EAX
end;

function CharPosEx(cChr: Char; const sStr: String; iOffset: Integer): Integer;
asm
  TEST  EDX, EDX
  JZ    @@Ret0
  PUSH  EBP
  PUSH  EBX
  PUSH  EDX
  PUSH  ESI
  PUSH  EDI
  MOV   EBX, ECX
  MOV   ECX, [EDX-4]
  SUB   ECX, EBX
  ADD   EDX, EBX
  not   ECX
  JZ    @@Pop0
  MOV   AH, AL
  ADD   ECX, 1
  MOVZX EDI, AX
  and   ECX, -4
  shl   EAX, 16
  SUB   EDX, ECX
  or    EDI, EAX
  MOV   EBP, $80808080
  MOV   EAX, EDI
  xor   EDI, [ECX+EDX]
  MOV   ESI, EAX
  LEA   EBX, [EDI-$01010101]
  not   EDI
  and   EBX, EDI
  ADD   ECX, 4
  JGE   @@Last1
  and   EBX, EBP
  JNZ   @@Found4
  xor   ESI, [ECX+EDX]
  MOV   EBP, EBP
  @@Find:
  LEA   EBX, [ESI-$01010101]
  not   ESI
  and   EBX, ESI
  MOV   EDI, [ECX+EDX+4]
  ADD   ECX, 8
  JGE   @@Last2
  xor   EDI, EAX
  and   EBX, EBP
  MOV   ESI, [ECX+EDX]
  JNZ   @@Found0
  LEA   EBX, [EDI-$01010101]
  not   EDI
  and   EBX, EDI
  xor   ESI, EAX
  and   EBX, EBP
  JZ    @@Find
  @@Found4:
  ADD   ECX, 4
  @@Found0:
  shr   EBX, 8
  JC    @@Inc0
  shr   EBX, 8
  JC    @@Inc1
  shr   EBX, 8
  JC    @@Inc2
  @@Inc3:
  INC   ECX
  @@Inc2:
  INC   ECX
  @@Inc1:
  INC   ECX
  @@Inc0:
  POP   EDI
  POP   ESI
  LEA   EAX, [ECX+EDX-7]
  POP   EDX
  POP   EBX
  SUB   EAX, EDX
  POP   EBP
  CMP   EAX, [EDX-4]
  JG    @@Ret0
  RET
  @@Last2:
  and   EBX, EBP
  JNZ   @@Found0
  xor   EDI, EAX
  LEA   EBX, [EDI-$01010101]
  not   EDI
  and   EBX, EDI
  @@Last1:
  and   EBX,EBP
  JNZ   @@Found4
  @@Pop0:
  POP   EDI
  POP   ESI
  POP   EDX
  POP   EBX
  POP   EBP
  @@Ret0:
  xor   EAX, EAX
end;

function GetStrRef(const sStr: String): Integer;
begin
  Result := Integer(sStr);
  if Result <> 0 then Result := PInteger(Result - 8)^;
end;

procedure IncStrRef(const sStr: String; iAddend: Integer);
var
  iAdr: Integer;
begin
  if iAddend = 0 then Exit;
  iAdr := Integer(sStr);
  if iAdr <> 0 then
  begin
    Dec(iAdr, 8);
    { TODO -oSeth -cThread-unsafe : replace with an interlocked function }
    PInteger(iAdr)^ := PInteger(iAdr)^ + iAddend;
  end;
end;

procedure DecStrRef(const sStr: String; iAddend: Integer);
var
  iAdr: Integer;
begin
  if iAddend = 0 then Exit;
  iAdr := Integer(sStr);
  if iAdr <> 0 then
  begin
    Dec(iAdr, 8);
    { TODO -oSeth -cThread-unsafe : replace with an interlocked function }
    PInteger(iAdr)^ := PInteger(iAdr)^ - iAddend;
  end;
end;

function FileNameToOS(const sName: String): String;
begin
  { No Change on Win32 }
  Result := StringReplace(sName, '{$YROOT}',
    ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))), [rfReplaceAll]);
  Result := StringReplace(Result, '/', '\', [rfReplaceAll]);
end;

{$ENDREGION}

{$REGION 'Utility functions'}
procedure AssignIfZero(pTarget: PLongword; lwValue: Longword);
begin
  if pTarget^ = 0 then pTarget^ := lwValue;
end;

procedure AssignIfZero(pTarget: PSingle; fValue: Single);
begin
  if pTarget^ = 0 then pTarget^ := fValue;
end;

procedure OutputToLog(const sLogName, sMsg: String; bAddDate: Boolean; iLimit: Integer);
const
  CRLF = #13#10;
var
  hHandle: Integer;
  tInfo: TByHandleFileInformation;
  pBuf: Pointer;
  pC: PChar;
  sDate: String;
  iMsgLen: Integer;
  iDateLen: Integer;
  iWriteCount: Integer;
begin
  if bAddDate then
  begin
    sDate := StringReplace(DateTimeToStr(Now), '. ', '-', [rfReplaceAll]);
    sDate := sDate + ': ';
    iDateLen := Length(sDate);
  end else
  begin
    sDate := '';
    iDateLen := 0;
  end;
  if not FileExists(sLogName) then
  begin
    hHandle := FileCreate(sLogName);
    if hHandle = -1 then Exit;
  end else
  begin
    hHandle := FileOpen(sLogName, fmOpenReadWrite);
    if hHandle = -1 then Exit;
  end;
  iMsgLen := Length(sMsg);
  GetFileInformationByHandle(hHandle, tInfo);
  if (tInfo.nFileSizeLow <> 0) and (iLimit <> 0) then
  begin
    if Integer(tInfo.nFileSizeLow) + iMsgLen + iDateLen + 2 > iLimit then
    begin
      GetMem(pBuf, tInfo.nFileSizeLow);
      FileRead(hHandle, pBuf^, tInfo.nFileSizeLow);
      pC := pBuf;
      iWriteCount := tInfo.nFileSizeLow;
      Inc(tInfo.nFileSizeLow, iMsgLen + iDateLen + 2);
      while ((pC^ <> #13) or (Integer(tInfo.nFileSizeLow) > iLimit)) and
        (Integer(pC) - Integer(pBuf) <> iWriteCount) do
      begin
        Inc(pC);
        Dec(tInfo.nFileSizeLow);
      end;
      if PC^ = #13 then Inc(PC, 2);
      Dec(iWriteCount, Integer(pC) - Integer(pBuf));
      FileSeek(hHandle, 0, soFromBeginning);
      FileWrite(hHandle, pC^, iWriteCount);
      FreeMem(pBuf);
    end else
    begin
      FileSeek(hHandle, 0, soFromEnd);
    end;
  end;
  FileWrite(hHandle, Pointer(sDate)^, iDateLen);
  FileWrite(hHandle, Pointer(sMsg)^, iMsgLen);
  FileWrite(hHandle, CRLF[1], 2);
  SetEndOfFile(hHandle);
  FileClose(hHandle);
end;

(*
procedure DumpPacket(cPkt: YPacket);
  function atohs(const sIn: string): string;
  var
    iIn: Integer;
    iLen: Integer;
    sRes: string;
  begin
    Result := '';

    iLen := Length(sIn);
    if iLen = 0 then Exit;

    SetLength(Result, (iLen * 3) -1);

    for iIn := 1 to iLen do
    begin
      sRes := itoh(Byte(sIn[iIn]));
      Result[iIn*3-2] := sRes[1];
      Result[iIn*3-1] := sRes[2];
      if iIn <> iLen then Result[iIn*3] := ' ';
    end;
  end;
const
  DUMP_FILE = 'packet_dump.txt';
  PKT_HEADER =
    'Size: %d' + #13#10 +
    'Data: %s' + #13#10;
  GAME_PKT_HEADER =
    'Size: %d' + #13#10 +
    'Opcode: %s' + #13#10 +
    'Data: %s' + #13#10;
  END_M = '------------------------------------------------------------------' + #13#10;
var
  hFile: Integer;
  sFormat: string;
  sTemp: string;
begin
  if not FileExists(DUMP_FILE) then
  begin
    hFile := FileCreate(DUMP_FILE);
    if hFile = -1 then Exit;
  end else
  begin
    hFile := FileOpen(DUMP_FILE, fmOpenReadWrite);
    FileSeek(hFile, 0, 2);
    if hFile = -1 then Exit;
  end;

  if cPkt is YServerPacket then
  begin
    sTemp := cPkt.BufferToString;
    Delete(sTemp, 1, 4);
    sTemp := atohs(sTemp);
    sFormat := Format(GAME_PKT_HEADER, [cPkt.Size, GetOpcodeName(YServerPacket(cPkt).Header^.Opcode),
      sTemp]);
  end else if cPkt is YClientPacket then
  begin
    sTemp := cPkt.BufferToString;
    Delete(sTemp, 1, 6);
    sTemp := atohs(sTemp);
    sFormat := Format(GAME_PKT_HEADER, [cPkt.Size, GetOpcodeName(YServerPacket(cPkt).Header^.Opcode),
      sTemp]);
  end else
  begin
    sFormat := Format(PKT_HEADER, [cPkt.Size, atohs(cPkt.BufferToString)]);
  end;
  
  FileWrite(hFile, Pointer(sFormat)^, Length(sFormat));
  FileWrite(hFile, END_M[1], Length(END_M));
  FileClose(hFile);
end;
*)

function StartThreadAtAddress(pAddr: YThreadProc; pParam: Pointer;
  bSuspended: Boolean): PThreadData;
const
  SuspTable: array[Boolean] of Longword = (0, CREATE_SUSPENDED);
var
  pThrdData: PThreadData absolute Result;
begin
  IsMultiThread := True;
  New(Result);
  pThrdData^.Param := pParam;
  pThrdData^.Handle := BeginThread(nil, 0, @pAddr, pThrdData,
    SuspTable[bSuspended], pThrdData^.ThreadId);
  InterlockedIncrement(@ThreadCount);
end;

procedure ThreadExit(lwResult: Longword);
begin
  InterlockedDecrement(@ThreadCount);
  EndThread(lwResult);
end;

procedure ThreadPrio(hHandle: THandle; var iPrio: YThreadPriority; bChange: Boolean);
var
  iPriority: Integer;
  iRes: YThreadPriority;
begin
  if bChange then SetThreadPriority(hHandle, Priorities[iPrio])
  else
  begin
    iPriority := GetThreadPriority(hHandle);
    for iRes := Low(YThreadPriority) to High(YThreadPriority) do
    begin
      if Priorities[iRes] = iPriority then
      begin
        iPrio := iRes;
        Exit;
      end;
    end;
    iPrio := ytpNormal;
  end;
end;

procedure ThreadExec(hHandle: THandle; bSuspend: Boolean);
begin
  if bSuspend then SuspendThread(hHandle)
  else
    ResumeThread(hHandle);
end;

function TotalThreadCount: Integer;
begin
  Result := ThreadCount;
end;

procedure CloseKernelHandle(hHandle: THandle);
begin
  {$IFDEF WIN32}
  CloseHandle(hHandle)
  {$ELSE}
  __close(hHandle);
  {$ENDIF}
end;

{$ENDREGION}

{$REGION 'System & SysUtils extensions'}
function GetTypeName(pTypInfo: PTypeInfo): String;
begin
  Result := pTypInfo^.Name;
end;

procedure OffsetMove(const Source; var Dest; Count, SourceOffset, DestOffset: Integer);
begin
  Move(Pointer(Integer(@Source) + SourceOffset)^,
    Pointer(Integer(@Dest) + DestOffset)^, Count);
end;

procedure CopyRecord(pSource, pDest: Pointer; pTypInfo: PTypeInfo);
asm
  TEST  ECX, ECX
  JZ    @@Exit
  XCHG  EAX, EDX
  CALL  System.@CopyRecord
  @@Exit:
end;

function Ceil32(const X: Single): Integer;
asm
  MOV   EAX, [ESP+8]
  CDQ
  shl   EAX, 1
  JZ    @@Done
  MOV   ECX, EAX
  shr   ECX, 24
  NEG   ECX
  ADD   ECX, 127 + 31
  CMP   ECX, 31
  JA    @@FractionOrTooLarge
  shl   EAX, 7
  or    EAX, $80000000
  MOV   EBP, EAX
  shr   EAX, CL
  TEST  EDX, EDX
  JNS   @@PositiveNumber
  NEG   EAX
  JS    @@Done
  @@RaiseInvalidOperationException:
  MOV   AL, reInvalidOp
  JMP   System.Error
  @@PositiveNumber:
  TEST  EAX, EAX
  JS    @@RaiseInvalidOperationException
  MOV   EDX, -1
  shl   EDX, CL
  not   EDX
  and   EDX, EBP
  JZ    @@Done
  ADD   EAX, 1
  JNS   @@Done
  JMP   @@RaiseInvalidOperationException
  @@FractionOrTooLarge:
  TEST  ECX, ECX
  JS    @@RaiseInvalidOperationException
  LEA   EAX, [EDX+1]
  @@Done:
end;

function Floor32(const X: Single): Integer;
asm
  MOV   EAX, [ESP+8]
  CDQ
  shl   EAX, 1
  JZ    @@Done
  MOV   ECX, EAX
  shr   ECX, 24
  NEG   ECX
  ADD   ECX, 127 + 31
  CMP   ECX, 31
  JA    @@FractionOrTooLarge
  shl   EAX, 7
  or    EAX, $80000000
  MOV   EBP, EAX
  shr   EAX, CL
  TEST  EDX, EDX
  JS    @@NegativeNumber
  TEST  EAX, EAX
  JNS   @@Done
  @@RaiseInvalidOperationException:
  MOV   AL, reInvalidOp
  JMP   System.Error
  @@NegativeNumber:
  NEG   EAX
  JNS   @@RaiseInvalidOperationException
  shl   EDX, CL
  not   EDX
  and   EDX, EBP
  JZ    @@Done
  SUB   EAX, 1
  JS    @@Done
  JMP   @@RaiseInvalidOperationException
  @@FractionOrTooLarge:
  TEST  ECX, ECX
  JS    @@RaiseInvalidOperationException
  MOV   EAX, EDX
  @@Done:
end;

function Trunc32(const X: Single): Integer;
var
  OldCW, NewCW: Word;
asm
  FNSTCW OldCW
  MOVZX  EAX, OldCW
  or     AX, $0F00
  MOV    NewCW, AX
  FLDCW  NewCW
  FLD    X
  FISTP  Result
  FLDCW  OldCW
end;

function DivMod(Dividend, Divisor: Integer; out Remainder: Integer): Integer;
asm
  PUSH  EBX
  MOV   EBX, EDX
  CDQ
  IDIV  EBX
  MOV[ECX], EDX
  POP   EBX
end;

function DivModPowerOf2(Dividend: Integer; Power: Longword;
  out Remainder: Integer): Integer;
asm
  PUSH  EBX
  PUSH  ESI
  MOV   EBX, EAX
  MOV   ESI, ECX
  MOV   ECX, EDX
  SAR   EAX, CL
  MOV   EDX, EAX
  SAL   EDX, CL
  SUB   EBX, EDX
  MOV[ESI], EBX
  POP   ESI
  POP   EBX
end;

function DivModPowerOf2Inc(Dividend: Integer; Power: Longword): Integer;
asm
  PUSH  EBX
  MOV   EBX, EAX
  MOV   ECX, EDX
  SAR   EAX, CL
  MOV   EDX, EAX
  SAL   EDX, CL
  CMP   EBX, EDX
  JNA   @@Skip
  INC   EAX
  @@Skip:
  POP   EBX
end;

function DivModU(Dividend, Divisor: Longword; out Remainder: Longword): Longword;
asm
  PUSH  EBX
  MOV   EBX, EDX
  xor   EDX, EDX
  div   EBX
  MOV[ECX], EDX
  POP   EBX
end;

function DivModUPowerOf2(Dividend, Power: Longword; out Remainder: Longword): Longword;
asm
  PUSH  EBX
  PUSH  ESI
  MOV   ESI, ECX
  MOV   EBX, EAX
  MOV   ECX, EDX
  shr   EAX, CL
  MOV   EDX, EAX
  shl   EDX, CL
  SUB   EBX, EDX
  MOV[ESI], EBX
  POP   ESI
  POP   EBX
end;

function GetCurrentReturnAddress: Pointer;
asm
  MOV   EAX, [EBP+4]
end;
{$ENDREGION}

{$REGION 'Winapi extension'}
function AdjustTokenPrivileges; external advapi32 Name 'AdjustTokenPrivileges';
function ReadProcessMemory; external kernel32 Name 'ReadProcessMemory';
function ChangeTimerQueueTimer; external kernel32 Name 'ChangeTimerQueueTimer';
function CreateTimerQueue; external kernel32 Name 'CreateTimerQueue';
function CreateTimerQueueTimer; external kernel32 Name 'CreateTimerQueueTimer';
function DeleteTimerQueue; external kernel32 Name 'DeleteTimerQueue';
function DeleteTimerQueueEx; external kernel32 Name 'DeleteTimerQueueEx';
function DeleteTimerQueueTimer; external kernel32 Name 'DeleteTimerQueueTimer';
function InterlockedCompareExchange; external kernel32 Name 'InterlockedCompareExchange';
function InterlockedExchange; external kernel32 Name 'InterlockedExchange';
function InterlockedExchangeAdd; external kernel32 Name 'InterlockedExchangeAdd';
function InterlockedIncrement; external kernel32 Name 'InterlockedIncrement';
function InterlockedDecrement; external kernel32 Name 'InterlockedDecrement';
function GetConsoleWindow; external kernel32 Name 'GetConsoleWindow';
function GetFileSizeEx; external kernel32 Name 'GetFileSizeEx';
function GetProcessId; external kernel32 Name 'GetProcessId';
function OpenThread; external kernel32 Name 'OpenThread';
function RegisterWaitForSingleObject;
  external kernel32 Name 'RegisterWaitForSingleObject';
function SetFilePointerEx; external kernel32 Name 'SetFilePointerEx';
function UnregisterWait; external kernel32 Name 'UnregisterWait';
function UnregisterWaitEx; external kernel32 Name 'UnregisterWaitEx';
function GetQueuedCompletionStatus; external kernel32 Name 'GetQueuedCompletionStatus';
function WriteProcessMemory; external kernel32 Name 'WriteProcessMemory';
function GetFileSize; external kernel32 Name 'GetFileSize';
function WriteFile; external kernel32 Name 'WriteFile';
function WriteFileEx; external kernel32 Name 'WriteFileEx';
function ReadFile; external kernel32 Name 'ReadFile';

{$IFDEF PIC}
function GetGOT: Longword;
asm
  MOV   EAX, EBX
end;
{$ENDIF}

function WindowsExit(lwRebootParam: Longword): Boolean;
const
  SE_SHUTDOWN_NAME: PChar = 'SeShutdownPrivilege';
var
  hToken: THandle;
  tTokenPvg: TTokenPrivileges;
  bResult: Boolean;
  tOsVersion: TOSVersionInfo;
begin
  GetVersionEx(tOsVersion);
  if tOsVersion.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
    bResult := OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or
      TOKEN_QUERY, hToken);
    if bResult then
    begin
      bResult := LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME,
        tTokenPvg.Privileges[0].Luid);
      if bResult then
      begin
        tTokenPvg.PrivilegeCount := 1;
        tTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        AdjustTokenPrivileges(hToken, False, tTokenPvg, 0, nil, nil);
      end;
    end;
  end;
  Result := ExitWindowsEx(lwRebootParam, 0);
end;

function ValidateHandle(hHandle: THandle): Boolean;
begin
  Result := hHandle <> INVALID_HANDLE_VALUE;
end;

procedure InvalidateHandle(var hHandle: THandle);
begin
  hHandle := INVALID_HANDLE_VALUE;
end;

{$ENDREGION}

procedure CalcOverhead;
var
  iInt: Integer;
  liStart, liEnd: Int64;
  liTemp: Int64;
begin
  QueryPerformanceCounter(liStart);
  for iInt := 0 to 99999 do
  begin
    QueryPerformanceCounter(liTemp);
    QueryPerformanceCounter(liTemp);
  end;
  QueryPerformanceCounter(liEnd);
  Overhead := (liEnd - liStart) / 100000;
end;

initialization
  QueryPerformanceFrequency(CPUFrequency);
  CalcOverhead;
  ThreadCount := 1;

end.
