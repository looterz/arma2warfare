	private["_key","_shift","_ctrl","_alt","_denyaction"];
	
	if (!(alive player) || (vehicle player != player)) exitWith{};

	_key=_this select 1;
	_shift=_this select 2;
	_ctrl=_this select 3;
	_alt=_this select 4;
	
	_denyaction=false;
	
	switch (true) do
	{						
		case (_key in (actionKeys "ZeroingUp")):
		{
			if ((currentMuzzle player) in System_GrenadeLauncherMuzzles) then
			{
				_denyaction=true;
				_max=(count System_BallisticGrenadeAngles)-1;
				if (System_CurrentGPSightLevel < _max) then
				{
					System_CurrentGPSightLevel=System_CurrentGPSightLevel+1;
				};
				hintSilent format[localize "STR_HINT_GPSight",(System_BallisticGrenadeAngles select System_CurrentGPSightLevel) select 0];
			}
			else
			{
				if ((currentWeapon player)==(secondaryWeapon player)) then
				{	
					_denyaction=true;					
					if (System_CurrentATSightLevel < 4) then
					{
						System_CurrentATSightLevel=System_CurrentATSightLevel+1;
					};
					hintSilent format[localize "STR_HINT_ATSight",System_CurrentATSightLevel*100];
				};
			};
			
		};
		case (_key in (actionKeys "ZeroingDown")):
		{
			if ((currentMuzzle player) in System_GrenadeLauncherMuzzles) then
			{
				_denyaction=true;
				if (System_CurrentGPSightLevel > 0) then
				{
					System_CurrentGPSightLevel=System_CurrentGPSightLevel-1;
				};				
				hintSilent format[localize "STR_HINT_GPSight",(System_BallisticGrenadeAngles select System_CurrentGPSightLevel) select 0];
			}
			else
			{
				if ((currentWeapon player)==(secondaryWeapon player)) then
				{
					_denyaction=true;
					if (System_CurrentATSightLevel > 1) then
					{
						System_CurrentATSightLevel=System_CurrentATSightLevel-1;
					};
					hintSilent format[localize "STR_HINT_ATSight",System_CurrentATSightLevel*100];
				};
			};			
		};				
		default
		{			
		};
	};
	_denyaction	
	
	