Private['_autonomous','_team'];

_team = _this;

_autonomous = _team getVariable 'autonomous';
if (isNil '_autonomous') then {_autonomous = false};

_autonomous