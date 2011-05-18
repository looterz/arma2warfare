Private["_count","_held","_side","_supplyValue","_sideID","_town"];

_side = _this;
_sideID = _side Call GetSideID;
_SV = 0;

for [{_count = totalTowns - 1},{_count >= 0},{_count = _count - 1}] do {
	_town = towns Select _count;
	if ((_town getVariable "sideID") == _sideID) then	{
		_supplyValue = _town getVariable "supplyValue";
		_SV = _SV + _supplyValue;
	};
};

_SV