Private ["_unit"];
_unit = _this select 0;

switch (typeOf _unit) do {

	case "T55_TK_EP1": {

		_unit addMagazine "8Rnd_AT5_BMP2";
		_unit addWeapon "AT5LauncherSingle";

	};

	case "T72_TK_EP1": {

		_unit addMagazine "5Rnd_AT11_T90";
		_unit addWeapon "AT11LauncherSingle";

	};

	case "ZSU_TK_EP1": {

		_unit addMagazine "2Rnd_Igla";
		_unit addMagazine "2Rnd_Igla";
		_unit addMagazine "2Rnd_Igla";
		_unit addMagazine "2Rnd_Igla";
		_unit addWeapon "Igla_twice";

	};

	case "M6_EP1": {

		_unit removeWeapon "StingerLaucher_4x";
		_unit addMagazine "8Rnd_9M311";
		_unit addWeapon "9M311Laucher";
	};

	case "An2_TK_EP1": {

		_unit addMagazine "4Rnd_FAB_250";
		_unit addMagazine "4Rnd_FAB_250";
		_unit addMagazine "4Rnd_FAB_250";
		_unit addWeapon "AirBombLauncher";
		_unit addMagazine "120Rnd_CMFlareMagazine";
		_unit addWeapon "CMFlareLauncher";

	};

	case "L39_TK_EP1": {

		_unit addMagazine "2Rnd_R73";
		_unit addWeapon "R73Launcher_2";
		_unit addMagazine "120Rnd_CMFlareMagazine";
		_unit addWeapon "CMFlareLauncher";

	};

	case "UH1H_TK_EP1": {

		_unit addMagazine "120Rnd_CMFlareMagazine";
		_unit addWeapon "CMFlareLauncher";

	};

	case "Mi24_D_TK_EP1": {

		_unit removeWeapon "AT2Launcher";
		_unit addMagazine "2Rnd_R73";
		_unit addWeapon "R73Launcher_2";

	};

	case "Mi24_V": {

		_unit removeWeapon "AT6Launcher";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addWeapon "AT9Launcher";

	};

	case "Mi24_P": {


	};

	case "Ka52": {

		_unit removeWeapon "VikhrLauncher";
		_unit addMagazine "8Rnd_Hellfire";
		_unit addWeapon "HellfireLauncher";
	
	};

	case "Ka52Black": {

		_unit removeWeapon "VikhrLauncher";
		_unit addMagazine "8Rnd_Hellfire";
		_unit addWeapon "HellfireLauncher";
		_unit addMagazine "2Rnd_R73";
		_unit addWeapon "R73Launcher_2";

	};

	case "MH6J_EP1": {

		_unit addMagazine "Laserbatteries";
		_unit addWeapon "Laserdesignator_mounted";

	};

	case "F35B": {

		_unit addMagazine "2Rnd_Sidewinder_F35";
		_unit addMagazine "2Rnd_Maverick_A10";
		_unit addMagazine "2Rnd_Maverick_A10";
		_unit addMagazine "2Rnd_Maverick_A10";
		_unit addMagazine "2Rnd_Maverick_A10";
		_unit addWeapon "MaverickLauncher";

	};
		
};