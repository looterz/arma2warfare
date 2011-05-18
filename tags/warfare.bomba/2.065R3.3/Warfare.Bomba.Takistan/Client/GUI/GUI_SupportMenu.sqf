MenuAction = -1;

_vehi = [group player,false] Call GetTeamVehicles;
_alives = (units group player) Call GetLiveUnits;
{if (vehicle _x == _x) then {_vehi = _vehi + [_x]}} forEach _alives;
_lastUse = 0;
ctrlEnable [20007,false];
_typeRepair = Format['WFBE_%1REPAIRTRUCKS',sideJoinedText] Call GetNamespace;
_ss = 'WFBE_SUPPLYSYSTEM' Call GetNamespace;
_sheal = 'WFBE_SUPPORTHEALTIME' Call GetNamespace;
_srearm = 'WFBE_SUPPORTREARMTIME' Call GetNamespace;
_srefuel = 'WFBE_SUPPORTREFUELTIME' Call GetNamespace;
_srepair = 'WFBE_SUPPORTREPAIRTIME' Call GetNamespace;

_healPrice = 0;
_repairPrice = 0;
_refuelPrice = 0;
_rearmPrice = 0;
_lastVeh = objNull;
_lastDmg = 0;
_lastFue = 0;

_buildings = (sideJoinedText) Call GetSideStructures;

//--- Service Point.
_csp = objNull;
_sp = [sideJoined, Format ["WFBE_%1SERVICEPOINTTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
if (count _sp != 0) then {
	_sorted = [player,_sp] Call SortByDistance;
	_csp = _sorted select 0;
};

if (paramEASA) then {
	_enable = false;
	_currentUpgrades = (sideJoinedText) Call GetSideUpgrades;
	_easaLevel = _currentUpgrades select 15;
	if (!(isNull _csp) && _easaLevel != 0) then {
		if (player distance _csp < ('WFBE_SUPPORTRANGE' Call GetNamespace)) then {
			if (typeOf(vehicle player) in ('WFBE_EASA_Vehicles' Call GetNamespace)) then {
				if (driver (vehicle player) == player) then {_enable = true};
			};
		};
	};
	ctrlEnable [20010,_enable];
} else {
	ctrlEnable [20010,false];
};

_effective = [];
{
	_closestSP = objNull;
	_add = false;
	if (count _sp != 0) then {
		_sorted = [_x,_sp] Call SortByDistance;
		_closestSP = _sorted select 0;
	};
	if !(isNull _closestSP) then {if (_x distance _closestSP < ('WFBE_SUPPORTRANGE' Call GetNamespace)) then {_add = true}};
	if !(_add) then {
		_nObjects = nearestObjects [_x, WFDEPOT,('WFBE_SUPPORTRANGE' Call GetNamespace)];
		_nObject = if (count _nObjects != 0) then {_nObjects select 0} else {objNull};
		if !(isNull _nObject) then {
			_sideID = _nObject getVariable "sideID";
			if !(isNil "_sideID") then {
				if (_sideID == sideID) then {_add = true};
			};
		};
		if !(_add) then {
			_checks = (getPos _x) nearEntities[_typeRepair,'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
			if (count _checks != 0) then {_add = true};
		};
		
		if (!_add && _x isKindOf 'Air') then {
			_pura = ('WFBE_SUPPORTRANGE' Call GetNamespace);
			_sorted = [_x, Airfields] Call SortByDistance;
			if (count _sorted != 0) then {
				if ((_sorted select 0) distance _x < _pura && alive(_sorted select 0)) then { _add = true; };
			};
		};		
	};
	if (_add) then {
		_effective = _effective + [_x];
		_desc = [typeOf _x, 'displayName'] Call GetConfigInfo;
		_text = toArray(str(_x));
		_amount = count _text;
		_val = _text select (_amount-2);
		_val2 = _text select (_amount-1);
		_ainumber = if (_val == 58) then {[_val2]} else {[_val, _val2]};
		_finalNumber = if (isPlayer _x) then {"1"} else {toString(_ainumber)};
		_isInVehicle = "";
		if (_x != vehicle _x) then {
			_descVehi = [typeOf (vehicle _x), 'displayName'] Call GetConfigInfo;
			_isInVehicle = " [" + _descVehi + "] ";
		};
		_txt = "["+_finalNumber+"] "+ _desc + _isInVehicle;
		lbAdd[20002,_txt];
	};
} forEach _vehi;

_checks = (getPos player) nearEntities[_typeRepair,'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
if (count _checks != 0) then {
	_repair = _checks select 0;
	_vehi = (getPos _repair) nearEntities[["Car","Motorcycle","Tank","Air","Ship","StaticWeapon"],100];
	{
		if !(_x in _effective) then {
			_effective = _effective + [_x];
			_descVehi = [typeOf (vehicle _x), 'displayName'] Call GetConfigInfo;
			lbAdd[20002,_descVehi];
		};
	} forEach _vehi;
};

if (count _effective != 0) then {lbSetCurSel[20002,0]};

while {true} do {
	sleep 0.1;
	
	if (Side player != sideJoined) exitWith {closeDialog 0};
	if (!dialog) exitWith {};
	_curSel = lbCurSel(20002);
	
	_isCommander = false;
	
	if (!isNull(commanderTeam)) then {if (commanderTeam == Group player) then {_isCommander = true}};
	_enabled = if (time - _lastUse > 5 && _isCommander && _ss == 0) then {true} else {false};
	ctrlEnable [20007,_enabled];

	if (_curSel != -1) then {
		_veh = (vehicle (_effective select _curSel));
		_funds = Call GetPlayerFunds;
		
		if (_veh isKindOf "Man") then {
			{ctrlEnable [_x,false]} forEach [20003,20004,20005];
			_enabled = if (time - lastHeal > _sheal && _funds >= _healPrice) then {true} else {false};
			ctrlEnable [20008,_enabled];
			//--- Healing.
			_healPrice = round((getDammage _veh)*('WFBE_SUPPORTHEALPRICE' Call GetNamespace));
			ctrlSetText [20011,"$0."];
			ctrlSetText [20012,"$0."];
			ctrlSetText [20013,"$0."];
			ctrlSetText [20014,"$"+str(_healPrice)+"."];
		} else {
			//--- Prevent on the air re-supply.
			_canBeUsed = if ((getPos _veh) select 2 <= 20 && speed _veh <= 20) then {true} else {false};
			_enabled = if (time - lastRearm > _srearm && _canBeUsed && _funds >= _rearmPrice) then {true} else {false};
			ctrlEnable [20003,_enabled];
			_enabled = if (time - lastRepair > _srepair && _canBeUsed && _funds >= _repairPrice) then {true} else {false};
			ctrlEnable [20004,_enabled];
			_enabled = if (time - lastRefuel > _srefuel && _canBeUsed && _funds >= _refuelPrice) then {true} else {false};
			ctrlEnable [20005,_enabled];
			_enabled = if (time - lastHeal > _sheal && _canBeUsed && _funds >= _healPrice) then {true} else {false};
			ctrlEnable [20008,_enabled];
			//--- Healing.
			_healPrice = 0;
			{
				if (alive _x) then {_healPrice = _healPrice + round((getDammage _x)*('WFBE_SUPPORTHEALPRICE' Call GetNamespace))};
			} forEach (crew _veh);
			ctrlSetText [20014,"$"+str(_healPrice)+"."];
			//--- Repair.
			if (_veh != _lastVeh || getDammage _veh != _lastDmg) then {
				_type = typeOf _veh;
				_lastDmg = getDammage _veh;
				_get = _type Call GetNamespace;
				if !(isNil '_get') then {
					_repairPrice = round((getDammage _veh)*((_get select QUERYUNITPRICE)/('WFBE_SUPPORTREPAIRPRICE' Call GetNamespace)));
				} else {
					_repairPrice = 500;
				};
			};
			ctrlSetText [20012,"$"+str(_repairPrice)+"."];
			//--- Rearm.
			if (_veh != _lastVeh) then {
				_type = typeOf _veh;
				_get = _type Call GetNamespace;
				if !(isNil '_get') then {
					_rearmPrice = round((_get select QUERYUNITPRICE)/('WFBE_SUPPORTREARMPRICE' Call GetNamespace));
				} else {
					_rearmPrice = 500;
				};
			};
			ctrlSetText [20011,"$"+str(_rearmPrice)+"."];
			//--- Refuel.
			if (_veh != _lastVeh || fuel _veh != _lastFue) then {
				_type = typeOf _veh;
				_lastFue = fuel _veh;
				_get = _type Call GetNamespace;
				if !(isNil '_get') then {
					_fuel = ((fuel _veh) -1) * -1;
					_refuelPrice = round(_fuel*((_get select QUERYUNITPRICE)/('WFBE_SUPPORTREFUELPRICE' Call GetNamespace)));
				} else {
					_refuelPrice = 200;
				};
			};
			ctrlSetText [20013,"$"+str(_refuelPrice)+"."];
		};
		
		_lastVeh = _veh;
		
		//--- Rearm.
		if (MenuAction == 1) then {
			MenuAction = -1;
			lastRearm = time;
			-_rearmPrice Call ChangePlayerFunds;
			_veh Call RearmVehicle;
			_veh Call RemoveFlares;
			
			hint (localize "STR_WF_Rearming");
		};	
		//--- Repair.
		if (MenuAction == 2) then {
			MenuAction = -1;
			lastRepair = time;
			-_repairPrice Call ChangePlayerFunds;
			_veh setDammage 0;
			hint (localize "STR_WF_Repairing");
		};
		//--- Refuel.
		if (MenuAction == 3) then {
			MenuAction = -1;
			lastRefuel = time;
			-_refuelPrice Call ChangePlayerFunds;
			_veh setFuel 1;
			hint (localize "STR_WF_Refueling");
		};
		//--- Heal.
		if (MenuAction == 5) then {
			MenuAction = -1;
			lastHeal = time;
			-_healPrice Call ChangePlayerFunds;
			if (_veh isKindOf "Man") then {_veh setDammage 0} else {
				_crews = crew _veh;
				if (count _crews != 0) then {{_x setDammage 0} forEach _crews};
			};
			hint (localize "STR_WF_Healing");
		};
	} else {
		{ctrlEnable[_x,false]} forEach [20003,20004,20005,20008];
	};
	
	
	//--- Respawn Supply Trucks.
	if (MenuAction == 4) then {
		MenuAction = -1;
		WFBE_RequestSpecial = ['SRVFNCREQUESTSPECIAL',["RespawnST",sideJoined]];
		publicVariable 'WFBE_RequestSpecial';
		if (IsClientServer) then {['SRVFNCREQUESTSPECIAL',["RespawnST",sideJoined]] Spawn HandleSPVF};
		_lastUse = time;
	};
	
	//--- EASA. TBD: Add dialog;
	if (MenuAction == 7) then {
		MenuAction = -1;
		closeDialog 0;
		createDialog "RscDisplayEASA";
	};
	
	//--- Parameters.
	if (MenuAction == 6) exitWith {
		MenuAction = -1;
		closeDialog 0;
		createDialog "RscDisplayIngameParameters";
	};
};