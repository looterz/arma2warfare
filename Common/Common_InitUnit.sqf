Private ["_finalNumber","_numbers","_side","_text","_unit"];
_unit = _this select 0;
_side = _this select 1;

if (isNull _unit) exitWith {};
waitUntil {commonInitComplete};
sleep 2;

if (sideJoined != _side) exitWith {};

_type = "Vehicle";
_color = "ColorGreen";
_size = [5,5];
_txt = "";
if ((typeOf _unit) == (Format['WFBE_%1SUPPLYTRUCK',str _side] Call GetNamespace)) then {_type = "SupplyVehicle";_size = [1,1]};
if ((typeOf _unit) == (Format['WFBE_%1REPAIRTRUCK',str _side] Call GetNamespace)) then {_type = "RepairVehicle"};
_markerName = Format ["unitMarker%1",unitMarker];
unitMarker = unitMarker + 1;
if (local _unit && isMultiplayer) then {_color = "ColorOrange"};
_params = [_type,_color,_size,_txt,_markerName,_unit,1,true,"DestroyedVehicle",_color,false,_side,[2,2]];
if (_unit isKindOf "Man") then {
	_color = "ColorYellow";
	_type = "mil_dot";
	_size = [0.5,0.5];
	if (group _unit == group player) then {
		_color = "ColorOrange";
		_text = toArray(str _unit);
		_amount = count _text;
		_val = _text select (_amount-2);
		_val2 = _text select (_amount-1);
		_ainumber = if (_val == 58) then {[_val2]} else {[_val, _val2]};
		_txt = toString(_ainumber);
	};
	_params = [_type,_color,_size,_txt,_markerName,_unit,1,true,"DestroyedVehicle",_color,false,_side,[1,1]];
};

_params Spawn MarkerUpdate;