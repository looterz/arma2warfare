Private["_currentDammages","_damage","_damagedBy","_side","_structure"];

_structure = _this Select 0;
_damagedBy = _this Select 1;
_damage = _this Select 2;
_currentDammages = getDammage _structure;

_side = east;
if ((typeOf _structure) in ('WFBE_WESTSTRUCTURENAMES' Call GetNamespace)) then {_side = west};

_timeAttacked = Call Compile Format["%1TimeUnderAttack",Str _side];

if (_side != Side _damagedBy) then {
	if (time - _timeAttacked > 30 && _damage > 0.05 && ((_currentDammages + _damage) < 1)) then {
		Call Compile Format["%1TimeUnderAttack = time",Str _side];		
		["IsUnderAttack",TypeOf _structure ,_side] Spawn SideMessage;
	};
};