Private["_client","_newScore","_playerChanged","_side"];

_side = _this select 0;
_client = _this select 1;
_playerChanged = _this select 2;
_newScore = _this select 3;

_oldScore = score _playerChanged;
_playerChanged addScore -_oldScore;
_playerChanged addScore _newScore;

[CMDCHANGESCORE,_playerChanged,_newScore] Spawn CommandToClients;