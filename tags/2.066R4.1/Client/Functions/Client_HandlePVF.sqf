/*
	description:
	 - New network system handler.
	destination:
	 - Nil: Everyone
	 - Scalar (Integer or Decimal): One person (use the ID system).
	 - Side: A side
	note:
	 - addPublicVariableEventHandler is triggered everywhere BUT on the caller.
	usage:
	 - [destination,client PVF to run,parameters]
*/

Private ["_destination","_exit","_id","_parameters","_publicVar","_script","_side"];
_publicVar = _this;
_exit = true;

format["HandlePVF: %1", _this] call LogHigh;

_destination = _publicVar select 0;
if (isNil '_destination') then {_destination = "nil";_exit = false};
if (typeName(_destination) == 'SIDE') then {if (sideJoined == _destination) then {_exit = false}};
if (typeName(_destination) == 'ARRAY') then {
	_id = _destination select 0;
	_side = _destination select 1;
	if (clientID == _id && _side == sideJoined) then {_exit = false};
};

if (_exit) exitWith {};

_script = _publicVar select 1;
_parameters = if (count _this > 2) then {_publicVar select 2} else {[]};

_parameters Spawn (Call Compile _script);