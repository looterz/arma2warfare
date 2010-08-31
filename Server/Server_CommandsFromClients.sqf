Private ["_command","_delay","_parameters","_params","_side"];

_delay = (250 / (Count serverCommandPV)) / 1000;

while {!gameOver} do
{
	{
		Sleep _delay;

		_command = Call Compile Format["%1",_x];

		if (_command != 0) then
		{
			_parameters = 0;
			if (_command >= CMDPARAMETERBIT1) then {_parameters = 2; _command = _command - CMDPARAMETERBIT1};
			if (_command >= CMDPARAMETERBIT0) then {_parameters = _parameters + 1; _command = _command - CMDPARAMETERBIT0};

			_side = Resistance;
			if (_command >= RESISTANCEID) then {_side = Resistance;_command = _command - RESISTANCEID};
			if (_command >= WESTID) then {_side = West;_command = _command - WESTID};
			if (_command >= EASTID) then {_side = East;_command = _command - EASTID};

			_params = [_side,_command];
			if (_parameters > 0) then {_params = _params + [Call Compile Format["%1P1",_x]]};
			if (_parameters > 1) then {_params = _params + [Call Compile Format["%1P2",_x]]};
			if (_parameters > 2) then {_params = _params + [Call Compile Format["%1P3",_x]]};

			Call Compile Format["_params Spawn SRVFNC%1",_x];
			Call Compile Format["%1 = 0;PublicVariable ""%1""",_x];
		};
	} ForEach serverCommandPV;
};