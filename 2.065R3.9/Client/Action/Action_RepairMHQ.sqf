_vehicle = _this select 0;

_hq = (sideJoinedText) Call GetSideHQ;
if (alive _hq || (_hq distance _vehicle > 30)) exitWith {};

//--- Is HQ already being fixed?
_isBeingFixed = WF_Logic getVariable Format ["%1MHQRepair",sideJoinedText];
if (_isBeingFixed) exitWith {};

_repairPrice = 'WFBE_MHQREPAIRPRICE' Call GetNamespace;
_supply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
if (_supply < _repairPrice) exitWith {hint Format [localize "STR_WF_Repair_MHQ_Funds",_repairPrice - _supply]};
_supply = _supply - _repairPrice;
WF_Logic setVariable [Format["%1Supplies",sideJoinedText],_supply,true];

WFBE_RequestMHQRepair = ['SRVFNCREQUESTMHQREPAIR',sideJoined];
publicVariable 'WFBE_RequestMHQRepair';
if (IsClientServer) then {['SRVFNCREQUESTMHQREPAIR',sideJoined] Spawn HandleSPVF};

WF_Logic setVariable [Format ["%1MHQRepair",sideJoinedText],true,true];