#include "profiler.h"
PROFILER_BEGIN("Common_SetTeamVote");

Private["_amount","_funds","_id","_sideId","_team"];

	_id = _this Select 0;
	_sideId = (_this Select 1) call GetSideID;
	_value = _this Select 2;

	switch (_sideId) do {
		case WESTID: {
			switch(_id) do	{
				case  1: { if (WESTTeam1Vote != _value) then { WESTTeam1Vote  = _value; publicVariable "WESTTeam1Vote";  }; };
				case  2: { if (WESTTeam2Vote != _value) then { WESTTeam2Vote  = _value; publicVariable "WESTTeam2Vote";  }; };
				case  3: { if (WESTTeam3Vote != _value) then { WESTTeam3Vote  = _value; publicVariable "WESTTeam3Vote";  }; };
				case  4: { if (WESTTeam4Vote != _value) then { WESTTeam4Vote  = _value; publicVariable "WESTTeam4Vote";  }; };
				case  5: { if (WESTTeam5Vote != _value) then { WESTTeam5Vote  = _value; publicVariable "WESTTeam5Vote";  }; };
				case  6: { if (WESTTeam6Vote != _value) then { WESTTeam6Vote  = _value; publicVariable "WESTTeam6Vote";  }; };
				case  7: { if (WESTTeam7Vote != _value) then { WESTTeam7Vote  = _value; publicVariable "WESTTeam7Vote";  }; };
				case  8: { if (WESTTeam8Vote != _value) then { WESTTeam8Vote  = _value; publicVariable "WESTTeam8Vote";  }; };
				case  9: { if (WESTTeam9Vote != _value) then { WESTTeam9Vote  = _value; publicVariable "WESTTeam9Vote";  }; };
				case 10: { if (WESTTeam10Vote != _value) then { WESTTeam10Vote = _value; publicVariable "WESTTeam10Vote"; }; };
				case 11: { if (WESTTeam11Vote != _value) then { WESTTeam11Vote = _value; publicVariable "WESTTeam11Vote"; }; };
				case 12: { if (WESTTeam12Vote != _value) then { WESTTeam12Vote = _value; publicVariable "WESTTeam12Vote"; }; };
				case 13: { if (WESTTeam13Vote != _value) then { WESTTeam13Vote = _value; publicVariable "WESTTeam13Vote"; }; };
				case 14: { if (WESTTeam14Vote != _value) then { WESTTeam14Vote = _value; publicVariable "WESTTeam14Vote"; }; };
				case 15: { if (WESTTeam15Vote != _value) then { WESTTeam15Vote = _value; publicVariable "WESTTeam15Vote"; }; };
				case 16: { if (WESTTeam16Vote != _value) then { WESTTeam16Vote = _value; publicVariable "WESTTeam16Vote"; }; };
				case 17: { if (WESTTeam17Vote != _value) then { WESTTeam17Vote = _value; publicVariable "WESTTeam17Vote"; }; };
				case 18: { if (WESTTeam18Vote != _value) then { WESTTeam18Vote = _value; publicVariable "WESTTeam18Vote"; }; };
				case 19: { if (WESTTeam19Vote != _value) then { WESTTeam19Vote = _value; publicVariable "WESTTeam19Vote"; }; };
				case 20: { if (WESTTeam20Vote != _value) then { WESTTeam20Vote = _value; publicVariable "WESTTeam20Vote"; }; };
				default { 
					format["Common_SetTeamVote unknown clientId: ", _this] call LogError;
					call Compile Format ["if (WESTTeam%1Vote != _value) then { WESTTeam%1Vote = _value; publicVariable 'WESTTeam%1Vote'; }", _id]
				};
			};
		};
		case EASTID: {
			switch(_id) do	{
				case  1: { if (EASTTeam1Vote != _value) then { EASTTeam1Vote  = _value; publicVariable "EASTTeam1Vote";  }; };
				case  2: { if (EASTTeam2Vote != _value) then { EASTTeam2Vote  = _value; publicVariable "EASTTeam2Vote";  }; };
				case  3: { if (EASTTeam3Vote != _value) then { EASTTeam3Vote  = _value; publicVariable "EASTTeam3Vote";  }; };
				case  4: { if (EASTTeam4Vote != _value) then { EASTTeam4Vote  = _value; publicVariable "EASTTeam4Vote";  }; };
				case  5: { if (EASTTeam5Vote != _value) then { EASTTeam5Vote  = _value; publicVariable "EASTTeam5Vote";  }; };
				case  6: { if (EASTTeam6Vote != _value) then { EASTTeam6Vote  = _value; publicVariable "EASTTeam6Vote";  }; };
				case  7: { if (EASTTeam7Vote != _value) then { EASTTeam7Vote  = _value; publicVariable "EASTTeam7Vote";  }; };
				case  8: { if (EASTTeam8Vote != _value) then { EASTTeam8Vote  = _value; publicVariable "EASTTeam8Vote";  }; };
				case  9: { if (EASTTeam9Vote != _value) then { EASTTeam9Vote  = _value; publicVariable "EASTTeam9Vote";  }; };
				case 10: { if (EASTTeam10Vote != _value) then { EASTTeam10Vote = _value; publicVariable "EASTTeam10Vote"; }; };
				case 11: { if (EASTTeam11Vote != _value) then { EASTTeam11Vote = _value; publicVariable "EASTTeam11Vote"; }; };
				case 12: { if (EASTTeam12Vote != _value) then { EASTTeam12Vote = _value; publicVariable "EASTTeam12Vote"; }; };
				case 13: { if (EASTTeam13Vote != _value) then { EASTTeam13Vote = _value; publicVariable "EASTTeam13Vote"; }; };
				case 14: { if (EASTTeam14Vote != _value) then { EASTTeam14Vote = _value; publicVariable "EASTTeam14Vote"; }; };
				case 15: { if (EASTTeam15Vote != _value) then { EASTTeam15Vote = _value; publicVariable "EASTTeam15Vote"; }; };
				case 16: { if (EASTTeam16Vote != _value) then { EASTTeam16Vote = _value; publicVariable "EASTTeam16Vote"; }; };
				case 17: { if (EASTTeam17Vote != _value) then { EASTTeam17Vote = _value; publicVariable "EASTTeam17Vote"; }; };
				case 18: { if (EASTTeam18Vote != _value) then { EASTTeam18Vote = _value; publicVariable "EASTTeam18Vote"; }; };
				case 19: { if (EASTTeam19Vote != _value) then { EASTTeam19Vote = _value; publicVariable "EASTTeam19Vote"; }; };
				case 20: { if (EASTTeam20Vote != _value) then { EASTTeam20Vote = _value; publicVariable "EASTTeam20Vote"; }; };
				default  { 
					format["Common_SetTeamVote unknown clientId: ", _this] call LogError;
					call Compile Format ["if (EASTTeam%1Vote != _value) then { EASTTeam%1Vote = _value; publicVariable 'EASTTeam%1Vote'; }", _id]
				};
			};
		};
		default {
			format["Common_SetTeamVote unknown sideId: ", _this] call LogError;
		};
	};

PROFILER_END();