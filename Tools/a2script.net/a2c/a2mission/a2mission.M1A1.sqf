/// <summary>
/// </summary>
a2mission_M1A1Create = {
    Private["_maxSpeed", "_maxHeight", "_group", "_numArray"];
    _maxSpeed = _this select 1;
    _maxHeight = _this select 2;
    _this = _this select 0;
    if (isNil "_this") then {_this = 'objectBase' createVehicle [0, 0, 0]};
    _this = [_this, _maxSpeed, _maxHeight] call a2mission_TankCreateB;
    _group = objNull;
    _numArray = [];
    _group addWaypoint [_numArray, 50];
    _this
};
/// <summary>
/// </summary>
a2mission_M1A1Delete = {
    Private["_str"];
    _this = _this select 0;
    _str = format["Now: %1",call Arma2ScriptLanguage_MissionGettime];
    if {((_this call a2mission_TankGetSpeed) < 50)} then {[_this, 50] call a2mission_TankSetSpeed };
    _this call a2mission_TankDelete
};
/// <summary>
/// </summary>
a2mission_M1A1TankKilled = {
    Private["_group", "_obj2", "_num", "_str", "_num2", "_numArray", "_a1"];
    _this = _this select 0;
    _a1 = nil;
    _group = objNull;
    _group addWaypoint [[0, 5, 5], 50];
    _this assignTeam "RED";
    _obj2 = assignedTarget _this;
    _num = ((asin(5) * 3.1415926535897931) / 2);
    vehicle player;
    player addEventHandler["killed", Arma2ScriptLanguageContracts_EventHandler.Create(_this,a2mission_M1A1TankKilled)];
    player action["action", objNull];
    _str = "" + "HelloWorld" + format["Hello "" world, %1 {{0} %1","hello"];
    player addAction["1234", "/sqs", objNull, 5, true, true, "", "function=1"];
    fuel _this;
    _num2 = (fuel (_this getVariable "_startTank") * 5);
    player action["eject", _this, player, vehicle player];
    _numArray = [100, 200, 500, 1000, 0];
    { if {((_this call a2mission_TankGetSpeed) < 100)} then {[_this, _x] call a2mission_TankSetSpeed } } forEach _numArray;
    [_numArray, {
        Private["_m"];
        _m = _this;_a1 = "HelloWorld123121"
    }] call SystemLinq_LinqExtensionsForEachOf
};
