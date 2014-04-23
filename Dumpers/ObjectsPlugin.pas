unit ObjectsPlugin;

interface

uses
  BitBuffer, Classes, ExtendablePlugin, PluginDef, SysUtils,
  UpdateFields, Utils, WoWOpCodes,
  WoWTypes;

type
  TSchObjectPlugin = class(TSchExtendablePlugin)
  private
    { Decodes the full update object packet }
    procedure DecodeUpdateObject();

    { Decompresses then decodes the packet }
    procedure DecodeCompressedUpdateObject();

    { Decodes the delete object packet }
    procedure DecodeDestroyObject();

    { Character Stuff }
    procedure DecodeCharEnum();
    procedure DecodeCharList();
    procedure DecodeLoginPlayer();

    { Sub-decoders }
    procedure DecodeNearFarObjects();
    procedure DecodeMovementPart();
    procedure DecodeUpdatesPart(iObjType: Cardinal);

  protected
    procedure ProcessPacket(iOp: Word); override;

  public
    function AcceptsPacket(iOp: Cardinal): TSchSelectionPower; override;

  end;

implementation

uses PluginSupport;

{ TSchObjectPlugin }

function TSchObjectPlugin.AcceptsPacket(iOp: Cardinal): TSchSelectionPower;
begin
  if (iOp = WoWOpCodes.CMSG_PLAYER_LOGIN) or (iOp = WoWOpCodes.SMSG_CHAR_ENUM) or
    (iOp = WoWOpCodes.CMSG_CHAR_ENUM) or (iOp = WoWOpCodes.SMSG_UPDATE_OBJECT) or
    (iOp = WoWOpCodes.SMSG_DESTROY_OBJECT) or
    (iOp = WoWOpCodes.SMSG_COMPRESSED_UPDATE_OBJECT) then Result := spAcceptNeed
  else
    Result := spNotAccept;
end;

procedure TSchObjectPlugin.DecodeCharEnum;
begin
  { Nothing :) }
end;

procedure TSchObjectPlugin.DecodeCharList;
var
  iCnt, i, u: Byte;
  iGUID: Int64;
begin
  iCnt := Packet.GetInt8('CharacterCount');

  for i := 0 to iCnt - 1 do
  begin
    Packet.StartLogicalGroup('Character(' + IntToStr(i) + ')');

    iGUID := Packet.GetGUID('GUID');
    Packet.RegisterObject(iGUID, OBJTYPEID_PLAYER, Packet.GetString(
      'Name') + ' {Me}');

    Packet.GetInt8('Race');
    Packet.GetInt8('Class');
    Packet.GetInt8('Gender');
    Packet.GetInt8('Skin');
    Packet.GetInt8('Face');
    Packet.GetInt8('HairStyle');
    Packet.GetInt8('HairColor');
    Packet.GetInt8('FacialHair');

    Packet.GetInt8('Level');
    Packet.GetInt32('ZoneID');
    Packet.GetInt32('MapID');

    Packet.GetFloat('PositionX');
    Packet.GetFloat('PositionY');
    Packet.GetFloat('PositionZ');

    Packet.GetHexInt32(UNK);
    Packet.GetHexInt32(UNK);

    Packet.GetInt8('Rested');

    Packet.GetInt32('PetID');
    Packet.GetInt32('PetLevel');
    Packet.GetInt32('PetFamily');

    Packet.StartLogicalGroup('Equipment');

    for u := 0 to 19 do
    begin
      Packet.StartLogicalGroup('EquippedItem(' + IntToStr(u) + ')');

      Packet.GetInt32('ModelID');
      Packet.GetInt8('InventorySlot');

      Packet.EndLogicalGroup();
    end;

    Packet.EndLogicalGroup();

    Packet.EndLogicalGroup();
  end;
end;

procedure TSchObjectPlugin.DecodeCompressedUpdateObject;
var
  iLen: Cardinal;
begin
  iLen := Packet.GetInt32();
  Packet.DecompressPacket(iLen);

  DecodeUpdateObject();
end;

procedure TSchObjectPlugin.DecodeDestroyObject;
var
  iGUID: Int64;
begin
  iGUID := Packet.GetGUID('Object');
  Packet.UnregisterObject(iGUID);
end;

procedure TSchObjectPlugin.DecodeLoginPlayer;
begin
  Packet.GetGUID('SelectedCharacter');
end;

procedure TSchObjectPlugin.DecodeMovementPart;
var
  iFlags, iExtendedFlags, iSplineFlags, iSplinePointsCount, iI: Cardinal;

begin
  iFlags := Packet.GetHexInt8('BaseFlags');
  iExtendedFlags := 0;

  if Packet.CheckMask(iFlags, MOVE_BASE_FLAG_EXTENDED) then
  begin
    iExtendedFlags := Packet.GetHexInt32('ExtendedFlags');
    Packet.GetInt32(UNK);
  end;

 {
 if Packet.CheckMask( iFlags, MOVE_BASE_FLAG_UNKNOWN1 ) then
 begin
  //iExtendedFlags := Packet.GetHexInt32( 'ExtendedFlags' );
  //Packet.GetInt32( UNK );
  Packet.GetInt16( UNK );
  Packet.GetInt8( UNK );
  Exit;
 end;  }

  if Packet.CheckMask(iFlags, MOVE_BASE_FLAG_INITIAL_POS) then
  begin
    Packet.GetFloat('PositionX');
    Packet.GetFloat('PositionY');
    Packet.GetFloat('PositionZ');
    Packet.GetFloat('Orientation');
  end;

  if Packet.CheckMask(iFlags, MOVE_BASE_FLAG_EXTENDED) then
    Packet.GetHexInt32(UNK);

  if Packet.CheckMask(iExtendedFlags, MOVE_SECOND_FLAG_UNKNOWN5) then
    Packet.GetHexInt32(UNK);

  if Packet.CheckMask(iExtendedFlags, MOVE_SECOND_FLAG_CORRECTION) then
  begin
    Packet.GetFloat('correctionX');
    Packet.GetFloat('correctionY');
    Packet.GetFloat('correctionZ');
    Packet.GetFloat('correctionSpeed');
  end;

  if Packet.CheckMask(iFlags, MOVE_BASE_FLAG_EXTENDED) then
  begin
    Packet.GetFloat('WalkSpeed');
    Packet.GetFloat('RunSpeed');
    Packet.GetFloat('BackWalkSpeed');

    Packet.GetFloat('SwimSpeed');
    Packet.GetFloat('BackSwimSpeed');
    Packet.GetFloat('SwimTurnRate');
  end;

  if Packet.CheckMask(iFlags, MOVE_BASE_FLAG_EXTENDED) then
  begin
    if Packet.CheckMask(iExtendedFlags, MOVE_SECOND_FLAG_HAS_SPLINE) then
    begin
      iSplineFlags := Packet.GetInt32('SplineFlags');

      if Packet.CheckMask(iSplineFlags, $00010000) then
      begin
        Packet.GetFloat('splinePositionX');
        Packet.GetFloat('splinePositionY');
        Packet.GetFloat('splinePositionZ');
      end;

      if Packet.CheckMask(iSplineFlags, $00020000) then
        Packet.GetGUID('SplineFaceGUID');

      if Packet.CheckMask(iSplineFlags, $00040000) then
        Packet.GetFloat('SplineOrientation');

      Packet.GetInt32('SplineCurrentJourneyTime');
      Packet.GetInt32(UNK);
      Packet.GetInt32('SplineTotalJourneyTime');

      iSplinePointsCount := Packet.GetInt32('SplinePointsPacketCount');

      Packet.GetFloat('splineStartPositionX');
      Packet.GetFloat('splineStartPositionY');
      Packet.GetFloat('splineStartPositionZ');

      for iI := 0 to iSplinePointsCount - 1 do
      begin
        Packet.GetFloat('splinePointX');
        Packet.GetFloat('splinePointY');
        Packet.GetFloat('splinePointZ');
      end;

    end;

  end;

  Packet.GetInt32(UNK);

  if Packet.CheckMask(iFlags, MOVE_BASE_FLAG_ATTACKING) then
  begin
    Packet.GetGUID('TargetOriented', True);
  end;
end;

procedure TSchObjectPlugin.DecodeNearFarObjects();
var
  iGUIDCount: Cardinal;
  iItr: Integer;
begin
  iGUIDCount := Packet.GetInt32('ObjectsCount');

  for iItr := 0 to iGUIDCount - 1 do Packet.GetGUID('Object', True);
end;

procedure TSchObjectPlugin.DecodeUpdateObject;
const
  UpdateGroupFormat = 'UpdateBlock(%d)';
var
  iUpdateBlocks: Cardinal;
  iItr: Integer;

  iBlockType: Cardinal;
  iGUID: Int64;

  iObjType: Integer;
begin
  { Phase 1 - Read the number of update blocks }
  iUpdateBlocks := Packet.GetInt32('UpdateBlocksCount');
  Packet.GetInt8(UNK);

  if iUpdateBlocks = 0 then  Exception.Create('Invalid Update packet received!');

  { Phase 2 - Iterate in all blocks and invoke necessary operations }

  for iItr := 0 to iUpdateBlocks - 1 do
  begin
    Packet.StartLogicalGroup(Format(UpdateGroupFormat, [iItr]));
    iBlockType := Packet.GetInt8('UpdateBlockType', __UPDATETYPE);

    case iBlockType of
      UPDATETYPE_VALUES:
      begin
        iGUID := Packet.GetGUID('Object', True);
        iObjType := Packet.GetObjectType(iGUID);

        DecodeUpdatesPart(iObjType);
      end;

      UPDATETYPE_MOVEMENT:
      begin
        Packet.GetGUID('Object', True);
        DecodeMovementPart();
      end;

      UPDATETYPE_CREATE_OBJECT, UPDATETYPE_CREATE_OBJECT_ME:
      begin
        iGUID := Packet.GetGUID('NewObject', True);
        iObjType := Packet.GetInt8('ObjectType', __OBJTYPEID);

        Packet.RegisterObject(iGUID, iObjType);

        DecodeMovementPart();
        DecodeUpdatesPart(iObjType);
      end;

      UPDATETYPE_NEAR_OBJECTS, UPDATETYPE_OUT_OF_RANGE_OBJECTS: DecodeNearFarObjects();

      else
        Exception.Create('Invalid Update packet received!');
    end;

    Packet.EndLogicalGroup();
  end;

end;

procedure TSchObjectPlugin.DecodeUpdatesPart(iObjType: Cardinal);
var
  iMaskCount: Cardinal;
  cBitBuffer: TSchBitBuffer;

  iBit: Cardinal;
  uField: TSchUpdateField;
begin
  iMaskCount := Packet.GetInt8('MaskCount');
  cBitBuffer := Packet.GetBitBuffer(iMaskCount * 4);

  for iBit := 0 to (iMaskCount * 4 * 8) - 1 do if cBitBuffer[iBit] then
    begin
      uField := GetUpdateField(iBit, iObjType);

      case uField.iType of
        dtGUID: Packet.GetHexInt32(uField.sName, uField.cCall);
        dtI32: Packet.GetInt32(uField.sName, uField.cCall);
        dtFloat: Packet.GetFloat(uField.sName);
        dtBit: Packet.GetBinaryInt32(uField.sName, uField.cCall);
      end;

    end;

  cBitBuffer.Destroy();
end;

procedure TSchObjectPlugin.ProcessPacket(iOp: Word);
begin
  case iOp of
    SMSG_UPDATE_OBJECT: DecodeUpdateObject();
    SMSG_COMPRESSED_UPDATE_OBJECT: DecodeCompressedUpdateObject();
    SMSG_DESTROY_OBJECT: DecodeDestroyObject();
    CMSG_CHAR_ENUM: DecodeCharEnum();
    SMSG_CHAR_ENUM: DecodeCharList();
    CMSG_PLAYER_LOGIN: DecodeLoginPlayer();
  end;
end;


initialization

  TSchObjectPlugin.Create(
    'Character & Objects Decoder',
    'Accepts all packets related to Object processing. Those packets carry 90% of information required for game to work.',
    '0.5',
    'BFG Team',
    True
    );

end.
