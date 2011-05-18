//
// Written by Evil_Echo 
//
// Usage:
// ok = [position, yield] ExecVM "nuclear_explosion.sqf";
//
 
#include "nuke.h"

private [
	"_pos",
	"_yield",
	"_mode",
	"_Bang",
	"_Shock",
	"_Damage",
	"_NonClass",
	"_Sectional",
	"_Fire",
	"_Cloud",
	"_Fallout"
];

_pos    = _this select 0;
_yield  = _this select 1;
_mode = "unknown";

_Bang = compile preprocessFile (NUKE_PATH + "nuke_sound.sqf");
_Shock = compile preprocessFile (NUKE_PATH + "nuke_shockwave.sqf");
_Damage = compile preprocessFile (NUKE_PATH + "nuke_damage.sqf");
_NonClass = compile preprocessFile (NUKE_PATH + "nuke_damageNonClass.sqf");
_Sectional = compile preprocessFile (NUKE_PATH + "nuke_damageSectional.sqf");
_Fire = compile preprocessFile (NUKE_PATH + "nuke_fires.sqf");
_Cloud = compile preprocessFile (NUKE_PATH + "nuke_cloud.sqf");
_Fallout = compile preprocessFile (NUKE_PATH + "nuke_fallout.sqf");

// bang
[_pos, _yield] spawn _Bang;

// shock wave
[_pos, _yield] spawn _Shock;

// cloud if ground burst.
[_pos, _yield] spawn _Cloud;


// damage
[_pos, _yield, _mode, _Sectional, _Fire] spawn _Damage;

[_pos, _yield] spawn _NonClass;

// fallout
[_pos, _yield] spawn _fallout;

