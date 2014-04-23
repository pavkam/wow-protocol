unit FlowProcess;

interface

uses
  WoWTypes;

type
  TSchFlowType = (ftInt64, ftInt32, ftInt16, ftInt8, ftGUID,
    ftMaskedGUID, ftFloat, ftString);
  TSchFlowFormat = (ffDecimal, ffHex, ffBinary);

  TSchFlowEntry = record
    iType: TSchFlowType;
    iFormat: TSchFlowFormat;
    sName: String;
    cCall: TSchConstCallBack;
  end;

 { Flow Parts }
 //const

implementation

end.
