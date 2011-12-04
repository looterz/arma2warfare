	private["_player","_weapon","_ammotype","_ammo"];
	
	if (!((_this select 0) isKindOf "man")) exitWith{};	
	
	_player=_this select 0;
	_weapon=_this select 1;
	_ammo= _this select 6;
	
	_ammotype= typeof _ammo;;
	
	if (_weapon==secondaryWeapon player) then
	{
		_index=System_BallisticMissileTypes find _ammotype;
		if (_index >= 0) then
		{	
			[_ammo,System_BallisticMissileAngles select _index] spawn Func_System_AdjustMissileBallistics;
		};		
	}
	else
	{	
		if (_weapon==primaryWeapon player) then
		{	
			if (_ammotype in System_BallisticGrenadeTypes) then
			{					
				_ammo call Func_System_AdjustGrenadeBallistics;
			};
		};
	};