unit HashMap;

interface

uses
  ArrayList, ContainerInterfaces,
  Sets;

type
  TStrEntry = record
    Key: String;
    Value: TObject;
  end;

  TStrStrEntry = record
    Key: String;
    Value: String;
  end;

  TStrIntEntry = record
    Key: String;
    Value: Integer;
  end;

  TStrPtrEntry = record
    Key: String;
    Value: Pointer;
  end;

  TIntEntry = record
    Key: Integer;
    Value: TObject;
  end;

  TIntIntEntry = record
    Key: Integer;
    Value: Integer;
  end;

  TIntPtrEntry = record
    Key: Integer;
    Value: Pointer;
  end;

  TPtrPtrEntry = record
    Key: Pointer;
    Value: Pointer;
  end;

  TEntry = record
    Key: TObject;
    Value: TObject;
  end;

  TStrEntryArray = array of TStrEntry;
  TStrStrEntryArray = array of TStrStrEntry;
  TStrIntEntryArray = array of TStrIntEntry;
  TStrPtrEntryArray = array of TStrPtrEntry;
  TIntEntryArray = array of TIntEntry;
  TIntIntEntryArray = array of TIntIntEntry;
  TIntPtrEntryArray = array of TIntPtrEntry;
  TPtrPtrEntryArray = array of TPtrPtrEntry;
  TEntryArray = array of TEntry;

  PStrBucket = ^TStrBucket;

  TStrBucket = record
    Count: Integer;
    Entries: TStrEntryArray;
  end;

  PStrStrBucket = ^TStrStrBucket;

  TStrStrBucket = record
    Count: Integer;
    Entries: TStrStrEntryArray;
  end;

  PStrIntBucket = ^TStrIntBucket;

  TStrIntBucket = record
    Count: Integer;
    Entries: TStrIntEntryArray;
  end;

  PStrPtrBucket = ^TStrPtrBucket;

  TStrPtrBucket = record
    Count: Integer;
    Entries: TStrPtrEntryArray;
  end;

  PIntBucket = ^TIntBucket;

  TIntBucket = record
    Count: Integer;
    Entries: TIntEntryArray;
  end;

  PIntIntBucket = ^TIntIntBucket;

  TIntIntBucket = record
    Count: Integer;
    Entries: TIntIntEntryArray;
  end;

  PIntPtrBucket = ^TIntPtrBucket;

  TIntPtrBucket = record
    Count: Integer;
    Entries: TIntPtrEntryArray;
  end;

  PPtrPtrBucket = ^TPtrPtrBucket;

  TPtrPtrBucket = record
    Count: Integer;
    Entries: TPtrPtrEntryArray;
  end;

  PBucket = ^TBucket;

  TBucket = record
    Count: Integer;
    Entries: TEntryArray;
  end;

  TStrBucketArray = array of TStrBucket;
  TStrStrBucketArray = array of TStrStrBucket;
  TStrIntBucketArray = array of TStrIntBucket;
  TStrPtrBucketArray = array of TStrPtrBucket;
  TIntBucketArray = array of TIntBucket;
  TIntIntBucketArray = array of TIntIntBucket;
  TIntPtrBucketArray = array of TIntPtrBucket;
  TPtrPtrBucketArray = array of TPtrPtrBucket;
  TBucketArray = array of TBucket;

  TStrPlatformHashMap = class(TInterfacedObject, IPlatformStrMap, IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TStrBucketArray;
    FOwnsObjects: Boolean;
    FStrCompareProc:
    function(const S1, S2: String): Boolean;
    FStrHashProc:
    function(const Key: String; Capacity: Integer): Integer;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function FreeObject(AObject: TObject): Boolean;
    function GetBucket(Index: Integer): PStrBucket;
    function GetBucketCount: Integer;
    function GetCaseSensitivity: Boolean;
  public
    { IPlatformStrMap }
    procedure Clear;
    function ContainsKey(const Key: String): Boolean;
    function ContainsValue(Value: TObject): Boolean;
    function Equals(AMap: IPlatformStrMap): Boolean;
    function GetValue(const Key: String): TObject;
    function IsEmpty: Boolean;
    function KeySet: IPlatformStrSet;
    procedure PutAll(AMap: IPlatformStrMap);
    procedure PutValue(const Key: String; Value: TObject);
    function Remove(const Key: String): TObject;
    function Size: Integer;
    function Values: IPlatformCollection;
    function GetBucketByKey(const Key: String): PStrBucket;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACaseSensitive: Boolean; ACapacity: Integer = 16;
      AOwnsObjects: Boolean = True);
    destructor Destroy; override;
    property MapValues[const Index: String]: TObject Read GetValue Write PutValue;
      default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PStrBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TStrStrPlatformHashMap = class(TInterfacedObject, IPlatformStrStrMap,
    IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TStrStrBucketArray;
    FStrCompareProc:
    function(const S1, S2: String): Boolean;
    FStrHashProc:
    function(const Key: String; Capacity: Integer): Integer;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function GetBucket(Index: Integer): PStrStrBucket;
    function GetBucketCount: Integer;
    function GetCaseSensitivity: Boolean;
  public
    { IPlatformStrStrMap }
    procedure Clear;
    function ContainsKey(const Key: String): Boolean;
    function ContainsValue(const Value: String): Boolean;
    function Equals(AMap: IPlatformStrStrMap): Boolean;
    function GetValue(const Key: String): String;
    function IsEmpty: Boolean;
    function KeySet: IPlatformStrSet;
    procedure PutAll(AMap: IPlatformStrStrMap);
    procedure PutValue(const Key, Value: String);
    function Remove(const Key: String): String;
    function Size: Integer;
    function Values: IPlatformStrCollection;
    function GetBucketByKey(const Key: String): PStrStrBucket;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACaseSensitive: Boolean; ACapacity: Integer = 16);
    destructor Destroy; override;
    property MapValues[const Index: String]: String Read GetValue Write PutValue;
      default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PStrStrBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TStrIntPlatformHashMap = class(TInterfacedObject, IPlatformStrIntMap,
    IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TStrIntBucketArray;
    FStrCompareProc:
    function(const S1, S2: String): Boolean;
    FStrHashProc:
    function(const Key: String; Capacity: Integer): Integer;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function GetBucket(Index: Integer): PStrIntBucket;
    function GetBucketCount: Integer;
    function GetCaseSensitivity: Boolean;
  public
    { IPlatformStrIntMap }
    procedure Clear;
    function ContainsKey(const Key: String): Boolean;
    function ContainsValue(Value: Integer): Boolean;
    function Equals(AMap: IPlatformStrIntMap): Boolean;
    function GetValue(const Key: String): Integer;
    function IsEmpty: Boolean;
    function KeySet: IPlatformStrSet;
    procedure PutAll(AMap: IPlatformStrIntMap);
    procedure PutValue(const Key: String; Value: Integer);
    function Remove(const Key: String): Integer;
    function Size: Integer;
    function Values: IPlatformIntCollection;
    function GetBucketByKey(const Key: String): PStrIntBucket;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACaseSensitive: Boolean; ACapacity: Integer = 16);
    destructor Destroy; override;
    property MapValues[const Index: String]: Integer Read GetValue Write PutValue;
      default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PStrIntBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TStrPtrPlatformHashMap = class(TInterfacedObject, IPlatformStrPtrMap,
    IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TStrPtrBucketArray;
    FStrCompareProc:
    function(const S1, S2: String): Boolean;
    FStrHashProc:
    function(const Key: String; Capacity: Integer): Integer;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function GetBucket(Index: Integer): PStrPtrBucket;
    function GetBucketCount: Integer;
    function GetCaseSensitivity: Boolean;
  public
    { IPlatformStrPtrMap }
    procedure Clear;
    function ContainsKey(const Key: String): Boolean;
    function ContainsValue(Value: Pointer): Boolean;
    function Equals(AMap: IPlatformStrPtrMap): Boolean;
    function GetValue(const Key: String): Pointer;
    function IsEmpty: Boolean;
    function KeySet: IPlatformStrSet;
    procedure PutAll(AMap: IPlatformStrPtrMap);
    procedure PutValue(const Key: String; Value: Pointer);
    function Remove(const Key: String): Pointer;
    function Size: Integer;
    function Values: IPlatformPtrCollection;
    function GetBucketByKey(const Key: String): PStrPtrBucket;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACaseSensitive: Boolean; ACapacity: Integer = 16);
    destructor Destroy; override;
    property MapValues[const Index: String]: Pointer Read GetValue Write PutValue;
      default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PStrPtrBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TIntPlatformHashMap = class(TInterfacedObject, IPlatformIntMap, IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TIntBucketArray;
    FOwnsObjects: Boolean;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function FreeObject(AObject: TObject): Boolean;
    function GetBucket(Index: Integer): PIntBucket;
    function GetBucketCount: Integer;
  public
    { IPlatformIntMap }
    procedure Clear;
    function ContainsKey(Key: Integer): Boolean;
    function ContainsValue(Value: TObject): Boolean;
    function Equals(AMap: IPlatformIntMap): Boolean;
    function GetValue(Key: Integer): TObject;
    function IsEmpty: Boolean;
    function KeySet: IPlatformIntSet;
    procedure PutAll(AMap: IPlatformIntMap);
    procedure PutValue(Key: Integer; Value: TObject);
    function Remove(Key: Integer): TObject;
    function Size: Integer;
    function Values: IPlatformCollection;
    function GetBucketByKey(Key: Integer): PIntBucket;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACapacity: Integer = 16; AOwnsObjects: Boolean = True);
    destructor Destroy; override;
    property MapValues[Index: Integer]: TObject Read GetValue Write PutValue; default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PIntBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TIntIntPlatformHashMap = class(TInterfacedObject, IPlatformIntIntMap,
    IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TIntIntBucketArray;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function GetBucket(Index: Integer): PIntIntBucket;
    function GetBucketCount: Integer;
  public
    { IPlatformIntIntMap }
    procedure Clear;
    function ContainsKey(Key: Integer): Boolean;
    function ContainsValue(Value: Integer): Boolean;
    function Equals(AMap: IPlatformIntIntMap): Boolean;
    function GetValue(Key: Integer): Integer;
    function IsEmpty: Boolean;
    function KeySet: IPlatformIntSet;
    procedure PutAll(AMap: IPlatformIntIntMap);
    procedure PutValue(Key, Value: Integer);
    function Remove(Key: Integer): Integer;
    function Size: Integer;
    function Values: IPlatformIntCollection;
    function GetBucketByKey(Key: Integer): PIntIntBucket;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACapacity: Integer = 16);
    destructor Destroy; override;
    property MapValues[Index: Integer]: Integer Read GetValue Write PutValue; default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PIntIntBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TIntPtrPlatformHashMap = class(TInterfacedObject, IPlatformIntPtrMap,
    IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TIntPtrBucketArray;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function GetBucket(Index: Integer): PIntPtrBucket;
    function GetBucketCount: Integer;
  public
    { IPlatformIntPtrMap }
    procedure Clear;
    function ContainsKey(Key: Integer): Boolean;
    function ContainsValue(Value: Pointer): Boolean;
    function Equals(AMap: IPlatformIntPtrMap): Boolean;
    function GetValue(Key: Integer): Pointer;
    function IsEmpty: Boolean;
    function KeySet: IPlatformIntSet;
    procedure PutAll(AMap: IPlatformIntPtrMap);
    procedure PutValue(Key: Integer; Value: Pointer);
    function Remove(Key: Integer): Pointer;
    function Size: Integer;
    function Values: IPlatformPtrCollection;
    function GetBucketByKey(Key: Integer): PIntPtrBucket;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACapacity: Integer = 16);
    destructor Destroy; override;
    property MapValues[Index: Integer]: Pointer Read GetValue Write PutValue; default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PIntPtrBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TPtrPtrPlatformHashMap = class(TInterfacedObject, IPlatformPtrPtrMap,
    IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TPtrPtrBucketArray;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function GetBucket(Index: Integer): PPtrPtrBucket;
    function GetBucketCount: Integer;
  public
    { IMap }
    procedure Clear;
    function ContainsKey(Key: Pointer): Boolean;
    function ContainsValue(Value: Pointer): Boolean;
    function Equals(AMap: IPlatformPtrPtrMap): Boolean;
    function GetValue(Key: Pointer): Pointer;
    function IsEmpty: Boolean;
    function KeySet: IPlatformPtrSet;
    procedure PutAll(AMap: IPlatformPtrPtrMap);
    procedure PutValue(Key, Value: Pointer);
    function Remove(Key: Pointer): Pointer;
    function Size: Integer;
    function Values: IPlatformPtrCollection;
    function GetBucketByKey(Key: Pointer): PPtrPtrBucket;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACapacity: Integer = 16);
    destructor Destroy; override;
    property MapValues[Index: Pointer]: Pointer Read GetValue Write PutValue; default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PPtrPtrBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

  TPlatformHashMap = class(TInterfacedObject, IPlatformMap, IPlatformCloneable)
  private
    FCapacity: Integer;
    FCount: Integer;
    FBuckets: TBucketArray;
    FOwnsObjects: Boolean;
  protected
    procedure GrowEntries(BucketIndex: Integer);
    function FreeObject(AObject: TObject): Boolean;
    function GetBucket(Index: Integer): PBucket;
    function GetBucketCount: Integer;
  public
    { IPlatformMap }
    procedure Clear;
    function ContainsKey(Key: TObject): Boolean;
    function ContainsValue(Value: TObject): Boolean;
    function Equals(AMap: IPlatformMap): Boolean;
    function GetValue(Key: TObject): TObject;
    function IsEmpty: Boolean;
    function KeySet: IPlatformSet;
    procedure PutAll(AMap: IPlatformMap);
    procedure PutValue(Key, Value: TObject);
    function Remove(Key: TObject): TObject;
    function Size: Integer;
    function Values: IPlatformCollection;
    function GetBucketByKey(Key: TObject): PBucket;
  public
    { ICloneable }
    function Clone: TObject;
  public
    constructor Create(ACapacity: Integer = 16; AOwnsObjects: Boolean = True);
    destructor Destroy; override;
    property MapValues[Index: TObject]: TObject Read GetValue Write PutValue; default;
    property Capacity: Integer Read FCapacity;
    property Buckets[Index: Integer]: PBucket Read GetBucket;
    property BucketCount: Integer Read GetBucketCount;
  end;

implementation

uses
  Miscelaneous;

{$IFOPT R+}
  {$DEFINE RANGE_CHECKS_ENABLED}
  {$R-}
{$ENDIF}

function HashFNV(Key: Integer; Limit: Integer): Integer;
const
  FNV_PRIME = 16777619;
  FNV_BASE_OFFSET = 2166136261;
var
  KeyRec: TLongwordRec absolute Key;
begin
  { Lazy mod mapping method used - we don't care about 0.0002375% bias with large numbers }
  Result := Integer(FNV_BASE_OFFSET);
  Result := Result xor KeyRec.Bytes[0];
  Result := Result * FNV_PRIME;
  Result := Result xor KeyRec.Bytes[1];
  Result := Result * FNV_PRIME;
  Result := Result xor KeyRec.Bytes[2];
  Result := Result * FNV_PRIME;
  Result := Result xor KeyRec.Bytes[3];
  Result := Result * FNV_PRIME;
  if Result < 0 then Result := not Result;
  Result := Result mod Limit;
end;

function HashStringFast(const Key: String; Limit: Integer): Integer;
var
  iInt: Integer;
begin
  Result := 0;
  if Key = '' then Exit;
  for iInt := 1 to Length(Key) do
  begin
    Result := Ord(Key[iInt]) + (Result shl 6) + (Result shl 16) - Result;
  end;
  Result := HashFNV(Result, Limit);
end;

function HashStringFastNoCase(const Key: String; Limit: Integer): Integer;
var
  iInt: Integer;
  bC: Byte;
begin
  Result := 0;
  if Key = '' then Exit;
  for iInt := 1 to Length(Key) do
  begin
    bC := Ord(Key[iInt]);
    if bC in [Ord('A')..Ord('Z')] then Inc(bC, 32);
    Result := bC + (Result shl 6) + (Result shl 16) - Result;
  end;
  Result := HashFNV(Result, Limit);
end;


{$IFDEF RANGE_CHECKS_ENABLED}
  {$R+}
  {$UNDEF RANGE_CHECKS_ENABLED}
{$ENDIF}

{ TStrPlatformHashMap }

procedure TStrPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := '';
      FreeObject(FBuckets[I].Entries[J].Value);
    end;
    FBuckets[I].Count := 0;
  end;
  FCount := 0;
end;

function TStrPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TStrEntryArray;
  NewMap: TStrPlatformHashMap;
begin
  NewMap := TStrPlatformHashMap.Create(CaseSensitive, FCapacity, False);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TStrPlatformHashMap.ContainsKey(const Key: String): Boolean;
var
  I: Integer;
  Bucket: PStrBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TStrPlatformHashMap.ContainsValue(Value: TObject): Boolean;
var
  I, J: Integer;
  Bucket: PStrBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TStrPlatformHashMap.Create(ACaseSensitive: Boolean;
  ACapacity: Integer = 16; AOwnsObjects: Boolean = True);
begin
  inherited Create;
  if ACaseSensitive then
  begin
    FStrCompareProc := StringsEqual;
    FStrHashProc := HashStringFast;
  end else
  begin
    FStrCompareProc := StringsEqualNoCase;
    FStrHashProc := HashStringFastNoCase;
  end;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  FOwnsObjects := AOwnsObjects;
  SetLength(FBuckets, FCapacity);
end;

destructor TStrPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TStrPlatformHashMap.Equals(AMap: IPlatformStrMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TStrPlatformHashMap.GetValue(const Key: String): TObject;
var
  I: Integer;
  Bucket: PStrBucket;
begin
  Result := nil;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  I := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[I];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

function TStrPlatformHashMap.FreeObject(AObject: TObject): Boolean;
begin
  Result := FOwnsObjects;
  if Result then AObject.Free;
end;

procedure TStrPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TStrPlatformHashMap.GetBucket(Index: Integer): PStrBucket;
begin
  Result := @FBuckets[Index];
end;

function TStrPlatformHashMap.GetBucketByKey(const Key: String): PStrBucket;
begin
  Result := @FBuckets[FStrHashProc(Key, FCapacity)];
end;

function TStrPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TStrPlatformHashMap.GetCaseSensitivity: Boolean;
begin
  Result := @FStrCompareProc = @StringsEqual;
end;

function TStrPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TStrPlatformHashMap.KeySet: IPlatformStrSet;
var
  I, J: Integer;
begin
  Result := TStrPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TStrPlatformHashMap.PutAll(AMap: IPlatformStrMap);
var
  It: IPlatformStrIterator;
  Key: String;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TStrPlatformHashMap.PutValue(const Key: String; Value: TObject);
var
  Index: Integer;
  Bucket: PStrBucket;
  I: Integer;
begin
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  if Value = nil then Exit;
  {$ENDIF}
  Index := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  Bucket.Entries[Bucket.Count].Key := Key;
  Bucket.Entries[Bucket.Count].Value := Value;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TStrPlatformHashMap.Remove(const Key: String): TObject;
var
  Bucket: PStrBucket;
  I: Integer;
begin
  Result := nil;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      if not FreeObject(Bucket.Entries[I].Value) then
      begin
        Result := Bucket.Entries[I].Value;
        Bucket.Entries[I].Value := nil;
      end;
      Bucket.Entries[I].Key := '';
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TStrPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TStrPlatformHashMap.Values: IPlatformCollection;
var
  I, J: Integer;
begin
  Result := TPlatformArrayList.Create(FCapacity, False);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TStrStrPlatformHashMap }

procedure TStrStrPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := '';
      FBuckets[I].Entries[J].Value := '';
    end;
    FBuckets[I].Count := 0;
  end;
  FCount := 0;
end;

function TStrStrPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TStrStrEntryArray;
  NewMap: TStrStrPlatformHashMap;
begin
  NewMap := TStrStrPlatformHashMap.Create(CaseSensitive, FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TStrStrPlatformHashMap.ContainsKey(const Key: String): Boolean;
var
  I: Integer;
  Bucket: PStrStrBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if StringsEqual(Bucket.Entries[I].Key, Key) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TStrStrPlatformHashMap.ContainsValue(const Value: String): Boolean;
var
  I, J: Integer;
  Bucket: PStrStrBucket;
begin
  Result := False;
  if Value = '' then Exit;
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if StringsEqual(Bucket.Entries[I].Value, Value) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TStrStrPlatformHashMap.Create(ACaseSensitive: Boolean;
  ACapacity: Integer = 16);
begin
  inherited Create;
  if ACaseSensitive then
  begin
    FStrCompareProc := StringsEqual;
    FStrHashProc := HashStringFast;
  end else
  begin
    FStrCompareProc := StringsEqualNoCase;
    FStrHashProc := HashStringFastNoCase;
  end;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  SetLength(FBuckets, FCapacity);
end;

destructor TStrStrPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TStrStrPlatformHashMap.Equals(AMap: IPlatformStrStrMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not FStrCompareProc(AMap.GetValue(FBuckets[I].Entries[J].Key),
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TStrStrPlatformHashMap.GetValue(const Key: String): String;
var
  I: Integer;
  Bucket: PStrStrBucket;
begin
  Result := '';
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  I := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[I];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TStrStrPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TStrStrPlatformHashMap.GetBucket(Index: Integer): PStrStrBucket;
begin
  Result := @FBuckets[Index];
end;

function TStrStrPlatformHashMap.GetBucketByKey(const Key: String): PStrStrBucket;
begin
  Result := @FBuckets[FStrHashProc(Key, FCapacity)];
end;

function TStrStrPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TStrStrPlatformHashMap.GetCaseSensitivity: Boolean;
begin
  Result := @FStrCompareProc = @StringsEqual;
end;

function TStrStrPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TStrStrPlatformHashMap.KeySet: IPlatformStrSet;
var
  I, J: Integer;
begin
  Result := TStrPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TStrStrPlatformHashMap.PutAll(AMap: IPlatformStrStrMap);
var
  It: IPlatformStrIterator;
  Key: String;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TStrStrPlatformHashMap.PutValue(const Key, Value: String);
var
  Index: Integer;
  Bucket: PStrStrBucket;
  I: Integer;
begin
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  if Value = '' then Exit;
  {$ENDIF}
  Index := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  Bucket.Entries[Bucket.Count].Key := Key;
  Bucket.Entries[Bucket.Count].Value := Value;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TStrStrPlatformHashMap.Remove(const Key: String): String;
var
  Bucket: PStrStrBucket;
  I: Integer;
begin
  Result := '';
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Bucket.Entries[I].Key := '';
      Bucket.Entries[I].Value := '';
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TStrStrPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TStrStrPlatformHashMap.Values: IPlatformStrCollection;
var
  I, J: Integer;
begin
  Result := TStrPlatformArrayList.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TStrIntPlatformHashMap }

procedure TStrIntPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := '';
      FBuckets[I].Entries[J].Value := 0;
    end;
    FBuckets[I].Count := 0;
  end;
  FCount := 0;
end;

function TStrIntPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TStrIntEntryArray;
  NewMap: TStrIntPlatformHashMap;
begin
  NewMap := TStrIntPlatformHashMap.Create(CaseSensitive, FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TStrIntPlatformHashMap.ContainsKey(const Key: String): Boolean;
var
  I: Integer;
  Bucket: PStrIntBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TStrIntPlatformHashMap.ContainsValue(Value: Integer): Boolean;
var
  I, J: Integer;
  Bucket: PStrIntBucket;
begin
  Result := False;
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TStrIntPlatformHashMap.Create(ACaseSensitive: Boolean;
  ACapacity: Integer = 16);
begin
  inherited Create;
  if ACaseSensitive then
  begin
    FStrCompareProc := StringsEqual;
    FStrHashProc := HashStringFast;
  end else
  begin
    FStrCompareProc := StringsEqualNoCase;
    FStrHashProc := HashStringFastNoCase;
  end;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  SetLength(FBuckets, FCapacity);
end;

destructor TStrIntPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TStrIntPlatformHashMap.Equals(AMap: IPlatformStrIntMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TStrIntPlatformHashMap.GetValue(const Key: String): Integer;
var
  I: Integer;
  Bucket: PStrIntBucket;
begin
  Result := 0;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  I := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[I];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TStrIntPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TStrIntPlatformHashMap.GetBucket(Index: Integer): PStrIntBucket;
begin
  Result := @FBuckets[Index];
end;

function TStrIntPlatformHashMap.GetBucketByKey(const Key: String): PStrIntBucket;
begin
  Result := @FBuckets[FStrHashProc(Key, FCapacity)];
end;

function TStrIntPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TStrIntPlatformHashMap.GetCaseSensitivity: Boolean;
begin
  Result := @FStrCompareProc = @StringsEqual;
end;

function TStrIntPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TStrIntPlatformHashMap.KeySet: IPlatformStrSet;
var
  I, J: Integer;
begin
  Result := TStrPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TStrIntPlatformHashMap.PutAll(AMap: IPlatformStrIntMap);
var
  It: IPlatformStrIterator;
  Key: String;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TStrIntPlatformHashMap.PutValue(const Key: String; Value: Integer);
var
  Index: Integer;
  Bucket: PStrIntBucket;
  I: Integer;
begin
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Index := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  Bucket.Entries[Bucket.Count].Key := Key;
  Bucket.Entries[Bucket.Count].Value := Value;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TStrIntPlatformHashMap.Remove(const Key: String): Integer;
var
  Bucket: PStrIntBucket;
  I: Integer;
begin
  Result := 0;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Bucket.Entries[I].Key := '';
      Bucket.Entries[I].Value := 0;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TStrIntPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TStrIntPlatformHashMap.Values: IPlatformIntCollection;
var
  I, J: Integer;
begin
  Result := TIntPlatformArrayList.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TStrPtrPlatformHashMap }

procedure TStrPtrPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := '';
      FBuckets[I].Entries[J].Value := nil;
    end;
    FBuckets[I].Count := 0;
  end;
  FCount := 0;
end;

function TStrPtrPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TStrPtrEntryArray;
  NewMap: TStrPtrPlatformHashMap;
begin
  NewMap := TStrPtrPlatformHashMap.Create(CaseSensitive, FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TStrPtrPlatformHashMap.ContainsKey(const Key: String): Boolean;
var
  I: Integer;
  Bucket: PStrPtrBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TStrPtrPlatformHashMap.ContainsValue(Value: Pointer): Boolean;
var
  I, J: Integer;
  Bucket: PStrPtrBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TStrPtrPlatformHashMap.Create(ACaseSensitive: Boolean;
  ACapacity: Integer = 16);
begin
  inherited Create;
  if ACaseSensitive then
  begin
    FStrCompareProc := StringsEqual;
    FStrHashProc := HashStringFast;
  end else
  begin
    FStrCompareProc := StringsEqualNoCase;
    FStrHashProc := HashStringFastNoCase;
  end;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  SetLength(FBuckets, FCapacity);
end;

destructor TStrPtrPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TStrPtrPlatformHashMap.Equals(AMap: IPlatformStrPtrMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TStrPtrPlatformHashMap.GetValue(const Key: String): Pointer;
var
  I: Integer;
  Bucket: PStrPtrBucket;
begin
  Result := nil;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  I := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[I];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TStrPtrPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TStrPtrPlatformHashMap.GetBucket(Index: Integer): PStrPtrBucket;
begin
  Result := @FBuckets[Index];
end;

function TStrPtrPlatformHashMap.GetBucketByKey(const Key: String): PStrPtrBucket;
begin
  Result := @FBuckets[FStrHashProc(Key, FCapacity)];
end;

function TStrPtrPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TStrPtrPlatformHashMap.GetCaseSensitivity: Boolean;
begin
  Result := @FStrCompareProc = @StringsEqual;
end;

function TStrPtrPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TStrPtrPlatformHashMap.KeySet: IPlatformStrSet;
var
  I, J: Integer;
begin
  Result := TStrPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TStrPtrPlatformHashMap.PutAll(AMap: IPlatformStrPtrMap);
var
  It: IPlatformStrIterator;
  Key: String;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TStrPtrPlatformHashMap.PutValue(const Key: String; Value: Pointer);
var
  Index: Integer;
  Bucket: PStrPtrBucket;
  I: Integer;
begin
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  if Value = nil then Exit;
  {$ENDIF}
  Index := FStrHashProc(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  Bucket.Entries[Bucket.Count].Key := Key;
  Bucket.Entries[Bucket.Count].Value := Value;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TStrPtrPlatformHashMap.Remove(const Key: String): Pointer;
var
  Bucket: PStrPtrBucket;
  I: Integer;
begin
  Result := nil;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Key = '' then Exit;
  {$ENDIF}
  Bucket := @FBuckets[FStrHashProc(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if FStrCompareProc(Bucket.Entries[I].Key, Key) then
    begin
      Result := Bucket.Entries[I].Value;
      Bucket.Entries[I].Key := '';
      Bucket.Entries[I].Value := nil;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TStrPtrPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TStrPtrPlatformHashMap.Values: IPlatformPtrCollection;
var
  I, J: Integer;
begin
  Result := TPtrPlatformArrayList.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TIntPlatformHashMap }

procedure TIntPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := 0;
      FreeObject(FBuckets[I].Entries[J].Value);
    end;
    FBuckets[I].Count := 0;
  end;
  FCount := 0;
end;

function TIntPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TIntEntryArray;
  NewMap: TIntPlatformHashMap;
begin
  NewMap := TIntPlatformHashMap.Create(FCapacity, False);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TIntPlatformHashMap.ContainsKey(Key: Integer): Boolean;
var
  I: Integer;
  Bucket: PIntBucket;
begin
  Result := False;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TIntPlatformHashMap.ContainsValue(Value: TObject): Boolean;
var
  I, J: Integer;
  Bucket: PIntBucket;
begin
  Result := False;
  if Value = nil then Exit;
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TIntPlatformHashMap.Create(ACapacity: Integer = 16;
  AOwnsObjects: Boolean = True);
begin
  inherited Create;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  FOwnsObjects := AOwnsObjects;
  SetLength(FBuckets, FCapacity);
end;

destructor TIntPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TIntPlatformHashMap.Equals(AMap: IPlatformIntMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TIntPlatformHashMap.GetValue(Key: Integer): TObject;
var
  I: Integer;
  Bucket: PIntBucket;
begin
  Result := nil;
  I := HashFNV(Key, FCapacity);
  Bucket := @FBuckets[I];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

function TIntPlatformHashMap.FreeObject(AObject: TObject): Boolean;
begin
  Result := FOwnsObjects;
  if Result then AObject.Free;
end;

procedure TIntPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TIntPlatformHashMap.GetBucket(Index: Integer): PIntBucket;
begin
  Result := @FBuckets[Index];
end;

function TIntPlatformHashMap.GetBucketByKey(Key: Integer): PIntBucket;
begin
  Result := @FBuckets[HashFNV(Key, FCapacity)];
end;

function TIntPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TIntPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TIntPlatformHashMap.KeySet: IPlatformIntSet;
var
  I, J: Integer;
begin
  Result := TIntPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TIntPlatformHashMap.PutAll(AMap: IPlatformIntMap);
var
  It: IPlatformIntIterator;
  Key: Integer;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TIntPlatformHashMap.PutValue(Key: Integer; Value: TObject);
var
  Index: Integer;
  Bucket: PIntBucket;
  I: Integer;
begin
  if Value = nil then Exit;
  Index := HashFNV(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  Bucket.Entries[Bucket.Count].Key := Key;
  Bucket.Entries[Bucket.Count].Value := Value;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TIntPlatformHashMap.Remove(Key: Integer): TObject;
var
  Bucket: PIntBucket;
  I: Integer;
begin
  Result := nil;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      if not FreeObject(Bucket.Entries[I].Value) then
      begin
        Result := Bucket.Entries[I].Value;
        Bucket.Entries[I].Value := nil;
      end;
      Bucket.Entries[I].Key := 0;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TIntPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TIntPlatformHashMap.Values: IPlatformCollection;
var
  I, J: Integer;
begin
  Result := TPlatformArrayList.Create(FCapacity, False);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TIntIntPlatformHashMap }

procedure TIntIntPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := 0;
    end;
    FBuckets[I].Count := 0;
  end;
  FCount := 0;
end;

function TIntIntPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TIntIntEntryArray;
  NewMap: TIntIntPlatformHashMap;
begin
  NewMap := TIntIntPlatformHashMap.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TIntIntPlatformHashMap.ContainsKey(Key: Integer): Boolean;
var
  I: Integer;
  Bucket: PIntIntBucket;
begin
  Result := False;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TIntIntPlatformHashMap.ContainsValue(Value: Integer): Boolean;
var
  I, J: Integer;
  Bucket: PIntIntBucket;
begin
  Result := False;
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TIntIntPlatformHashMap.Create(ACapacity: Integer = 16);
begin
  inherited Create;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  SetLength(FBuckets, FCapacity);
end;

destructor TIntIntPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TIntIntPlatformHashMap.Equals(AMap: IPlatformIntIntMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TIntIntPlatformHashMap.GetValue(Key: Integer): Integer;
var
  I: Integer;
  Bucket: PIntIntBucket;
begin
  Result := 0;
  I := HashFNV(Key, FCapacity);
  Bucket := @FBuckets[I];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TIntIntPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TIntIntPlatformHashMap.GetBucket(Index: Integer): PIntIntBucket;
begin
  Result := @FBuckets[Index];
end;

function TIntIntPlatformHashMap.GetBucketByKey(Key: Integer): PIntIntBucket;
begin
  Result := @FBuckets[HashFNV(Key, FCapacity)];
end;

function TIntIntPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TIntIntPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TIntIntPlatformHashMap.KeySet: IPlatformIntSet;
var
  I, J: Integer;
begin
  Result := TIntPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TIntIntPlatformHashMap.PutAll(AMap: IPlatformIntIntMap);
var
  It: IPlatformIntIterator;
  Key: Integer;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TIntIntPlatformHashMap.PutValue(Key, Value: Integer);
var
  Index: Integer;
  Bucket: PIntIntBucket;
  I: Integer;
begin
  Index := HashFNV(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  Bucket.Entries[Bucket.Count].Key := Key;
  Bucket.Entries[Bucket.Count].Value := Value;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TIntIntPlatformHashMap.Remove(Key: Integer): Integer;
var
  Bucket: PIntIntBucket;
  I: Integer;
begin
  Result := 0;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Bucket.Entries[I].Key := 0;
      Bucket.Entries[I].Value := 0;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TIntIntPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TIntIntPlatformHashMap.Values: IPlatformIntCollection;
var
  I, J: Integer;
begin
  Result := TIntPlatformArrayList.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TIntPtrPlatformHashMap }

procedure TIntPtrPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    FBuckets[I].Count := 0;
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := 0;
    end;
  end;
  FCount := 0;
end;

function TIntPtrPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TIntPtrEntryArray;
  NewMap: TIntPtrPlatformHashMap;
begin
  NewMap := TIntPtrPlatformHashMap.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TIntPtrPlatformHashMap.ContainsKey(Key: Integer): Boolean;
var
  I: Integer;
  Bucket: PIntPtrBucket;
begin
  Result := False;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TIntPtrPlatformHashMap.ContainsValue(Value: Pointer): Boolean;
var
  I, J: Integer;
  Bucket: PBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TIntPtrPlatformHashMap.Create(ACapacity: Integer = 16);
begin
  inherited Create;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  SetLength(FBuckets, FCapacity);
end;

destructor TIntPtrPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TIntPtrPlatformHashMap.Equals(AMap: IPlatformIntPtrMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TIntPtrPlatformHashMap.GetValue(Key: Integer): Pointer;
var
  I: Integer;
  Bucket: PIntPtrBucket;
begin
  Result := nil;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TIntPtrPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TIntPtrPlatformHashMap.GetBucket(Index: Integer): PIntPtrBucket;
begin
  Result := @FBuckets[Index];
end;

function TIntPtrPlatformHashMap.GetBucketByKey(Key: Integer): PIntPtrBucket;
begin
  Result := @FBuckets[HashFNV(Key, FCapacity)];
end;

function TIntPtrPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TIntPtrPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TIntPtrPlatformHashMap.KeySet: IPlatformIntSet;
var
  I, J: Integer;
begin
  Result := TIntPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TIntPtrPlatformHashMap.PutAll(AMap: IPlatformIntPtrMap);
var
  It: IPlatformIntIterator;
  Key: Integer;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TIntPtrPlatformHashMap.PutValue(Key: Integer; Value: Pointer);
var
  Index: Integer;
  Bucket: PIntPtrBucket;
  I: Integer;
begin
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  Index := HashFNV(Key, FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  begin
    Bucket.Entries[Bucket.Count].Key := Key;
    Bucket.Entries[Bucket.Count].Value := Value;
  end;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TIntPtrPlatformHashMap.Remove(Key: Integer): Pointer;
var
  Bucket: PIntPtrBucket;
  I: Integer;
begin
  Result := nil;
  Bucket := @FBuckets[HashFNV(Key, FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Bucket.Entries[I].Key := 0;
      Bucket.Entries[I].Value := nil;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TIntPtrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TIntPtrPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TIntPtrPlatformHashMap.Values: IPlatformPtrCollection;
var
  I, J: Integer;
begin
  Result := TPtrPlatformArrayList.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TPtrPtrPlatformHashMap }

procedure TPtrPtrPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    FBuckets[I].Count := 0;
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := nil;
    end;
  end;
  FCount := 0;
end;

function TPtrPtrPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TPtrPtrEntryArray;
  NewMap: TPtrPtrPlatformHashMap;
begin
  NewMap := TPtrPtrPlatformHashMap.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TPtrPtrPlatformHashMap.ContainsKey(Key: Pointer): Boolean;
var
  I: Integer;
  Bucket: PBucket;
begin
  Result := False;
  if Key = nil then Exit;
  Bucket := @FBuckets[HashFNV(Integer(Key), FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TPtrPtrPlatformHashMap.ContainsValue(Value: Pointer): Boolean;
var
  I, J: Integer;
  Bucket: PBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TPtrPtrPlatformHashMap.Create(ACapacity: Integer = 16);
begin
  inherited Create;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  SetLength(FBuckets, FCapacity);
end;

destructor TPtrPtrPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TPtrPtrPlatformHashMap.Equals(AMap: IPlatformPtrPtrMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TPtrPtrPlatformHashMap.GetValue(Key: Pointer): Pointer;
var
  I: Integer;
  Bucket: PPtrPtrBucket;
begin
  Result := nil;
  if Key = nil then Exit;
  Bucket := @FBuckets[HashFNV(Integer(Key), FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TPtrPtrPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TPtrPtrPlatformHashMap.GetBucket(Index: Integer): PPtrPtrBucket;
begin
  Result := @FBuckets[Index];
end;

function TPtrPtrPlatformHashMap.GetBucketByKey(Key: Pointer): PPtrPtrBucket;
begin
  Result := @FBuckets[HashFNV(Integer(Key), FCapacity)];
end;

function TPtrPtrPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TPtrPtrPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TPtrPtrPlatformHashMap.KeySet: IPlatformPtrSet;
var
  I, J: Integer;
begin
  Result := TPtrPlatformArraySet.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TPtrPtrPlatformHashMap.PutAll(AMap: IPlatformPtrPtrMap);
var
  It: IPlatformPtrIterator;
  Key: Pointer;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TPtrPtrPlatformHashMap.PutValue(Key, Value: Pointer);
var
  Index: Integer;
  Bucket: PPtrPtrBucket;
  I: Integer;
begin
  if Key = nil then Exit;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  Index := HashFNV(Integer(Key), FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  begin
    Bucket.Entries[Bucket.Count].Key := Key;
    Bucket.Entries[Bucket.Count].Value := Value;
  end;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TPtrPtrPlatformHashMap.Remove(Key: Pointer): Pointer;
var
  Bucket: PPtrPtrBucket;
  I: Integer;
begin
  Result := nil;
  if Key = nil then Exit;
  Bucket := @FBuckets[HashFNV(Integer(Key), FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Bucket.Entries[I].Key := nil;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TPtrPtrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TPtrPtrPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TPtrPtrPlatformHashMap.Values: IPlatformPtrCollection;
var
  I, J: Integer;
begin
  Result := TPtrPlatformArrayList.Create(FCapacity);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

{ TPlatformHashMap }

procedure TPlatformHashMap.Clear;
var
  I, J: Integer;
begin
  for I := 0 to FCapacity - 1 do
  begin
    FBuckets[I].Count := 0;
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      FBuckets[I].Entries[J].Key := nil;
      FreeObject(FBuckets[I].Entries[J].Value);
    end;
  end;
  FCount := 0;
end;

function TPlatformHashMap.Clone: TObject;
var
  I, J: Integer;
  NewEntryArray: TEntryArray;
  NewMap: TPlatformHashMap;
begin
  NewMap := TPlatformHashMap.Create(FCapacity, FOwnsObjects);
  for I := 0 to FCapacity - 1 do
  begin
    NewEntryArray := NewMap.FBuckets[I].Entries;
    SetLength(NewEntryArray, Length(FBuckets[I].Entries));
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      NewEntryArray[J].Key := FBuckets[I].Entries[J].Key;
      NewEntryArray[J].Value := FBuckets[I].Entries[J].Value;
    end;
    NewMap.FBuckets[I].Count := FBuckets[I].Count;
  end;
  Result := NewMap;
end;

function TPlatformHashMap.ContainsKey(Key: TObject): Boolean;
var
  I: Integer;
  Bucket: PBucket;
begin
  Result := False;
  if Key = nil then Exit;
  Bucket := @FBuckets[HashFNV(Integer(Key), FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function TPlatformHashMap.ContainsValue(Value: TObject): Boolean;
var
  I, J: Integer;
  Bucket: PBucket;
begin
  Result := False;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  for J := 0 to FCapacity - 1 do
  begin
    Bucket := @FBuckets[J];
    for I := 0 to Bucket.Count - 1 do
    begin
      if Bucket.Entries[I].Value = Value then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

constructor TPlatformHashMap.Create(ACapacity: Integer = 16;
  AOwnsObjects: Boolean = True);
begin
  inherited Create;
  if ACapacity > 0 then
  begin
    FCapacity := ACapacity;
  end;
  FOwnsObjects := AOwnsObjects;
  SetLength(FBuckets, FCapacity);
end;

destructor TPlatformHashMap.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TPlatformHashMap.Equals(AMap: IPlatformMap): Boolean;
var
  I, J: Integer;
begin
  Result := False;
  if AMap = nil then Exit;
  if FCount <> AMap.Size then Exit;
  Result := True;
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      if AMap.ContainsKey(FBuckets[I].Entries[J].Key) then
      begin
        if not (AMap.GetValue(FBuckets[I].Entries[J].Key) =
          FBuckets[I].Entries[J].Value) then
        begin
          Result := False;
          Exit;
        end;
      end else
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

function TPlatformHashMap.FreeObject(AObject: TObject): Boolean;
begin
  Result := FOwnsObjects;
  if Result then AObject.Free;
end;

function TPlatformHashMap.GetValue(Key: TObject): TObject;
var
  I: Integer;
  Bucket: PBucket;
begin
  Result := nil;
  if Key = nil then Exit;
  Bucket := @FBuckets[HashFNV(Integer(Key), FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Result := Bucket.Entries[I].Value;
      Exit;
    end;
  end;
end;

procedure TPlatformHashMap.GrowEntries(BucketIndex: Integer);
var
  Capacity: Integer;
begin
  Capacity := Length(FBuckets[BucketIndex].Entries);
  if Capacity > 64 then
  begin
    Inc(Capacity, Capacity shr 2);
  end else if Capacity > 0 then
  begin
    Capacity := Capacity shl 2;
  end else
  begin
    Capacity := 4;
  end;
  SetLength(FBuckets[BucketIndex].Entries, Capacity);
end;

function TPlatformHashMap.GetBucket(Index: Integer): PBucket;
begin
  Result := @FBuckets[Index];
end;

function TPlatformHashMap.GetBucketByKey(Key: TObject): PBucket;
begin
  Result := @FBuckets[HashFNV(Integer(Key), FCapacity)];
end;

function TPlatformHashMap.GetBucketCount: Integer;
begin
  Result := Length(FBuckets);
end;

function TPlatformHashMap.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TPlatformHashMap.KeySet: IPlatformSet;
var
  I, J: Integer;
begin
  Result := TPlatformArraySet.Create(FCapacity, False);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Key);
    end;
  end;
end;

procedure TPlatformHashMap.PutAll(AMap: IPlatformMap);
var
  It: IPlatformIterator;
  Key: TObject;
begin
  if AMap = nil then Exit;
  It := AMap.KeySet.First;
  while It.HasNext do
  begin
    Key := It.Next;
    PutValue(Key, AMap.GetValue(Key));
  end;
end;

procedure TPlatformHashMap.PutValue(Key, Value: TObject);
var
  Index: Integer;
  Bucket: PBucket;
  I: Integer;
begin
  if Key = nil then Exit;
  {$IFNDEF ALLOW_NIL_PARAMS}
  if Value = nil then Exit;
  {$ENDIF}
  Index := HashFNV(Integer(Key), FCapacity);
  Bucket := @FBuckets[Index];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      Bucket.Entries[I].Value := Value;
      Exit;
    end;
  end;
  if Bucket.Count = Length(Bucket.Entries) then GrowEntries(Index);
  begin
    Bucket.Entries[Bucket.Count].Key := Key;
    Bucket.Entries[Bucket.Count].Value := Value;
  end;
  Inc(Bucket.Count);
  Inc(FCount);
end;

function TPlatformHashMap.Remove(Key: TObject): TObject;
var
  Bucket: PBucket;
  I: Integer;
begin
  Result := nil;
  if Key = nil then Exit;
  Bucket := @FBuckets[HashFNV(Integer(Key), FCapacity)];
  for I := 0 to Bucket.Count - 1 do
  begin
    if Bucket.Entries[I].Key = Key then
    begin
      if not FreeObject(Bucket.Entries[I].Value) then
      begin
        Result := Bucket.Entries[I].Value;
        Bucket.Entries[I].Value := nil;
      end;
      Bucket.Entries[I].Key := nil;
      if I < Bucket.Count - 1 then
      begin
        Move(Bucket.Entries[I + 1], Bucket.Entries[I], (Bucket.Count - I) *
          SizeOf(TStrEntry));
      end;
      Dec(Bucket.Count);
      Dec(FCount);
      Exit;
    end;
  end;
end;

function TPlatformHashMap.Size: Integer;
begin
  Result := FCount;
end;

function TPlatformHashMap.Values: IPlatformCollection;
var
  I, J: Integer;
begin
  Result := TPlatformArrayList.Create(FCapacity, False);
  for I := 0 to FCapacity - 1 do
  begin
    for J := 0 to FBuckets[I].Count - 1 do
    begin
      Result.Add(FBuckets[I].Entries[J].Value);
    end;
  end;
end;

end.
