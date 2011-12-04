Private ["_ammo","_irLock","_missile","_source","_unit"];
_unit = _this select 0;
_ammo = _this select 1;
_source = _this select 2;

_missile = nearestObject [_source,_ammo];
if (isNull _missile) exitWith {};

//--- Get the ammo type.
_irLock = getNumber(configFile >> "CfgAmmo" >> _ammo >> "irLock");
_hit = getNumber(configFile >> "CfgAmmo" >> _ammo >> "hit");
//_indirect_hit = getNumber(configFile >> "CfgAmmo" >> _ammo >> "indirectHit");
//_indirectHitRange = getNumber(configFile >> "CfgAmmo" >> _ammo >> "indirectHitRange");

//--- MetisM1
if (_irLock == 1 && _hit == 670) then {
	_distance = _unit distance _source;
	_limit = 2000;
	if (_distance > _limit) then {
		waitUntil {_missile distance _source > _limit};
		deleteVehicle _missile;
	};	
};
//--- Javelin
if (_irLock == 1 && _hit == 800) then {
	_distance = _unit distance _source;
	_limit = 2500;
	if (_distance > _limit) then {
		waitUntil {_missile distance _source > _limit};
		deleteVehicle _missile;
	};
};