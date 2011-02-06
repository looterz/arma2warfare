#include "profiler.h"
PROFILER_BEGIN("Common_GetClientFunds");

private['_id','_sideId','_funds'];

	_funds = _this select 0;
	_sideId = (_this Select 1) call GetSideID;
	_id = _this select 2;
	
	switch (_sideId) do {
		case WESTID: {
			switch(_id) do	{
				case  1: { WESTFunds1  = _funds;  };
				case  2: { WESTFunds2  = _funds;  };
				case  3: { WESTFunds3  = _funds;  };
				case  4: { WESTFunds4  = _funds;  };
				case  5: { WESTFunds5  = _funds;  };
				case  6: { WESTFunds6  = _funds;  };
				case  7: { WESTFunds7  = _funds;  };
				case  8: { WESTFunds8  = _funds;  };
				case  9: { WESTFunds9  = _funds;  };
				case 10: { WESTFunds10 = _funds;  };
				case 11: { WESTFunds11 = _funds;  };
				case 12: { WESTFunds12 = _funds;  };
				case 13: { WESTFunds13 = _funds;  };
				case 14: { WESTFunds14 = _funds;  };
				case 15: { WESTFunds15 = _funds;  };
				case 16: { WESTFunds16 = _funds;  };
				case 17: { WESTFunds17 = _funds;  };
				case 18: { WESTFunds18 = _funds;  };
				case 19: { WESTFunds19 = _funds;  };
				case 20: { WESTFunds20 = _funds;  };
				default  { 
					format["Common_SetClientFunds unknown clientId: %1, %2", _this, _id] call LogError;
					_funds = call Compile Format ["WESTFunds%1 = _funds", _id];
				};
			};
		};
		case EASTID: {
			switch(_id) do	{
				case  1: { EASTFunds1  = _funds;  };
				case  2: { EASTFunds2  = _funds;  };
				case  3: { EASTFunds3  = _funds;  };
				case  4: { EASTFunds4  = _funds;  };
				case  5: { EASTFunds5  = _funds;  };
				case  6: { EASTFunds6  = _funds;  };
				case  7: { EASTFunds7  = _funds;  };
				case  8: { EASTFunds8  = _funds;  };
				case  9: { EASTFunds9  = _funds;  };
				case 10: { EASTFunds10 = _funds;  };
				case 11: { EASTFunds11 = _funds;  };
				case 12: { EASTFunds12 = _funds;  };
				case 13: { EASTFunds13 = _funds;  };
				case 14: { EASTFunds14 = _funds;  };
				case 15: { EASTFunds15 = _funds;  };
				case 16: { EASTFunds16 = _funds;  };
				case 17: { EASTFunds17 = _funds;  };
				case 18: { EASTFunds18 = _funds;  };
				case 19: { EASTFunds19 = _funds;  };
				case 20: { EASTFunds20 = _funds;  };
				default  { 
					format["Common_SetClientFunds unknown clientId: %1, %2", _this, _id] call LogError;
					_funds = call Compile Format ["EASTFunds%1 = _funds", _id];
				};
			};
		};
		default {
			format["Common_SetClientFunds unknown sideId: %1", _sideId] call LogError;
		};
	};

PROFILER_END();
_funds;