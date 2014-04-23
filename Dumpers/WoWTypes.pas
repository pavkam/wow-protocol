unit WoWTypes;

interface

type
  { Constant decryptor callback }
  TSchConstCallBack = function(iConst: Cardinal): String;

  TSchValueBlock = record
    iValue: Cardinal;
    sName: String;
  end;

{ Update block types }
const
  UPDATETYPE_VALUES   = 0;
  UPDATETYPE_MOVEMENT = 1;
  UPDATETYPE_CREATE_OBJECT = 2;
  UPDATETYPE_CREATE_OBJECT_ME = 3;
  UPDATETYPE_NEAR_OBJECTS = 5;
  UPDATETYPE_OUT_OF_RANGE_OBJECTS = 4;

const
  MOVE_BASE_FLAG_NONE      = $000000;
  MOVE_BASE_FLAG_UNKNOWN3  = $000001;
  MOVE_BASE_FLAG_UNKNOWN4  = $000002;
  MOVE_BASE_FLAG_ATTACKING = $000004;
  MOVE_BASE_FLAG_UNKNOWN1  = $000008;
  MOVE_BASE_FLAG_UNKNOWN0  = $000010;
  MOVE_BASE_FLAG_EXTENDED  = $000020;
  MOVE_BASE_FLAG_INITIAL_POS = $000040;
  MOVE_BASE_FLAG_UNKNOWN2  = $000080;

  MOVE_SECOND_FLAG_NONE     = $000000;
  MOVE_SECOND_FLAG_UNKNOWN4 = $000001;
  MOVE_SECOND_FLAG_UNIQUE   = $000100;
  MOVE_SECOND_FLAG_CORRECTION = $002000;
  MOVE_SECOND_FLAG_UNKNOWN5 = $200000;
  MOVE_SECOND_FLAG_HAS_SPLINE = $400000;
  MOVE_SECOND_FLAG_UNKNOWN3 = $800000;

const
  OBJTYPEID_OBJECT    = 0;
  OBJTYPEID_ITEM      = 1;
  OBJTYPEID_CONTAINER = 2;
  OBJTYPEID_UNIT      = 3;
  OBJTYPEID_PLAYER    = 4;
  OBJTYPEID_GAMEOBJECT = 5;
  OBJTYPEID_DYNAMICOBJECT = 6;
  OBJTYPEID_CORPSE    = 7;
  OBJTYPEID_AIGROUP   = 8;
  OBJTYPEID_AREATRIGGER = 9;


const
  AUTH_OK     = $0C;       { Authentication successful }
  AUTH_FAILED = $0D;       { Authentication failed }
  AUTH_REJECT = $0E;       { Rejected - please contact customer support }
  AUTH_BAD_SERVER_PROOF = $0F;  { Server is not valid }
  AUTH_UNAVAILABLE = $10;  { System unavailable - please try again later }
  AUTH_SYSTEM_ERROR = $11;  { System error }
  AUTH_BILLING_ERROR = $12;  { Billing system error }
  AUTH_BILLING_EXPIRED = $13;  { Account billing has expired }
  AUTH_VERSION_MISMATCH = $14;  { Wrong client version }
  AUTH_UNKNOWN_ACCOUNT = $15;  { Unknown account }

  AUTH_INCORRECT_PASSWORD = $16;  { Incorrect password }
  AUTH_SESSION_EXPIRED = $17;  { Session expired }
  AUTH_SERVER_SHUTTING_DOWN = $18;  { Server shutting down }
  AUTH_ALREADY_LOGGING_IN = $19;  { Already logging in }
  AUTH_LOGIN_SERVER_NOT_FOUND = $1A;  { Invalid login server }
  AUTH_WAIT_QUEUE = $1B;  { Position in queue - (number) }


function __AUTHCODE(iConst: Cardinal): String;

function __UPDATETYPE(iConst: Cardinal): String;
function __OBJTYPEID(iConst: Cardinal): String;
function __OBJTYPE(iConst: Cardinal): String;
function __UNITSTANDTYPE(iConst: Cardinal): String;


implementation

const
  UpdateTypes: array[0..5] of TSchValueBlock =
    (
    (iValue: 0; sName: 'UPDATETYPE_VALUES'),
    (iValue: 1; sName: 'UPDATETYPE_MOVEMENT'),
    (iValue: 2; sName: 'UPDATETYPE_CREATE_OBJECT'),
    (iValue: 3; sName: 'UPDATETYPE_CREATE_OBJECT_ME'),
    (iValue: 4; sName: 'UPDATETYPE_OUT_OF_RANGE_OBJECTS'),
    (iValue: 5; sName: 'UPDATETYPE_NEAR_OBJECTS')
    );


  ObjectTypes: array[0..9] of TSchValueBlock =
    (
    (iValue: 0; sName: 'OBJTYPEID_OBJECT'),
    (iValue: 1; sName: 'OBJTYPEID_ITEM'),
    (iValue: 2; sName: 'OBJTYPEID_CONTAINER'),
    (iValue: 3; sName: 'OBJTYPEID_UNIT'),
    (iValue: 4; sName: 'OBJTYPEID_PLAYER'),
    (iValue: 5; sName: 'OBJTYPEID_GAMEOBJECT'),
    (iValue: 6; sName: 'OBJTYPEID_DYNAMICOBJECT'),
    (iValue: 7; sName: 'OBJTYPEID_CORPSE'),
    (iValue: 8; sName: 'OBJTYPEID_AIGROUP'),
    (iValue: 9; sName: 'OBJTYPEID_AREATRIGGER')
    );


  ObjectFlags: array[0..9] of TSchValueBlock =
    (
    (iValue: 001; sName: 'TYPE_OBJECT'),
    (iValue: 002; sName: 'TYPE_ITEM'),
    (iValue: 004; sName: 'TYPE_CONTAINER'),
    (iValue: 008; sName: 'TYPE_UNIT'),
    (iValue: 016; sName: 'TYPE_PLAYER'),
    (iValue: 032; sName: 'TYPE_GAMEOBJECT'),
    (iValue: 064; sName: 'TYPE_DYNAMICOBJECT'),
    (iValue: 128; sName: 'TYPE_CORPSE'),
    (iValue: 256; sName: 'TYPE_AIGROUP'),
    (iValue: 512; sName: 'TYPE_AREATRIGGER')
    );


  AuthValues: array[0..15] of TSchValueBlock =
    (
    (iValue: $0C; sName: 'AUTH_OK'),
    (iValue: $0D; sName: 'AUTH_FAILED'),
    (iValue: $0E; sName: 'AUTH_REJECT'),
    (iValue: $0F; sName: 'AUTH_BAD_SERVER_PROOF'),
    (iValue: $10; sName: 'AUTH_UNAVAILABLE'),
    (iValue: $11; sName: 'AUTH_SYSTEM_ERROR'),
    (iValue: $12; sName: 'AUTH_BILLING_ERROR'),
    (iValue: $13; sName: 'AUTH_BILLING_EXPIRED'),
    (iValue: $14; sName: 'AUTH_VERSION_MISMATCH'),
    (iValue: $15; sName: 'AUTH_UNKNOWN_ACCOUNT'),
    (iValue: $16; sName: 'AUTH_INCORRECT_PASSWORD'),
    (iValue: $17; sName: 'AUTH_SESSION_EXPIRED'),
    (iValue: $18; sName: 'AUTH_SERVER_SHUTTING_DOWN'),
    (iValue: $19; sName: 'AUTH_ALREADY_LOGGING_IN'),
    (iValue: $1A; sName: 'AUTH_LOGIN_SERVER_NOT_FOUND'),
    (iValue: $1B; sName: 'AUTH_WAIT_QUEUE')
    );

  UnitStateTypes: array[0..8] of TSchValueBlock =
    (
    (iValue: 0; sName: 'UNIT_STATE_STAND'),
    (iValue: 1; sName: 'UNIT_STATE_SIT'),
    (iValue: 2; sName: 'UNIT_STATE_SIT_CHAIR'),
    (iValue: 3; sName: 'UNIT_STATE_SLEEP'),
    (iValue: 4; sName: 'UNIT_STATE_SIT_LOW_CHAIR'),
    (iValue: 5; sName: 'UNIT_STATE_SIT_MEDIUM_CHAIR'),
    (iValue: 6; sName: 'UNIT_STATE_SIT_HIGH_CHAIR'),
    (iValue: 7; sName: 'UNIT_STATE_DEAD'),
    (iValue: 8; sName: 'UNIT_STATE_KNEEL')
    );


function __DIRECT__(iConst: Cardinal; aArray: array of TSchValueBlock;
  sDef: String): String;
var
  i: Integer;
begin
  for i := 0 to Length(aArray) - 1 do if iConst = aArray[i].iValue then
    begin
      Result := aArray[i].sName;
      exit;
    end;

  Result := sDef;
end;

function __FLAGS__(iConst: Cardinal; aArray: array of TSchValueBlock): String;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to Length(aArray) - 1 do if (iConst and aArray[i].iValue) <> 0 then
    begin
      Result := Result + '|' + aArray[i].sName;
    end;

  if Result = '' then Result := '-'
  else
    Delete(Result, 1, 1);
end;

function __UPDATETYPE(iConst: Cardinal): String;
begin
  Result := __DIRECT__(iConst, UpdateTypes, 'UPDATETYPE_UNK');
end;

function __OBJTYPEID(iConst: Cardinal): String;
begin
  Result := __DIRECT__(iConst, ObjectTypes, 'OBJTYPEID_UNK');
end;

function __OBJTYPE(iConst: Cardinal): String;
begin
  Result := __FLAGS__(iConst, ObjectFlags);
end;

function __AUTHCODE(iConst: Cardinal): String;
begin
  Result := __DIRECT__(iConst, AuthValues, 'AUTH_UNK');
end;

function __UNITSTANDTYPE(iConst: Cardinal): String;
begin
  Result := __DIRECT__(iConst and $FF, UnitStateTypes, 'UNIT_STATE_UNK');
end;



end.
