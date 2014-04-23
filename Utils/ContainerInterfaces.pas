unit ContainerInterfaces;

interface

type
  IPlatformCloneable = interface(IInterface)
    ['{D224AE70-2C93-4998-9479-1D513D75F2B2}']
    function Clone: TObject;
  end;

  IPlatformStrIterator = interface(IInterface)
    ['{D5D4B681-F902-49C7-B9E1-73007C9D64F0}']
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
  end;

  IPlatformIntIterator = interface(IInterface)
    ['{2BD01251-33B2-4E88-81B1-3E918D0EDB1D}']
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
  end;

  IPlatformPtrIterator = interface(IInterface)
    ['{E4292B86-E4A7-4A22-B47C-8106204A6522}']
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
  end;

  IPlatformIterator = interface(IInterface)
    ['{997DF9B7-9AA2-4239-8B94-14DFFD26D790}']
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
  end;

  IPlatformStrCollection = interface(IInterface)
    ['{3E3CFC19-E8AF-4DD7-91FA-2DF2895FC7B9}']
    function Add(const AString: String): Boolean;
    function AddAll(ACollection: IPlatformStrCollection): Boolean;
    procedure Clear;
    function Contains(const AString: String): Boolean;
    function ContainsAll(ACollection: IPlatformStrCollection): Boolean;
    function Equals(ACollection: IPlatformStrCollection): Boolean;
    function First: IPlatformStrIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformStrIterator;
    function Remove(const AString: String): Boolean;
    function RemoveAll(ACollection: IPlatformStrCollection): Boolean;
    function RetainAll(ACollection: IPlatformStrCollection): Boolean;
    function GetSize: Integer;
    procedure SetCaseSensitivity(AValue: Boolean);
    function GetCaseSensitivity: Boolean;
    property Size: Integer Read GetSize;
    property CaseSensitive: Boolean Read GetCaseSensitivity Write SetCaseSensitivity;
  end;

  IPlatformIntCollection = interface(IInterface)
    ['{FEC97D92-0206-45EA-A3D1-C581FC184FA1}']
    function Add(const AInt: Integer): Boolean;
    function AddAll(ACollection: IPlatformIntCollection): Boolean;
    procedure Clear;
    function Contains(const AInt: Integer): Boolean;
    function ContainsAll(ACollection: IPlatformIntCollection): Boolean;
    function Equals(ACollection: IPlatformIntCollection): Boolean;
    function First: IPlatformIntIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformIntIterator;
    function Remove(const AInt: Integer): Boolean;
    function RemoveAll(ACollection: IPlatformIntCollection): Boolean;
    function RetainAll(ACollection: IPlatformIntCollection): Boolean;
    function GetSize: Integer;
    property Size: Integer Read GetSize;
  end;

  IPlatformPtrCollection = interface(IInterface)
    ['{A8625A7B-A3F6-42B4-9895-99EC92CFEA34}']
    function Add(APtr: Pointer): Boolean;
    function AddAll(ACollection: IPlatformPtrCollection): Boolean;
    procedure Clear;
    function Contains(APtr: Pointer): Boolean;
    function ContainsAll(ACollection: IPlatformPtrCollection): Boolean;
    function Equals(ACollection: IPlatformPtrCollection): Boolean;
    function First: IPlatformPtrIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformPtrIterator;
    function Remove(APtr: Pointer): Boolean;
    function RemoveAll(ACollection: IPlatformPtrCollection): Boolean;
    function RetainAll(ACollection: IPlatformPtrCollection): Boolean;
    function GetSize: Integer;
    property Size: Integer Read GetSize;
  end;

  IPlatformCollection = interface(IInterface)
    ['{58947EF1-CD21-4DD1-AE3D-225C3AAD7EE5}']
    function Add(AObject: TObject): Boolean;
    function AddAll(ACollection: IPlatformCollection): Boolean;
    procedure Clear;
    function Contains(AObject: TObject): Boolean;
    function ContainsAll(ACollection: IPlatformCollection): Boolean;
    function Equals(ACollection: IPlatformCollection): Boolean;
    function First: IPlatformIterator;
    function IsEmpty: Boolean;
    function Last: IPlatformIterator;
    function Remove(AObject: TObject): Boolean;
    function RemoveAll(ACollection: IPlatformCollection): Boolean;
    function RetainAll(ACollection: IPlatformCollection): Boolean;
    function GetSize: Integer;
    property Size: Integer Read GetSize;
  end;

  IPlatformStrList = interface(IPlatformStrCollection)
    ['{07DD7644-EAC6-4059-99FC-BEB7FBB73186}']
    procedure Add(Index: Integer; const AString: String); overload;
    function AddAll(Index: Integer; ACollection: IPlatformStrCollection): Boolean;
      overload;
    function GetString(Index: Integer): String;
    function IndexOf(const AString: String): Integer;
    function LastIndexOf(const AString: String): Integer;
    function Remove(Index: Integer): String; overload;
    procedure SetString(Index: Integer; const AString: String);
    function SubList(First, Count: Integer): IPlatformStrList;
  end;

  IPlatformIntList = interface(IPlatformIntCollection)
    ['{8298C67B-E9ED-4393-A2DF-3BB3CAA99221}']
    procedure Add(Index: Integer; const AInt: Integer); overload;
    function AddAll(Index: Integer; ACollection: IPlatformIntCollection): Boolean;
      overload;
    function GetInt(Index: Integer): Integer;
    function IndexOf(const AInt: Integer): Integer;
    function LastIndexOf(const AInt: Integer): Integer;
    function RemoveFromIndex(Index: Integer): Integer; overload;
    procedure SetInt(Index: Integer; const AInt: Integer);
    function SubList(First, Count: Integer): IPlatformIntList;
  end;

  IPlatformPtrList = interface(IPlatformPtrCollection)
    ['{4C2E9045-D0DF-409D-BEAC-1AF62E2A4E8B}']
    procedure Add(Index: Integer; APtr: Pointer); overload;
    function AddAll(Index: Integer; ACollection: IPlatformPtrCollection): Boolean;
      overload;
    function GetPtr(Index: Integer): Pointer;
    function IndexOf(APtr: Pointer): Integer;
    function LastIndexOf(APtr: Pointer): Integer;
    function Remove(Index: Integer): Pointer; overload;
    procedure SetPtr(Index: Integer; APtr: Pointer);
    function SubList(First, Count: Integer): IPlatformPtrList;
  end;

  IPlatformList = interface(IPlatformCollection)
    ['{8ABC70AC-5C06-43EA-AFE0-D066379BCC28}']
    procedure Add(Index: Integer; AObject: TObject); overload;
    function AddAll(Index: Integer; ACollection: IPlatformCollection): Boolean; overload;
    function GetObject(Index: Integer): TObject;
    function IndexOf(AObject: TObject): Integer;
    function LastIndexOf(AObject: TObject): Integer;
    function Remove(Index: Integer): TObject; overload;
    procedure SetObject(Index: Integer; AObject: TObject);
    function SubList(First, Count: Integer): IPlatformList;
  end;

  IPlatformStrArray = interface(IPlatformStrList)
    ['{B055B427-7817-43FC-97D4-AD1845643D63}']
    property Items[Index: Integer]: String Read GetString Write SetString; default;
  end;

  IPlatformIntArray = interface(IPlatformIntList)
    ['{B44DB92F-5E25-4D5F-A2C3-6B3EC93845C1}']
    property Items[Index: Integer]: Integer Read GetInt Write SetInt; default;
  end;

  IPlatformPtrArray = interface(IPlatformPtrList)
    ['{846082E5-0571-429C-AC2F-64F9D9845CF9}']
    property Items[Index: Integer]: Pointer Read GetPtr Write SetPtr; default;
  end;

  IPlatformArray = interface(IPlatformList)
    ['{A69F6D35-54B2-4361-852E-097ED75E648A}']
    property Items[Index: Integer]: TObject Read GetObject Write SetObject; default;
  end;

  IPlatformStrSet = interface(IPlatformStrCollection)
    ['{72204D85-2B68-4914-B9F2-09E5180C12E9}']
    procedure Intersect(ACollection: IPlatformStrCollection);
    procedure Subtract(ACollection: IPlatformStrCollection);
    procedure Union(ACollection: IPlatformStrCollection);
  end;

  IPlatformIntSet = interface(IPlatformIntCollection)
    ['{48AA58C7-3CDB-4D38-B605-2790A8A35403}']
    procedure Intersect(ACollection: IPlatformIntCollection);
    procedure Subtract(ACollection: IPlatformIntCollection);
    procedure Union(ACollection: IPlatformIntCollection);
  end;

  IPlatformPtrSet = interface(IPlatformPtrCollection)
    ['{54BF965E-8261-4852-BD8C-74368AF78567}']
    procedure Intersect(ACollection: IPlatformPtrCollection);
    procedure Subtract(ACollection: IPlatformPtrCollection);
    procedure Union(ACollection: IPlatformPtrCollection);
  end;

  IPlatformSet = interface(IPlatformCollection)
    ['{0B7CDB90-8588-4260-A54C-D87101C669EA}']
    procedure Intersect(ACollection: IPlatformCollection);
    procedure Subtract(ACollection: IPlatformCollection);
    procedure Union(ACollection: IPlatformCollection);
  end;

  IPlatformStrMap = interface(IInterface)
    ['{A7D0A882-6952-496D-A258-23D47DDCCBC4}']
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
    function GetCaseSensitivity: Boolean;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  end;

  IPlatformStrStrMap = interface(IInterface)
    ['{047BD297-01C8-4685-B1A0-DC86477FD9B3}']
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
    function GetCaseSensitivity: Boolean;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  end;

  IPlatformStrIntMap = interface(IInterface)
    ['{15C0BA74-C39C-4E2A-9FC0-464F885CE7FF}']
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
    function GetCaseSensitivity: Boolean;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  end;

  IPlatformStrPtrMap = interface(IInterface)
    ['{047BD297-01C8-4685-B1A0-DC86477FD9B3}']
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
    function GetCaseSensitivity: Boolean;
    property CaseSensitive: Boolean Read GetCaseSensitivity;
  end;

  IPlatformIntMap = interface(IInterface)
    ['{B4C88E02-7A1E-479D-99E7-2033EDF1C21E}']
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
  end;

  IPlatformIntIntMap = interface(IInterface)
    ['{9EA12C79-92F9-4F70-8A02-B8185A77E2DD}']
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
  end;

  IPlatformIntPtrMap = interface(IInterface)
    ['{7AA58678-8FEF-481D-9222-7B640DF6D164}']
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
  end;

  IPlatformPtrPtrMap = interface(IInterface)
    ['{5C7B8B48-842C-4920-8DAD-9A434CE95127}']
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
  end;

  IPlatformMap = interface(IInterface)
    ['{62142145-011A-43C0-8F03-D13BFAC4C680}']
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
  end;


implementation

end.
