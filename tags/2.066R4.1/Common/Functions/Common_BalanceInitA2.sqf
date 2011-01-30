#include "profiler.h"
PROFILER_BEGIN("Common_BalanceInit");
// this file describe balance for vanilla arma2

Private ["_unit"];
_unit = _this select 0;

format["BalanceUnit:%1", typeof _unit] call LogHigh;

switch (typeOf _unit) do {
	//EAST
	case "Ka52": {
		_unit removeWeapon "VikhrLauncher";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addweapon "AT9Launcher";
	};	
};

PROFILER_END();