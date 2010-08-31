Private ["_milalpha"];

_milalpha = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mike",
"November","Oscar","Papa","Quebec","Romeo","Sierra","Tango","Uniform","Victor","Whiskey","X-Ray","Yankee","Zulu"];

_u = 0;
{
	if !(isNil '_x') then {_x setGroupID [_milalpha select _u]};
	_u = _u + 1;
} forEach clientTeams