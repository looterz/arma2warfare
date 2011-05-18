#define COLUMN_PERCENT 0.95
#define RISETIME 0.5

#define TICK_RATE 0.05
#define OVERLAP 1.8

#define GROW_RATE 1.002

#define RED_DECAY 0.99
#define GREEN_DECAY 0.98
#define BLUE_DECAY 0.96

#define ALPHA_INITIAL 20
#define ALPHA_DECAY 0.700
#define ALPHA_THRESHOLD 0.02

#define GLARE_INITIAL 100
#define GLARE_DECAY .955

#define LIGHT1_INITIAL 50
#define LIGHT1_DECAY .950
#define LIGHT2_THRESHOLD 6
#define LIGHT2_DECAY .94

#define RISE_SPEED TICK_RATE*2495/112

private [
	"_pos",
	"_yield",
	"_Glare",
	"_airburst_threshold",
	"_fireball_size",
	"_fireball_life",
	"_fireball_spawntime",
	"_column_life",
	"_column_size",
	"_loft_time",
	"_cloud_base1",
	"_Base_PA",
	"_Base_PA_WA",
	"_C1",
	"_C2",
	"_light"
];

_pos = _this select 0;
_yield = _this select 1;

_Glare = {
	private[
		"_pos",
		"_radius",
		"_light",
		"_glare",
		"_i"
	];

	_pos = _this select 0;
	_radius = _this select 1;
//	diag_log format["Glare - _this = %1", _this];

	_glare = GLARE_INITIAL*10;
	_light = "#lightpoint" createvehicleLocal [0,0,0];
	_light setpos _pos;
	_light setLightBrightness _glare;
	_light setLightAmbient[0.8*_glare, 0.9*_glare, 1.0*_glare];
	_light setLightColor[1, 1, 1];

	drop [
		"\Ca\Data\kouleSvetlo.p3d",
		"",
		"Billboard",
		1,
		2,
		_pos,
		[0, 0, 0],
		1,
		1.3,
		1.0,
		0.0,
		[0, _radius ],
		[[1.0, 1.0, 1.0, -2.0], [1.0, 0.7, 0.4, -1.0]],
		[0],
		0.0,
		0.0,
		"",
		"",
		""
	];

	sleep 0.95;

	drop [
		"\Ca\Data\kouleSvetlo.p3d",
		"",
		"Billboard",
		1,
		5,
		_pos,
		[0, 0, 0],
		1,
		1.3,
		1.0,
		0.0,
		[_radius],
		[[1.0, 0.7, 0.4, 1.0], [1.0, 0.6, 0.3, 0.0]],
		[0],
		0.0,
		0.0,
		"",
		"",
		""
	];

	sleep 0.1;

	for [{_i = 0}, {_i < 100}, {_i = _i + 1}] do {
		_glare = GLARE_INITIAL*(GLARE_DECAY^_i);
		_light setLightBrightness _glare;
		_light setLightAmbient[0.8*_glare, 0.9*_glare, 1.0*_glare];
		sleep 0.05;
	};

	deleteVehicle _light;
};

_C1 = _yield^(1/5);
_C2 = 247.1705*_C1;

_airburst_threshold = 33.528*_C1^2;
_airburst_threshold_2 = 68.58*_C1^2;


if ( (_pos select 2) < _airburst_threshold_2 ) then {
	_fireball_size = 1.95*_airburst_threshold;
	_fireball_life = 1.75*_airburst_threshold;
	_fireball_spawntime = RISETIME*sqrt(_airburst_threshold);
	_column_size = _fireball_size^(4/5);
	_column_life = COLUMN_PERCENT*_fireball_life;
	_loft_time = 0.75*_column_life;

	_cloud_base1 = "#particlesource" createVehicleLocal _pos;

	// Cloud base - debris rushing inward.
	_Base_PA = [
		["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 48, 1],
		"",
		"Billboard",
		1,
		35.0,
		[0, 0, 0],
		[0, 0, 0],
		1.0,
		1.275,
		1,
		0.001,
		[30, 60],
		[
			[0.40, 0.26, 0.13, 0.04],
			[0.40, 0.26, 0.13, 0.6],
			[0.40, 0.26, 0.13, 0.8],
			[0.40, 0.26, 0.13, 0.7],
			[0.40, 0.26, 0.13, 0]
		],
		[0.5],
		1,
		0,
		"",
		"",
		""
	];

	// Cloud base WATER - debris rushing inward.
	_Base_PA_WA = [
		["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 1],
		"",
		"Billboard",
		1,
		35.0,
		[0, 0, 0],
		[0, 0, 0],
		1.0,
		1.275,
		1,
		0.001,
		[30, 60],
		[
			[1, 1, 1, 0.04],
			[1, 1, 1, 0.6],
			[1, 1, 1, 0.8],
			[1, 1, 1, 0.7],
			[1, 1, 1, 0]
		],
		[0.5],
		1,
		0,
		"",
		"",
		""
	];

	[_pos, 8*_fireball_size] spawn _Glare;

// Light
	_light = "logic" createvehicleLocal [0, 0, 0];
	_light setpos _pos;

	[_light, _fireball_life] spawn {
		// 112 seconds - 2495m
		private[
			"_light_logic",
			"_life",
			"_light",
			"_vel",
			"_pos",
			"_elapsed",
			"_tick",
			"_i",
			"_intensity",
			"_time_ini"
		];

		_light_logic = _this select 0;
		_life = _this select 1;

		_vel = 2495/112;
		_pos = getPos _light_logic;
		_elapsed = 0;
		_time_ini = dayTime*3600;

		// 50 secs before no hat light is gone
		while {_elapsed < (_life - 50)} do {
			_pos = [
				(_pos select 0) + (wind select 0)*_elapsed*0.02,
				(_pos select 1) + (wind select 1)*_elapsed*0.02,
				(_pos select 2) + _vel*0.5
			];
			_light_logic setPos _pos;
			sleep 0.5;
			_elapsed = (dayTime*3600) - _time_ini;
		};

		deleteVehicle _light_logic;
	};


	[_light, _fireball_life] spawn {
		// 112 seconds - 2495m
		private[
			"_light_logic",
			"_life",
			"_light",
			"_vel",
			"_pos",
			"_elapsed",
			"_tick",
			"_i",
			"_intensity",
			"_time_ini"
		];

		_light_logic = _this select 0;
		_life = _this select 1;

		_intensity = LIGHT1_INITIAL;

		_light = "#lightpoint" createvehicleLocal [0,0,0];
		_light setLightBrightness _intensity;
		_light setLightAmbient[1.0, 0.8, 0.5];
		_light setLightColor[1.0, 0.8, 0.5];

		_vel = 2495/112;
		_pos = getPos _light_logic;
		_elapsed = 0;
		_time_ini = dayTime*3600;

		// 50 secs before no hat light is gone
		while {_elapsed < (_life - 60)} do {
			if ( _intensity > LIGHT2_THRESHOLD ) then {
				_intensity = LIGHT1_INITIAL*(LIGHT1_DECAY^_elapsed);
			} else {
				_intensity = LIGHT1_INITIAL*(LIGHT2_DECAY^_elapsed);
			};

			_red = RED_DECAY^_elapsed;
			_green = GREEN_DECAY^_elapsed;
			_blue = BLUE_DECAY^_elapsed;

			if (_intensity > 5) then
			{
				_light setLightBrightness _intensity;
				_light setLightAmbient[_red, _green, _blue];
				_light setLightColor[_red, _green, _blue];
			};

			if (!isNull _light_logic) then
			{
				_light setPos getPos _light_logic;
			};
			sleep 0.1;
			_elapsed = (dayTime*3600) - _time_ini;
		};

		_intensity = 5;
		_tick = 0.05;
		_rate = _intensity / (2/_tick);
		while {_intensity > 0} do
		{
			_intensity = _intensity - _rate;
			_light setLightBrightness _intensity;
			sleep _tick;
		};

		deleteVehicle _light;
	};



// Cap ascending
[_pos, _fireball_size, _fireball_life, _fireball_spawntime, _light] spawn {
	private[
		"_pos_ini",
		"_size",
		"_life",
		"_time_to_generate",
		"_light",
		"_pos",
		"_elapsed",
		"_vel",
		"_ang",
		"_time_ini",
		"_sizep",
		"_alt",
		"_water",
		"_water_old",
		"_shape",
		"_angv",
		"_angs",
		"_lifes",
		"_branches",
		"_delta",
		"_i"
	];

	_pos_ini = _this select 0;
	_size = _this select 1;
	_life = _this select 2;
	_time_to_generate = _this select 3;
	_light = _this select 4;

	_ang = 0;
	_time_ini = dayTime*3600;
	_elapsed = 0;
	_sizep = 5;
	_alt = 0.19*_size;
	_i = 60;

	_water_old = false;
	while {_i > 0} do {

		if (_i > 15) then {
			_sizep = (_sizep + 6) min 500;
		} else {
			_sizep = (_sizep - 6) max 100;
		};

		_alt = _alt - 1*(((60 - _i)/10) min 100);

		for [{_ang = 0}, {_ang < 360}, {_ang = _ang + 15}] do {
			_pos = [
				(_pos_ini select 0) + sin(_ang + random 15)*(_sizep + random 80),
				(_pos_ini select 1) + cos(_ang + random 15)*(_sizep + random 80),
				_alt
			];
			_angv = ((_pos_ini select 0) - (_pos select 0)) atan2 ((_pos_ini select 1) - (_pos select 1));

			_water = surfaceIsWater _pos;

			if ((_i > 20) || ((_i % 3) != 0)) then {
			// Mostly dust
				if (!_water) then {
					_shape = ["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 48, 1];
					if (_water_old) then {
						if (random 2 < 1) then {
							_shape = ["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 1];
						};
					};

					drop [
						_shape,
						"",
						"Billboard",
						1,
						_life - _elapsed,
						_pos,
						[0, 0, 50 + (10 - random 20)],
						0.25,
						0.90 + 0.30 - 0.20,
						1,
						0.010,
						[
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							0,
							0
						],
						[
							[1, 0.5, 0., 0.9],
							[0.9, 0.4, 0, 0.9],
							[0.5, 0.3, 0.2, 0.9],
							[0.55, 0.40, 0.35, 0.8],
							[0.60, 0.48, 0.44, 0.8],
							[0.65, 0.56, 0.53, 0.8],
							[0.70, 0.64, 0.62, 0.8],
							[0.75, 0.72, 0.71, 0.8],
							[0.80, 0.80, 0.80, 0.8],
							[0.80, 0.80, 0.80, 0.8],
							[0.80, 0.80, 0.80, 0.8],
							[0.80, 0.80, 0.80, 0.7],
							[0.90, 0.90, 0.90, 0.6],
							[0.90, 0.90, 0.90, 0.5],
							[0.90, 0.90, 0.90, 0.4],
							[0.90, 0.90, 0.90, 0.3],
							[0.90, 0.90, 0.90, 0.2],
							[0.90, 0.90, 0.90, 0.1],
							[1, 1, 1, 0.0],
							[1, 1, 1, 0.0],
							[1, 1, 1, 0.0]
						],
						[random 1],
						1,
						0.5,
						"",
						"",
						""
					];
				}
				else
				{
					_shape = ["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 1];
					if (!_water_old) then {
						if (random 2 < 1) then {
							_shape = ["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 48, 1];
						};
					};

					drop [
						_shape,
						"",
						"Billboard",
						1,
						_life - _elapsed,
						_pos,
						[0, 0, 50 + (10 - random 20)],
						0.25,
						0.90 + 0.30 - 0.20,
						1,
						0.010,
						[
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							90 + random(_size),
							0,
							0
						],
						[
							[1, 1, 1, 1],
							[1, 1, 1, 0.8],
							[1, 1, 1, 0.8],
							[1, 1, 1, 0.8],
							[1, 1, 1, 0.8],
							[1, 1, 1, 0.8],
							[1, 1, 1, 0.8],
							[1, 1, 1, 0.8],
							[0.80, 0.80, 0.80, 0.8],
							[0.80, 0.80, 0.80, 0.8],
							[0.80, 0.80, 0.80, 0.8],
							[0.80, 0.80, 0.80, 0.7],
							[0.90, 0.90, 0.90, 0.6],
							[0.90, 0.90, 0.90, 0.5],
							[0.90, 0.90, 0.90, 0.4],
							[0.90, 0.90, 0.90, 0.3],
							[0.90, 0.90, 0.90, 0.2],
							[0.90, 0.90, 0.90, 0.1],
							[1, 1, 1, 0.0],
							[1, 1, 1, 0.0],
							[1, 1, 1, 0.0]
						],
						[random 1],
						1,
						0.5,
						"",
						"",
						""
					];

				};
			} else {
			// Some fire
				drop [
					["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 5, 32, 1],
					"",
					"Billboard",
					1,
					_life - _elapsed,
					_pos,
					[0, 0, 50 + (10 - random 20)],
					0.25,
					0.90 + 0.30 - 0.20,
					1,
					0.010,
					[50 + random(_size/2), 50 + random(_size/2), 30 + random(_size/2), 20 + random(_size/2), 0, 0],
					[
						[1, 1, 1, 0.2],
						[1, 1, 1, 0.2],
						[1, 1, 1, 0.2],
						[0.90, 0.90, 0.90, 0.0],
						[0.90, 0.90, 0.90, 0.0],
						[0.90, 0.90, 0.90, 0.0]
					],
					[0.1 + random 0.9, 0.1 + random 0.9, 0.1 + random 0.9],
					1,
					0.2,
					"",
					"",
					""
				];

			};
			_water_old = _water;
			_elapsed = dayTime*3600 - _time_ini;
		};

		_i = _i - 1;
	};

	_angs = [];
	_lifes = [];
	_branches = 8;
	_delta = 360 / _branches;
	for [{_i = 0}, {_i < _branches}, {_i=_i + 1}] do {
		_angs = _angs + [(_delta*_i) + random 15];
		_lifes = _lifes + [8 + random 5];
	};

	while {!isNull _light} do {
		_pos_ini = getPos _light;

		if (_pos_ini select 2 < 1000) then {

			for [{_i = 0}, {_i < _branches}, {_i=_i + 1}] do {
				_ang = _angs select _i;
				_pos = [(_pos_ini select 0) + sin(_ang + random 2)*(10 + random 5), (_pos_ini select 1) + cos(_ang + random 2)*(10 + random 5), (_pos_ini select 2) - 60];
				_angv = ((_pos select 0) - (_pos_ini select 0)) atan2 ((_pos select 1) - (_pos_ini select 1));
				_vel = [(sin(_angv)*35 + (2 - random 4)) + (wind select 0)*0.3*0.02,
					(cos(_angv)*35 + (2 - random 4)) + (wind select 1)*0.3*0.02,
					 -65 - random 5];

				if (_pos_ini select 2 < 900) then {
					drop [
						["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 5, 16, 1],
						"",
						"Billboard",
						1,
						_lifes select _i,
						_pos,
						_Vel,
						0.25,
						0.90 + 0.30 - 0.20 + 0.1,
						1,
						0.015,
						[40 + random 10, 70 + random(30), 100 + random(30), 120 + random(40)],
						[
							[1, 1, 1, 1],
							[1, 1, 1, 0.5],
							[1, 1, 1, 0.5],
							[1, 1, 1, 0.4],
							[0.5, 0.5, 0.5, 0.3],
							[0, 0, 0, 0.2],
							[0, 0, 0, 0.0]
						],
						[random 1, random 1, random 1],
						1,
						1,
						"",
						"",
						""
					];
				} else {
					drop [
						["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 16, 1],
						"",
						"Billboard",
						1,
						_lifes select _i,
						_pos,
						_Vel,
						0.25,
						0.90 + 0.30 - 0.20 + 0.1,
						1,
						0.015,
						[40 + random 10, 70 + random(30), 100 + random(30), 120 + random(40)],
						[
							[0.5, 0.5, 0.5, 0.3],
							[0.5, 0.5, 0.5, 0.2],
							[0, 0, 0, 0.0]
						],
						[random 1, random 1, random 1],
						1,
						1,
						"",
						"",
						""
					];

				};
			};
			sleep 0.25;
		} else {
			sleep 1;
		};
	};

};

	// base clouds
	_cloud_base1 setParticleCircle [
		700,
		[0, -20, -0.5]];

	if (!surfaceIsWater getPos _cloud_base1) then {
		_cloud_base1 setParticleParams _Base_PA;
	} else {
		_cloud_base1 setParticleParams _Base_PA_WA;
	};

	_cloud_base1 setDropInterval 0.01;

	// Ascending column
	_column_life = _column_life - 30;

	[_pos, _column_size*1.5, _column_life] spawn {
		private[
			"_pos_ini",
			"_size",
			"_life",
			"_vel",
			"_ang",
			"_time_ini",
			"_time_left",
			"_pos",
			"_angv"
		];

		_pos_ini = _this select 0;
		_size = _this select 1;
		_life = _this select 2;

		_ang = 0;
		_time_ini = dayTime*3600;
		_time_left = _life;

		while {_time_left > 0} do {
			for [{_ang = 0}, {_ang < 360}, {_ang = _ang + 40}] do {
				_pos = [
					(_pos_ini select 0) + sin(_ang + random 4)*(_size + random 7),
					(_pos_ini select 1) + cos(_ang + random 4)*(_size + random 7),
					0
				];
				_angv = ((_pos_ini select 0) - (_pos select 0)) atan2 ((_pos_ini select 1) - (_pos select 1));
				_vel = [
					sin(_angv)*4 + (4 - random 8),
					cos(_angv)*4 + (4 - random 8),
					20 + (10 - random 20
				)];

				if (!surfaceIsWater _pos) then {
					drop [
						["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 48, 1],
						"",
						"Billboard",
						1,
						_life,
						_pos,
						_vel,
						0.25,
						0.90 + 0.30 - 0.20,
						1,
						0.01,
						[20 + random 150, 10 + random 40],
						[
							[0.40, 0.26, 0.13, 0.1*_time_left/_life],
							[0.40, 0.26, 0.13, 0.5*_time_left/_life],
							[0.40, 0.26, 0.13, 0.7*_time_left/_life],
							[0.40, 0.26, 0.13, 0.8*_time_left/_life],
							[0.40, 0.26, 0.13, 1*_time_left/_life],
							[0.45, 0.29, 0.20, 1*_time_left/_life],
							[0.50, 0.32, 0.26, 1*_time_left/_life],
							[0.55, 0.40, 0.35, 1*_time_left/_life],
							[0.60, 0.48, 0.44, 1*_time_left/_life],
							[0.65, 0.56, 0.53, 1*_time_left/_life],
							[0.70, 0.64, 0.62, 1*_time_left/_life],
							[0.75, 0.72, 0.71, 1*_time_left/_life],
							[0.80, 0.80, 0.80, 1*_time_left/_life],
							[0.80, 0.80, 0.80, 0.8*_time_left/_life],
							[0.90, 0.90, 0.90, 0.6*_time_left/_life],
							[0.90, 0.90, 0.90, 0.004*_time_left/_life],
							[0.90, 0.90, 0.90, 0.002*_time_left/_life],
							[0.90, 0.90, 0.90, 0.00*_time_left/_life],
							[0.90, 0.90, 0.90, 0.00*_time_left/_life]

						],
						[0.2 + random 0.4],
						1,
						0,
						"",
						"",
						""
					];
				} else {
					drop [
						["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 1],
						"",
						"Billboard",
						1,
						_life,
						_pos,
						_vel,
						0.25,
						0.90 + 0.30 - 0.20,
						1,
						0.01,
						[20 + random 150, 10 + random 40],
						[
							[1, 1, 1, 0.1*_time_left/_life],
							[1, 1, 1, 0.5*_time_left/_life],
							[1, 1, 1, 0.7*_time_left/_life],
							[1, 1, 1, 0.7*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.8*_time_left/_life],
							[1, 1, 1, 0.7*_time_left/_life],
							[0.90, 0.90, 0.90, 0.6*_time_left/_life],
							[0.90, 0.90, 0.90, 0.004*_time_left/_life],
							[0.90, 0.90, 0.90, 0.002*_time_left/_life],
							[0.90, 0.90, 0.90, 0.00*_time_left/_life],
							[0.90, 0.90, 0.90, 0.00*_time_left/_life]

						],
						[0.2 + random 0.4],
						1,
						0,
						"",
						"",
						""
					];
				};

			};
			sleep 0.2;
			_time_left = _life - ((dayTime*3600) - _time_ini);
		};
	};

	sleep _column_life - 30;
	deleteVehicle _cloud_base1;
} else {
// Air burst
// Cap ascending

	_fireball_size = 1.15*_airburst_threshold_2;
	_fireball_life = 0.80*_airburst_threshold_2;

	[_pos, _fireball_size, _fireball_life] spawn {
		private[
			"_pos_ini",
			"_size",
			"_life",
			"_pos",
			"_elapsed",
			"_vel",
			"_ang",
			"_time_ini",
			"_sizep",
			"_alt",
			"_shape",
			"_angv",
			"_i"
		];

		_pos_ini = _this select 0;
		_size = _this select 1;
		_life = _this select 2;

		_ang = 0;
		_time_ini = dayTime*3600;
		_elapsed = 0;
		_sizep = 5;
		_alt = (_pos_ini select 2) - 0.19*_size;
		_i = 60;

		while {_i > 0} do {

			if (_i > 5) then {
				_sizep = (_sizep + 6) min 500;
			} else {
				_sizep = (_sizep - 6) max 100;
			};

			_alt = _alt - 1*(((60 - _i)/10) min 100);

			for [{_ang = 0}, {_ang < 360}, {_ang = _ang + 15}] do {
				_pos = [
					(_pos_ini select 0) + sin(_ang + random 15)*(_sizep + random 80),
					(_pos_ini select 1) + cos(_ang + random 15)*(_sizep + random 80),
					_alt
				];
				_angv = ((_pos_ini select 0) - (_pos select 0)) atan2 ((_pos_ini select 1) - (_pos select 1));

					_shape = ["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 12, 13, 0];
					if (random 1 > 0.7) then
					{
						_shape = ["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 16, 7, 48, 1];
					};

						drop [
							_shape,
							"",
							"Billboard",
							1,
							(_life - _elapsed - 3) + random 3,
							_pos,
							[0, 0, 50 + (10 - random 20)],
							0.25,
							0.90 + 0.30 - 0.20,
							1,
							0.010,
							[
								90 + random(_size),
								90 + random(_size),
								90 + random(_size),
								90 + random(_size),
								90 + random(_size),
								90 + random(_size),
								90 + random(_size),
								90 + random(_size)
							],
							[
								[1, 1, 1, 0],
								[1, 1, 1, 0],
								[1, 1, 1, 0.1],
								[1, 1, 1, 0.2],
								[1, 1, 1, 0.3],
								[1, 1, 1, 0.4],
								[1, 1, 1, 0.5],
								[1, 1, 1, 0.6],
								[1, 1, 1, 0.7],
								[1, 1, 1, 0.8],
								[1, 1, 1, 1],							
								[1, 1, 1, 1],
								[1, 1, 1, 1],
								[1, 1, 1, 1],
								[1, 1, 1, 1],
								[1, 1, 1, 1],
								[1, 1, 1, 1],
								[1, 1, 1, 1],
								[1, 1, 1, 0.5],
								[1, 1, 1, 0.01],
								[1, 1, 1, 0.0]
							],
							[random 1],
							1,
							0.5,
							"",
							"",
							""
						];
				_elapsed = dayTime*3600 - _time_ini;
			};

			_i = _i - 1;
		};
	};

	[_pos, 1.0*_airburst_threshold_2] spawn _Glare;
};
