#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamVote");

Private["_amount","_funds","_id","_sideId","_team"];

_id = _this Select 0;
_sideId = (_this Select 1) call GetSideID;
_value = nil;

	switch (_sideId) do {
		case WESTID: {
			switch(_id) do	{
				case  1: { _value = WESTTeam1Vote ; };
				case  2: { _value = WESTTeam2Vote ; };
				case  3: { _value = WESTTeam3Vote ; };
				case  4: { _value = WESTTeam4Vote ; };
				case  5: { _value = WESTTeam5Vote ; };
				case  6: { _value = WESTTeam6Vote ; };
				case  7: { _value = WESTTeam7Vote ; };
				case  8: { _value = WESTTeam8Vote ; };
				case  9: { _value = WESTTeam9Vote ; };
				case 10: { _value = WESTTeam10Vote; };
				case 11: { _value = WESTTeam11Vote; };
				case 12: { _value = WESTTeam12Vote; };
				case 13: { _value = WESTTeam13Vote; };
				case 14: { _value = WESTTeam14Vote; };
				case 15: { _value = WESTTeam15Vote; };
				case 16: { _value = WESTTeam16Vote; };
				case 17: { _value = WESTTeam17Vote; };
				case 18: { _value = WESTTeam18Vote; };
				case 19: { _value = WESTTeam19Vote; };
				case 20: { _value = WESTTeam20Vote; };
				default  { 
					format["Common_GetTeamVote unknown clientId: %1", _this] call LogError;
					_value = call Compile Format ["WESTTeam%1Vote", _id];
				};
			};
		};
		case EASTID: {
			switch(_id) do	{
				case  1: { _value = EASTTeam1Vote; };
				case  2: { _value = EASTTeam2Vote; };
				case  3: { _value = EASTTeam3Vote; };
				case  4: { _value = EASTTeam4Vote; };
				case  5: { _value = EASTTeam5Vote; };
				case  6: { _value = EASTTeam6Vote; };
				case  7: { _value = EASTTeam7Vote; };
				case  8: { _value = EASTTeam8Vote; };
				case  9: { _value = EASTTeam9Vote; };
				case 10: { _value = EASTTeam10Vote; };
				case 11: { _value = EASTTeam11Vote; };
				case 12: { _value = EASTTeam12Vote; };
				case 13: { _value = EASTTeam13Vote; };
				case 14: { _value = EASTTeam14Vote; };
				case 15: { _value = EASTTeam15Vote; };
				case 16: { _value = EASTTeam16Vote; };
				case 17: { _value = EASTTeam17Vote; };
				case 18: { _value = EASTTeam18Vote; };
				case 19: { _value = EASTTeam19Vote; };
				case 20: { _value = EASTTeam20Vote; };
				default  { 
					format["Common_GetTeamVote unknown clientId: %1", _this] call LogError;
					_value = call Compile Format ["WESTTeam%1Vote", _id];
				};
			};
		};
		default  {
			format["Common_GetTeamVote unknown sideId: %1", _this] call LogError;
		};
	};

PROFILER_END();
if (!isNil "_value") exitWith { _value };