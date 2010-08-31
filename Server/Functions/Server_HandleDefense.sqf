Private ["_defense","_unit"];
_defense = _this select 0;
_unit = _this select 1;

sleep 45;

if ((vehicle _unit != _defense)&& alive _unit &&(!isNull _unit)) then {
	if ((_defense EmptyPositions "gunner" > 0)&& alive _defense &&(!isNull _defense)) then {_unit MoveInGunner _defense} else {deleteVehicle _unit};
};