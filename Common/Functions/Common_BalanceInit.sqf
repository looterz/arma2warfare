#include "profiler.h"
PROFILER_BEGIN("Common_BalanceInit");

Private ["_unit"];
_unit = _this select 0;

switch (typeOf _unit) do {
	//WEST
	case "HMMWV_Avenger": {
		_unit removeWeapon "SidewinderLaucher_AH1Z";
		_unit removeWeapon "StingerLaucher";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addMagazine "2Rnd_Sidewinder_AH1Z";
		_unit addWeapon "SidewinderLaucher_AH1Z";
	};
	case "AH1Z": {
		_unit removeMagazine "2Rnd_Sidewinder_AH1Z";
		_unit removeWeapon "SidewinderLaucher_AH1Z";		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
	};
	case "CH_47F_EP1": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
	};
	case "AV8B": {
		_unit removeMagazinesTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
		_unit addMagazineTurret ["120Rnd_CMFlareMagazine",[-1]];
	};
	case "AV8B2": {
		_unit removeMagazinesTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
		_unit addMagazineTurret ["120Rnd_CMFlareMagazine",[-1]];
	};
	case "F35B": {
		_unit removeWeapon "BombLauncherF35";
		_unit addMagazine "2Rnd_Maverick_A10";
		_unit addWeapon "MaverickLauncher";
	};
	case "M6_EP1": {
		_unit removeWeapon "StingerLaucher_4x";
		_unit addMagazine "4Rnd_Sidewinder_AV8B";
		_unit addMagazine "4Rnd_Sidewinder_AV8B";
		_unit addWeapon "SidewinderLaucher";
	};
	//EAST
	case "Ka52": {
		//_unit removeWeapon "AT9Launcher";
		_unit removeWeapon "VikhrLauncher";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addweapon "AT9Launcher";
		_unit removeMagazinesTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
	};	
	case "Ka52Black": {
		//_unit removeWeapon "AT9Launcher";	 
		_unit removeWeapon "VikhrLauncher";
		_unit addMagazine "2Rnd_R73";
		_unit addweapon "R73Launcher_2";	
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addweapon "AT9Launcher";
		_unit removeMagazinesTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlare_Chaff_Magazine",[-1]];
	};	
	case "Mi24_V": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Mi24_D": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Mi24_D_TK_EP1": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Mi24_P": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Su34": {
		_unit removeMagazinesTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
		_unit addMagazineTurret ["120Rnd_CMFlareMagazine",[-1]];
	};
	case "Mi17_rockets_RU": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Mi17_TK_EP1": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Mi17_medevac_RU": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["60Rnd_CMFlareMagazine",[-1]];
	};
	case "Su25_TK_EP1": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
	};
	case "Su39": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
	};
	case "Su25_Ins": {
		_unit removeMagazinesTurret ["120Rnd_CMFlareMagazine",[-1]];
		_unit addMagazineTurret ["120Rnd_CMFlare_Chaff_Magazine",[-1]];
	};
	case "An2_TK_EP1": {
		_unit addMagazine "4Rnd_FAB_250";
		_unit addWeapon "AirBombLauncher";
		_unit addMagazine "60Rnd_CMFlareMagazine";
		_unit addWeapon "CMFlareLauncher";
	};
};

_unit Call RemoveFlares; // -- allow flares only after upgrade
PROFILER_END();