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
if (count _sp > 0) then {
	_sorted = [player,_sp] Call SortByDistance;
	_csp = _sorted select 0;
};

if (paramEASA) then {
	_enable = false;
	_currentUpgrades = (sideJoinedText) Call GetSideUpgrades;
	_easaLevel = _currentUpgrades select 15;
	if (!(isNull _csp) && _easaLevel > 0) then {
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
_nearSupport = [];
_spType = Call Compile Format ["%1SP",sideJoinedText];
_i = 0;
{
	_closestSP = objNull;
	_add = false;
	
	_nearSupport set [_i, []];
	
	//--- Service Point.
	if (count _sp > 0) then {
		_sorted = [_x,_sp] Call SortByDistance;
		_closestSP = _sorted select 0;
		if !(isNull _closestSP) then {
			if (_x distance _closestSP < ('WFBE_SUPPORTRANGE' Call GetNamespace)) then {
				_add = true;
				_nearSupport set [_i,(_nearSupport select _i) + [_closestSP]];
	};
		};
	};

	//--- Depots.
		_nObjects = nearestObjects [_x, WFDEPOT,('WFBE_SUPPORTRANGE' Call GetNamespace)];
		_nObject = if (count _nObjects > 0) then {_nObjects select 0} else {objNull};
		if !(isNull _nObject) then {
			_sideID = _nObject getVariable "sideID";
			if !(isNil "_sideID") then {
			if (_sideID == sideID) then {
				_add = true;
				_nearSupport set [_i,(_nearSupport select _i) + [_nObject]];
			};
			};
		};
	
	//--- Repairs Trucks.
			_checks = (getPos _x) nearEntities[_typeRepair,'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
	if (count _checks > 0) then {
		_add = true;
		_nearSupport set [_i,(_nearSupport select _i) + _checks];
		};
		
	if (!_add && _x isKindOf 'Air') then 
        {
		_pura = ('WFBE_SUPPORTRANGE' Call GetNamespace);
		_sorted = [_x, Airfields] Call SortByDistance;
		if (count _sorted > 0) then 
                {
			if ((_sorted select 0) distance _x < _pura && alive(_sorted select 0)) then { _add = true; };
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
		
		_i = _i + 1;
	};
} forEach _vehi;

_checks = (getPos player) nearEntities[_typeRepair,'WFBE_REPAIRTRUCKRANGE' Call GetNamespace];
if (count _checks > 0) then {
	_repair = _checks select 0;
	_vehi = ((getPos _repair) nearEntities[["Car","Motorcycle","Tank","Air","Ship","StaticWeapon"],100]) - [_repair];
	{
		if !(_x in _effective) then {
			_effective = _effective + [_x];
			_nearSupport set [_i,[_repair]];
			_descVehi = [typeOf (vehicle _x), 'displayName'] Call GetConfigInfo;
			lbAdd[20002,_descVehi];
			
			_i = _i + 1;
		};
	} forEach _vehi;
};

if (count _effective > 0) then {lbSetCurSel[20002,0]};

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
			
			//--- Spawn a Rearm thread.
			[_veh,_nearSupport select _curSel,_typeRepair,_spType] Spawn {
				Private ['_i','_name','_repairRange','_rearmTime','_spType','_supportRange','_supports','_typeRepair','_veh'];
				_veh = _this select 0;
				_supports = _this select 1;
				_typeRepair = _this select 2;
				_spType = _this select 3;
				_supportRange = 'WFBE_SUPPORTRANGE' Call GetNamespace;
				_repairRange = 'WFBE_REPAIRTRUCKRANGE' Call GetNamespace;
				
				//--- Retrieve Informations.
				_name = [typeOf _veh, 'displayName'] Call GetConfigInfo;
				_rearmTime = round(('WFBE_SUPPORTREARMTIME' Call GetNamespace)/2);
				
				//--- SP?
				_nearIsSP = false;
				_nearIsDP = false;
				_nearIsRT = false;
				{
					if ((typeOf _x) == _spType) then {_nearIsSP = true};
					if ((typeOf _x) in WFDEPOT) then {_nearIsDP = true};
					if ((typeOf _x) in _typeRepair) then {_nearIsRT = true};
				} forEach _supports;
				
				//--- Coefficient Vary depending on the support type.
				_airCoef = 1;
				_artCoef = 1;
				_heaCoef = 1;
				_ligCoef = 1;
				if (_nearIsRT) then {
					_airCoef = 3.4;
					_artCoef = 3;
					_heaCoef = 2.8;
					_ligCoef = 2.6;
				};
				if (_nearIsDP) then {
					_airCoef = 2.5;
					_artCoef = 2.4;
					_heaCoef = 2.2;
					_ligCoef = 2;
				};
				if (_nearIsSP) then {
					_airCoef = 1.9;
					_artCoef = 1.7;
					_heaCoef = 1.5;
					_ligCoef = 1.2;
				};

				//--- Class Malus.
				if (_veh isKindOf 'Air') then {_rearmTime = round(_rearmTime * _airCoef)};
				if (_veh isKindOf 'StaticWeapon ') then {_rearmTime = round(_rearmTime * _artCoef)};
				if (_veh isKindOf 'Tank') then {_rearmTime = round(_rearmTime * _heaCoef)};
				if (_veh isKindOf 'Car' || _veh isKindOf 'Motorcycle') then {_rearmTime = round(_rearmTime * _ligCoef)};
				
				//--- Inform the player.
				hint parseText(Format[localize "STR_WF_Rearming",_name,_rearmTime]);
				
				//--- Make sure that we still have something as a support.
				_cts = 0;
				_i = 0;
				while {true} do {
					sleep 1;
					
					//--- Check the distance & alive.
					_cts = 0;
					{
						_distanceMin = if ((typeOf _x) in _typeRepair) then {_repairRange} else {_supportRange};
						if ((alive _x) && ((_veh distance _x) < _distanceMin)) then {_cts = _cts + 1};
					} forEach _supports;
					
					_i = _i + 1;
					
					if (_cts == 0 || !(alive _veh)) exitWith {hint parseText(Format[localize "STR_WF_Rearm_Failed",_name])};
					if (_i >= _rearmTime) exitWith {hint parseText(Format[localize "STR_WF_Rearm_Success",_name])};
				};
				
				//--- Rearm?
				if (_cts != 0) then {
					[_veh,sideJoinedText] Spawn RearmVehicle;
				};
			};
		};	
		//--- Repair.
		if (MenuAction == 2) then {
			MenuAction = -1;
			lastRepair = time;
			-_repairPrice Call ChangePlayerFunds;
			
			//--- Spawn a Repair thread.
			[_veh,_nearSupport select _curSel,_typeRepair,_spType] Spawn {
				Private ['_i','_name','_repairRange','_repTime','_spType','_supportRange','_supports','_typeRepair','_veh'];
				_veh = _this select 0;
				_supports = _this select 1;
				_typeRepair = _this select 2;
				_spType = _this select 3;
				_supportRange = 'WFBE_SUPPORTRANGE' Call GetNamespace;
				_repairRange = 'WFBE_REPAIRTRUCKRANGE' Call GetNamespace;
				
				//--- Retrieve Informations.
				_name = [typeOf _veh, 'displayName'] Call GetConfigInfo;
				_repTime = round(('WFBE_SUPPORTREPAIRTIME' Call GetNamespace)/2);
				
				//--- SP?
				_nearIsSP = false;
				_nearIsDP = false;
				_nearIsRT = false;
				{
					if ((typeOf _x) == _spType) then {_nearIsSP = true};
					if ((typeOf _x) in WFDEPOT) then {_nearIsDP = true};
					if ((typeOf _x) in _typeRepair) then {_nearIsRT = true};
				} forEach _supports;
				
				//--- Coefficient Vary depending on the support type.
				_airCoef = 1;
				_artCoef = 1;
				_heaCoef = 1;
				_ligCoef = 1;
				if (_nearIsRT) then {
					_airCoef = 3.4;
					_artCoef = 3;
					_heaCoef = 2.8;
					_ligCoef = 2.6;
				};
				if (_nearIsDP) then {
					_airCoef = 2.5;
					_artCoef = 2.4;
					_heaCoef = 2.2;
					_ligCoef = 2;
				};
				if (_nearIsSP) then {
					_airCoef = 1.9;
					_artCoef = 1.7;
					_heaCoef = 1.5;
					_ligCoef = 1.2;
				};
				
				//--- Class Malus.
				if (_veh isKindOf 'Air') then {_repTime = round(_repTime * _airCoef)};
				if (_veh isKindOf 'StaticWeapon ') then {_repTime = round(_rearmTime * _artCoef)};
				if (_veh isKindOf 'Tank') then {_repTime = round(_repTime * _heaCoef)};
				if (_veh isKindOf 'Car' || _veh isKindOf 'Motorcycle') then {_repTime = round(_repTime * _ligCoef)};
				
				//--- Inform the player.
				hint parseText(Format[localize "STR_WF_Repairing",_name,_repTime]);
				
				//--- Make sure that we still have something as a support.
				_cts = 0;
				_i = 0;
				while {true} do {
					sleep 1;
					
					//--- Check the distance & alive.
					_cts = 0;
					{
						_distanceMin = if ((typeOf _x) in _typeRepair) then {_repairRange} else {_supportRange};
						if ((alive _x) && ((_veh distance _x) < _distanceMin)) then {_cts = _cts + 1};
					} forEach _supports;
					
					_i = _i + 1;
					
					if (_cts == 0 || !(alive _veh)) exitWith {hint parseText(Format[localize "STR_WF_Repair_Failed",_name])};
					if (_i >= _repTime) exitWith {hint parseText(Format[localize "STR_WF_Repair_Success",_name])};
				};
				
				//--- Fix the damages?
				if (_cts != 0) then {
			_veh setDammage 0;
				};
			};
		};
		//--- Refuel.
		if (MenuAction == 3) then {
			MenuAction = -1;
			lastRefuel = time;
			-_refuelPrice Call ChangePlayerFunds;
			
			//--- Spawn a Refuel thread.
			[_veh,_nearSupport select _curSel,_typeRepair,_spType] Spawn {
				Private ['_i','_name','_repairRange','_refTime','_spType','_supportRange','_supports','_typeRepair','_veh'];
				_veh = _this select 0;
				_supports = _this select 1;
				_typeRepair = _this select 2;
				_spType = _this select 3;
				_supportRange = 'WFBE_SUPPORTRANGE' Call GetNamespace;
				_repairRange = 'WFBE_REPAIRTRUCKRANGE' Call GetNamespace;
				
				//--- Retrieve Informations.
				_name = [typeOf _veh, 'displayName'] Call GetConfigInfo;
				_refTime = round(('WFBE_SUPPORTREFUELTIME' Call GetNamespace)/2);
				
				//--- SP?
				_nearIsSP = false;
				_nearIsDP = false;
				_nearIsRT = false;
				{
					if ((typeOf _x) == _spType) then {_nearIsSP = true};
					if ((typeOf _x) in WFDEPOT) then {_nearIsDP = true};
					if ((typeOf _x) in _typeRepair) then {_nearIsRT = true};
				} forEach _supports;
				
				//--- Coefficient Vary depending on the support type.
				_airCoef = 1;
				_artCoef = 1;
				_heaCoef = 1;
				_ligCoef = 1;
				if (_nearIsRT) then {
					_airCoef = 3.4;
					_artCoef = 3;
					_heaCoef = 2.8;
					_ligCoef = 2.6;
				};
				if (_nearIsDP) then {
					_airCoef = 2.5;
					_artCoef = 2.4;
					_heaCoef = 2.2;
					_ligCoef = 2;
				};
				if (_nearIsSP) then {
					_airCoef = 1.9;
					_artCoef = 1.7;
					_heaCoef = 1.5;
					_ligCoef = 1.2;
				};
				
				//--- Class Malus.
				if (_veh isKindOf 'Air') then {_refTime = round(_refTime * _airCoef)};
				if (_veh isKindOf 'StaticWeapon ') then {_refTime = round(_rearmTime * _artCoef)};
				if (_veh isKindOf 'Tank') then {_refTime = round(_refTime * _heaCoef)};
				if (_veh isKindOf 'Car' || _veh isKindOf 'Motorcycle') then {_refTime = round(_refTime * _ligCoef)};
				
				//--- Inform the player.
				hint parseText(Format[localize "STR_WF_Refueling",_name,_refTime]);
				
				//--- Make sure that we still have something as a support.
				_cts = 0;
				_i = 0;
				while {true} do {
					sleep 1;
					
					//--- Check the distance & alive.
					_cts = 0;
					{
						_distanceMin = if ((typeOf _x) in _typeRepair) then {_repairRange} else {_supportRange};
						if ((alive _x) && ((_veh distance _x) < _distanceMin)) then {_cts = _cts + 1};
					} forEach _supports;
					
					_i = _i + 1;
					
					if (_cts == 0 || !(alive _veh)) exitWith {hint parseText(Format[localize "STR_WF_Refueling_Failed",_name])};
					if (_i >= _refTime) exitWith {hint parseText(Format[localize "STR_WF_Refueling_Success",_name])};
				};
				
				//--- Refuel the vehicle?
				if (_cts != 0) then {
			_veh setFuel 1;
				};
			};
		};
		//--- Heal.
		if (MenuAction == 5) then {
			MenuAction = -1;
			lastHeal = time;
			-_healPrice Call ChangePlayerFunds;
			if (_veh isKindOf "Man") then {_veh setDammage 0} else {
				_crews = crew _veh;
				if (count _crews > 0) then {{_x setDammage 0} forEach _crews};
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