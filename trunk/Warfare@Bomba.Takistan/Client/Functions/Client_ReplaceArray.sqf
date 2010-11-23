Private ['_array','_indexExcluded','_newArray'];
_array = _this select 0;
_indexExcluded = _this select 1;

_newArray = [];
for [{_x = 0},{_x < count(_array)},{_x = _x + 1}] do {
	if (_x != _indexExcluded) then {
		_newArray = _newArray + [_array select _x];
	};
};

_newArray