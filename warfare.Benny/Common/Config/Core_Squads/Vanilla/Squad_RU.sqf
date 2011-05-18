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

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_d]