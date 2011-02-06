private['_u','_aiteamtemplates','_aiteamtemplaterequires','_aiteamtypes','_aiteamupgrades','_d','_f','_l'];_aiTeamTemplates = [];
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

[_aiTeamTemplates,_aiTeamTemplateRequires,_aiTeamTypes,_aiTeamUpgrades,_d]