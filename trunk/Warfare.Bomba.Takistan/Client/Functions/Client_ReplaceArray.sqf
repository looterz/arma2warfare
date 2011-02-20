Private ['_array','_i','_indexExcluded','_newArray'];
_array = _this select 0;
_indexExcluded = _this select 1;

_newArray = [];
for [{_i = 0},{_i < count(_array)},{_i = _i + 1}] do {
	if (_i != _indexExcluded) then {
		_newArray = _newArray + [_array select _i];
	};
};

_newArray