unit UpdateFields;

interface

uses
  SysUtils, WoWTypes;

type
  TSchUpdateFieldType = (dtGUID, dtI32, dtFloat, dtBit);

  TSchUpdateField = record
    sName: String;
    wConst: Cardinal;
    iType: TSchUpdateFieldType;
    cCall: TSchConstCallBack;
  end;

const
  ObjectUpdateFields: array[0..4] of TSchUpdateField =
    (
    (sName: 'OBJECT_FIELD_GUID'; wConst: $000; iType: dtGUID; cCall: nil),
    (sName: 'OBJECT_FIELD_TYPE'; wConst: $002; iType: dtI32; cCall: __OBJTYPE),
    (sName: 'OBJECT_FIELD_ENTRY'; wConst: $003; iType: dtI32; cCall: nil),
    (sName: 'OBJECT_FIELD_SCALE_X'; wConst: $004; iType: dtFloat; cCall: nil),
    (sName: 'OBJECT_FIELD_PADDING'; wConst: $005; iType: dtI32; cCall: nil)
    );

  OBJECT_END = $005 + 1;

  ItemUpdateFields: array[0..37] of TSchUpdateField =
    (
    (sName: 'ITEM_FIELD_OWNER'; wConst: OBJECT_END + $000; iType: dtGUID; cCall: nil),
    (sName: 'ITEM_FIELD_CONTAINED'; wConst: OBJECT_END + $002;
    iType: dtGUID; cCall: nil),
    (sName: 'ITEM_FIELD_CREATOR'; wConst: OBJECT_END + $004; iType: dtGUID; cCall: nil),
    (sName: 'ITEM_FIELD_GIFTCREATOR'; wConst: OBJECT_END + $006;
    iType: dtGUID; cCall: nil),
    (sName: 'ITEM_FIELD_STACK_COUNT'; wConst: OBJECT_END + $008;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_DURATION'; wConst: OBJECT_END + $009; iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_SPELL_CHARGES'; wConst: OBJECT_END + $00A;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_SPELL_CHARGES_01'; wConst: OBJECT_END + $00B;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_SPELL_CHARGES_02'; wConst: OBJECT_END + $00C;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_SPELL_CHARGES_03'; wConst: OBJECT_END + $00D;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_SPELL_CHARGES_04'; wConst: OBJECT_END + $00E;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_FLAGS'; wConst: OBJECT_END + $00F; iType: dtBit; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT'; wConst: OBJECT_END + $010;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_01'; wConst: OBJECT_END + $011;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_02'; wConst: OBJECT_END + $012;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_03'; wConst: OBJECT_END + $013;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_04'; wConst: OBJECT_END + $014;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_05'; wConst: OBJECT_END + $015;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_06'; wConst: OBJECT_END + $016;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_07'; wConst: OBJECT_END + $017;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_08'; wConst: OBJECT_END + $018;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_09'; wConst: OBJECT_END + $019;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_10'; wConst: OBJECT_END + $01A;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_11'; wConst: OBJECT_END + $01B;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_12'; wConst: OBJECT_END + $01C;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_13'; wConst: OBJECT_END + $01D;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_14'; wConst: OBJECT_END + $01E;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_15'; wConst: OBJECT_END + $01F;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_16'; wConst: OBJECT_END + $020;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_17'; wConst: OBJECT_END + $021;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_18'; wConst: OBJECT_END + $022;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_19'; wConst: OBJECT_END + $023;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ENCHANTMENT_20'; wConst: OBJECT_END + $024;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_PROPERTY_SEED'; wConst: OBJECT_END + $025;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_RANDOM_PROPERTIES_ID'; wConst: OBJECT_END + $026;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_ITEM_TEXT_ID'; wConst: OBJECT_END + $027;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_DURABILITY'; wConst: OBJECT_END + $028;
    iType: dtI32; cCall: nil),
    (sName: 'ITEM_FIELD_MAXDURABILITY'; wConst: OBJECT_END + $029;
    iType: dtI32; cCall: nil));

  ITEM_END = OBJECT_END + $029 + 1;

  ContainerUpdateFields: array[0..37] of TSchUpdateField =
    (
    (sName: 'CONTAINER_FIELD_NUM_SLOTS'; wConst: ITEM_END + $000;
    iType: dtI32; cCall: nil),
    (sName: 'CONTAINER_ALIGN_PAD'; wConst: ITEM_END + $001; iType: dtI32; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_1'; wConst: ITEM_END + $002;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_2'; wConst: ITEM_END + $004;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_3'; wConst: ITEM_END + $006;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_4'; wConst: ITEM_END + $008;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_5'; wConst: ITEM_END + $00A;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_6'; wConst: ITEM_END + $00C;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_7'; wConst: ITEM_END + $00E;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_8'; wConst: ITEM_END + $010;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_9'; wConst: ITEM_END + $012;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_10'; wConst: ITEM_END + $014;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_11'; wConst: ITEM_END + $016;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_12'; wConst: ITEM_END + $018;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_13'; wConst: ITEM_END + $01A;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_14'; wConst: ITEM_END + $01C;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_15'; wConst: ITEM_END + $01E;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_16'; wConst: ITEM_END + $020;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_17'; wConst: ITEM_END + $022;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_18'; wConst: ITEM_END + $024;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_19'; wConst: ITEM_END + $026;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_20'; wConst: ITEM_END + $028;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_21'; wConst: ITEM_END + $02A;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_22'; wConst: ITEM_END + $02C;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_23'; wConst: ITEM_END + $03E;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_24'; wConst: ITEM_END + $030;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_25'; wConst: ITEM_END + $032;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_26'; wConst: ITEM_END + $034;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_27'; wConst: ITEM_END + $036;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_28'; wConst: ITEM_END + $038;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_29'; wConst: ITEM_END + $03A;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_30'; wConst: ITEM_END + $03C;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_31'; wConst: ITEM_END + $04E;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_32'; wConst: ITEM_END + $040;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_33'; wConst: ITEM_END + $042;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_34'; wConst: ITEM_END + $044;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_35'; wConst: ITEM_END + $046;
    iType: dtGUID; cCall: nil),
    (sName: 'CONTAINER_FIELD_SLOT_36'; wConst: ITEM_END + $048;
    iType: dtGUID; cCall: nil)
    );


  UnitUpdateFields: array[0..173] of TSchUpdateField =
    (
    (sName: 'UNIT_FIELD_CHARM'; wConst: OBJECT_END + $000; iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_SUMMON'; wConst: OBJECT_END + $002; iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_CHARMEDBY'; wConst: OBJECT_END + $004;
    iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_SUMMONEDBY'; wConst: OBJECT_END + $006;
    iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_CREATEDBY'; wConst: OBJECT_END + $008;
    iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_TARGET'; wConst: OBJECT_END + $00A; iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_PERSUADED'; wConst: OBJECT_END + $00C;
    iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_CHANNEL_OBJECT'; wConst: OBJECT_END + $00E;
    iType: dtGUID; cCall: nil),
    (sName: 'UNIT_FIELD_HEALTH'; wConst: OBJECT_END + $010; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER1'; wConst: OBJECT_END + $011; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER2'; wConst: OBJECT_END + $012; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER3'; wConst: OBJECT_END + $013; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER4'; wConst: OBJECT_END + $014; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER5'; wConst: OBJECT_END + $015; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MAXHEALTH'; wConst: OBJECT_END + $016;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MAXPOWER1'; wConst: OBJECT_END + $017;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MAXPOWER2'; wConst: OBJECT_END + $018;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MAXPOWER3'; wConst: OBJECT_END + $019;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MAXPOWER4'; wConst: OBJECT_END + $01A;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MAXPOWER5'; wConst: OBJECT_END + $01B;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_LEVEL'; wConst: OBJECT_END + $01C; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_FACTIONTEMPLATE'; wConst: OBJECT_END + $01D;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BYTES_0'; wConst: OBJECT_END + $01E; iType: dtBit; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_SLOT_DISPLAY'; wConst: OBJECT_END + $01F;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_SLOT_DISPLAY_01'; wConst: OBJECT_END + $020;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_SLOT_DISPLAY_02'; wConst: OBJECT_END + $021;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_INFO'; wConst: OBJECT_END + $022;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_INFO_01'; wConst: OBJECT_END + $023;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_INFO_02'; wConst: OBJECT_END + $024;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_INFO_03'; wConst: OBJECT_END + $025;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_INFO_04'; wConst: OBJECT_END + $026;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_VIRTUAL_ITEM_INFO_05'; wConst: OBJECT_END + $027;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_FLAGS'; wConst: OBJECT_END + $028; iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURA'; wConst: OBJECT_END + $029; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_01'; wConst: OBJECT_END + $02A; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_02'; wConst: OBJECT_END + $02B; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_03'; wConst: OBJECT_END + $02C; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_04'; wConst: OBJECT_END + $02D; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_05'; wConst: OBJECT_END + $02E; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_06'; wConst: OBJECT_END + $02F; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_07'; wConst: OBJECT_END + $030; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_08'; wConst: OBJECT_END + $031; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_09'; wConst: OBJECT_END + $032; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_10'; wConst: OBJECT_END + $033; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_11'; wConst: OBJECT_END + $034; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_12'; wConst: OBJECT_END + $035; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_13'; wConst: OBJECT_END + $036; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_14'; wConst: OBJECT_END + $037; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_15'; wConst: OBJECT_END + $038; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_16'; wConst: OBJECT_END + $039; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_17'; wConst: OBJECT_END + $03A; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_18'; wConst: OBJECT_END + $03B; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_19'; wConst: OBJECT_END + $03C; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_20'; wConst: OBJECT_END + $03D; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_21'; wConst: OBJECT_END + $03E; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_22'; wConst: OBJECT_END + $03F; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_23'; wConst: OBJECT_END + $040; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_24'; wConst: OBJECT_END + $041; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_25'; wConst: OBJECT_END + $042; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_26'; wConst: OBJECT_END + $043; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_27'; wConst: OBJECT_END + $044; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_28'; wConst: OBJECT_END + $045; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_29'; wConst: OBJECT_END + $046; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_30'; wConst: OBJECT_END + $047; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_31'; wConst: OBJECT_END + $048; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_32'; wConst: OBJECT_END + $049; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_33'; wConst: OBJECT_END + $04A; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_34'; wConst: OBJECT_END + $04B; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_35'; wConst: OBJECT_END + $04C; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_36'; wConst: OBJECT_END + $04D; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_37'; wConst: OBJECT_END + $04E; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_38'; wConst: OBJECT_END + $04F; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_39'; wConst: OBJECT_END + $050; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_40'; wConst: OBJECT_END + $051; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_41'; wConst: OBJECT_END + $052; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_42'; wConst: OBJECT_END + $053; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_43'; wConst: OBJECT_END + $054; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_44'; wConst: OBJECT_END + $055; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_45'; wConst: OBJECT_END + $056; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_46'; wConst: OBJECT_END + $057; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURA_47'; wConst: OBJECT_END + $058; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAFLAGS'; wConst: OBJECT_END + $059;
    iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURAFLAGS_01'; wConst: OBJECT_END + $05A;
    iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURAFLAGS_02'; wConst: OBJECT_END + $05B;
    iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURAFLAGS_03'; wConst: OBJECT_END + $05C;
    iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURAFLAGS_04'; wConst: OBJECT_END + $05D;
    iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURAFLAGS_05'; wConst: OBJECT_END + $05E;
    iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS'; wConst: OBJECT_END + $05F;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_01'; wConst: OBJECT_END + $060;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_02'; wConst: OBJECT_END + $061;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_03'; wConst: OBJECT_END + $062;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_04'; wConst: OBJECT_END + $063;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_05'; wConst: OBJECT_END + $064;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_06'; wConst: OBJECT_END + $065;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_07'; wConst: OBJECT_END + $066;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_08'; wConst: OBJECT_END + $067;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_09'; wConst: OBJECT_END + $068;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_10'; wConst: OBJECT_END + $069;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURALEVELS_11'; wConst: OBJECT_END + $06A;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS'; wConst: OBJECT_END + $06B;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_01'; wConst: OBJECT_END + $06C;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_02'; wConst: OBJECT_END + $06D;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_03'; wConst: OBJECT_END + $06E;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_04'; wConst: OBJECT_END + $06F;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_05'; wConst: OBJECT_END + $070;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_06'; wConst: OBJECT_END + $071;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_07'; wConst: OBJECT_END + $072;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_08'; wConst: OBJECT_END + $073;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_09'; wConst: OBJECT_END + $074;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_10'; wConst: OBJECT_END + $075;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURAAPPLICATIONS_11'; wConst: OBJECT_END + $076;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_AURASTATE'; wConst: OBJECT_END + $077;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BASEATTACKTIME'; wConst: OBJECT_END + $078;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BASEATTACKTIME_01'; wConst: OBJECT_END + $079;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RANGEDATTACKTIME'; wConst: OBJECT_END + $07A;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BOUNDINGRADIUS'; wConst: OBJECT_END + $07B;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_COMBATREACH'; wConst: OBJECT_END + $07C;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_DISPLAYID'; wConst: OBJECT_END + $07D;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_NATIVEDISPLAYID'; wConst: OBJECT_END + $07E;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MOUNTDISPLAYID'; wConst: OBJECT_END + $07F;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_MINDAMAGE'; wConst: OBJECT_END + $080;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_MAXDAMAGE'; wConst: OBJECT_END + $081;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_MINOFFHANDDAMAGE'; wConst: OBJECT_END + $082;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_MAXOFFHANDDAMAGE'; wConst: OBJECT_END + $083;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_BYTES_1'; wConst: OBJECT_END + $084; iType: dtBit;
    cCall: __UNITSTANDTYPE),
    (sName: 'UNIT_FIELD_PETNUMBER'; wConst: OBJECT_END + $085;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_PET_NAME_TIMESTAMP'; wConst: OBJECT_END + $086;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_PETEXPERIENCE'; wConst: OBJECT_END + $087;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_PETNEXTLEVELEXP'; wConst: OBJECT_END + $088;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_DYNAMIC_FLAGS'; wConst: OBJECT_END + $089; iType: dtBit; cCall: nil),
    (sName: 'UNIT_CHANNEL_SPELL'; wConst: OBJECT_END + $08A; iType: dtI32; cCall: nil),
    (sName: 'UNIT_MOD_CAST_SPEED'; wConst: OBJECT_END + $08B;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_CREATED_BY_SPELL'; wConst: OBJECT_END + $08C;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_NPC_FLAGS'; wConst: OBJECT_END + $08D; iType: dtBit; cCall: nil),
    (sName: 'UNIT_NPC_EMOTESTATE'; wConst: OBJECT_END + $08E; iType: dtI32; cCall: nil),
    (sName: 'UNIT_TRAINING_POINTS'; wConst: OBJECT_END + $08F;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_STAT0'; wConst: OBJECT_END + $090; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_STAT1'; wConst: OBJECT_END + $091; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_STAT2'; wConst: OBJECT_END + $092; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_STAT3'; wConst: OBJECT_END + $093; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_STAT4'; wConst: OBJECT_END + $094; iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES'; wConst: OBJECT_END + $095;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES_01'; wConst: OBJECT_END + $096;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES_02'; wConst: OBJECT_END + $097;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES_03'; wConst: OBJECT_END + $098;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES_04'; wConst: OBJECT_END + $099;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES_05'; wConst: OBJECT_END + $09A;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RESISTANCES_06'; wConst: OBJECT_END + $09B;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BASE_MANA'; wConst: OBJECT_END + $09C;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BASE_HEALTH'; wConst: OBJECT_END + $09D;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_BYTES_2'; wConst: OBJECT_END + $09E; iType: dtBit; cCall: nil),
    (sName: 'UNIT_FIELD_ATTACK_POWER'; wConst: OBJECT_END + $09F;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_ATTACK_POWER_MODS'; wConst: OBJECT_END + $0A0;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_ATTACK_POWER_MULTIPLIER'; wConst: OBJECT_END + $0A1;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_RANGED_ATTACK_POWER'; wConst: OBJECT_END + $0A2;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RANGED_ATTACK_POWER_MODS'; wConst: OBJECT_END + $0A3;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER';
    wConst: OBJECT_END + $0A4; iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_MINRANGEDDAMAGE'; wConst: OBJECT_END + $0A5;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_MAXRANGEDDAMAGE'; wConst: OBJECT_END + $0A6;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER'; wConst: OBJECT_END + $0A7;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER_01'; wConst: OBJECT_END + $0A8;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER_02'; wConst: OBJECT_END + $0A9;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER_03'; wConst: OBJECT_END + $0AA;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER_04'; wConst: OBJECT_END + $0AB;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER_05'; wConst: OBJECT_END + $0AC;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MODIFIER_06'; wConst: OBJECT_END + $0AD;
    iType: dtI32; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER'; wConst: OBJECT_END + $0AE;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER_01'; wConst: OBJECT_END + $0AF;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER_02'; wConst: OBJECT_END + $0B0;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER_03'; wConst: OBJECT_END + $0B1;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER_04'; wConst: OBJECT_END + $0B2;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER_05'; wConst: OBJECT_END + $0B3;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_POWER_COST_MULTIPLIER_06'; wConst: OBJECT_END + $0B4;
    iType: dtFloat; cCall: nil),
    (sName: 'UNIT_FIELD_PADDING'; wConst: OBJECT_END + $0B5; iType: dtI32; cCall: nil)
    );

  UNIT_END = OBJECT_END + $0B5 + 1;

  PlayerUpdateFields: array[0..851] of TSchUpdateField =
    (
    (sName: 'PLAYER_DUEL_ARBITER'; wConst: UNIT_END + $000; iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FLAGS'; wConst: UNIT_END + $002; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_GUILDID'; wConst: UNIT_END + $003; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_GUILDRANK'; wConst: UNIT_END + $004; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_BYTES'; wConst: UNIT_END + $005; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_BYTES_2'; wConst: UNIT_END + $006; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_BYTES_3'; wConst: UNIT_END + $007; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_DUEL_TEAM'; wConst: UNIT_END + $008; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_GUILD_TIMESTAMP'; wConst: UNIT_END + $009;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_1_1'; wConst: UNIT_END + $00A; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_1_2'; wConst: UNIT_END + $00B; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_1_01'; wConst: UNIT_END + $00C; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_2_1'; wConst: UNIT_END + $00D; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_2_2'; wConst: UNIT_END + $00E; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_2_01'; wConst: UNIT_END + $00F; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_3_1'; wConst: UNIT_END + $010; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_3_2'; wConst: UNIT_END + $011; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_3_01'; wConst: UNIT_END + $012; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_4_1'; wConst: UNIT_END + $013; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_4_2'; wConst: UNIT_END + $014; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_4_01'; wConst: UNIT_END + $015; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_5_1'; wConst: UNIT_END + $016; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_5_2'; wConst: UNIT_END + $017; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_5_01'; wConst: UNIT_END + $018; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_6_1'; wConst: UNIT_END + $019; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_6_2'; wConst: UNIT_END + $01A; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_6_01'; wConst: UNIT_END + $01B; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_7_1'; wConst: UNIT_END + $01C; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_7_2'; wConst: UNIT_END + $01D; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_7_01'; wConst: UNIT_END + $01E; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_8_1'; wConst: UNIT_END + $01F; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_8_2'; wConst: UNIT_END + $020; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_8_01'; wConst: UNIT_END + $021; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_9_1'; wConst: UNIT_END + $022; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_9_2'; wConst: UNIT_END + $023; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_9_01'; wConst: UNIT_END + $024; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_10_1'; wConst: UNIT_END + $025; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_10_2'; wConst: UNIT_END + $026; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_10_01'; wConst: UNIT_END + $027;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_11_1'; wConst: UNIT_END + $028; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_11_2'; wConst: UNIT_END + $029; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_11_01'; wConst: UNIT_END + $02A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_12_1'; wConst: UNIT_END + $02B; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_12_2'; wConst: UNIT_END + $02C; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_12_01'; wConst: UNIT_END + $02D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_13_1'; wConst: UNIT_END + $02E; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_13_2'; wConst: UNIT_END + $02F; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_13_01'; wConst: UNIT_END + $030;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_14_1'; wConst: UNIT_END + $031; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_14_2'; wConst: UNIT_END + $032; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_14_01'; wConst: UNIT_END + $033;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_15_1'; wConst: UNIT_END + $034; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_15_2'; wConst: UNIT_END + $035; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_15_01'; wConst: UNIT_END + $036;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_16_1'; wConst: UNIT_END + $037; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_16_2'; wConst: UNIT_END + $038; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_16_01'; wConst: UNIT_END + $039;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_17_1'; wConst: UNIT_END + $03A; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_17_2'; wConst: UNIT_END + $03B; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_17_01'; wConst: UNIT_END + $03C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_18_1'; wConst: UNIT_END + $03D; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_18_2'; wConst: UNIT_END + $03E; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_18_01'; wConst: UNIT_END + $03F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_19_1'; wConst: UNIT_END + $040; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_19_2'; wConst: UNIT_END + $041; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_19_01'; wConst: UNIT_END + $042;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_20_1'; wConst: UNIT_END + $043; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_20_2'; wConst: UNIT_END + $044; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_QUEST_LOG_20_01'; wConst: UNIT_END + $045;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_CREATOR'; wConst: UNIT_END + $046;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_0'; wConst: UNIT_END + $048;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_01'; wConst: UNIT_END + $049;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_02'; wConst: UNIT_END + $04A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_03'; wConst: UNIT_END + $04B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_04'; wConst: UNIT_END + $04C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_05'; wConst: UNIT_END + $04D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_06'; wConst: UNIT_END + $04E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_07'; wConst: UNIT_END + $04F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_PROPERTIES'; wConst: UNIT_END + $050;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_1_PAD'; wConst: UNIT_END + $051;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_CREATOR'; wConst: UNIT_END + $052;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_0'; wConst: UNIT_END + $054;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_01'; wConst: UNIT_END + $055;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_02'; wConst: UNIT_END + $056;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_03'; wConst: UNIT_END + $057;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_04'; wConst: UNIT_END + $058;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_05'; wConst: UNIT_END + $059;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_06'; wConst: UNIT_END + $05A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_07'; wConst: UNIT_END + $05B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_PROPERTIES'; wConst: UNIT_END + $05C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_2_PAD'; wConst: UNIT_END + $05D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_CREATOR'; wConst: UNIT_END + $05E;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_0'; wConst: UNIT_END + $060;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_01'; wConst: UNIT_END + $061;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_02'; wConst: UNIT_END + $062;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_03'; wConst: UNIT_END + $063;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_04'; wConst: UNIT_END + $064;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_05'; wConst: UNIT_END + $065;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_06'; wConst: UNIT_END + $066;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_07'; wConst: UNIT_END + $067;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_PROPERTIES'; wConst: UNIT_END + $068;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_3_PAD'; wConst: UNIT_END + $069;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_CREATOR'; wConst: UNIT_END + $06A;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_0'; wConst: UNIT_END + $06C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_01'; wConst: UNIT_END + $06D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_02'; wConst: UNIT_END + $06E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_03'; wConst: UNIT_END + $06F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_04'; wConst: UNIT_END + $070;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_05'; wConst: UNIT_END + $071;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_06'; wConst: UNIT_END + $072;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_07'; wConst: UNIT_END + $073;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_PROPERTIES'; wConst: UNIT_END + $074;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_4_PAD'; wConst: UNIT_END + $075;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_CREATOR'; wConst: UNIT_END + $076;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_0'; wConst: UNIT_END + $078;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_01'; wConst: UNIT_END + $079;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_02'; wConst: UNIT_END + $07A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_03'; wConst: UNIT_END + $07B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_04'; wConst: UNIT_END + $07C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_05'; wConst: UNIT_END + $07D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_06'; wConst: UNIT_END + $07E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_07'; wConst: UNIT_END + $07F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_PROPERTIES'; wConst: UNIT_END + $080;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_5_PAD'; wConst: UNIT_END + $081;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_CREATOR'; wConst: UNIT_END + $082;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_0'; wConst: UNIT_END + $084;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_01'; wConst: UNIT_END + $085;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_02'; wConst: UNIT_END + $086;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_03'; wConst: UNIT_END + $087;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_04'; wConst: UNIT_END + $088;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_05'; wConst: UNIT_END + $089;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_06'; wConst: UNIT_END + $08A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_07'; wConst: UNIT_END + $08B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_PROPERTIES'; wConst: UNIT_END + $08C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_6_PAD'; wConst: UNIT_END + $08D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_CREATOR'; wConst: UNIT_END + $08E;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_0'; wConst: UNIT_END + $090;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_01'; wConst: UNIT_END + $091;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_02'; wConst: UNIT_END + $092;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_03'; wConst: UNIT_END + $093;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_04'; wConst: UNIT_END + $094;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_05'; wConst: UNIT_END + $095;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_06'; wConst: UNIT_END + $096;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_07'; wConst: UNIT_END + $097;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_PROPERTIES'; wConst: UNIT_END + $098;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_7_PAD'; wConst: UNIT_END + $099;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_CREATOR'; wConst: UNIT_END + $09A;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_0'; wConst: UNIT_END + $09C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_01'; wConst: UNIT_END + $09D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_02'; wConst: UNIT_END + $09E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_03'; wConst: UNIT_END + $09F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_04'; wConst: UNIT_END + $0A0;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_05'; wConst: UNIT_END + $0A1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_06'; wConst: UNIT_END + $0A2;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_07'; wConst: UNIT_END + $0A3;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_PROPERTIES'; wConst: UNIT_END + $0A4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_8_PAD'; wConst: UNIT_END + $0A5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_CREATOR'; wConst: UNIT_END + $0A6;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_0'; wConst: UNIT_END + $0A8;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_01'; wConst: UNIT_END + $0A9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_02'; wConst: UNIT_END + $0AA;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_03'; wConst: UNIT_END + $0AB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_04'; wConst: UNIT_END + $0AC;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_05'; wConst: UNIT_END + $0AD;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_06'; wConst: UNIT_END + $0AE;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_07'; wConst: UNIT_END + $0AF;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_PROPERTIES'; wConst: UNIT_END + $0B0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_9_PAD'; wConst: UNIT_END + $0B1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_CREATOR'; wConst: UNIT_END + $0B2;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_0'; wConst: UNIT_END + $0B4;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_01'; wConst: UNIT_END + $0B5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_02'; wConst: UNIT_END + $0B6;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_03'; wConst: UNIT_END + $0B7;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_04'; wConst: UNIT_END + $0B8;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_05'; wConst: UNIT_END + $0B9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_06'; wConst: UNIT_END + $0BA;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_07'; wConst: UNIT_END + $0BB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_PROPERTIES'; wConst: UNIT_END + $0BC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_10_PAD'; wConst: UNIT_END + $0BD;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_CREATOR'; wConst: UNIT_END + $0BE;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_0'; wConst: UNIT_END + $0C0;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_01'; wConst: UNIT_END + $0C1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_02'; wConst: UNIT_END + $0C2;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_03'; wConst: UNIT_END + $0C3;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_04'; wConst: UNIT_END + $0C4;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_05'; wConst: UNIT_END + $0C5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_06'; wConst: UNIT_END + $0C6;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_07'; wConst: UNIT_END + $0C7;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_PROPERTIES'; wConst: UNIT_END + $0C8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_11_PAD'; wConst: UNIT_END + $0C9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_CREATOR'; wConst: UNIT_END + $0CA;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_0'; wConst: UNIT_END + $0CC;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_01'; wConst: UNIT_END + $0CD;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_02'; wConst: UNIT_END + $0CE;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_03'; wConst: UNIT_END + $0CF;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_04'; wConst: UNIT_END + $0D0;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_05'; wConst: UNIT_END + $0D1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_06'; wConst: UNIT_END + $0D2;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_07'; wConst: UNIT_END + $0D3;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_PROPERTIES'; wConst: UNIT_END + $0D4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_12_PAD'; wConst: UNIT_END + $0D5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_CREATOR'; wConst: UNIT_END + $0D6;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_0'; wConst: UNIT_END + $0D8;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_01'; wConst: UNIT_END + $0D9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_02'; wConst: UNIT_END + $0DA;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_03'; wConst: UNIT_END + $0DB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_04'; wConst: UNIT_END + $0DC;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_05'; wConst: UNIT_END + $0DD;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_06'; wConst: UNIT_END + $0DE;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_07'; wConst: UNIT_END + $0DF;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_PROPERTIES'; wConst: UNIT_END + $0E0;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_13_PAD'; wConst: UNIT_END + $0E1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_CREATOR'; wConst: UNIT_END + $0E2;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_0'; wConst: UNIT_END + $0E4;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_01'; wConst: UNIT_END + $0E5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_02'; wConst: UNIT_END + $0E6;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_03'; wConst: UNIT_END + $0E7;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_04'; wConst: UNIT_END + $0E8;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_05'; wConst: UNIT_END + $0E9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_06'; wConst: UNIT_END + $0EA;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_07'; wConst: UNIT_END + $0EB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_PROPERTIES'; wConst: UNIT_END + $0EC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_14_PAD'; wConst: UNIT_END + $0ED;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_CREATOR'; wConst: UNIT_END + $0EE;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_0'; wConst: UNIT_END + $0F0;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_01'; wConst: UNIT_END + $0F1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_02'; wConst: UNIT_END + $0F2;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_03'; wConst: UNIT_END + $0F3;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_04'; wConst: UNIT_END + $0F4;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_05'; wConst: UNIT_END + $0F5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_06'; wConst: UNIT_END + $0F6;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_07'; wConst: UNIT_END + $0F7;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_PROPERTIES'; wConst: UNIT_END + $0F8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_15_PAD'; wConst: UNIT_END + $0F9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_CREATOR'; wConst: UNIT_END + $0FA;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_0'; wConst: UNIT_END + $0FC;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_01'; wConst: UNIT_END + $0FD;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_02'; wConst: UNIT_END + $0FE;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_03'; wConst: UNIT_END + $0FF;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_04'; wConst: UNIT_END + $100;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_05'; wConst: UNIT_END + $101;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_06'; wConst: UNIT_END + $102;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_07'; wConst: UNIT_END + $103;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_PROPERTIES'; wConst: UNIT_END + $104;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_16_PAD'; wConst: UNIT_END + $105;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_CREATOR'; wConst: UNIT_END + $106;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_0'; wConst: UNIT_END + $108;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_01'; wConst: UNIT_END + $109;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_02'; wConst: UNIT_END + $10A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_03'; wConst: UNIT_END + $10B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_04'; wConst: UNIT_END + $10C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_05'; wConst: UNIT_END + $10D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_06'; wConst: UNIT_END + $10E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_07'; wConst: UNIT_END + $10F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_PROPERTIES'; wConst: UNIT_END + $110;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_17_PAD'; wConst: UNIT_END + $111;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_CREATOR'; wConst: UNIT_END + $112;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_0'; wConst: UNIT_END + $114;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_01'; wConst: UNIT_END + $115;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_02'; wConst: UNIT_END + $116;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_03'; wConst: UNIT_END + $117;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_04'; wConst: UNIT_END + $118;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_05'; wConst: UNIT_END + $119;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_06'; wConst: UNIT_END + $11A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_07'; wConst: UNIT_END + $11B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_PROPERTIES'; wConst: UNIT_END + $11C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_18_PAD'; wConst: UNIT_END + $11D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_CREATOR'; wConst: UNIT_END + $11E;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_0'; wConst: UNIT_END + $120;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_01'; wConst: UNIT_END + $121;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_02'; wConst: UNIT_END + $122;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_03'; wConst: UNIT_END + $123;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_04'; wConst: UNIT_END + $124;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_05'; wConst: UNIT_END + $125;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_06'; wConst: UNIT_END + $126;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_07'; wConst: UNIT_END + $127;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_PROPERTIES'; wConst: UNIT_END + $128;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_VISIBLE_ITEM_19_PAD'; wConst: UNIT_END + $129;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_INV_SLOT_HEAD'; wConst: UNIT_END + $12A;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FIELD_PACK_SLOT_1'; wConst: UNIT_END + $158;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FIELD_BANK_SLOT_1'; wConst: UNIT_END + $178;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FIELD_BANKBAG_SLOT_1'; wConst: UNIT_END + $1A8;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FIELD_VENDORBUYBACK_SLOT_1'; wConst: UNIT_END + $1B4;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FIELD_KEYRING_SLOT_1'; wConst: UNIT_END + $1CC;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_FARSIGHT'; wConst: UNIT_END + $20C; iType: dtGUID; cCall: nil),
    (sName: 'PLAYER__FIELD_COMBO_TARGET'; wConst: UNIT_END + $20E;
    iType: dtGUID; cCall: nil),
    (sName: 'PLAYER_XP'; wConst: UNIT_END + $210; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_NEXT_LEVEL_XP'; wConst: UNIT_END + $211; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_1'; wConst: UNIT_END + $212; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_01'; wConst: UNIT_END + $213;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_02'; wConst: UNIT_END + $214;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_03'; wConst: UNIT_END + $215;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_04'; wConst: UNIT_END + $216;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_05'; wConst: UNIT_END + $217;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_06'; wConst: UNIT_END + $218;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_07'; wConst: UNIT_END + $219;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_08'; wConst: UNIT_END + $21A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_09'; wConst: UNIT_END + $21B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_10'; wConst: UNIT_END + $21C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_11'; wConst: UNIT_END + $21D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_12'; wConst: UNIT_END + $21E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_13'; wConst: UNIT_END + $21F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_14'; wConst: UNIT_END + $220;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_15'; wConst: UNIT_END + $221;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_16'; wConst: UNIT_END + $222;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_17'; wConst: UNIT_END + $223;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_18'; wConst: UNIT_END + $224;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_19'; wConst: UNIT_END + $225;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_20'; wConst: UNIT_END + $226;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_21'; wConst: UNIT_END + $227;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_22'; wConst: UNIT_END + $228;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_23'; wConst: UNIT_END + $229;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_24'; wConst: UNIT_END + $22A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_25'; wConst: UNIT_END + $22B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_26'; wConst: UNIT_END + $22C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_27'; wConst: UNIT_END + $22D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_28'; wConst: UNIT_END + $22E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_29'; wConst: UNIT_END + $22F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_30'; wConst: UNIT_END + $230;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_31'; wConst: UNIT_END + $231;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_32'; wConst: UNIT_END + $232;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_33'; wConst: UNIT_END + $233;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_34'; wConst: UNIT_END + $234;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_35'; wConst: UNIT_END + $235;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_36'; wConst: UNIT_END + $236;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_37'; wConst: UNIT_END + $237;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_38'; wConst: UNIT_END + $238;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_39'; wConst: UNIT_END + $239;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_40'; wConst: UNIT_END + $23A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_41'; wConst: UNIT_END + $23B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_42'; wConst: UNIT_END + $23C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_43'; wConst: UNIT_END + $23D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_44'; wConst: UNIT_END + $23E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_45'; wConst: UNIT_END + $23F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_46'; wConst: UNIT_END + $240;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_47'; wConst: UNIT_END + $241;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_48'; wConst: UNIT_END + $242;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_49'; wConst: UNIT_END + $243;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_50'; wConst: UNIT_END + $244;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_51'; wConst: UNIT_END + $245;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_52'; wConst: UNIT_END + $246;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_53'; wConst: UNIT_END + $247;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_54'; wConst: UNIT_END + $248;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_55'; wConst: UNIT_END + $249;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_56'; wConst: UNIT_END + $24A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_57'; wConst: UNIT_END + $24B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_58'; wConst: UNIT_END + $24C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_59'; wConst: UNIT_END + $24D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_60'; wConst: UNIT_END + $24E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_61'; wConst: UNIT_END + $24F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_62'; wConst: UNIT_END + $250;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_63'; wConst: UNIT_END + $251;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_64'; wConst: UNIT_END + $252;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_65'; wConst: UNIT_END + $253;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_66'; wConst: UNIT_END + $254;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_67'; wConst: UNIT_END + $255;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_68'; wConst: UNIT_END + $256;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_69'; wConst: UNIT_END + $257;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_70'; wConst: UNIT_END + $258;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_71'; wConst: UNIT_END + $259;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_72'; wConst: UNIT_END + $25A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_73'; wConst: UNIT_END + $25B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_74'; wConst: UNIT_END + $25C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_75'; wConst: UNIT_END + $25D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_76'; wConst: UNIT_END + $25E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_77'; wConst: UNIT_END + $25F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_78'; wConst: UNIT_END + $260;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_79'; wConst: UNIT_END + $261;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_80'; wConst: UNIT_END + $262;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_81'; wConst: UNIT_END + $263;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_82'; wConst: UNIT_END + $264;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_83'; wConst: UNIT_END + $265;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_84'; wConst: UNIT_END + $266;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_85'; wConst: UNIT_END + $267;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_86'; wConst: UNIT_END + $268;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_87'; wConst: UNIT_END + $269;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_88'; wConst: UNIT_END + $26A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_89'; wConst: UNIT_END + $26B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_90'; wConst: UNIT_END + $26C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_91'; wConst: UNIT_END + $26D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_92'; wConst: UNIT_END + $26E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_93'; wConst: UNIT_END + $26F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_94'; wConst: UNIT_END + $270;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_95'; wConst: UNIT_END + $271;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_96'; wConst: UNIT_END + $272;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_97'; wConst: UNIT_END + $273;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_98'; wConst: UNIT_END + $274;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_99'; wConst: UNIT_END + $275;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_100'; wConst: UNIT_END + $276;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_101'; wConst: UNIT_END + $277;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_102'; wConst: UNIT_END + $278;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_103'; wConst: UNIT_END + $279;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_104'; wConst: UNIT_END + $27A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_105'; wConst: UNIT_END + $27B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_106'; wConst: UNIT_END + $27C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_107'; wConst: UNIT_END + $27D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_108'; wConst: UNIT_END + $27E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_109'; wConst: UNIT_END + $27F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_110'; wConst: UNIT_END + $280;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_111'; wConst: UNIT_END + $281;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_112'; wConst: UNIT_END + $282;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_113'; wConst: UNIT_END + $283;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_114'; wConst: UNIT_END + $284;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_115'; wConst: UNIT_END + $285;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_116'; wConst: UNIT_END + $286;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_117'; wConst: UNIT_END + $287;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_118'; wConst: UNIT_END + $288;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_119'; wConst: UNIT_END + $289;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_120'; wConst: UNIT_END + $28A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_121'; wConst: UNIT_END + $28B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_122'; wConst: UNIT_END + $28C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_123'; wConst: UNIT_END + $28D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_124'; wConst: UNIT_END + $28E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_125'; wConst: UNIT_END + $28F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_126'; wConst: UNIT_END + $290;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_127'; wConst: UNIT_END + $291;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_128'; wConst: UNIT_END + $292;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_129'; wConst: UNIT_END + $293;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_130'; wConst: UNIT_END + $294;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_131'; wConst: UNIT_END + $295;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_132'; wConst: UNIT_END + $296;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_133'; wConst: UNIT_END + $297;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_134'; wConst: UNIT_END + $298;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_135'; wConst: UNIT_END + $299;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_136'; wConst: UNIT_END + $29A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_137'; wConst: UNIT_END + $29B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_138'; wConst: UNIT_END + $29C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_139'; wConst: UNIT_END + $29D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_140'; wConst: UNIT_END + $29E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_141'; wConst: UNIT_END + $29F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_142'; wConst: UNIT_END + $2A0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_143'; wConst: UNIT_END + $2A1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_144'; wConst: UNIT_END + $2A2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_145'; wConst: UNIT_END + $2A3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_146'; wConst: UNIT_END + $2A4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_147'; wConst: UNIT_END + $2A5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_148'; wConst: UNIT_END + $2A6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_149'; wConst: UNIT_END + $2A7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_150'; wConst: UNIT_END + $2A8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_151'; wConst: UNIT_END + $2A9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_152'; wConst: UNIT_END + $2AA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_153'; wConst: UNIT_END + $2AB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_154'; wConst: UNIT_END + $2AC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_155'; wConst: UNIT_END + $2AD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_156'; wConst: UNIT_END + $2AE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_157'; wConst: UNIT_END + $2AF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_158'; wConst: UNIT_END + $2B0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_159'; wConst: UNIT_END + $2B1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_160'; wConst: UNIT_END + $2B2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_161'; wConst: UNIT_END + $2B3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_162'; wConst: UNIT_END + $2B4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_163'; wConst: UNIT_END + $2B5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_164'; wConst: UNIT_END + $2B6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_165'; wConst: UNIT_END + $2B7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_166'; wConst: UNIT_END + $2B8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_167'; wConst: UNIT_END + $2B9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_168'; wConst: UNIT_END + $2BA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_169'; wConst: UNIT_END + $2BB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_170'; wConst: UNIT_END + $2BC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_171'; wConst: UNIT_END + $2BD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_172'; wConst: UNIT_END + $2BE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_173'; wConst: UNIT_END + $2BF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_174'; wConst: UNIT_END + $2C0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_175'; wConst: UNIT_END + $2C1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_176'; wConst: UNIT_END + $2C2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_177'; wConst: UNIT_END + $2C3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_178'; wConst: UNIT_END + $2C4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_179'; wConst: UNIT_END + $2C5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_180'; wConst: UNIT_END + $2C6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_181'; wConst: UNIT_END + $2C7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_182'; wConst: UNIT_END + $2C8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_183'; wConst: UNIT_END + $2C9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_184'; wConst: UNIT_END + $2CA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_185'; wConst: UNIT_END + $2CB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_186'; wConst: UNIT_END + $2CC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_187'; wConst: UNIT_END + $2CD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_188'; wConst: UNIT_END + $2CE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_189'; wConst: UNIT_END + $2CF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_190'; wConst: UNIT_END + $2D0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_191'; wConst: UNIT_END + $2D1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_192'; wConst: UNIT_END + $2D2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_193'; wConst: UNIT_END + $2D3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_194'; wConst: UNIT_END + $2D4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_195'; wConst: UNIT_END + $2D5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_196'; wConst: UNIT_END + $2D6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_197'; wConst: UNIT_END + $2D7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_198'; wConst: UNIT_END + $2D8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_199'; wConst: UNIT_END + $2D9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_200'; wConst: UNIT_END + $2DA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_201'; wConst: UNIT_END + $2DB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_202'; wConst: UNIT_END + $2DC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_203'; wConst: UNIT_END + $2DD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_204'; wConst: UNIT_END + $2DE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_205'; wConst: UNIT_END + $2DF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_206'; wConst: UNIT_END + $2E0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_207'; wConst: UNIT_END + $2E1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_208'; wConst: UNIT_END + $2E2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_209'; wConst: UNIT_END + $2E3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_210'; wConst: UNIT_END + $2E4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_211'; wConst: UNIT_END + $2E5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_212'; wConst: UNIT_END + $2E6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_213'; wConst: UNIT_END + $2E7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_214'; wConst: UNIT_END + $2E8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_215'; wConst: UNIT_END + $2E9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_216'; wConst: UNIT_END + $2EA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_217'; wConst: UNIT_END + $2EB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_218'; wConst: UNIT_END + $2EC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_219'; wConst: UNIT_END + $2ED;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_220'; wConst: UNIT_END + $2EE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_221'; wConst: UNIT_END + $2EF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_222'; wConst: UNIT_END + $2F0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_223'; wConst: UNIT_END + $2F1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_224'; wConst: UNIT_END + $2F2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_225'; wConst: UNIT_END + $2F3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_226'; wConst: UNIT_END + $2F4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_227'; wConst: UNIT_END + $2F5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_228'; wConst: UNIT_END + $2F6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_229'; wConst: UNIT_END + $2F7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_230'; wConst: UNIT_END + $2F8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_231'; wConst: UNIT_END + $2F9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_232'; wConst: UNIT_END + $2FA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_233'; wConst: UNIT_END + $2FB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_234'; wConst: UNIT_END + $2FC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_235'; wConst: UNIT_END + $2FD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_236'; wConst: UNIT_END + $2FE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_237'; wConst: UNIT_END + $2FF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_238'; wConst: UNIT_END + $300;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_239'; wConst: UNIT_END + $301;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_240'; wConst: UNIT_END + $302;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_241'; wConst: UNIT_END + $303;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_242'; wConst: UNIT_END + $304;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_243'; wConst: UNIT_END + $305;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_244'; wConst: UNIT_END + $306;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_245'; wConst: UNIT_END + $307;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_246'; wConst: UNIT_END + $308;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_247'; wConst: UNIT_END + $309;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_248'; wConst: UNIT_END + $30A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_249'; wConst: UNIT_END + $30B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_250'; wConst: UNIT_END + $30C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_251'; wConst: UNIT_END + $30D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_252'; wConst: UNIT_END + $30E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_253'; wConst: UNIT_END + $30F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_254'; wConst: UNIT_END + $310;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_255'; wConst: UNIT_END + $311;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_256'; wConst: UNIT_END + $312;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_257'; wConst: UNIT_END + $313;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_258'; wConst: UNIT_END + $314;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_259'; wConst: UNIT_END + $315;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_260'; wConst: UNIT_END + $316;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_261'; wConst: UNIT_END + $317;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_262'; wConst: UNIT_END + $318;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_263'; wConst: UNIT_END + $319;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_264'; wConst: UNIT_END + $31A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_265'; wConst: UNIT_END + $31B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_266'; wConst: UNIT_END + $31C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_267'; wConst: UNIT_END + $31D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_268'; wConst: UNIT_END + $31E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_269'; wConst: UNIT_END + $31F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_270'; wConst: UNIT_END + $320;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_271'; wConst: UNIT_END + $321;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_272'; wConst: UNIT_END + $322;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_273'; wConst: UNIT_END + $323;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_274'; wConst: UNIT_END + $324;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_275'; wConst: UNIT_END + $325;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_276'; wConst: UNIT_END + $326;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_277'; wConst: UNIT_END + $327;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_278'; wConst: UNIT_END + $328;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_279'; wConst: UNIT_END + $329;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_280'; wConst: UNIT_END + $32A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_281'; wConst: UNIT_END + $32B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_282'; wConst: UNIT_END + $32C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_283'; wConst: UNIT_END + $32D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_284'; wConst: UNIT_END + $32E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_285'; wConst: UNIT_END + $32F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_286'; wConst: UNIT_END + $330;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_287'; wConst: UNIT_END + $331;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_288'; wConst: UNIT_END + $332;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_289'; wConst: UNIT_END + $333;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_290'; wConst: UNIT_END + $334;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_291'; wConst: UNIT_END + $335;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_292'; wConst: UNIT_END + $336;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_293'; wConst: UNIT_END + $337;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_294'; wConst: UNIT_END + $338;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_295'; wConst: UNIT_END + $339;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_296'; wConst: UNIT_END + $33A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_297'; wConst: UNIT_END + $33B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_298'; wConst: UNIT_END + $33C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_299'; wConst: UNIT_END + $33D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_300'; wConst: UNIT_END + $33E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_301'; wConst: UNIT_END + $33F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_302'; wConst: UNIT_END + $340;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_303'; wConst: UNIT_END + $341;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_304'; wConst: UNIT_END + $342;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_305'; wConst: UNIT_END + $343;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_306'; wConst: UNIT_END + $344;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_307'; wConst: UNIT_END + $345;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_308'; wConst: UNIT_END + $346;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_309'; wConst: UNIT_END + $347;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_310'; wConst: UNIT_END + $348;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_311'; wConst: UNIT_END + $349;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_312'; wConst: UNIT_END + $34A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_313'; wConst: UNIT_END + $34B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_314'; wConst: UNIT_END + $34C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_315'; wConst: UNIT_END + $34D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_316'; wConst: UNIT_END + $34E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_317'; wConst: UNIT_END + $34F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_318'; wConst: UNIT_END + $350;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_319'; wConst: UNIT_END + $351;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_320'; wConst: UNIT_END + $352;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_321'; wConst: UNIT_END + $353;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_322'; wConst: UNIT_END + $354;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_323'; wConst: UNIT_END + $355;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_324'; wConst: UNIT_END + $356;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_325'; wConst: UNIT_END + $357;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_326'; wConst: UNIT_END + $358;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_327'; wConst: UNIT_END + $359;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_328'; wConst: UNIT_END + $35A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_329'; wConst: UNIT_END + $35B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_330'; wConst: UNIT_END + $35C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_331'; wConst: UNIT_END + $35D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_332'; wConst: UNIT_END + $35E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_333'; wConst: UNIT_END + $35F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_334'; wConst: UNIT_END + $360;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_335'; wConst: UNIT_END + $361;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_336'; wConst: UNIT_END + $362;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_337'; wConst: UNIT_END + $363;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_338'; wConst: UNIT_END + $364;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_339'; wConst: UNIT_END + $365;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_340'; wConst: UNIT_END + $366;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_341'; wConst: UNIT_END + $367;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_342'; wConst: UNIT_END + $368;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_343'; wConst: UNIT_END + $369;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_344'; wConst: UNIT_END + $36A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_345'; wConst: UNIT_END + $36B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_346'; wConst: UNIT_END + $36C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_347'; wConst: UNIT_END + $36D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_348'; wConst: UNIT_END + $36E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_349'; wConst: UNIT_END + $36F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_350'; wConst: UNIT_END + $370;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_351'; wConst: UNIT_END + $371;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_352'; wConst: UNIT_END + $372;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_353'; wConst: UNIT_END + $373;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_354'; wConst: UNIT_END + $374;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_355'; wConst: UNIT_END + $375;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_356'; wConst: UNIT_END + $376;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_357'; wConst: UNIT_END + $377;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_358'; wConst: UNIT_END + $378;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_359'; wConst: UNIT_END + $379;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_360'; wConst: UNIT_END + $37A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_361'; wConst: UNIT_END + $37B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_362'; wConst: UNIT_END + $37C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_363'; wConst: UNIT_END + $37D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_364'; wConst: UNIT_END + $37E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_365'; wConst: UNIT_END + $37F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_366'; wConst: UNIT_END + $380;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_367'; wConst: UNIT_END + $381;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_368'; wConst: UNIT_END + $382;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_369'; wConst: UNIT_END + $383;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_370'; wConst: UNIT_END + $384;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_371'; wConst: UNIT_END + $385;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_372'; wConst: UNIT_END + $386;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_373'; wConst: UNIT_END + $387;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_374'; wConst: UNIT_END + $388;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_375'; wConst: UNIT_END + $389;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_376'; wConst: UNIT_END + $38A;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_377'; wConst: UNIT_END + $38B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_378'; wConst: UNIT_END + $38C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_379'; wConst: UNIT_END + $38D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_380'; wConst: UNIT_END + $38E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_381'; wConst: UNIT_END + $38F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_382'; wConst: UNIT_END + $390;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_SKILL_INFO_1_383'; wConst: UNIT_END + $391;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_CHARACTER_POINTS1'; wConst: UNIT_END + $392;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_CHARACTER_POINTS2'; wConst: UNIT_END + $393;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_TRACK_CREATURES'; wConst: UNIT_END + $394;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_TRACK_RESOURCES'; wConst: UNIT_END + $395;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_BLOCK_PERCENTAGE'; wConst: UNIT_END + $396;
    iType: dtFloat; cCall: nil),
    (sName: 'PLAYER_DODGE_PERCENTAGE'; wConst: UNIT_END + $397;
    iType: dtFloat; cCall: nil),
    (sName: 'PLAYER_PARRY_PERCENTAGE'; wConst: UNIT_END + $398;
    iType: dtFloat; cCall: nil),
    (sName: 'PLAYER_CRIT_PERCENTAGE'; wConst: UNIT_END + $399;
    iType: dtFloat; cCall: nil),
    (sName: 'PLAYER_RANGED_CRIT_PERCENTAGE'; wConst: UNIT_END + $39A;
    iType: dtFloat; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_1'; wConst: UNIT_END + $39B;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_01'; wConst: UNIT_END + $39C;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_02'; wConst: UNIT_END + $39D;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_03'; wConst: UNIT_END + $39E;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_04'; wConst: UNIT_END + $39F;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_05'; wConst: UNIT_END + $3A0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_06'; wConst: UNIT_END + $3A1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_07'; wConst: UNIT_END + $3A2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_08'; wConst: UNIT_END + $3A3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_09'; wConst: UNIT_END + $3A4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_10'; wConst: UNIT_END + $3A5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_11'; wConst: UNIT_END + $3A6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_12'; wConst: UNIT_END + $3A7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_13'; wConst: UNIT_END + $3A8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_14'; wConst: UNIT_END + $3A9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_15'; wConst: UNIT_END + $3AA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_16'; wConst: UNIT_END + $3AB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_17'; wConst: UNIT_END + $3AC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_18'; wConst: UNIT_END + $3AD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_19'; wConst: UNIT_END + $3AE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_20'; wConst: UNIT_END + $3AF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_21'; wConst: UNIT_END + $3B0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_22'; wConst: UNIT_END + $3B1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_23'; wConst: UNIT_END + $3B2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_24'; wConst: UNIT_END + $3B3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_25'; wConst: UNIT_END + $3B4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_26'; wConst: UNIT_END + $3B5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_27'; wConst: UNIT_END + $3B6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_28'; wConst: UNIT_END + $3B7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_29'; wConst: UNIT_END + $3B8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_30'; wConst: UNIT_END + $3B9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_31'; wConst: UNIT_END + $3BA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_32'; wConst: UNIT_END + $3BB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_33'; wConst: UNIT_END + $3BC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_34'; wConst: UNIT_END + $3BD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_35'; wConst: UNIT_END + $3BE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_36'; wConst: UNIT_END + $3BF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_37'; wConst: UNIT_END + $3C0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_38'; wConst: UNIT_END + $3C1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_39'; wConst: UNIT_END + $3C2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_40'; wConst: UNIT_END + $3C3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_41'; wConst: UNIT_END + $3C4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_42'; wConst: UNIT_END + $3C5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_43'; wConst: UNIT_END + $3C6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_44'; wConst: UNIT_END + $3C7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_45'; wConst: UNIT_END + $3C8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_46'; wConst: UNIT_END + $3C9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_47'; wConst: UNIT_END + $3CA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_48'; wConst: UNIT_END + $3CB;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_49'; wConst: UNIT_END + $3CC;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_50'; wConst: UNIT_END + $3CD;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_51'; wConst: UNIT_END + $3CE;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_52'; wConst: UNIT_END + $3CF;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_53'; wConst: UNIT_END + $3D0;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_54'; wConst: UNIT_END + $3D1;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_55'; wConst: UNIT_END + $3D2;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_56'; wConst: UNIT_END + $3D3;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_57'; wConst: UNIT_END + $3D4;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_58'; wConst: UNIT_END + $3D5;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_59'; wConst: UNIT_END + $3D6;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_60'; wConst: UNIT_END + $3D7;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_61'; wConst: UNIT_END + $3D8;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_62'; wConst: UNIT_END + $3D9;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_EXPLORED_ZONES_63'; wConst: UNIT_END + $3DA;
    iType: dtBit; cCall: nil),
    (sName: 'PLAYER_REST_STATE_EXPERIENCE'; wConst: UNIT_END + $3DB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COINAGE'; wConst: UNIT_END + $3DC; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_POSSTAT0'; wConst: UNIT_END + $3DD; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_POSSTAT1'; wConst: UNIT_END + $3DE; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_POSSTAT2'; wConst: UNIT_END + $3DF; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_POSSTAT3'; wConst: UNIT_END + $3E0; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_POSSTAT4'; wConst: UNIT_END + $3E1; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_NEGSTAT0'; wConst: UNIT_END + $3E2; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_NEGSTAT1'; wConst: UNIT_END + $3E3; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_NEGSTAT2'; wConst: UNIT_END + $3E4; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_NEGSTAT3'; wConst: UNIT_END + $3E5; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_NEGSTAT4'; wConst: UNIT_END + $3E6; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE'; wConst: UNIT_END + $3E7;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE_01'; wConst: UNIT_END + $3E8;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE_02'; wConst: UNIT_END + $3E9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE_03'; wConst: UNIT_END + $3EA;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE_04'; wConst: UNIT_END + $3EB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE_05'; wConst: UNIT_END + $3EC;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSPOSITIVE_06'; wConst: UNIT_END + $3ED;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE'; wConst: UNIT_END + $3EE;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE_01'; wConst: UNIT_END + $3EF;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE_02'; wConst: UNIT_END + $3F0;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE_03'; wConst: UNIT_END + $3F1;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE_04'; wConst: UNIT_END + $3F2;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE_05'; wConst: UNIT_END + $3F3;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_RESISTANCEBUFFMODSNEGATIVE_06'; wConst: UNIT_END + $3F4;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS'; wConst: UNIT_END + $3F5;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS_01'; wConst: UNIT_END + $3F6;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS_02'; wConst: UNIT_END + $3F7;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS_03'; wConst: UNIT_END + $3F8;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS_04'; wConst: UNIT_END + $3F9;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS_05'; wConst: UNIT_END + $3FA;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_POS_06'; wConst: UNIT_END + $3FB;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG'; wConst: UNIT_END + $3FC;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG_01'; wConst: UNIT_END + $3FD;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG_02'; wConst: UNIT_END + $3FE;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG_03'; wConst: UNIT_END + $3FF;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG_04'; wConst: UNIT_END + $400;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG_05'; wConst: UNIT_END + $401;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_NEG_06'; wConst: UNIT_END + $402;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT'; wConst: UNIT_END + $403;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT_01'; wConst: UNIT_END + $404;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT_02'; wConst: UNIT_END + $405;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT_03'; wConst: UNIT_END + $406;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT_04'; wConst: UNIT_END + $407;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT_05'; wConst: UNIT_END + $408;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_MOD_DAMAGE_DONE_PCT_06'; wConst: UNIT_END + $409;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BYTES'; wConst: UNIT_END + $40A; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_AMMO_ID'; wConst: UNIT_END + $40B; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_SELF_RES_SPELL'; wConst: UNIT_END + $40C; iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_PVP_MEDALS'; wConst: UNIT_END + $40D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_1'; wConst: UNIT_END + $40E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_01'; wConst: UNIT_END + $40F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_02'; wConst: UNIT_END + $410;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_03'; wConst: UNIT_END + $411;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_04'; wConst: UNIT_END + $412;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_05'; wConst: UNIT_END + $413;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_06'; wConst: UNIT_END + $414;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_07'; wConst: UNIT_END + $415;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_08'; wConst: UNIT_END + $416;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_09'; wConst: UNIT_END + $417;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_10'; wConst: UNIT_END + $418;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_PRICE_11'; wConst: UNIT_END + $419;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_1'; wConst: UNIT_END + $41A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_01'; wConst: UNIT_END + $41B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_02'; wConst: UNIT_END + $41C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_03'; wConst: UNIT_END + $41D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_04'; wConst: UNIT_END + $41E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_05'; wConst: UNIT_END + $41F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_06'; wConst: UNIT_END + $420;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_07'; wConst: UNIT_END + $421;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_08'; wConst: UNIT_END + $422;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_09'; wConst: UNIT_END + $423;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_10'; wConst: UNIT_END + $424;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BUYBACK_TIMESTAMP_11'; wConst: UNIT_END + $425;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_SESSION_KILLS'; wConst: UNIT_END + $426;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_YESTERDAY_KILLS'; wConst: UNIT_END + $427;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_LAST_WEEK_KILLS'; wConst: UNIT_END + $428;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_THIS_WEEK_KILLS'; wConst: UNIT_END + $429;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_THIS_WEEK_CONTRIBUTION'; wConst: UNIT_END + $42A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_LIFETIME_HONORBALE_KILLS'; wConst: UNIT_END + $42B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_LIFETIME_DISHONORBALE_KILLS'; wConst: UNIT_END + $42C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_YESTERDAY_CONTRIBUTION'; wConst: UNIT_END + $42D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_LAST_WEEK_CONTRIBUTION'; wConst: UNIT_END + $42E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_LAST_WEEK_RANK'; wConst: UNIT_END + $42F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_BYTES2'; wConst: UNIT_END + $430; iType: dtBit; cCall: nil),
    (sName: 'PLAYER_FIELD_WATCHED_FACTION_INDEX'; wConst: UNIT_END + $431;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_1'; wConst: UNIT_END + $432;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_01'; wConst: UNIT_END + $433;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_02'; wConst: UNIT_END + $434;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_03'; wConst: UNIT_END + $435;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_04'; wConst: UNIT_END + $436;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_05'; wConst: UNIT_END + $437;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_06'; wConst: UNIT_END + $438;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_07'; wConst: UNIT_END + $439;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_08'; wConst: UNIT_END + $43A;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_09'; wConst: UNIT_END + $43B;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_10'; wConst: UNIT_END + $43C;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_11'; wConst: UNIT_END + $43D;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_12'; wConst: UNIT_END + $43E;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_13'; wConst: UNIT_END + $43F;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_14'; wConst: UNIT_END + $440;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_15'; wConst: UNIT_END + $441;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_16'; wConst: UNIT_END + $442;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_17'; wConst: UNIT_END + $443;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_18'; wConst: UNIT_END + $444;
    iType: dtI32; cCall: nil),
    (sName: 'PLAYER_FIELD_COMBAT_RATING_19'; wConst: UNIT_END + $445;
    iType: dtI32; cCall: nil)
    );


  GameObjectUpdateFields: array[0..18] of TSchUpdateField =
    (
    (sName: 'OBJECT_FIELD_CREATED_BY'; wConst: OBJECT_END + $000;
    iType: dtGUID; cCall: nil),
    (sName: 'GAMEOBJECT_DISPLAYID'; wConst: OBJECT_END + $002;
    iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_FLAGS'; wConst: OBJECT_END + $003; iType: dtBit; cCall: nil),
    (sName: 'GAMEOBJECT_ROTATION'; wConst: OBJECT_END + $004;
    iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_ROTATION_01'; wConst: OBJECT_END + $005;
    iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_ROTATION_02'; wConst: OBJECT_END + $006;
    iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_ROTATION_03'; wConst: OBJECT_END + $007;
    iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_STATE'; wConst: OBJECT_END + $008; iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_POS_X'; wConst: OBJECT_END + $009; iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_POS_Y'; wConst: OBJECT_END + $00A; iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_POS_Z'; wConst: OBJECT_END + $00B; iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_FACING'; wConst: OBJECT_END + $00C; iType: dtFloat; cCall: nil),
    (sName: 'GAMEOBJECT_DYN_FLAGS'; wConst: OBJECT_END + $00D;
    iType: dtBit; cCall: nil),
    (sName: 'GAMEOBJECT_FACTION'; wConst: OBJECT_END + $00E; iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_TYPE_ID'; wConst: OBJECT_END + $00F; iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_LEVEL'; wConst: OBJECT_END + $010; iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_ARTKIT'; wConst: OBJECT_END + $011; iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_ANIMPROGRESS'; wConst: OBJECT_END + $012;
    iType: dtI32; cCall: nil),
    (sName: 'GAMEOBJECT_PADDING'; wConst: OBJECT_END + $013; iType: dtI32; cCall: nil)
    );


  DynamicObjectUpdateFields: array[0..8] of TSchUpdateField =
    (
    (sName: 'DYNAMICOBJECT_CASTER'; wConst: OBJECT_END + $000;
    iType: dtGUID; cCall: nil),
    (sName: 'DYNAMICOBJECT_BYTES'; wConst: OBJECT_END + $002; iType: dtBit; cCall: nil),
    (sName: 'DYNAMICOBJECT_SPELLID'; wConst: OBJECT_END + $003;
    iType: dtI32; cCall: nil),
    (sName: 'DYNAMICOBJECT_RADIUS'; wConst: OBJECT_END + $004;
    iType: dtFloat; cCall: nil),
    (sName: 'DYNAMICOBJECT_POS_X'; wConst: OBJECT_END + $005;
    iType: dtFloat; cCall: nil),
    (sName: 'DYNAMICOBJECT_POS_Y'; wConst: OBJECT_END + $006;
    iType: dtFloat; cCall: nil),
    (sName: 'DYNAMICOBJECT_POS_Z'; wConst: OBJECT_END + $007;
    iType: dtFloat; cCall: nil),
    (sName: 'DYNAMICOBJECT_FACING'; wConst: OBJECT_END + $008;
    iType: dtFloat; cCall: nil),
    (sName: 'DYNAMICOBJECT_PAD'; wConst: OBJECT_END + $009; iType: dtI32; cCall: nil)
    );

  CorpseUpdateFields: array[0..30] of TSchUpdateField =
    (
    (sName: 'CORPSE_FIELD_OWNER'; wConst: OBJECT_END + $000; iType: dtGUID; cCall: nil),
    (sName: 'CORPSE_FIELD_FACING'; wConst: OBJECT_END + $002;
    iType: dtFloat; cCall: nil),
    (sName: 'CORPSE_FIELD_POS_X'; wConst: OBJECT_END + $003;
    iType: dtFloat; cCall: nil),
    (sName: 'CORPSE_FIELD_POS_Y'; wConst: OBJECT_END + $004;
    iType: dtFloat; cCall: nil),
    (sName: 'CORPSE_FIELD_POS_Z'; wConst: OBJECT_END + $005;
    iType: dtFloat; cCall: nil),
    (sName: 'CORPSE_FIELD_DISPLAY_ID'; wConst: OBJECT_END + $006;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM'; wConst: OBJECT_END + $007; iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_01'; wConst: OBJECT_END + $008;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_02'; wConst: OBJECT_END + $009;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_03'; wConst: OBJECT_END + $00A;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_04'; wConst: OBJECT_END + $00B;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_05'; wConst: OBJECT_END + $00C;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_06'; wConst: OBJECT_END + $00D;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_07'; wConst: OBJECT_END + $00E;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_08'; wConst: OBJECT_END + $00F;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_09'; wConst: OBJECT_END + $010;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_10'; wConst: OBJECT_END + $011;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_11'; wConst: OBJECT_END + $012;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_12'; wConst: OBJECT_END + $013;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_13'; wConst: OBJECT_END + $014;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_14'; wConst: OBJECT_END + $015;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_15'; wConst: OBJECT_END + $016;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_16'; wConst: OBJECT_END + $017;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_17'; wConst: OBJECT_END + $018;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_ITEM_18'; wConst: OBJECT_END + $019;
    iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_BYTES_1'; wConst: OBJECT_END + $01A;
    iType: dtBit; cCall: nil),
    (sName: 'CORPSE_FIELD_BYTES_2'; wConst: OBJECT_END + $01B;
    iType: dtBit; cCall: nil),
    (sName: 'CORPSE_FIELD_GUILD'; wConst: OBJECT_END + $01C; iType: dtI32; cCall: nil),
    (sName: 'CORPSE_FIELD_FLAGS'; wConst: OBJECT_END + $01D; iType: dtBit; cCall: nil),
    (sName: 'CORPSE_FIELD_DYNAMIC_FLAGS'; wConst: OBJECT_END + $01E;
    iType: dtBit; cCall: nil),
    (sName: 'CORPSE_FIELD_PAD'; wConst: OBJECT_END + $01F; iType: dtI32; cCall: nil)
    );


function GetUpdateField(iUpdateField: Cardinal; iObjType: Integer): TSchUpdateField;

implementation

function SelectFrom(aBlock: array of TSchUpdateField; iUpdateField: Cardinal;
  fDef: TSchUpdateField): TSchUpdateField;
var
  iI, iDif: Integer;
begin
  Result := fDef;

  for iI := 0 to Length(aBlock) - 1 do
  begin
    if aBlock[iI].wConst = iUpdateField then
    begin
      Result := aBlock[iI];
      Exit;
    end;

    if aBlock[iI].wConst > iUpdateField then
    begin
      if iI = 0 then Exit;

      iDif := iUpdateField - aBlock[iI - 1].wConst;

      Result.sName := aBlock[iI - 1].sName + ' + ' + IntToStr(iDif);
      Result.wConst := iUpdateField;
      Result.iType := aBlock[iI - 1].iType;
      Result.cCall := aBlock[iI - 1].cCall;

      Exit;
    end;
  end;

end;


function GetUpdateField(iUpdateField: Cardinal; iObjType: Integer): TSchUpdateField;
begin
  Result.sName := 'FIELD_' + IntToHex(iUpdateField, 8);
  Result.iType := dtI32;
  Result.wConst := iUpdateField;

  case iObjType of

    OBJTYPEID_OBJECT:
    begin
      if iUpdateField < OBJECT_END then
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_ITEM:
    begin
      if iUpdateField >= OBJECT_END then
        Result := SelectFrom(ItemUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_CONTAINER:
    begin
      if iUpdateField >= ITEM_END then
        Result := SelectFrom(ContainerUpdateFields, iUpdateField, Result)
      else if iUpdateField >= OBJECT_END then
        Result := SelectFrom(ItemUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_UNIT:
    begin
      if iUpdateField >= OBJECT_END then
        Result := SelectFrom(UnitUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_PLAYER:
    begin
      if iUpdateField >= UNIT_END then
        Result := SelectFrom(PlayerUpdateFields, iUpdateField, Result)
      else if iUpdateField >= OBJECT_END then
        Result := SelectFrom(UnitUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_GAMEOBJECT:
    begin
      if iUpdateField >= OBJECT_END then
        Result := SelectFrom(GameObjectUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_DYNAMICOBJECT:
    begin
      if iUpdateField >= OBJECT_END then
        Result := SelectFrom(DynamicObjectUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

    OBJTYPEID_CORPSE:
    begin
      if iUpdateField >= OBJECT_END then
        Result := SelectFrom(CorpseUpdateFields, iUpdateField, Result)
      else
        Result := SelectFrom(ObjectUpdateFields, iUpdateField, Result);
    end;

  end;

  // OBJTYPEID_OBJECT                                      = 0;
  // OBJTYPEID_ITEM                                        = 1;
  // OBJTYPEID_CONTAINER                                   = 2;
  // OBJTYPEID_UNIT                                        = 3;
  // OBJTYPEID_PLAYER                                      = 4;
  // OBJTYPEID_GAMEOBJECT                                  = 5;
  // OBJTYPEID_DYNAMICOBJECT                               = 6;
  // OBJTYPEID_CORPSE                                      = 7;
  // OBJTYPEID_AIGROUP                                     = 8;
  // OBJTYPEID_AREATRIGGER                                 = 9;
end;

end.
