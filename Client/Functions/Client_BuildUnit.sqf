Private [];
_building = _this select 0;
_unitType = _this select 1;
_vehInfo = _this select 2;

waitUntil { !isNil "LogInited" };

_cpt = 0;
_isMan = false;
if (_unit isKindOf "Man") then {
	_cpt = 1;
	_isMan = true;
} else {
	_driver = _vehInfo select 0;
	_gunner = _vehInfo select 1;
	_commander = _vehInfo select 2;
	if (_driver) 	then {_cpt = _cpt + 1};
	if (_gunner) 	then {_cpt = _cpt + 1};
	if (_commander) then {_cpt = _cpt + 1};
};

unitQueu = unitQueu + _cpt;

_clientId = if (isPlayer(leader _team)) then { getPlayerUID (leader _team) } else { 'AI' };
[_clientId, _building, _unitType, (side player), (group player), _vehInfo] spawn BuyUnit_OrderCreate;