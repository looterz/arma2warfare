/// <summary>
/// </summary>
a2mission_TankCreate = {
    Private["_numArray", "_length", "_numArray2", "_num3", "_num"];
    _this = _this select 0;
    _num = nil;
    if (isNil "_this") then {_this = 'objectBase' createVehicle [0, 0, 0]};
    _this = _this call Arma2ScriptLanguage_VehicleCreate;
    _this setVariable ["_startTank", objNull];
    [a2mission_Tank_StartTank, 50] call a2mission_TankSetSpeed;
    [(_this getVariable "_startTank"), 25] call a2mission_TankSetSpeed;
    (_this getVariable "_startTank") setVariable ["_speed", 25];
    _numArray = [100, 200, 500, 1000, 0];
    _numArray set [1, 20];
    _num = 0;
    while {(_num < count(_numArray))} do {
        [_this, (_numArray select (_num * 2))] call a2mission_TankSetSpeed;
        _num = _num + 1
    };
    _length = count(_numArray);
    _num = 0;
    while {(_num < _length)} do {
        _numArray set [(_num * 2), (_this call a2mission_TankGetSpeed)];
        _num = _num + 1
    };
    _this call a2mission_TankSetSpeedA;
    _numArray2 = (_this getVariable "_allowedSpeeds");
    _num3 = ((_numArray2 select 1) * 5);
    _numArray2 set [1, (_num3 + 100)];
    _numArray set [1, _num3];
    _this
};
/// <summary>
/// </summary>
a2mission_TankCreateA = {
    Private["_maxSpeed", "_numArray"];
    _maxSpeed = _this select 1;
    _this = _this select 0;
    if (isNil "_this") then {_this = 'objectBase' createVehicle [0, 0, 0]};
    _this = _this call Arma2ScriptLanguage_VehicleCreate;
    _this setVariable ["_startTank", objNull];
    _numArray = [100, 200, 500, 1000, 0];
    { [_this, _x] call a2mission_TankSetSpeed } forEach _numArray;
    _this
};
/// <summary>
/// </summary>
a2mission_TankCreateB = {
    Private["_maxSpeed", "_maxHeight", "_numArray"];
    _maxSpeed = _this select 1;
    _maxHeight = _this select 2;
    _this = _this select 0;
    if (isNil "_this") then {_this = 'objectBase' createVehicle [0, 0, 0]};
    _this = [_this, _maxSpeed] call a2mission_TankCreateA;
    _numArray = [100, 200, 500, 1000, 0];
    {
        [_this, _x] call a2mission_TankSetSpeed;
        [_this, ((_this call a2mission_TankGetSpeed) / 2)] call a2mission_TankSetSpeed
    } forEach _numArray;
    _this
};
/// <summary>
/// </summary>
a2mission_TankCreateC = {
    a2mission_Tank_MaxFieldValue = call a2mission_TankGetMaxValue;
    a2mission_Tank_MaxFieldValueNa = "MotherNature";
    a2mission_Tank_StartTank = objNull
};
/// <summary>
/// </summary>
a2mission_TankDelete = {
    Private["_num", "_numArray", "_numArray2", "_numArray3", "_objArray", "_length"];
    _this = _this select 0;
    [(_this getVariable "_startTank"), 5] call a2mission_TankSetSpeed;
    _num = 50;
    _numArray = (call {private["_array", "_i"];_array=[];_i=0;while{_i<_num} do {_array set[_i,0];_i=_i+1;};_array});
    _numArray2 = (call {private["_array", "_i"];_array=[]; for "_i" from 0 to 50 do {_array set[_i,0];};_array});
    _numArray3 = [0, 0, 0, 0, 0];
    _objArray = [objNull, objNull, objNull, objNull, objNull];
    _length = count(_numArray);
    _this setVariable ["_speed", if { ((_this getVariable "_speed") < 100) } then { 500 } else { 100 }];
    _this setVariable ["_hasSpeed", if(((_this getVariable "_speed") < 100)) then { true } else { false }];
    if {((_this getVariable "_speed") >= 100)} then {_this setVariable ["_speed", 100] } else {_this setVariable ["_speed", 50] };
    _this call a2mission_TankReload
};
/// <summary>
/// </summary>
a2mission_TankGetMaxValue = {
    60
};
/// <summary>
/// </summary>
a2mission_TankGetSpeed = {
    (_this getVariable "_speed")
};
/// <summary>
/// </summary>
a2mission_TankReload = {
    Private["_num", "_flag"];
    _this = _this select 0;
    _this setVariable ["_speed", 0];
    _num = 50;
    _flag = if((_num == 50)) then { true } else { false }
};
/// <summary>
/// </summary>
a2mission_TankSetSpeed = {
    Private["_value"];
    _value = _this select 1;
    _this = _this select 0;
    _this setVariable ["_speed", _value]
};
/// <summary>
/// </summary>
a2mission_TankSetSpeedA = {
    _this setVariable ["_speed", 5]
};
a2mission_Tank_MaxFieldValue = nil;
a2mission_Tank_MaxFieldValueNa = nil;
a2mission_Tank_StartTank = nil;
