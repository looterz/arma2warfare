_vehicle = _this select 0;

_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];
if ((getDammage _hq < 1)||(_hq distance _vehicle > 30)) exitWith {};

_repairPrice = 'WFBE_MHQREPAIRPRICE' Call GetNamespace;
_supply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
if (_supply < _repairPrice) exitWith {hint Format [localize "STR_WF_Repair_MHQ_Funds",_repairPrice - _supply]};
_supply = _supply - _repairPrice;
WF_Logic setVariable [Format["%1Supplies",sideJoinedText],_supply,true];

//--- Is HQ already being fixed?
_isBeingFixed = WF_Logic getVariable Format ["%1MHQRepair",sideJoinedText];
if (_isBeingFixed) exitWith {};

[CMDREQUESTMHQREPAIR,sideJoined] Spawn CommandToServer;
WF_Logic setVariable [Format ["%1MHQRepair",sideJoinedText],true,true];