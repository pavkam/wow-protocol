unit Debug;

interface

uses Classes, Forms, SysUtils, Windows;

type
  TDebugLogger = class(TObject)
  private
    fMainThread: Cardinal;
    fMainLocked: Integer;

    fLocked: Integer;
    fLockedBy: Cardinal;
    fAbortOthers: Boolean;

  public
    constructor Initialize();
    procedure Finalize();

    procedure Lock();
    procedure UnLock();

    procedure MainLock();
    procedure MainUnLock();

    procedure AbortPendingThreads();

  end;


implementation

{ TDebugLogger }

procedure TDebugLogger.Finalize;
begin
end;

constructor TDebugLogger.Initialize();
begin
  fLocked := 0;
  fMainThread := GetCurrentThreadId();
  fMainLocked := 0;
end;

procedure TDebugLogger.MainLock();
var
  LeetWait: Integer;
begin
  LeetWait := 1;

  if fLockedBy <> GetCurrentThreadId() then  while (fLocked > 0) and (LeetWait < 1) do
    begin
      if fAbortOthers then Abort();
      Sleep(20);

      LeetWait := LeetWait + 1;
    end;


  fMainLocked := fMainLocked + 1;
  fAbortOthers := False;
end;

procedure TDebugLogger.MainUnLock();
begin
  fMainLocked := fMainLocked - 1;

  if fAbortOthers then  Sleep(40);

  fAbortOthers := False;
end;

procedure TDebugLogger.Lock();
begin
  if GetCurrentThreadId() = fMainThread then
  begin
    MainLock();
    Exit;
  end;

  if fLockedBy <> GetCurrentThreadId() then
    while (fLocked > 0) and (fMainLocked > 0) do
    begin
      if fAbortOthers then Abort();
      Sleep(20);
    end;

  fLocked := fLocked + 1;
  fLockedBy := GetCurrentThreadId();
  fAbortOthers := False;
end;

procedure TDebugLogger.UnLock();
begin
  if GetCurrentThreadId() = fMainThread then
  begin
    MainUnLock();
    Exit;
  end;

  fLocked := fLocked - 1;

  if fAbortOthers then  Sleep(40);

  fAbortOthers := False;
end;

procedure TDebugLogger.AbortPendingThreads();
begin
  fAbortOthers := True;
end;


end.
