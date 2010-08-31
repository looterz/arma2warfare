Private ["_command","_exit","_ID","_parameters","_paramMask"];

_command = _this Select 0;
_parameters = Count _this;

_exit = false;
while {!_exit} do {
	sleep (((Random 190) + 10) / 1000);
	if (Call Compile Format["%1",serverCommandPV Select _command] == 0) then {_exit = true};
};

_ID = sideID + clientID;
_paramMask = CMD0PARAMETERS;

if (_parameters > 1) then {_paramMask = CMD1PARAMETERS;Call Compile Format["%1P1 = _this Select 1;PublicVariable ""%1P1""",serverCommandPV Select _command]};
if (_parameters > 2) then {_paramMask = CMD2PARAMETERS;Call Compile Format["%1P2 = _this Select 2;PublicVariable ""%1P2""",serverCommandPV Select _command]};
if (_parameters > 3) then {_paramMask = CMD3PARAMETERS;Call Compile Format["%1P3 = _this Select 3;PublicVariable ""%1P3""",serverCommandPV Select _command]};

Call Compile Format["%1 = _ID + _paramMask;PublicVariable ""%1""",serverCommandPV Select _command];