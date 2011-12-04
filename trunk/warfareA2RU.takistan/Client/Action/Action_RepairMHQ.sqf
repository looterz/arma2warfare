Private ["_currency","_currencySym","_hq","_isBeingFixed","_repairPrice","_vehicle"];

_vehicle = _this select 0;

_hq = (sideJoinedText) Call GetSideHQ;
if (alive _hq || (_hq distance _vehicle > 30)) exitWith {hint (localize "STR_WF_INFO_Repair_MHQ_None")};

//--- Is HQ already being fixed?
_isBeingFixed = WF_Logic getVariable Format ["%1MHQRepair",sideJoinedText];
if (_isBeingFixed) exitWith {hint (localize "STR_WF_INFO_Repair_MHQ_BeingRepaired")};

_repairPrice = 'WFBE_MHQREPAIRPRICE' Call GetNamespace;

//--- progressive MHQ REPAIR cost Begin ---
_repairCount = WF_Logic getVariable Format ["%1MHQRepairCount",sideJoinedText];
if (isNil "_repairCount") then {
	_repairCount = 0;
};
_repairPrice = _repairPrice * (1 + (0.5 * _repairCount));
//--- progressive MHQ REPAIR cost End ---

_currency = if !(paramMoneyOnly) then {(sideJoined) Call GetSideSupply} else {Call GetPlayerFunds};
_currencySym = if !(paramMoneyOnly) then {"S"} else {"$"};
if (_currency < _repairPrice) exitWith {hint Format [localize "STR_WF_INFO_Repair_MHQ_Funds",_currencySym,_repairPrice - _currency]};

WF_Logic setVariable [format ["%1MHQRepairCount",sideJoinedText], _repairCount + 1, true];

if !(paramMoneyOnly) then {
	[sideJoined, -_repairPrice] Call ChangeSideSupply;
} else {
	-(_repairPrice) Call ChangePlayerFunds;
};

WFBE_RequestMHQRepair = ['SRVFNCREQUESTMHQREPAIR',sideJoined];
publicVariable 'WFBE_RequestMHQRepair';
if (isHostedServer) then {['SRVFNCREQUESTMHQREPAIR',sideJoined] Spawn HandleSPVF};

WF_Logic setVariable [Format ["%1MHQRepair",sideJoinedText],true,true];

hint (localize "STR_WF_INFO_Repair_MHQ_Repair");