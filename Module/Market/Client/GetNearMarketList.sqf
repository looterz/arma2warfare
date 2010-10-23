Private ['_sorted','_range', '_markets', '_buildings', '_hq', '_marketList'];

waitUntil {_base = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];!isNil "_base"};

_sorted = [];
_range = ('WFBE_TOWNPURCHASERANGE' Call GetNamespace);

_markets = [] + towns;
_buildings = WF_Logic getVariable Format ['%1BaseStructures',sideJoinedText];
_hq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];

_markets = _markets + _buildings + [_hq];

 if (paramHangars) then { _markets = _markets + Airfields; };     

_marketList = [];
{
	if (player distance _x <= (2*_range) && alive _x) then { _marketList = _marketList + [_x]; };
} forEach _markets;

_sorted = [player, _marketList] Call SortByDistance;

_sorted;
