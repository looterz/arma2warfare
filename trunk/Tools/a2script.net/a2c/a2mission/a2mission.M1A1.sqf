/// <summary>
/// </summary>
a2mission_M1A1Create = {
    Private["_maxSpeed", "_maxHeight", "_group", "_pos", "_position", "_obj2", "_num", "_str", "_num2", "_numArray", "_a1"];
    _maxSpeed = _this select 1;
    _maxHeight = _this select 2;
    _this = _this select 0;
    _a1 = nil;
    if (isNil "_this") then {_this = 'objectBase' createVehicle [0, 0, 0]};
    _this = [_this, _maxSpeed, _maxHeight] call a2mission_TankCreateB;
    _group = a2mission_UnitGroup.Create;
    _pos = [];
    [_group, _pos, 50] call a2mission_UnitGroupAddWaypoint;
    _position = Arma2ScriptLanguage_Position.Create;
    0 call Arma2ScriptLanguage_PositionSetX;
    0 call Arma2ScriptLanguage_PositionSetY;
    0 call Arma2ScriptLanguage_PositionSetZ;
    [_group, _position, 50] call a2mission_UnitGroupAddWaypointA;
    "RED" call Arma2ScriptLanguage_VehicleAssignTeam;
    _obj2 = assignedTarget _this;
    _num = ((asin(5) * 3.1415926535897931) / 2);
    vehicle player;
    ["killed", Arma2ScriptLanguageContracts_EventHandler.Create(a2mission_M1A1,a2mission_M1A1TankKilled)] call Arma2ScriptLanguageContracts_IObjectAddEventHandler;
    ["action", objNull] call Arma2ScriptLanguageContracts_IUnitAction;
    _str = "" + "HelloWorld" + format["Hello "" world, %1 {{0} %1","hello"];
    ["1234", "/sqs", objNull, 5, true, true, "", "function=1"] call Arma2ScriptLanguageContracts_IUnitAddAction;
    call Arma2ScriptLanguage_VehicleFuel;
    _num2 = (call Arma2ScriptLanguage_VehicleFuel * 5);
    ["eject", _this, player, vehicle player] call Arma2ScriptLanguageContracts_IUnitActionA;
    _numArray = [100, 200, 500, 1000, 0];
    { if {((_this call a2mission_TankGetSpeed) < 100)} then {[_this, _x] call a2mission_TankSetSpeed } } forEach _numArray;
    [_numArray, {
        Private["_m"];
        _m = _this;_a1 = "HelloWorld123121"
    }] call SystemLinq_LinqExtensionsForEachOf;
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
};
