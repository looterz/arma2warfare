	_ammo=_this select 0;
	_data=_this select 1;

	_elev=_data select System_CurrentATSightLevel;

	_dir=(getDir _ammo) + ((random 0.3) - (random 0.3));
	_sdir=sin _dir;
	_cdir=cos _dir;

	_PitchBank=_ammo call Func_System_GetPitchBank;
	_Pitch=_PitchBank select 0;
	_Bank=_PitchBank select 1;
	_pitch=_pitch + _elev;
	[_ammo,_pitch,_Bank] call Func_System_SetPitchBank;

	_vel=_data select 0;
	_vel_h=_vel*cos (_pitch);

	_vel_y=_vel*sin (_pitch);
	_vel_x=_vel_h*_sdir;
	_vel_z=_vel_h*_cdir;

	_ammo setVelocity[_vel_x,_vel_z,_vel_y];

	_lasttime=time-0.1;

	while {!isNull _ammo} do
	{
		_t=time;
		
		_pitch=_pitch-0.25*(_t-_lasttime)/0.115;
		
		_lasttime=_t;

		[_ammo,_pitch,_Bank] call Func_System_SetPitchBank;
		
		_vel_h=_vel*cos (_pitch);

		_vel_y=_vel*sin (_pitch);
		_vel_x=_vel_h*_sdir;
		_vel_z=_vel_h*_cdir;

		_ammo setVelocity[_vel_x,_vel_z,_vel_y];
		sleep 0.1;
	};
