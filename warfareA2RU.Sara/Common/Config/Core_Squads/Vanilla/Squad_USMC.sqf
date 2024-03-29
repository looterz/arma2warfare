Private ['_aiTeamTemplateRequires','_aiTeamTemplates','_aiTeamTypes','_aiTeamUpgrades','_d','_f','_l','_u'];

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

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_d]