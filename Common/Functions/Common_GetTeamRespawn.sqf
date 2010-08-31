Private['_respawn','_team'];

_team = _this;

_respawn = _team getVariable 'respawn';
if (isNil '_respawn') then {_respawn = ''};

_respawn