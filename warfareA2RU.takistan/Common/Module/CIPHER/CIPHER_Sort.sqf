/* Elements to sort etc ... */

_preformat = {
	Private ["_get","_output","_units"];
	_units = _this;
	_output = [];

	for '_i' from 0 to count(_units)-1 do {
		_get = (_units select _i) Call GetNamespace;
		if !(isNil "_get") then {
			_output set [_i, _get select QUERYUNITLABEL];
		} else {
			_output set [_i, (_units select _i)];
		};
	};
	
	_output
};

_preformat_gear = {
	Private ["_content","_get","_output"];
	_content = _this;
	_output = [];

	for '_i' from 0 to count(_content)-1 do {
		_get = (_content select _i) Call GetNamespace;
		if !(isNil "_get") then {
			_output set [_i, _get select QUERYGEARLABEL];
		} else {
			_output set [_i, (_content select _i)];
		};
	};
	
	_output
};

