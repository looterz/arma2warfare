#include "profiler.h"
PROFILER_BEGIN("Common_GetTeamFunds");

Private["_id","_team", "_result", "_sideId"];

	_team = _this;
	
	_sideId = (side _team) call GetSideID;
	_funds = 0;	
	switch (_sideId) do {
		case WESTID: {
			_id = _team Call GetClientIDFromTeam;
			switch(_id) do	{
				case  1: { _funds = WESTFunds1;  };
				case  2: { _funds = WESTFunds2;  };
				case  3: { _funds = WESTFunds3;  };
				case  4: { _funds = WESTFunds4;  };
				case  5: { _funds = WESTFunds5;  };
				case  6: { _funds = WESTFunds6;  };
				case  7: { _funds = WESTFunds7;  };
				case  8: { _funds = WESTFunds8;  };
				case  9: { _funds = WESTFunds9;  };
				case 10: { _funds = WESTFunds10;  };
				case 11: { _funds = WESTFunds11;  };
				case 12: { _funds = WESTFunds12;  };
				case 13: { _funds = WESTFunds13;  };
				case 14: { _funds = WESTFunds14;  };
				case 15: { _funds = WESTFunds15;  };
				case 16: { _funds = WESTFunds16;  };
				case 17: { _funds = WESTFunds17;  };
				case 18: { _funds = WESTFunds18;  };
				case 19: { _funds = WESTFunds19;  };
				case 20: { _funds = WESTFunds20;  };
				default  { 
					format["Common_GetTeamFunds unknown clientId: %1, %2", _this, _id] call LogError;
					_funds = call Compile Format ["WESTFunds%1", _id];
				};
			};
		};
		case EASTID: {
			_id = _team Call GetClientIDFromTeam;
			switch(_id) do	{
				case  1: { _funds = EASTFunds1;  };
				case  2: { _funds = EASTFunds2;  };
				case  3: { _funds = EASTFunds3;  };
				case  4: { _funds = EASTFunds4;  };
				case  5: { _funds = EASTFunds5;  };
				case  6: { _funds = EASTFunds6;  };
				case  7: { _funds = EASTFunds7;  };
				case  8: { _funds = EASTFunds8;  };
				case  9: { _funds = EASTFunds9;  };
				case 10: { _funds = EASTFunds10; };
				case 11: { _funds = EASTFunds11; };
				case 12: { _funds = EASTFunds12; };
				case 13: { _funds = EASTFunds13; };
				case 14: { _funds = EASTFunds14; };
				case 15: { _funds = EASTFunds15; };
				case 16: { _funds = EASTFunds16; };
				case 17: { _funds = EASTFunds17; };
				case 18: { _funds = EASTFunds18; };
				case 19: { _funds = EASTFunds19; };
				case 20: { _funds = EASTFunds20; };
				default  { 
					format["Common_GetTeamFunds unknown clientId: %1, %2", _this, _id] call LogError;
					_funds = call Compile Format ["EASTFunds%1", _id];
				};
			};
		};
		default {
			format["Common_GetTeamFunds unknown sideId: %1", _sideId] call LogError;
		};
	};

PROFILER_END();
_funds;