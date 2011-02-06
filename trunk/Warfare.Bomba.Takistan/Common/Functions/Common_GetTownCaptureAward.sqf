#include "profiler.h"
PROFILER_BEGIN("Common_GetTownCaptureAward");
private['_teams','_location','_assaultTeams','_assaultTeamCount','_assistTeamCount','_assaultAward','_assistAward','_cash','_fnisassaultteam','_fngetassalutteams','_result'];

	_fnIsAssaultTeam = {
		private['_team', '_maxDist', '_location', '_flag'];
	
		_team = _this select 0;
		_maxDist = _this select 1;
		_location = _this select 2;
		
		_flag = false;
		
		{ if (_x distance _location < _maxDist) then { _flag = true; }; } forEach (units _team);
		
		_flag;
	};

	_fnGetAssalutTeams = {
		private['_teams', '_location', '_assaultTeamCount', '_assistTeamCount', '_assaultMaxDist', '_assistMaxDist'];
		_teams = _this select 0;
		_location = _this select 1;
		
		_assaultMaxDist =  ('WFBE_TOWNCAPTURERANGE' Call GetNamespace);
		_assistMaxDist = (_location getVariable "range") * ('WFBE_TOWNCAPTUREASSISTRANGEMODIFIER' Call GetNamespace);

		_assaultTeamCount = 0;
		_assistTeamCount = 0;
		
		{ 
			if !(isNil '_x') then {

				if ([_x, _assaultMaxDist, _location ] call _fnIsAssaultTeam) then {
					_assaultTeamCount = _assaultTeamCount + 1;	
				} else {
					if ([_x, _assistMaxDist, _location ] call _fnIsAssaultTeam) then {
						_assistTeamCount = _assistTeamCount + 1;	
					};
				};
			};
		} forEach _teams;	

		[_assaultTeamCount, _assistTeamCount]
	};

	format["GetTownCaptureAward:%1", _this] call LogHigh;
	
	_teams = _this select 0;
	_location = _this select 1;
	_cash = _this select 2;

	_assaultTeams = [_teams, _location] call _fnGetAssalutTeams;
	_assaultTeamCount = _assaultTeams select 0;
	_assistTeamCount = _assaultTeams select 1;

	format["GetTownCaptureAward: AssaultTeams:%1 AssistTeams:%2", _assaultTeamCount, _assistTeamCount] call LogHigh;

	_assaultAward = _cash * 0.75;
	_assistAward = _cash * 0.25;
	
	format["GetTownCaptureAward: AssaultTeamAward:%1 AssistTeamAward:%2", _assaultAward, _assistAward] call LogHigh;
	
	if (_assaultTeamCount == 0) then { _assistAward = _cash; _assaultAward = 0; };
	if (_assistTeamCount == 0)  then { _assaultAward = _cash; _assistAward = 0; };
	
	if (_assaultTeamCount > 0) then { _assaultAward = _assaultAward / _assaultTeamCount; };
	if (_assistTeamCount > 0) then { _assistAward = _assistAward / _assistTeamCount; };
	
	_assaultAward = floor(_assaultAward);
	_assistAward = floor(_assistAward);
	
	if (_assaultAward > 5000) then { _assaultAward = 5000; };
	if (_assistAward > 5000) then { _assistAward = 5000; };
	
	format["GetTownCaptureAward: AssaultTeamAward:%1 AssistTeamAward:%2", _assaultAward, _assistAward] call LogHigh;
	
	_result = [_assaultAward, _assistAward];
	format["TeamAwards=%1", _result] call LogHigh;
PROFILER_END();

_result