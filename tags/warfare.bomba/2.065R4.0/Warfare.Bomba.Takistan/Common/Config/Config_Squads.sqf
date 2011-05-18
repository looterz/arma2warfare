Private ['_aiTeamTemplates','_aiTeamTemplateRequires','_aiTeamTypes'];
//--- _f = [barracks,light,heavy,air];
if (WF_A2_Vanilla) then {
	//--- West
	_aiTeamTemplates = [];
	_aiTeamTemplateRequires = [];
	_aiTeamTypes = []; //--- 0 Inf, 1 Light, 2 Armor, 3	Air
	_aiTeamUpgrades = [];

	_d		= ["Infantry - Rifle Squad"];
	_u		= ["USMC_Soldier_SL"];
	_u = _u + ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];
	
	_d = _d	+ ["Infantry - Fire Team"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (MG)"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_MG"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AA)"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_AA"];
	_u = _u + ["USMC_Soldier_AA"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AT)"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_AT"];
	_u = _u + ["USMC_Soldier_LAT"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AA/AT)"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AA"];
	_u = _u + ["USMC_Soldier_AA"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier_AT"];
	_u = _u + ["USMC_Soldier_AR"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (Support)"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier_Medic"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Heavy AT Team"];
	_u		= ["USMC_Soldier_HAT"];
	_u = _u + ["USMC_Soldier_AT"];
	_u = _u + ["USMC_Soldier_LAT"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Snipers Team"];
	_u		= ["USMC_SoldierS_Sniper"];
	_u = _u + ["USMC_SoldierS_Spotter"];
	_u = _u + ["USMC_SoldierS"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Force Recon Team"];
	_u		= ["FR_TL"];
	_u = _u + ["FR_AR"];
	_u = _u + ["FR_GL"];
	_u = _u + ["FR_Marksman"];
	_u = _u + ["FR_R"];
	_u = _u + ["FR_Corpsman"];
	_u = _u + ["FR_Sapper"];
	_u = _u + ["FR_AC"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized - Anti Air Section"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["HMMWV_Avenger"];
	_u = _u + ["HMMWV_Avenger"];
	_u = _u + ["USMC_Soldier_AA"];
	_f 		= [true,true,false,false];
	_l 		= [2,3,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Section"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["HMMWV_M2"];
	_u = _u + ["HMMWV_Mk19"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,true,false,false];
	_l 		= [0,1,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Section (AT)"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["HMMWV_TOW"];
	_u = _u + ["HMMWV_TOW"];
	_u = _u + ["USMC_Soldier_AR"];
	_f 		= [true,true,false,false];
	_l 		= [0,2,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Mechanized Rifle Squad"];
	_u		= ["USMC_Soldier_SL"];
	_u = _u + ["AAV"];
	_u = _u + ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier_Medic"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,false,true,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Recon Section"];
	_u		= ["USMC_Soldier_TL"];
	_u = _u + ["LAV25"];
	_u = _u + ["USMC_Soldier_MG"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_AT"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,true,false,false];
	_l 		= [2,3,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Light)"];
	_u		= ["M1A1"];
	_u = _u + ["M1A1"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,1,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Heavy)"];
	_u		= ["M1A2_TUSK_MG"];
	_u = _u + ["M1A2_TUSK_MG"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,2,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - AH-1Z Squadron"];
	_u		= ["AH1Z"];
	_u = _u + ["AH1Z"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - UH1Y Squadron"];
	_u		= ["UH1Y"];
	_u = _u + ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_AR"];
	_u = _u + ["USMC_Soldier_LAT"];
	_u = _u + ["USMC_Soldier_Medic"];
	_u = _u + ["USMC_Soldier"];
	_u = _u + ["USMC_Soldier"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,false,false,true];
	_l 		= [0,0,0,1];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - MH-60S Squadron"];
	_u		= ["MH60S"];
	_u = _u + ["USMC_Soldier_TL"];
	_u = _u + ["USMC_Soldier_MG"];
	_u = _u + ["USMC_Soldier_AT"];
	_u = _u + ["USMC_Soldier_Medic"];
	_u = _u + ["USMC_Soldier"];
	_u = _u + ["USMC_Soldier"];
	_u = _u + ["USMC_Soldier"];
	_f 		= [true,false,false,true];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - A10 Squadron"];
	_u		= ["A10"];
	_u = _u + ["A10"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,3];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Harrier Squadron"];
	_u		= ["AV8B2"];
	_u = _u + ["AV8B"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	['WFBE_WESTAITEAMTEMPLATES',_aiTeamTemplates,true] Call SetNamespace;
	['WFBE_WESTAITEAMTEMPLATEREQUIRES',_aiTeamTemplateRequires,true] Call SetNamespace;
	['WFBE_WESTAITEAMTYPES',_aiTeamTypes,true] Call SetNamespace;
	['WFBE_WESTAITEAMUPGRADES',_aiTeamUpgrades,true] Call SetNamespace;
	['WFBE_WESTAITEAMTEMPLATEDESCRIPTIONS',_d,true] Call SetNamespace;

	//--- East.
	_aiTeamTemplates = [];
	_aiTeamTemplateRequires = [];
	_aiTeamTypes = [];
	_aiTeamUpgrades = [];

	_d		= ["Infantry - Infantry Squad"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_Marksman"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d + ["Infantry - Infantry Section"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AT)"];
	_u 		= ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (HAT)"];
	_u		= ["RU_Soldier_HAT"];
	_u = _u + ["RU_Soldier_HAT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AA)"];
	_u		= ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AA/AT)"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (MG)"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_GL"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Snipers Team"];
	_u		= ["RU_Soldier_Marksman"];
	_u = _u + ["RUS_Soldier_Marksman"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Spetsnaz Team"];
	_u		= ["RUS_Commander"];
	_u = _u + ["RUS_Soldier1"];
	_u = _u + ["RUS_Soldier2"];
	_u = _u + ["RUS_Soldier_GL"];
	_u = _u + ["RUS_Soldier_Marksman"];
	_u = _u + ["RUS_Soldier3"];
	_u = _u + ["RUS_Soldier_TL"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - MVD Assault Team"];
	_u		= ["MVD_Soldier_TL"];
	_u = _u + ["MVD_Soldier_MG"];
	_u = _u + ["MVD_Soldier_AT"];
	_u = _u + ["MVD_Soldier_GL"];
	_u = _u + ["MVD_Soldier_Sniper"];
	_u = _u + ["MVD_Soldier_Marksman"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Infantry Squad"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["Kamaz"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_Marksman"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,true,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Recon Section"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["GAZ_Vodnik"];
	_u = _u + ["GAZ_Vodnik_HMG"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier_Marksman"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,true,false,false];
	_l 		= [2,2,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Patrol Section"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["UAZ_AGS30_RU"];
	_f 		= [true,true,false,false];
	_l 		= [0,1,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Motor Rifles (BMP)"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["BMP3"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_GL"];
	_f 		= [true,false,true,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Motor Rifles (BTR)"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["BTR90"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_GL"];
	_f 		= [true,true,false,false];
	_l 		= [1,3,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Anti Air Platoon"];
	_u		= ["2S6M_Tunguska"];
	_u = _u + ["2S6M_Tunguska"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,3,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Light)"];
	_u		= ["T72_RU"];
	_u = _u + ["T72_RU"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,1,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Heavy)"];
	_u		= ["T90"];
	_u = _u + ["T90"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,2,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Mi-17 Squadron"];
	_u		= ["Mi17_Ins"];
	_u = _u + ["MVD_Soldier_TL"];
	_u = _u + ["MVD_Soldier_GL"];
	_u = _u + ["MVD_Soldier_MG"];
	_u = _u + ["MVD_Soldier_MG"];
	_u = _u + ["MVD_Soldier_Marksman"];
	_u = _u + ["MVD_Soldier_AT"];
	_u = _u + ["MVD_Soldier_AT"];
	_f 		= [true,false,false,true];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Mi-8 Squadron"];
	_u		= ["Mi17_rockets_RU"];
	_u = _u + ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_MG"];
	_f 		= [true,false,false,true];
	_l 		= [2,0,0,1];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	if !(paramRestrictionKamov) then {
		_d = _d	+ ["Air - Ka-52 Squadron"];
		_u		= ["Ka52Black"];
		_u = _u + ["Ka52"];
		_f 		= [false,false,false,true];

		_aiTeamTemplates = _aiTeamTemplates + [_u];
		_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
		_aiTeamTypes = _aiTeamTypes + [3];
		_aiTeamUpgrades = _aiTeamUpgrades + [_l];
		_l 		= [0,0,0,3];
	};

	_d = _d	+ ["Air - Mi-24 Squadron"];
	_u		= ["Mi24_V"];
	_u = _u + ["Mi24_P"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Sukhoi 34 Squadron"];
	_u		= ["Su34"];
	_u = _u + ["Su34"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Sukhoi 39 Squadron"];
	_u		= ["Su39"];
	_u = _u + ["Su39"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,3];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	['WFBE_EASTAITEAMTEMPLATES',_aiTeamTemplates,true] Call SetNamespace;
	['WFBE_EASTAITEAMTEMPLATEREQUIRES',_aiTeamTemplateRequires,true] Call SetNamespace;
	['WFBE_EASTAITEAMTYPES',_aiTeamTypes,true] Call SetNamespace;
	['WFBE_EASTAITEAMUPGRADES',_aiTeamUpgrades,true] Call SetNamespace;
	['WFBE_EASTAITEAMTEMPLATEDESCRIPTIONS',_d,true] Call SetNamespace;
};

if (WF_A2_Arrowhead) then {
	//--- West
	_aiTeamTemplates = [];
	_aiTeamTemplateRequires = [];
	_aiTeamTypes = []; //--- 0 Inf, 2 Light, 3 Armor, 4 Air
	_aiTeamUpgrades = [];

	_d		= ["Infantry - Rifle Squad"];
	_u		= ["US_Soldier_SL_EP1"];
	_u = _u + ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (MG)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_MG_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AA)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AT)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AA/AT)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (Support)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_Medic_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Heavy AT Team"];
	_u		= ["US_Soldier_HAT_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Snipers Team"];
	_u		= ["US_Soldier_Sniper_EP1"];
	_u = _u + ["US_Soldier_Marksman_EP1"];
	_u = _u + ["US_Soldier_Spotter_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Delta Force Team"];
	_u		= ["US_Delta_Force_TL_EP1"];
	_u = _u + ["US_Delta_Force_Assault_EP1"];
	_u = _u + ["US_Delta_Force_MG_EP1"];
	_u = _u + ["US_Delta_Force_AR_EP1"];
	_u = _u + ["US_Delta_Force_EP1"];
	_u = _u + ["US_Delta_Force_Medic_EP1"];
	_u = _u + ["US_Delta_Force_M14_EP1"];
	_u = _u + ["US_Delta_Force_Air_Controller_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized - Anti Air Section"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["HMMWV_Avenger_DES_EP1"];
	_u = _u + ["HMMWV_Avenger_DES_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [2,3,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Section"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["HMMWV_M998_crows_M2_DES_EP1"];
	_u = _u + ["HMMWV_M998_crows_MK19_DES_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [2,1,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Section (AT)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["HMMWV_TOW_DES_EP1"];
	_u = _u + ["HMMWV_TOW_DES_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [0,2,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Mechanized Rifle Squad"];
	_u		= ["M2A2_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_Medic_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,true,false];
	_l 		= [0,0,1,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Light)"];
	_u		= ["M1A1_US_DES_EP1"];
	_u = _u + ["M1A1_US_DES_EP1"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,2,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Heavy)"];
	_u		= ["M1A2_US_TUSK_MG_EP1"];
	_u = _u + ["M1A2_US_TUSK_MG_EP1"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,3,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - AH-6J Squadron"];
	_u		= ["AH6J_EP1"];
	_u = _u + ["AH6J_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,1];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - AH-64D Squadron"];
	_u		= ["AH64D_EP1"];
	_u = _u + ["AH64D_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - CH-47F Squadron"];
	_u		= ["CH_47F_EP1"];
	_u = _u + ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_Medic_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,false,true];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - A10 Squadron"];
	_u		= ["A10_US_EP1"];
	_u = _u + ["A10_US_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,3];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	['WFBE_WESTAITEAMTEMPLATES',_aiTeamTemplates,true] Call SetNamespace;
	['WFBE_WESTAITEAMTEMPLATEREQUIRES',_aiTeamTemplateRequires,true] Call SetNamespace;
	['WFBE_WESTAITEAMTYPES',_aiTeamTypes,true] Call SetNamespace;
	['WFBE_WESTAITEAMUPGRADES',_aiTeamUpgrades,true] Call SetNamespace;
	['WFBE_WESTAITEAMTEMPLATEDESCRIPTIONS',_d,true] Call SetNamespace;

	//--- East.
	_aiTeamTemplates = [];
	_aiTeamTemplateRequires = [];
	_aiTeamTypes = [];
	_aiTeamUpgrades = [];

	_d		= ["Infantry - Infantry Squad"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_Spotter_EP1"];
	_u = _u + ["TK_Soldier_AR_EP1"];
	_u = _u + ["TK_Soldier_GL_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d + ["Infantry - Infantry Section"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["TK_Soldier_AR_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_GL_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AT)"];
	_u 		= ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];
	
	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (HAT)"];
	_u		= ["TK_Soldier_HAT_EP1"];
	_u = _u + ["TK_Soldier_HAT_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AA)"];
	_u		= ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AA/AT)"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (MG)"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_GL_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Snipers Team"];
	_u		= ["TK_Soldier_Spotter_EP1"];
	_u = _u + ["TK_Soldier_Sniper_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Special Ops Team"];
	_u		= ["TK_Special_Forces_EP1"];
	_u = _u + ["TK_Special_Forces_TL_EP1"];
	_u = _u + ["TK_Special_Forces_MG_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Infantry Squad"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["V3S_TK_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_Spotter_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_AR_EP1"];
	_u = _u + ["TK_Soldier_GL_EP1"];
	_u = _u + ["TK_Soldier_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Patrol Section"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["BRDM2_TK_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [0,1,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Motor Rifles (BMP)"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["BMP2_TK_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_GL_EP1"];
	_f 		= [true,false,true,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Motor Rifles (BTR)"];
	_u		= ["TK_Soldier_SL_EP1"];
	_u = _u + ["BTR60_TK_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_AT_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_GL_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [1,2,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Anti Air Platoon"];
	_u		= ["ZSU_TK_EP1"];
	_u = _u + ["ZSU_TK_EP1"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,1,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Light)"];
	_u		= ["T55_TK_EP1"];
	_u = _u + ["T55_TK_EP1"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,1,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Heavy)"];
	_u		= ["T72_TK_EP1"];
	_u = _u + ["T72_TK_EP1"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,2,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Mi-17 Squadron"];
	_u		= ["Mi17_TK_EP1"];
	_u = _u + ["TK_Soldier_SL_EP1"];
	_u = _u + ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_AA_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_LAT_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_u = _u + ["TK_Soldier_MG_EP1"];
	_f 		= [true,false,false,true];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Mi-24 Squadron"];
	_u		= ["Mi24_D_TK_EP1"];
	_u = _u + ["Mi24_D_TK_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,1];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - L39 Squadron"];
	_u		= ["L39_TK_EP1"];
	_u = _u + ["L39_TK_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];
	
	_d = _d	+ ["Air - Sukhoi 25 Squadron"];
	_u		= ["Su25_TK_EP1"];
	_u = _u + ["Su25_TK_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,3];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	['WFBE_EASTAITEAMTEMPLATES',_aiTeamTemplates,true] Call SetNamespace;
	['WFBE_EASTAITEAMTEMPLATEREQUIRES',_aiTeamTemplateRequires,true] Call SetNamespace;
	['WFBE_EASTAITEAMTYPES',_aiTeamTypes,true] Call SetNamespace;
	['WFBE_EASTAITEAMUPGRADES',_aiTeamUpgrades,true] Call SetNamespace;
	['WFBE_EASTAITEAMTEMPLATEDESCRIPTIONS',_d,true] Call SetNamespace;
};

if (WF_A2_CombinedOps) then {
	//--- West.
	_aiTeamTemplates = [];
	_aiTeamTemplateRequires = [];
	_aiTeamTypes = []; //--- 0 Inf, 2 Light, 3 Armor, 4 Air
	_aiTeamUpgrades = [];
	
	_d		= ["Infantry - Rifle Squad"];
	_u		= ["US_Soldier_SL_EP1"];
	_u = _u + ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (MG)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_MG_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AA)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AT)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (AA/AT)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_u = _u + ["US_Soldier_AA_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Fire Team (Support)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_Medic_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Heavy AT Team"];
	_u		= ["US_Soldier_HAT_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Snipers Team"];
	_u		= ["US_Soldier_Sniper_EP1"];
	_u = _u + ["US_Soldier_Marksman_EP1"];
	_u = _u + ["US_Soldier_Spotter_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Delta Force Team"];
	_u		= ["US_Delta_Force_TL_EP1"];
	_u = _u + ["US_Delta_Force_Assault_EP1"];
	_u = _u + ["US_Delta_Force_MG_EP1"];
	_u = _u + ["US_Delta_Force_AR_EP1"];
	_u = _u + ["US_Delta_Force_EP1"];
	_u = _u + ["US_Delta_Force_Medic_EP1"];
	_u = _u + ["US_Delta_Force_M14_EP1"];
	_u = _u + ["US_Delta_Force_Air_Controller_EP1"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized - Anti Air Section"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + [if (WF_Camo) then {"HMMWV_Avenger"} else {"HMMWV_Avenger_DES_EP1"}];
	_u = _u + [if (WF_Camo) then {"HMMWV_Avenger"} else {"HMMWV_Avenger_DES_EP1"}];
	_u = _u + ["US_Soldier_AA_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [2,3,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Section"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + [if (WF_Camo) then {"HMMWV_M2"} else {"HMMWV_M998_crows_M2_DES_EP1"}];
	_u = _u + [if (WF_Camo) then {"HMMWV_MK19"} else {"HMMWV_M998_crows_MK19_DES_EP1"}];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_AT_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [2,1,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Section (AT)"];
	_u		= ["US_Soldier_TL_EP1"];
	_u = _u + [if (WF_Camo) then {"HMMWV_TOW"} else {"HMMWV_TOW_DES_EP1"}];
	_u = _u + [if (WF_Camo) then {"HMMWV_TOW"} else {"HMMWV_TOW_DES_EP1"}];
	_u = _u + ["US_Soldier_AR_EP1"];
	_f 		= [true,true,false,false];
	_l 		= [0,2,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Mechanized Rifle Squad"];
	_u		= ["M2A2_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_Medic_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,true,false];
	_l 		= [0,0,1,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Light)"];
	_u		= [if (WF_Camo) then {"M1A1"} else {"M1A1_US_DES_EP1"}];
	_u = _u + [if (WF_Camo) then {"M1A1"} else {"M1A1_US_DES_EP1"}];
	_f 		= [false,false,true,false];
	_l 		= [0,0,2,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Heavy)"];
	_u		= [if (WF_Camo) then {"M1A2_TUSK_MG"} else {"M1A2_US_TUSK_MG_EP1"}];
	_u = _u + [if (WF_Camo) then {"M1A2_TUSK_MG"} else {"M1A2_US_TUSK_MG_EP1"}];
	_f 		= [false,false,true,false];
	_l 		= [0,0,3,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - AH-64D Squadron"];
	_u		= ["AH64D_EP1"];
	_u = _u + ["AH64D_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - CH-47F Squadron"];
	_u		= ["CH_47F_EP1"];
	_u = _u + ["US_Soldier_TL_EP1"];
	_u = _u + ["US_Soldier_AR_EP1"];
	_u = _u + ["US_Soldier_LAT_EP1"];
	_u = _u + ["US_Soldier_Medic_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_u = _u + ["US_Soldier_EP1"];
	_f 		= [true,false,false,true];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - A10 Squadron"];
	_u		= ["A10_US_EP1"];
	_u = _u + ["A10_US_EP1"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,3];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	['WFBE_WESTAITEAMTEMPLATES',_aiTeamTemplates,true] Call SetNamespace;
	['WFBE_WESTAITEAMTEMPLATEREQUIRES',_aiTeamTemplateRequires,true] Call SetNamespace;
	['WFBE_WESTAITEAMTYPES',_aiTeamTypes,true] Call SetNamespace;
	['WFBE_WESTAITEAMUPGRADES',_aiTeamUpgrades,true] Call SetNamespace;
	['WFBE_WESTAITEAMTEMPLATEDESCRIPTIONS',_d,true] Call SetNamespace;

	//--- East.
	_aiTeamTemplates = [];
	_aiTeamTemplateRequires = [];
	_aiTeamTypes = [];
	_aiTeamUpgrades = [];

	_d		= ["Infantry - Infantry Squad"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_Marksman"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d + ["Infantry - Infantry Section"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AT)"];
	_u		= ["RU_Soldier_HAT"];
	_u = _u + ["RU_Soldier_HAT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];
	
	_d = _d	+ ["Infantry - Infantry Section (HAT)"];
	_u		= ["RU_Soldier_HAT"];
	_u = _u + ["RU_Soldier_HAT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AA)"];
	_u		= ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (AA/AT)"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Infantry Section (MG)"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_GL"];
	_f 		= [true,false,false,false];
	_l 		= [0,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Snipers Team"];
	_u		= ["RU_Soldier_Marksman"];
	_u = _u + ["RUS_Soldier_Marksman"];
	_f 		= [true,false,false,false];
	_l 		= [2,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - Spetsnaz Team"];
	_u		= ["RUS_Commander"];
	_u = _u + ["RUS_Soldier1"];
	_u = _u + ["RUS_Soldier2"];
	_u = _u + ["RUS_Soldier_GL"];
	_u = _u + ["RUS_Soldier_Marksman"];
	_u = _u + ["RUS_Soldier3"];
	_u = _u + ["RUS_Soldier_TL"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Infantry - MVD Assault Team"];
	_u		= ["MVD_Soldier_TL"];
	_u = _u + ["MVD_Soldier_MG"];
	_u = _u + ["MVD_Soldier_AT"];
	_u = _u + ["MVD_Soldier_GL"];
	_u = _u + ["MVD_Soldier_Sniper"];
	_u = _u + ["MVD_Soldier_Marksman"];
	_f 		= [true,false,false,false];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [0];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Infantry Squad"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["Kamaz"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_Marksman"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,true,false,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Recon Section"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["GAZ_Vodnik"];
	_u = _u + ["GAZ_Vodnik_HMG"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_GL"];
	_u = _u + ["RU_Soldier_Marksman"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AR"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier"];
	_u = _u + ["RU_Soldier"];
	_f 		= [true,true,false,false];
	_l 		= [2,2,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Motorized Infantry - Motorized Patrol Section"];
	_u		= ["RU_Soldier_TL"];
	_u = _u + ["UAZ_AGS30_RU"];
	_f 		= [true,true,false,false];
	_l 		= [0,1,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Motor Rifles (BMP)"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["BMP3"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_GL"];
	_f 		= [true,false,true,false];
	_l 		= [1,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Mechanized Infantry - Motor Rifles (BTR)"];
	_u		= ["RU_Soldier_SL"];
	_u = _u + ["BTR90"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_AT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_GL"];
	_f 		= [true,true,false,false];
	_l 		= [1,3,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [1];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Anti Air Platoon"];
	_u		= ["2S6M_Tunguska"];
	_u = _u + ["2S6M_Tunguska"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,3,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Light)"];
	_u		= ["T72_RU"];
	_u = _u + ["T72_RU"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,2,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Armor - Tank Platoon (Heavy)"];
	_u		= ["T90"];
	_u = _u + ["T90"];
	_f 		= [false,false,true,false];
	_l 		= [0,0,3,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [2];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Mi-17 Squadron"];
	_u		= ["Mi17_Ins"];
	_u = _u + ["MVD_Soldier_TL"];
	_u = _u + ["MVD_Soldier_GL"];
	_u = _u + ["MVD_Soldier_MG"];
	_u = _u + ["MVD_Soldier_MG"];
	_u = _u + ["MVD_Soldier_Marksman"];
	_u = _u + ["MVD_Soldier_AT"];
	_u = _u + ["MVD_Soldier_AT"];
	_f 		= [true,false,false,true];
	_l 		= [3,0,0,0];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Mi-8 Squadron"];
	_u		= ["Mi17_rockets_RU"];
	_u = _u + ["RU_Soldier_TL"];
	_u = _u + ["RU_Soldier_AA"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_LAT"];
	_u = _u + ["RU_Soldier_MG"];
	_u = _u + ["RU_Soldier_MG"];
	_f 		= [true,false,false,true];
	_l 		= [2,0,0,1];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	if !(paramRestrictionKamov) then {
		_d = _d	+ ["Air - Ka-52 Squadron"];
		_u		= ["Ka52Black"];
		_u = _u + ["Ka52"];
		_f 		= [false,false,false,true];
		_l 		= [0,0,0,3];

		_aiTeamTemplates = _aiTeamTemplates + [_u];
		_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
		_aiTeamTypes = _aiTeamTypes + [3];
		_aiTeamUpgrades = _aiTeamUpgrades + [_l];
	};

	_d = _d	+ ["Air - Mi-24 Squadron"];
	_u		= ["Mi24_V"];
	_u = _u + ["Mi24_P"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Sukhoi 34 Squadron"];
	_u		= ["Su34"];
	_u = _u + ["Su34"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,2];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	_d = _d	+ ["Air - Sukhoi 39 Squadron"];
	_u		= ["Su39"];
	_u = _u + ["Su39"];
	_f 		= [false,false,false,true];
	_l 		= [0,0,0,3];

	_aiTeamTemplates = _aiTeamTemplates + [_u];
	_aiTeamTemplateRequires = _aiTeamTemplateRequires + [_f];
	_aiTeamTypes = _aiTeamTypes + [3];
	_aiTeamUpgrades = _aiTeamUpgrades + [_l];

	['WFBE_EASTAITEAMTEMPLATES',_aiTeamTemplates,true] Call SetNamespace;
	['WFBE_EASTAITEAMTEMPLATEREQUIRES',_aiTeamTemplateRequires,true] Call SetNamespace;
	['WFBE_EASTAITEAMTYPES',_aiTeamTypes,true] Call SetNamespace;
	['WFBE_EASTAITEAMUPGRADES',_aiTeamUpgrades,true] Call SetNamespace;
	['WFBE_EASTAITEAMTEMPLATEDESCRIPTIONS',_d,true] Call SetNamespace;
};

"Config_Squads: Initialization - [Done]" call LogMedium;