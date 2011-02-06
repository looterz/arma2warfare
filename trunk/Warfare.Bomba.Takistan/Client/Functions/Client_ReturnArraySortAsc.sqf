/* Only use string ! */
private['_k','_copy','_asciar','_temp','_lowest','_index','_i','_list'];

_list = _this;
_temp = [];

_asciAr = [];
/* Get the ascii value */
{
	_asciAr = _asciAr + [(toArray(_x)) select 0];
} forEach _list;
_copy = +_asciAr;

_lowest = 100000;
_index = -1;
for [{_i = 0},{_i < count _asciAr},{_i = _i + 1}] do {
	/* Get Lowest */	
	for [{_k = 0},{_k < count _copy},{_k = _k + 1}] do {
		if (_lowest > (_copy select _k) && (_copy select _k) != -1) then {
			_lowest = _copy select _k;
			_index = _k;
		};
	};
	
	_temp = _temp + [_index];
	_copy set [_index, -1];
	_lowest = 100000;
};

_temp