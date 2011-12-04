/**/
_ammo=_this;

_currentalpha=_ammo call Func_System_GetPitchBank;
_currentalpha=_currentalpha select 0;

_adjustment=(System_BallisticGrenadeAngles select System_CurrentGPSightLevel) select 1;

_speed=75;
_alpha=_currentalpha+_adjustment;
_dir=getDir _ammo;
_ammo setVelocity [0,0,0];

_vSpeed=_speed*(sin _alpha);
_hSpeed=_speed*(cos _alpha);
_ammo setVelocity[_hSpeed*(sin _dir),_hSpeed*(cos _dir),_vSpeed];