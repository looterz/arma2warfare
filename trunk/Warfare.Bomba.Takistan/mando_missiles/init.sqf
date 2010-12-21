
[false]execVM "mando_missiles\mando_missileinit.sqf";

// Wait for Mando Missile initialization 
waitUntil {!isNil "mando_missile_init_done"};
waitUntil {mando_missile_init_done};
	
if (local player) then {
	[]execVM"mando_missiles\mando_setup_full.sqf";
	[]execVM"mando_missiles\mando_setup_ffaa.sqf";
	//[]execVM"mando_missiles\mando_setup_ace.sqf";
	[]execVM"mando_missiles\mando_gun\mando_guninit.sqf";
};
