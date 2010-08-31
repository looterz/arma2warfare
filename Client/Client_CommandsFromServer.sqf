_delay = (250 / Count clientCommandPV) / 1000;

while {!gameOver} do {
	{
		sleep _delay;

		_command = Call Compile Format["%1",_x];

		if (_command != 0) then	{
			_side = 0;
			_parameters = 0;

			if (_command >= CMDPARAMETERBIT1) then {_parameters = 2;_command = _command - CMDPARAMETERBIT1};
			if (_command >= CMDPARAMETERBIT0) then {_parameters = _parameters + 1;_command = _command - CMDPARAMETERBIT0};

			if (_command >= RESISTANCEID) then {_side = RESISTANCEID;_command = _command - RESISTANCEID};
			if (_command >= WESTID) then {_side = WESTID;_command = _command - WESTID};
			if (_command >= EASTID) then {_side = EASTID;_command = _command - EASTID};

			if (_side == 0 || _side == sideID) then {
				if (_command == 0 || _command == clientID) then {
					_params = [];
					if (_parameters > 0) then {_params = _params + [Call Compile Format["%1P1",_x]]};
					if (_parameters > 1) then {_params = _params + [Call Compile Format["%1P2",_x]]};
					if (_parameters > 2) then {_params = _params + [Call Compile Format["%1P3",_x]]};
					Call Compile Format["_params Spawn CLTFNC%1",_x];
				};
			};
			Call Compile Format["%1 = 0",_x];
		};
	} ForEach clientCommandPV;
};