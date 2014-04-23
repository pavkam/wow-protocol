unit ArrayList;

interface

uses
  ContainerInterfaces;

type
  TStringArray = array of String;
  TIntegerArray = array of Integer;
  TPointerArray = array of Pointer;
  TObjectArray = array of TObject;

  TStrPlatformArrayList = class(TInterfacedObject, IPlatformStrCollection,
    IPlatformStrList, IPlatformStrArray, IPlatformCloneable)
  private
    FCapacity: Integer;
    FElementData: TStringArray;
    FSize: Integer;
    FStrCompareProc:
    function(const S1, S2: String): Boolean;
  protected
    procedure Grow;
  public
    { IPlatformStrCollection }
    function Add(const AString: String): Boolean; overload;
    function AddAll(ACollection: IPlatformStrCollection): Boolean; overload;
    procedure Clear;
    function Contains(const AString: String): Boolean;
    function ContainsAll(ACollection: IPlatformStrCollection): Boolean;
    function Equals(ACollection: IPlatformStrCollection): Boolean;
    function First: IPlatformStrIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformStrIterator;
    function Remove(const AString: String): Boolean; overload;
    function RemoveAll(ACollection: IPlatformStrCollection): Boolean;
    function RetainAll(ACollection: IPlatformStrCollection): Boolean;
  protected
    function GetSize: Integer;
    procedure SetCaseSensitivity(AValue: Boolean);
    function GetCaseSensitivity: Boolean;
  public
    property Size: Integer Read GetSize;
  public
    { IPlatformStrList }
    procedure Add(Index: Integer; const AString: String); overload;
    function AddAll(Index: Integer; ACollection: IPlatformStrCollection): Boolean;
      overload;
    function GetString(Index: Integer): String;
    function IndexOf(const AString: String): Integer;
    function LastIndexOf(const AString: String): Integer;
    function Remove(Index: Integer): String; overload;
    procedure SetString(Index: Integer; const AString: String);
    function SubList(First, Count: Integer): IPlatformStrList;
    property Items[Index: Integer]: String Read GetString Write SetString; default;
    property CaseSensitive: Boolean Read GetCaseSensitivity Write SetCaseSensitivity;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create; overload;
    constructor Create(Capacity: Integer); overload;
    constructor Create(ACollection: IPlatformStrCollection); overload;
    destructor Destroy; override;
  end;

  TIntPlatformArrayList = class(TInterfacedObject, IPlatformIntCollection,
    IPlatformIntList, IPlatformIntArray, IPlatformCloneable)
  private
    FCapacity: Integer;
    FElementData: TIntegerArray;
    FSize: Integer;
  protected
    procedure Grow;
  public
    { IPlatformIntCollection }
    function Add(const AInt: Integer): Boolean; overload;
    function AddAll(ACollection: IPlatformIntCollection): Boolean; overload;
    procedure Clear;
    function Contains(const AInt: Integer): Boolean;
    function ContainsAll(ACollection: IPlatformIntCollection): Boolean;
    function Equals(ACollection: IPlatformIntCollection): Boolean;
    function First: IPlatformIntIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformIntIterator;
    function Remove(const AInt: Integer): Boolean; overload;
    function RemoveAll(ACollection: IPlatformIntCollection): Boolean;
    function RetainAll(ACollection: IPlatformIntCollection): Boolean;
  protected
    function GetSize: Integer;
  public
    property Size: Integer Read GetSize;
  public
    { IPlatformIntList }
    procedure Add(Index: Integer; const AInt: Integer); overload;
    function AddAll(Index: Integer; ACollection: IPlatformIntCollection): Boolean;
      overload;
    function GetInt(Index: Integer): Integer;
    function IndexOf(const AInt: Integer): Integer;
    function LastIndexOf(const AInt: Integer): Integer;
    function RemoveFromIndex(Index: Integer): Integer; overload;
    procedure SetInt(Index: Integer; const AInt: Integer);
    function SubList(First, Count: Integer): IPlatformIntList;
    property Items[Index: Integer]: Integer Read GetInt Write SetInt; default;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create; overload;
    constructor Create(Capacity: Integer); overload;
    constructor Create(ACollection: IPlatformIntCollection); overload;
    destructor Destroy; override;
  end;

  TPtrPlatformArrayList = class(TInterfacedObject, IPlatformPtrCollection,
    IPlatformPtrList, IPlatformPtrArray, IPlatformCloneable)
  private
    FCapacity: Integer;
    FElementData: TPointerArray;
    FSize: Integer;
  protected
    procedure Grow;
  public
    { IPlatformPtrCollection }
    function Add(APtr: Pointer): Boolean; overload;
    function AddAll(ACollection: IPlatformPtrCollection): Boolean; overload;
    procedure Clear;
    function Contains(APtr: Pointer): Boolean;
    function ContainsAll(ACollection: IPlatformPtrCollection): Boolean;
    function Equals(ACollection: IPlatformPtrCollection): Boolean;
    function First: IPlatformPtrIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformPtrIterator;
    function Remove(APtr: Pointer): Boolean; overload;
    function RemoveAll(ACollection: IPlatformPtrCollection): Boolean;
    function RetainAll(ACollection: IPlatformPtrCollection): Boolean;
  protected
    function GetSize: Integer;
  public
    property Size: Integer Read GetSize;
  public
    { IPlatformPtrList }
    procedure Add(Index: Integer; APtr: Pointer); overload;
    function AddAll(Index: Integer; ACollection: IPlatformPtrCollection): Boolean;
      overload;
    function GetPtr(Index: Integer): Pointer;
    function IndexOf(APtr: Pointer): Integer;
    function LastIndexOf(APtr: Pointer): Integer;
    function Remove(Index: Integer): Pointer; overload;
    procedure SetPtr(Index: Integer; APtr: Pointer);
    function SubList(First, Count: Integer): IPlatformPtrList;
    property Items[Index: Integer]: Pointer Read GetPtr Write SetPtr; default;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create; overload;
    constructor Create(Capacity: Integer); overload;
    constructor Create(ACollection: IPlatformPtrCollection); overload;
    destructor Destroy; override;
  end;

  TPlatformArrayList = class(TInterfacedObject, IPlatformCollection, IPlatformList,
    IPlatformArray, IPlatformCloneable)
  private
    FCapacity: Integer;
    FElementData: TObjectArray;
    FOwnsObjects: Boolean;
    FSize: Integer;
  protected
    procedure Grow;
    procedure FreeObject(AObject: TObject);
  public
    { ICollection }
    function Add(AObject: TObject): Boolean; overload;
    function AddAll(ACollection: IPlatformCollection): Boolean; overload;
    procedure Clear;
    function Contains(AObject: TObject): Boolean;
    function ContainsAll(ACollection: IPlatformCollection): Boolean;
    function Equals(ACollection: IPlatformCollection): Boolean;
    function First: IPlatformIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformIterator;
    function Remove(AObject: TObject): Boolean; overload;
    function RemoveAll(ACollection: IPlatformCollection): Boolean;
    function RetainAll(ACollection: IPlatformCollection): Boolean;
  protected
    function GetSize: Integer;
  public
    property Size: Integer Read GetSize;
  public
    { IList }
    procedure Add(Index: Integer; AObject: TObject); overload;
    function AddAll(Index: Integer; ACollection: IPlatformCollection): Boolean;
      overload;
    function GetObject(Index: Integer): TObject;
    function IndexOf(AObject: TObject): Integer;
    function LastIndexOf(AObject: TObject): Integer;
    function Remove(Index: Integer): TObject; overload;
    procedure SetObject(Index: Integer; AObject: TObject);
    function SubList(First, Count: Integer): IPlatformList;
    property Items[Index: Integer]: TObject Read GetObject Write SetObject; default;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create; overload;
    constructor Create(Capacity: Integer; AOwnsObjects: Boolean); overload;
    constructor Create(ACollection: IPlatformCollection; AOwnsObjects: Boolean);
      overload;
    destructor Destroy; override;
  end;

  TStrItr = class(TInterfacedObject, IPlatformStrIterator)
  private
    FCursor: Integer;
    FOwnList: TStrPlatformArrayList;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IPlatformStrIterator}
    procedure Add(const AString: String);
    function GetString: String;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: String;
    function NextIndex: Integer;
    function Previous: String;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetString(const AString: String);
  public
    constructor Create(OwnList: TStrPlatformArrayList);
    destructor Destroy; override;
  end;

  TIntItr = class(TInterfacedObject, IPlatformIntIterator)
  private
    FCursor: Integer;
    FOwnList: TIntPlatformArrayList;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IPlatformIntIterator}
    procedure Add(const AInt: Integer);
    function GetInt: Integer;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: Integer;
    function NextIndex: Integer;
    function Previous: Integer;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetInt(const AInt: Integer);
  public
    constructor Create(OwnList: TIntPlatformArrayList);
    destructor Destroy; override;
  end;

  TPtrItr = class(TInterfacedObject, IPlatformPtrIterator)
  private
    FCursor: Integer;
    FOwnList: TPtrPlatformArrayList;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IPlatformPtrIterator}
    procedure Add(APtr: Pointer);
    function GetPtr: Pointer;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: Pointer;
    function NextIndex: Integer;
    function Previous: Pointer;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetPtr(APtr: Pointer);
  public
    constructor Create(OwnList: TPtrPlatformArrayList);
    destructor Destroy; override;
  end;

  TItr = class(TInterfacedObject, IPlatformIterator)
  private
    FCursor: Integer;
    FOwnList: TPlatformArrayList;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IIterator}
    procedure Add(AObject: TObject);
    function GetObject: TObject;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: TObject;
    function NextIndex: Integer;
    function Previous: TObject;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetObject(AObject: TObject);
  public
    constructor Create(OwnList: TPlatformArrayList);
    destructor Destroy; override;
  end;

implementation

uses
  Miscelaneous;

procedure TStrItr.Add(const AString: String);
begin
  with FOwnList do
  begin
    Move(FElementData[FCursor], FElementData[FCursor + 1],
      (FOwnList.FSize - FCursor) * SizeOf(String));
    FCapacity := Length(FElementData);
    FElementData[FCursor] := AString;
    Inc(FOwnList.FSize);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

constructor TStrItr.Create(OwnList: TStrPlatformArrayList);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef;
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TStrItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

function TStrItr.GetString: String;
begin
  Result := FOwnList.FElementData[FCursor];
end;

function TStrItr.HasNext: Boolean;
begin
  Result := FCursor < FSize;
end;

function TStrItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TStrItr.Next: String;
begin
  Result := FOwnList.FElementData[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TStrItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TStrItr.Previous: String;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.FElementData[FCursor];
end;

function TStrItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TStrItr.Remove;
begin
  with FOwnList do
  begin
    FElementData[FCursor] := '';
    Move(FElementData[FCursor + 1], FElementData[FCursor], (FSize - FCursor) *
      SizeOf(String));
  end;
  Dec(FOwnList.FSize);
  Dec(FSize);
end;

procedure TStrItr.SetString(const AString: String);
begin
  FOwnList.FElementData[FCursor] := AString;
end;

{ TIntItr }

procedure TIntItr.Add(const AInt: Integer);
begin
  with FOwnList do
  begin
    Move(FElementData[FCursor], FElementData[FCursor + 1],
      (FOwnList.FSize - FCursor) * SizeOf(Integer));
    FCapacity := Length(FElementData);
    FElementData[FCursor] := AInt;
    Inc(FOwnList.FSize);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

constructor TIntItr.Create(OwnList: TIntPlatformArrayList);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef;
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TIntItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

function TIntItr.GetInt: Integer;
begin
  Result := FOwnList.FElementData[FCursor];
end;

function TIntItr.HasNext: Boolean;
begin
  Result := FCursor < FSize;
end;

function TIntItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TIntItr.Next: Integer;
begin
  Result := FOwnList.FElementData[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TIntItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TIntItr.Previous: Integer;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.FElementData[FCursor];
end;

function TIntItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TIntItr.Remove;
begin
  with FOwnList do
  begin
    FElementData[FCursor] := 0;
    Move(FElementData[FCursor + 1], FElementData[FCursor], (FSize - FCursor) *
      SizeOf(Integer));
  end;
  Dec(FOwnList.FSize);
  Dec(FSize);
end;

procedure TIntItr.SetInt(const AInt: Integer);
begin
  FOwnList.FElementData[FCursor] := AInt;
end;

{ TPtrItr }

procedure TPtrItr.Add(APtr: Pointer);
begin
  with FOwnList do
  begin
    Move(FElementData[FCursor], FElementData[FCursor + 1],
      (FOwnList.FSize - FCursor) * SizeOf(Pointer));
    FCapacity := Length(FElementData);
    FElementData[FCursor] := APtr;
    Inc(FOwnList.FSize);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

constructor TPtrItr.Create(OwnList: TPtrPlatformArrayList);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef;
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TPtrItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

function TPtrItr.GetPtr: Pointer;
begin
  Result := FOwnList.FElementData[FCursor];
end;

function TPtrItr.HasNext: Boolean;
begin
  Result := FCursor <> FSize;
end;

function TPtrItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TPtrItr.Next: Pointer;
begin
  Result := FOwnList.FElementData[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TPtrItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TPtrItr.Previous: Pointer;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.FElementData[FCursor];
end;

function TPtrItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TPtrItr.Remove;
begin
  with FOwnList do
  begin
    Move(FElementData[FCursor + 1], FElementData[FCursor], (FSize - FCursor) *
      SizeOf(Pointer));
  end;
  Dec(FOwnList.FSize);
  Dec(FSize);
end;

procedure TPtrItr.SetPtr(APtr: Pointer);
begin
  FOwnList.FElementData[FCursor] := APtr;
end;

{ TItr }

procedure TItr.Add(AObject: TObject);
begin
  with FOwnList do
  begin
    Move(FElementData[FCursor], FElementData[FCursor + 1],
      (FOwnList.FSize - FCursor) * SizeOf(TObject));
    FCapacity := Length(FElementData);
    FElementData[FCursor] := AObject;
    Inc(FOwnList.FSize);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

constructor TItr.Create(OwnList: TPlatformArrayList);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef;
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

function TItr.GetObject: TObject;
begin
  Result := FOwnList.FElementData[FCursor];
end;

function TItr.HasNext: Boolean;
begin
  Result := FCursor <> FSize;
end;

function TItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TItr.Next: TObject;
begin
  Result := FOwnList.FElementData[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TItr.Previous: TObject;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.FElementData[FCursor];
end;

function TItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TItr.Remove;
begin
  with FOwnList do
  begin
    FreeObject(FElementData[FCursor]);
    Move(FElementData[FCursor + 1], FElementData[FCursor], (FSize - FCursor) *
      SizeOf(TObject));
  end;
  Dec(FOwnList.FSize);
  Dec(FSize);
end;

procedure TItr.SetObject(AObject: TObject);
begin
  FOwnList.FElementData[FCursor] := AObject;
end;

{ TStrPlatformArrayList }

procedure TStrPlatformArrayList.Add(Index: Integer; const AString: String);
begin
  if FSize = FCapacity then Grow;
  Move(FElementData[Index], FElementData[Index + 1], (FSize - Index) * SizeOf(String));
  FElementData[Index] := AString;
  Inc(FSize);
end;

function TStrPlatformArrayList.Add(const AString: String): Boolean;
begin
  if FSize = FCapacity then Grow;
  FElementData[FSize] := AString;
  Inc(FSize);
  Result := True;
end;

function TStrPlatformArrayList.AddAll(Index: Integer;
  ACollection: IPlatformStrCollection): Boolean;
var
  It: IPlatformStrIterator;
  Size: Integer;
begin
  Result := False;
  if ACollection = nil then Exit;
  Size := ACollection.Size;
  Move(FElementData[Index], FElementData[Index + Size], Size * SizeOf(String));
  It := ACollection.First;
  while It.HasNext do
  begin
    FElementData[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

function TStrPlatformArrayList.AddAll(ACollection: IPlatformStrCollection): Boolean;
var
  It: IPlatformStrIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

procedure TStrPlatformArrayList.Clear;
var
  I: Integer;
begin
  for I := 0 to FSize - 1 do FElementData[I] := '';
  FSize := 0;
end;

function TStrPlatformArrayList.Clone: TObject;
var
  NewList: TStrPlatformArrayList;
begin
  NewList := TStrPlatformArrayList.Create(FCapacity);
  NewList.AddAll(Self);
  Result := NewList;
end;

function TStrPlatformArrayList.Contains(const AString: String): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AString = '' then Exit;
  for I := 0 to FSize - 1 do if FStrCompareProc(FElementData[I], AString) then
    begin
      Result := True;
      Exit;
    end;
end;

function TStrPlatformArrayList.ContainsAll(ACollection: IPlatformStrCollection): Boolean;
var
  It: IPlatformStrIterator;
begin
  Result := True;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do
  begin
    if not Contains(It.Next) then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

constructor TStrPlatformArrayList.Create;
begin
  Create(16);
end;

constructor TStrPlatformArrayList.Create(ACollection: IPlatformStrCollection);
var
  It: IPlatformStrIterator;
begin
  inherited Create;
  FStrCompareProc := StringsEqual;
  Create(ACollection.Size);
  It := ACollection.First;
  while it.HasNext do Add(It.Next);
end;

constructor TStrPlatformArrayList.Create(Capacity: Integer);
begin
  inherited Create;
  FSize := 0;
  FCapacity := Capacity;
  FStrCompareProc := StringsEqual;
  SetLength(FElementData, FCapacity);
end;

destructor TStrPlatformArrayList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TStrPlatformArrayList.Equals(ACollection: IPlatformStrCollection): Boolean;
var
  I: Integer;
  It: IPlatformStrIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  if FSize <> ACollection.Size then  Exit;
  It := ACollection.First;
  for I := 0 to FSize - 1 do if not FStrCompareProc(FElementData[I], It.Next) then
      Exit;
  Result := True;
end;

function TStrPlatformArrayList.First: IPlatformStrIterator;
begin
  Result := TStrItr.Create(Self);
end;

function TStrPlatformArrayList.GetString(Index: Integer): String;
begin
  if (Index < 0) or (Index >= FSize) then
  begin
    Result := '';
    Exit;
  end;
  Result := FElementData[Index];
end;

procedure TStrPlatformArrayList.Grow;
begin
  if FCapacity > 64 then
  begin
    Inc(FCapacity, FCapacity shr 2);
  end else if FCapacity = 0 then
  begin
    FCapacity := 64;
  end else
  begin
    FCapacity := FCapacity shl 2;
  end;
  SetLength(FElementData, FCapacity);
end;

function TStrPlatformArrayList.IndexOf(const AString: String): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AString = '' then Exit;
  for I := 0 to FSize - 1 do if FStrCompareProc(FElementData[I], AString) then
    begin
      Result := I;
      Exit;
    end;
end;

function TStrPlatformArrayList.IsEmpty: Boolean;
begin
  Result := FSize = 0;
end;

function TStrPlatformArrayList.Last: IPlatformStrIterator;
var
  NewIterator: TStrItr;
begin
  NewIterator := TStrItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FSize;
  NewIterator.FSize := NewIterator.FOwnList.FSize;
  Result := NewIterator;
end;

function TStrPlatformArrayList.LastIndexOf(const AString: String): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AString = '' then Exit;
  for I := FSize - 1 downto 0 do if FStrCompareProc(FElementData[I], AString) then
    begin
      Result := I;
      Exit;
    end;
end;

function TStrPlatformArrayList.Remove(const AString: String): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AString = '' then Exit;
  for I := FSize - 1 downto 0 do if FStrCompareProc(FElementData[I], AString) then
    begin
      FElementData[I] := '';
      Move(FElementData[I + 1], FElementData[I], (FSize - I) * SizeOf(String));
      Dec(FSize);
      Result := True;
    end;
end;

function TStrPlatformArrayList.Remove(Index: Integer): String;
begin
  Result := FElementData[Index];
  FElementData[Index] := '';
  Move(FElementData[Index + 1], FElementData[Index], (FSize - Index) * SizeOf(String));
  Dec(FSize);
end;

function TStrPlatformArrayList.RemoveAll(ACollection: IPlatformStrCollection): Boolean;
var
  It: IPlatformStrIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  It := ACollection.First;
  while It.HasNext do Remove(It.Next);
end;

function TStrPlatformArrayList.RetainAll(ACollection: IPlatformStrCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then  Exit;
  for I := FSize - 1 downto 0 do if not ACollection.Contains(FElementData[I]) then
      Remove(I);
end;

procedure TStrPlatformArrayList.SetCaseSensitivity(AValue: Boolean);
begin
  if AValue and (@FStrCompareProc = @StringsEqualNoCase) then
  begin
    FStrCompareProc := StringsEqual;
  end else if (@FStrCompareProc = @StringsEqual) then
  begin
    FStrCompareProc := StringsEqualNoCase;
  end;
end;

procedure TStrPlatformArrayList.SetString(Index: Integer; const AString: String);
begin
  FElementData[Index] := AString;
end;

function TStrPlatformArrayList.GetCaseSensitivity: Boolean;
begin
  Result := @FStrCompareProc = @StringsEqual;
end;

function TStrPlatformArrayList.GetSize: Integer;
begin
  Result := FSize;
end;

function TStrPlatformArrayList.SubList(First, Count: Integer): IPlatformStrList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FSize then  Last := FSize - 1;
  Result := TStrPlatformArrayList.Create(Count);
  for I := First to Last do
  begin
    Result.Add(FElementData[I]);
  end;
end;

{ TIntPlatformArrayList }

procedure TIntPlatformArrayList.Add(Index: Integer; const AInt: Integer);
begin
  if FSize = FCapacity then Grow;
  Move(FElementData[Index], FElementData[Index + 1], (FSize - Index) * SizeOf(Integer));
  FElementData[Index] := AInt;
  Inc(FSize);
end;

function TIntPlatformArrayList.Add(const AInt: Integer): Boolean;
begin
  if FSize = FCapacity then Grow;
  FElementData[FSize] := AInt;
  Inc(FSize);
  Result := True;
end;

function TIntPlatformArrayList.AddAll(Index: Integer;
  ACollection: IPlatformIntCollection): Boolean;
var
  It: IPlatformIntIterator;
  Size: Integer;
begin
  Result := False;
  if ACollection = nil then Exit;
  Size := ACollection.Size;
  Move(FElementData[Index], FElementData[Index + Size], Size * SizeOf(Integer));
  It := ACollection.First;
  while It.HasNext do
  begin
    FElementData[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

function TIntPlatformArrayList.AddAll(ACollection: IPlatformIntCollection): Boolean;
var
  It: IPlatformIntIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

procedure TIntPlatformArrayList.Clear;
var
  I: Integer;
begin
  for I := 0 to FSize - 1 do FElementData[I] := 0;
  FSize := 0;
end;

function TIntPlatformArrayList.Clone: TObject;
var
  NewList: TIntPlatformArrayList;
begin
  NewList := TIntPlatformArrayList.Create(FCapacity);
  NewList.AddAll(Self);
  Result := NewList;
end;

function TIntPlatformArrayList.Contains(const AInt: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FSize - 1 do if FElementData[I] = AInt then
    begin
      Result := True;
      Exit;
    end;
end;

function TIntPlatformArrayList.ContainsAll(ACollection: IPlatformIntCollection): Boolean;
var
  It: IPlatformIntIterator;
begin
  Result := True;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do
  begin
    if not Contains(It.Next) then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

constructor TIntPlatformArrayList.Create;
begin
  Create(16);
end;

constructor TIntPlatformArrayList.Create(ACollection: IPlatformIntCollection);
var
  It: IPlatformIntIterator;
begin
  inherited Create;
  Create(ACollection.Size);
  It := ACollection.First;
  while it.HasNext do Add(It.Next);
end;

constructor TIntPlatformArrayList.Create(Capacity: Integer);
begin
  inherited Create;
  FSize := 0;
  FCapacity := Capacity;
  SetLength(FElementData, FCapacity);
end;

destructor TIntPlatformArrayList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TIntPlatformArrayList.Equals(ACollection: IPlatformIntCollection): Boolean;
var
  I: Integer;
  It: IPlatformIntIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  if FSize <> ACollection.Size then  Exit;
  It := ACollection.First;
  for I := 0 to FSize - 1 do if FElementData[I] <> It.Next then Exit;
  Result := True;
end;

function TIntPlatformArrayList.First: IPlatformIntIterator;
begin
  Result := TIntItr.Create(Self);
end;

function TIntPlatformArrayList.GetInt(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= FSize) then
  begin
    Result := 0;
    Exit;
  end;
  Result := FElementData[Index];
end;

procedure TIntPlatformArrayList.Grow;
begin
  if FCapacity > 64 then
  begin
    Inc(FCapacity, FCapacity shr 2);
  end else if FCapacity = 0 then
  begin
    FCapacity := 64;
  end else
  begin
    FCapacity := FCapacity shl 2;
  end;
  SetLength(FElementData, FCapacity);
end;

function TIntPlatformArrayList.IndexOf(const AInt: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FSize - 1 do if FElementData[I] = AInt then
    begin
      Result := I;
      Exit;
    end;
end;

function TIntPlatformArrayList.IsEmpty: Boolean;
begin
  Result := FSize = 0;
end;

function TIntPlatformArrayList.Last: IPlatformIntIterator;
var
  NewIterator: TIntItr;
begin
  NewIterator := TIntItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FSize;
  NewIterator.FSize := NewIterator.FOwnList.FSize;
  Result := NewIterator;
end;

function TIntPlatformArrayList.LastIndexOf(const AInt: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := FSize - 1 downto 0 do if FElementData[I] = AInt then
    begin
      Result := I;
      Exit;
    end;
end;

function TIntPlatformArrayList.Remove(const AInt: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := FSize - 1 downto 0 do if FElementData[I] = AInt then
    begin
      FElementData[I] := 0;
      Move(FElementData[I + 1], FElementData[I], (FSize - I) * SizeOf(Integer));
      Dec(FSize);
      Result := True;
    end;
end;

function TIntPlatformArrayList.RemoveFromIndex(Index: Integer): Integer;
begin
  Result := FElementData[Index];
  FElementData[Index] := 0;
  Move(FElementData[Index + 1], FElementData[Index], (FSize - Index) * SizeOf(Integer));
  Dec(FSize);
end;

function TIntPlatformArrayList.RemoveAll(ACollection: IPlatformIntCollection): Boolean;
var
  It: IPlatformIntIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  It := ACollection.First;
  while It.HasNext do Remove(It.Next);
end;

function TIntPlatformArrayList.RetainAll(ACollection: IPlatformIntCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then  Exit;
  for I := FSize - 1 downto 0 do if not ACollection.Contains(FElementData[I]) then
      Remove(I);
end;

procedure TIntPlatformArrayList.SetInt(Index: Integer; const AInt: Integer);
begin
  FElementData[Index] := AInt;
end;

function TIntPlatformArrayList.GetSize: Integer;
begin
  Result := FSize;
end;

function TIntPlatformArrayList.SubList(First, Count: Integer): IPlatformIntList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FSize then  Last := FSize - 1;
  Result := TIntPlatformArrayList.Create(Count);
  for I := First to Last do
  begin
    Result.Add(FElementData[I]);
  end;
end;

{ TPtrPlatformArrayList }

procedure TPtrPlatformArrayList.Add(Index: Integer; APtr: Pointer);
begin
  if FSize = FCapacity then  Grow;
  Move(FElementData[Index], FElementData[Index + 1], (FSize - Index) * SizeOf(Pointer));
  FElementData[Index] := APtr;
  Inc(FSize);
end;

function TPtrPlatformArrayList.Add(APtr: Pointer): Boolean;
begin
  if FSize = FCapacity then Grow;
  FElementData[FSize] := APtr;
  Inc(FSize);
  Result := True;
end;

function TPtrPlatformArrayList.AddAll(ACollection: IPlatformPtrCollection): Boolean;
var
  It: IPlatformPtrIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

function TPtrPlatformArrayList.AddAll(Index: Integer;
  ACollection: IPlatformPtrCollection): Boolean;
var
  It: IPlatformPtrIterator;
  Size: Integer;
begin
  Result := False;
  if ACollection = nil then Exit;
  Size := ACollection.Size;
  Move(FElementData[Index], FElementData[Index + Size], Size * SizeOf(Pointer));
  It := ACollection.First;
  while It.HasNext do
  begin
    FElementData[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

procedure TPtrPlatformArrayList.Clear;
var
  I: Integer;
begin
  for I := 0 to FSize - 1 do
  begin
    if Assigned(FElementData[I]) then FElementData[I] := nil;
  end;
  FSize := 0;
end;

function TPtrPlatformArrayList.Clone: TObject;
var
  NewList: TPtrPlatformArrayList;
begin
  NewList := TPtrPlatformArrayList.Create(FCapacity);
  NewList.AddAll(Self);
  Result := NewList;
end;

function TPtrPlatformArrayList.Contains(APtr: Pointer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if APtr = nil then Exit;
  for I := 0 to FSize - 1 do if FElementData[I] = APtr then
    begin
      Result := True;
      Exit;
    end;
end;

function TPtrPlatformArrayList.ContainsAll(ACollection: IPlatformPtrCollection): Boolean;
var
  It: IPlatformPtrIterator;
begin
  Result := True;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do
  begin
    if not Contains(It.Next) then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

constructor TPtrPlatformArrayList.Create(Capacity: Integer);
begin
  inherited Create;
  FSize := 0;
  FCapacity := Capacity;
  SetLength(FElementData, FCapacity);
end;

constructor TPtrPlatformArrayList.Create(ACollection: IPlatformPtrCollection);
var
  It: IPlatformPtrIterator;
begin
  inherited Create;
  Create(ACollection.Size);
  It := ACollection.First;
  while it.HasNext do Add(It.Next);
end;

constructor TPtrPlatformArrayList.Create;
begin
  Create(16);
end;

destructor TPtrPlatformArrayList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TPtrPlatformArrayList.Equals(ACollection: IPlatformPtrCollection): Boolean;
var
  I: Integer;
  It: IPlatformPtrIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  if FSize <> ACollection.Size then  Exit;
  It := ACollection.First;
  for I := 0 to FSize - 1 do if FElementData[I] <> It.Next then Exit;
  Result := True;
end;

function TPtrPlatformArrayList.GetPtr(Index: Integer): Pointer;
begin
  if (Index < 0) or (Index >= FSize) then
  begin
    Result := nil;
    Exit;
  end;
  Result := FElementData[Index];
end;

procedure TPtrPlatformArrayList.Grow;
begin
  if FCapacity > 64 then
  begin
    Inc(FCapacity, FCapacity shr 2);
  end else if FCapacity = 0 then
  begin
    FCapacity := 64;
  end else
  begin
    FCapacity := FCapacity shl 2;
  end;
  SetLength(FElementData, FCapacity);
end;

function TPtrPlatformArrayList.IndexOf(APtr: Pointer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if APtr = nil then Exit;
  for I := 0 to FSize - 1 do if FElementData[I] = APtr then
    begin
      Result := I;
      Exit;
    end;
end;

function TPtrPlatformArrayList.First: IPlatformPtrIterator;
begin
  Result := TPtrItr.Create(Self);
end;

function TPtrPlatformArrayList.IsEmpty: Boolean;
begin
  Result := FSize = 0;
end;

function TPtrPlatformArrayList.Last: IPlatformPtrIterator;
var
  NewIterator: TPtrItr;
begin
  NewIterator := TPtrItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FSize;
  NewIterator.FSize := NewIterator.FOwnList.FSize;
  Result := NewIterator;
end;

function TPtrPlatformArrayList.LastIndexOf(APtr: Pointer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if APtr = nil then Exit;
  for I := FSize - 1 downto 0 do if FElementData[I] = APtr then
    begin
      Result := I;
      Exit;
    end;
end;

function TPtrPlatformArrayList.Remove(APtr: Pointer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if APtr = nil then Exit;
  for I := FSize - 1 downto 0 do if FElementData[I] = APtr then
    begin
      Move(FElementData[I + 1], FElementData[I], (FSize - I) * SizeOf(Pointer));
      Dec(FSize);
      Result := True;
    end;
end;

function TPtrPlatformArrayList.Remove(Index: Integer): Pointer;
begin
  Result := nil;
  Move(FElementData[Index + 1], FElementData[Index], (FSize - Index) * SizeOf(Pointer));
  Dec(FSize);
end;

function TPtrPlatformArrayList.RemoveAll(ACollection: IPlatformPtrCollection): Boolean;
var
  It: IPlatformPtrIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  It := ACollection.First;
  while It.HasNext do Remove(It.Next);
end;

function TPtrPlatformArrayList.RetainAll(ACollection: IPlatformPtrCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then  Exit;
  for I := FSize - 1 to 0 do if not ACollection.Contains(FElementData[I]) then
      Remove(I);
end;

procedure TPtrPlatformArrayList.SetPtr(Index: Integer; APtr: Pointer);
begin
  FElementData[Index] := APtr;
end;

function TPtrPlatformArrayList.GetSize: Integer;
begin
  Result := FSize;
end;

function TPtrPlatformArrayList.SubList(First, Count: Integer): IPlatformPtrList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FSize then Last := FSize - 1;
  Result := TPtrPlatformArrayList.Create(Count);
  for I := First to Last do
  begin
    Result.Add(FElementData[I]);
  end;
end;

{ TPlatformArrayList }

procedure TPlatformArrayList.Add(Index: Integer; AObject: TObject);
begin
  if FSize = FCapacity then  Grow;
  Move(FElementData[Index], FElementData[Index + 1], (FSize - Index) * SizeOf(TObject));
  FElementData[Index] := AObject;
  Inc(FSize);
end;

function TPlatformArrayList.Add(AObject: TObject): Boolean;
begin
  if FSize = FCapacity then Grow;
  FElementData[FSize] := AObject;
  Inc(FSize);
  Result := True;
end;

function TPlatformArrayList.AddAll(ACollection: IPlatformCollection): Boolean;
var
  It: IPlatformIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

function TPlatformArrayList.AddAll(Index: Integer;
  ACollection: IPlatformCollection): Boolean;
var
  It: IPlatformIterator;
  Size: Integer;
begin
  Result := False;
  if ACollection = nil then Exit;
  Size := ACollection.Size;
  Move(FElementData[Index], FElementData[Index + Size], Size * SizeOf(Pointer));
  It := ACollection.First;
  while It.HasNext do
  begin
    FElementData[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

procedure TPlatformArrayList.Clear;
var
  I: Integer;
begin
  for I := 0 to FSize - 1 do
  begin
    FreeObject(FElementData[I]);
    FElementData[I] := nil;
  end;
  FSize := 0;
end;

function TPlatformArrayList.Clone: TObject;
var
  NewList: TPlatformArrayList;
begin
  NewList := TPlatformArrayList.Create(FCapacity, False);
  NewList.AddAll(Self);
  Result := NewList;
end;

function TPlatformArrayList.Contains(AObject: TObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AObject = nil then Exit;
  for I := 0 to FSize - 1 do if FElementData[I] = AObject then
    begin
      Result := True;
      Exit;
    end;
end;

function TPlatformArrayList.ContainsAll(ACollection: IPlatformCollection): Boolean;
var
  It: IPlatformIterator;
begin
  Result := True;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do
  begin
    if not Contains(It.Next) then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

constructor TPlatformArrayList.Create(Capacity: Integer; AOwnsObjects: Boolean);
begin
  inherited Create;
  FSize := 0;
  FCapacity := Capacity;
  FOwnsObjects := AOwnsObjects;
  SetLength(FElementData, FCapacity);
end;

constructor TPlatformArrayList.Create(ACollection: IPlatformCollection;
  AOwnsObjects: Boolean);
var
  It: IPlatformIterator;
begin
  inherited Create;
  Create(ACollection.Size, AOwnsObjects);
  It := ACollection.First;
  while it.HasNext do Add(It.Next);
end;

constructor TPlatformArrayList.Create;
begin
  Create(16, True);
end;

destructor TPlatformArrayList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TPlatformArrayList.Equals(ACollection: IPlatformCollection): Boolean;
var
  I: Integer;
  It: IPlatformIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  if FSize <> ACollection.Size then  Exit;
  It := ACollection.First;
  for I := 0 to FSize - 1 do if FElementData[I] <> It.Next then Exit;
  Result := True;
end;

procedure TPlatformArrayList.FreeObject(AObject: TObject);
begin
  if FOwnsObjects then AObject.Free;
end;

function TPlatformArrayList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FSize) then
  begin
    Result := nil;
    Exit;
  end;
  Result := FElementData[Index];
end;

procedure TPlatformArrayList.Grow;
begin
  if FCapacity > 64 then
  begin
    Inc(FCapacity, FCapacity shr 2);
  end else if FCapacity = 0 then
  begin
    FCapacity := 64;
  end else
  begin
    FCapacity := FCapacity shl 2;
  end;
  SetLength(FElementData, FCapacity);
end;

function TPlatformArrayList.IndexOf(AObject: TObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AObject = nil then Exit;
  for I := 0 to FSize - 1 do if FElementData[I] = AObject then
    begin
      Result := I;
      Exit;
    end;
end;

function TPlatformArrayList.First: IPlatformIterator;
begin
  Result := TItr.Create(Self);
end;

function TPlatformArrayList.IsEmpty: Boolean;
begin
  Result := FSize = 0;
end;

function TPlatformArrayList.Last: IPlatformIterator;
var
  NewIterator: TItr;
begin
  NewIterator := TItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FSize;
  NewIterator.FSize := NewIterator.FOwnList.FSize;
  Result := NewIterator;
end;

function TPlatformArrayList.LastIndexOf(AObject: TObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AObject = nil then Exit;
  for I := FSize - 1 downto 0 do if FElementData[I] = AObject then
    begin
      Result := I;
      Exit;
    end;
end;

function TPlatformArrayList.Remove(AObject: TObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AObject = nil then Exit;
  for I := FSize - 1 downto 0 do if FElementData[I] = AObject then
    begin
      FreeObject(FElementData[I]);
      Move(FElementData[I + 1], FElementData[I], (FSize - I) * SizeOf(TObject));
      Dec(FSize);
      Result := True;
    end;
end;

function TPlatformArrayList.Remove(Index: Integer): TObject;
begin
  Result := nil;
  FreeObject(FElementData[Index]);
  Move(FElementData[Index + 1], FElementData[Index], (FSize - Index) * SizeOf(TObject));
  Dec(FSize);
end;

function TPlatformArrayList.RemoveAll(ACollection: IPlatformCollection): Boolean;
var
  It: IPlatformIterator;
begin
  Result := False;
  if ACollection = nil then  Exit;
  It := ACollection.First;
  while It.HasNext do Remove(It.Next);
end;

function TPlatformArrayList.RetainAll(ACollection: IPlatformCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then  Exit;
  for I := FSize - 1 to 0 do if not ACollection.Contains(FElementData[I]) then
      Remove(I);
end;

procedure TPlatformArrayList.SetObject(Index: Integer; AObject: TObject);
begin
  FElementData[Index] := AObject;
end;

function TPlatformArrayList.GetSize: Integer;
begin
  Result := FSize;
end;

function TPlatformArrayList.SubList(First, Count: Integer): IPlatformList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FSize then Last := FSize - 1;
  Result := TPlatformArrayList.Create(Count, FOwnsObjects);
  for I := First to Last do
  begin
    Result.Add(FElementData[I]);
  end;
end;

end.
