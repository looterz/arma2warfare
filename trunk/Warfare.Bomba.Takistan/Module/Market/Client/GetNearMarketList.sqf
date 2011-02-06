private['_sorted','_range','_markets','_buildings','_hq','_marketList','_base'];

waitUntil {_base = ((sideJoinedText) Call GetSideHQ);!isNil "_base"};

_sorted = [];
_range = ('WFBE_TOWNPURCHASERANGE' Call GetNamespace);

_markets = [] + towns;
_buildings = (sideJoinedText) Call GetSideStructures;
_hq = (sideJoinedText) Call GetSideHQ;

_markets = _markets + _buildings + [_hq];

 if (paramHangars) then { _markets = _markets + Airfields; };     

_marketList = [];
{
	if (player distance _x <= (2*_range) && alive _x) then { _marketList = _marketList + [_x]; };
} forEach _markets;

_sorted = [player, _marketList] Call SortByDistance;

_sorted;
