Private ["_building", "_unitType", "_vehInfo", "_cpt", "_isMan", "_driver", "_gunner", "_commander"];
_building = _this select 0;
_unitType = _this select 1;
_vehInfo = _this select 2;

waitUntil { !isNil "initJIP" };

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

[WBE_NETSEND_CLIENTID, _building, _unitType, (side player), (group player), _vehInfo] spawn BuyUnit_OrderCreate;