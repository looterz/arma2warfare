Private ["_command","_parameters","_paramMask"];

_command = _this Select 0;
_parameters = Count _this;

while {!_exit} do {
	sleep 0.05;
	if ((clientCommandPVTimeLeft Select _command) == 0) then {_exit = true};
};

_paramMask = CMD0PARAMETERS;

if (_parameters > 1) then {_paramMask = CMD1PARAMETERS;Call Compile Format["%1P1 = _this Select 1;PublicVariable ""%1P1""",clientCommandPV Select _command]};
if (_parameters > 2) then {_paramMask = CMD2PARAMETERS;Call Compile Format["%1P2 = _this Select 2;PublicVariable ""%1P2""",clientCommandPV Select _command]};
if (_parameters > 3) then {_paramMask = CMD3PARAMETERS;Call Compile Format["%1P3 = _this Select 3;PublicVariable ""%1P3""",clientCommandPV Select _command]};

Call Compile Format["%1 = _paramMask;PublicVariable ""%1""",clientCommandPV Select _command];

clientCommandPVTimeLeft Set [_command,0.25];
sleep 0.25;
clientCommandPVTimeLeft Set [_command,0];