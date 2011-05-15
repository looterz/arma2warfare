/// <summary>
/// </summary>
a2mission_UnitGroupCreate = {
    if (isNil "_this") then {_this = 'objectBase' createVehicle [0, 0, 0]};
    _this = _this call System_ObjectCreate;_this
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddGroupIcon = {
    Private["_name"];
    _name = _this select 1;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddGroupIconA = {
    Private["_name", "_offsetX", "_offsetY"];
    _name = _this select 1;
    _offsetX = _this select 2;
    _offsetY = _this select 3;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddVehicle = {
    Private["_vehicleName"];
    _vehicleName = _this select 1;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddWaypoint = {
    Private["_pos", "_radius"];
    _pos = _this select 1;
    _radius = _this select 2;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddWaypointA = {
    Private["_pos", "_radius"];
    _pos = _this select 1;
    _radius = _this select 2;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddWaypointB = {
    Private["_pos", "_radius", "_index"];
    _pos = _this select 1;
    _radius = _this select 2;
    _index = _this select 3;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAddWaypointC = {
    Private["_pos", "_radius", "_index"];
    _pos = _this select 1;
    _radius = _this select 2;
    _index = _this select 3;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAllowFleeing = {
    Private["_cowardice"];
    _cowardice = _this select 1;
    _this = _this select 0;
    raise System_NotImplementedException.Create
};
/// <summary>
/// </summary>
a2mission_UnitGroupAttackEnabled = {
    raise System_NotImplementedException.Create
};
