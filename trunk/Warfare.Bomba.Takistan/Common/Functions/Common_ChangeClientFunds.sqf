#include "profiler.h"
PROFILER_BEGIN("Common_ChangeClientFunds");

private['_amount','_id','_sideId'];

_amount = _this Select 0;
_sideId = (_this Select 1) call GetSideID;
_id = _this Select 2;

	switch (_sideId) do {
		case WESTID: {
			switch(_id) do	{
				case  1: { WESTFunds1  = WESTFunds1  + _amount; publicVariable "WESTFunds1";  };
				case  2: { WESTFunds2  = WESTFunds2  + _amount; publicVariable "WESTFunds2";  };
				case  3: { WESTFunds3  = WESTFunds3  + _amount; publicVariable "WESTFunds3";  };
				case  4: { WESTFunds4  = WESTFunds4  + _amount; publicVariable "WESTFunds4";  };
				case  5: { WESTFunds5  = WESTFunds5  + _amount; publicVariable "WESTFunds5";  };
				case  6: { WESTFunds6  = WESTFunds6  + _amount; publicVariable "WESTFunds6";  };
				case  7: { WESTFunds7  = WESTFunds7  + _amount; publicVariable "WESTFunds7";  };
				case  8: { WESTFunds8  = WESTFunds8  + _amount; publicVariable "WESTFunds8";  };
				case  9: { WESTFunds9  = WESTFunds9  + _amount; publicVariable "WESTFunds9";  };
				case 10: { WESTFunds10 = WESTFunds10 + _amount; publicVariable "WESTFunds10"; };
				case 11: { WESTFunds11 = WESTFunds11 + _amount; publicVariable "WESTFunds11"; };
				case 12: { WESTFunds12 = WESTFunds12 + _amount; publicVariable "WESTFunds12"; };
				case 13: { WESTFunds13 = WESTFunds13 + _amount; publicVariable "WESTFunds13"; };
				case 14: { WESTFunds14 = WESTFunds14 + _amount; publicVariable "WESTFunds14"; };
				case 15: { WESTFunds15 = WESTFunds15 + _amount; publicVariable "WESTFunds15"; };
				case 16: { WESTFunds16 = WESTFunds16 + _amount; publicVariable "WESTFunds16"; };
				case 17: { WESTFunds17 = WESTFunds17 + _amount; publicVariable "WESTFunds17"; };
				case 18: { WESTFunds18 = WESTFunds18 + _amount; publicVariable "WESTFunds18"; };
				case 19: { WESTFunds19 = WESTFunds19 + _amount; publicVariable "WESTFunds19"; };
				case 20: { WESTFunds20 = WESTFunds20 + _amount; publicVariable "WESTFunds20"; };
				default { 
					format["Common_ChangeClientFunds unknown clientId: ", _this] call LogError;
					call Compile Format ["WESTFunds%1 = WESTFunds%1 + _amount; publicVariable 'WESTFunds%1';", _id]
				};
			};
		};
		case EASTID: {
			switch(_id) do	{
				case  1: { EASTFunds1  = EASTFunds1  + _amount; publicVariable "EASTFunds1";  };
				case  2: { EASTFunds2  = EASTFunds2  + _amount; publicVariable "EASTFunds2";  };
				case  3: { EASTFunds3  = EASTFunds3  + _amount; publicVariable "EASTFunds3";  };
				case  4: { EASTFunds4  = EASTFunds4  + _amount; publicVariable "EASTFunds4";  };
				case  5: { EASTFunds5  = EASTFunds5  + _amount; publicVariable "EASTFunds5";  };
				case  6: { EASTFunds6  = EASTFunds6  + _amount; publicVariable "EASTFunds6";  };
				case  7: { EASTFunds7  = EASTFunds7  + _amount; publicVariable "EASTFunds7";  };
				case  8: { EASTFunds8  = EASTFunds8  + _amount; publicVariable "EASTFunds8";  };
				case  9: { EASTFunds9  = EASTFunds9  + _amount; publicVariable "EASTFunds9";  };
				case 10: { EASTFunds10 = EASTFunds10 + _amount; publicVariable "EASTFunds10"; };
				case 11: { EASTFunds11 = EASTFunds11 + _amount; publicVariable "EASTFunds11"; };
				case 12: { EASTFunds12 = EASTFunds12 + _amount; publicVariable "EASTFunds12"; };
				case 13: { EASTFunds13 = EASTFunds13 + _amount; publicVariable "EASTFunds13"; };
				case 14: { EASTFunds14 = EASTFunds14 + _amount; publicVariable "EASTFunds14"; };
				case 15: { EASTFunds15 = EASTFunds15 + _amount; publicVariable "EASTFunds15"; };
				case 16: { EASTFunds16 = EASTFunds16 + _amount; publicVariable "EASTFunds16"; };
				case 17: { EASTFunds17 = EASTFunds17 + _amount; publicVariable "EASTFunds17"; };
				case 18: { EASTFunds18 = EASTFunds18 + _amount; publicVariable "EASTFunds18"; };
				case 19: { EASTFunds19 = EASTFunds19 + _amount; publicVariable "EASTFunds19"; };
				case 20: { EASTFunds20 = EASTFunds20 + _amount; publicVariable "EASTFunds20"; };
				default { 
					format["Common_ChangeClientFunds unknown clientId: ", _this] call LogError;
					call Compile Format ["EASTFunds%1 = EASTFunds%1 + _amount; publicVariable 'EASTFunds%1';", _id];
				};
			};
		};
		default {
			format["Common_ChangeClientFunds unknown sideId: ", _this] call LogError;
		};
	};

PROFILER_END();