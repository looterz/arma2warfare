private ["_building","_unitType","_vehInfo","_cpt","_driver","_gunner","_commander"];
_building = _this select 0;
_unitType = _this select 1;
_vehInfo = _this select 2;

waitUntil { !isNil "initJIP" };

_cpt = 0;
if (_unitType isKindOf "Man") then {
	_cpt = 1;
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