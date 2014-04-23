unit Sets;

interface

uses
  ArrayList, ContainerInterfaces;

type
  TStrPlatformArraySet = class(TStrPlatformArrayList, IPlatformStrCollection,
    IPlatformStrSet, IPlatformCloneable)
  protected
    function Add(const AString: String): Boolean;
    function AddAll(ACollection: IPlatformStrCollection): Boolean;
  public
    { IPlatformStrSet }
    procedure Intersect(ACollection: IPlatformStrCollection);
    procedure Subtract(ACollection: IPlatformStrCollection);
    procedure Union(ACollection: IPlatformStrCollection);
  end;

  TIntPlatformArraySet = class(TIntPlatformArrayList, IPlatformIntCollection,
    IPlatformIntSet, IPlatformCloneable)
  protected
    function Add(const AInt: Integer): Boolean;
    function AddAll(ACollection: IPlatformIntCollection): Boolean;
  public
    { IPlatformIntSet }
    procedure Intersect(ACollection: IPlatformIntCollection);
    procedure Subtract(ACollection: IPlatformIntCollection);
    procedure Union(ACollection: IPlatformIntCollection);
  end;

  TPtrPlatformArraySet = class(TPtrPlatformArrayList, IPlatformPtrCollection,
    IPlatformPtrSet, IPlatformCloneable)
  protected
    function Add(APtr: Pointer): Boolean;
    function AddAll(ACollection: IPlatformPtrCollection): Boolean;
  public
    { IPlatformPtrSet }
    procedure Intersect(ACollection: IPlatformPtrCollection);
    procedure Subtract(ACollection: IPlatformPtrCollection);
    procedure Union(ACollection: IPlatformPtrCollection);
  end;

  TPlatformArraySet = class(TPlatformArrayList, IPlatformCollection,
    IPlatformSet, IPlatformCloneable)
  protected
    function Add(AObject: TObject): Boolean;
    function AddAll(ACollection: IPlatformCollection): Boolean;
  public
    { ISet }
    procedure Intersect(ACollection: IPlatformCollection);
    procedure Subtract(ACollection: IPlatformCollection);
    procedure Union(ACollection: IPlatformCollection);
  end;

implementation

{ TStrArraySet }

function TStrPlatformArraySet.Add(const AString: String): Boolean;
begin
  Result := False;
  if Contains(AString) then Exit;
  inherited Add(AString);
  Result := True;
end;

function TStrPlatformArraySet.AddAll(ACollection: IPlatformStrCollection): Boolean;
var
  It: IPlatformStrIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

procedure TStrPlatformArraySet.Intersect(ACollection: IPlatformStrCollection);
begin
  RetainAll(ACollection);
end;

procedure TStrPlatformArraySet.Subtract(ACollection: IPlatformStrCollection);
begin
  RemoveAll(ACollection);
end;

procedure TStrPlatformArraySet.Union(ACollection: IPlatformStrCollection);
begin
  AddAll(ACollection);
end;

{ TIntPlatformArraySet }

function TIntPlatformArraySet.Add(const AInt: Integer): Boolean;
begin
  Result := False;
  if Contains(AInt) then Exit;
  inherited Add(AInt);
  Result := True;
end;

function TIntPlatformArraySet.AddAll(ACollection: IPlatformIntCollection): Boolean;
var
  It: IPlatformIntIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

procedure TIntPlatformArraySet.Intersect(ACollection: IPlatformIntCollection);
begin
  RetainAll(ACollection);
end;

procedure TIntPlatformArraySet.Subtract(ACollection: IPlatformIntCollection);
begin
  RemoveAll(ACollection);
end;

procedure TIntPlatformArraySet.Union(ACollection: IPlatformIntCollection);
begin
  AddAll(ACollection);
end;

{ TPtrPlatformArraySet }

function TPtrPlatformArraySet.Add(APtr: Pointer): Boolean;
begin
  Result := False;
  if Contains(APtr) then Exit;
  inherited Add(APtr);
  Result := True;
end;

function TPtrPlatformArraySet.AddAll(ACollection: IPlatformPtrCollection): Boolean;
var
  It: IPlatformPtrIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

procedure TPtrPlatformArraySet.Intersect(ACollection: IPlatformPtrCollection);
begin
  RetainAll(ACollection);
end;

procedure TPtrPlatformArraySet.Subtract(ACollection: IPlatformPtrCollection);
begin
  RemoveAll(ACollection);
end;

procedure TPtrPlatformArraySet.Union(ACollection: IPlatformPtrCollection);
begin
  AddAll(ACollection);
end;

{ TPlatformArraySet }

function TPlatformArraySet.Add(AObject: TObject): Boolean;
begin
  Result := False;
  if Contains(AObject) then Exit;
  inherited Add(AObject);
  Result := True;
end;

function TPlatformArraySet.AddAll(ACollection: IPlatformCollection): Boolean;
var
  It: IPlatformIterator;
begin
  Result := False;
  if ACollection = nil then Exit;
  It := ACollection.First;
  while It.HasNext do Add(It.Next);
  Result := True;
end;

procedure TPlatformArraySet.Intersect(ACollection: IPlatformCollection);
begin
  RetainAll(ACollection);
end;

procedure TPlatformArraySet.Subtract(ACollection: IPlatformCollection);
begin
  RemoveAll(ACollection);
end;

procedure TPlatformArraySet.Union(ACollection: IPlatformCollection);
begin
  AddAll(ACollection);
end;

end.
