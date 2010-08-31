/*
	New loadout system. | Hybrid
	  Only one side gear is defined at a time. west don't know east and vice versa.
*/

/* Vanilla */
if (WF_A2_Vanilla) then {
	//*** WEST ***//
	if (!isServer || local player) then {
	
		['WFBE_BINOCULARS',['Binocular'],true] Call SetNamespace;
		
		if (side player == WEST) then {
			//--- Magazines.
			/*
				Note: 
					_r define whether the magazine belong to the main ammo pool or to the handgun ammo pool.
					_l define the upgrade level required to display the ammo.
					_b define whether the ammunition shall displayed or not if advanced camp gear parameter is on.
			*/
			
			_m = ["30Rnd_556x45_Stanag"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];
			
			_m = _m + ["30Rnd_556x45_StanagSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_556x45_Stanag"];
			_c = _c + [5];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_556x45_G36"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_556x45_G36SD"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_556x45_BetaCMag"];
			_c = _c + [15];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["5Rnd_762x51_M24"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_DMR"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["10Rnd_127x99_m107"];
			_c = _c + [18];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_762x51_M240"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["200Rnd_556x45_M249"];
			_c = _c + [22];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_MP5"];
			_c = _c + [3];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_MP5SD"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["8Rnd_B_Beneli_74Slug"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["M136"];
			_c = _c + [50];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["SMAW_HEAA"];
			_c = _c + [175];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];
			
			_m = _m + ["SMAW_HEDP"];
			_c = _c + [150];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];
			
			_m = _m + ["Javelin"];
			_c = _c + [300];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];
			
			_m = _m + ["Stinger"];
			_c = _c + [100];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];
			
			_m = _m + ["Laserbatteries"];
			_c = _c + [20];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [true];
			
			_m = _m + ["15Rnd_9x19_M9"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["15Rnd_9x19_M9SD"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["7Rnd_45ACP_1911"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgMagazines' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgMagazines' >> _x >> 'displayName')];
				_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
			} forEach _m;

			WF_Logic setVariable ['magazineClasses',_m];
			WF_Logic setVariable ['magazineCosts',_c];
			WF_Logic setVariable ['magazinePictures',_p];
			WF_Logic setVariable ['magazineNames',_d];
			WF_Logic setVariable ['magazineSpaces',_s];
			WF_Logic setVariable ['magazineMain',_r];
			WF_Logic setVariable ['magazineTypes',_t];
			WF_Logic setVariable ['magazineUpgrades',_l];
			WF_Logic setVariable ['magazineAllowed',_b];
			
			_magazinesT = _m;

			//--- Primary.
			/*
				Note: _a define whether the default ammunitions are dumped from CfgMagazines or added manualy:
					Manual override require a nested array.

				Exemple:
					_w = _w + ['M16A2GL'];
					_c = _c + [85];
					_a = _a + [true];	
				OR
					_w = _w + ['M16A2GL'];
					_c = _c + [85];
					_a = _a + [['30Rnd_556x45_Stanag','30Rnd_556x45_StanagSD',...]];
				
			*/

			_w = ['M16A2'];
			_c = [80];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['M16A2GL'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['m16a4'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['m16a4_acg'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M16A4_GL'];
			_c = _c + [95];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M16A4_ACG_GL'];
			_c = _c + [105];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M24'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M40A3'];
			_c = _c + [195];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['M240'];
			_c = _c + [165];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Mk_48'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['M249'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['M4A1'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M4A1_Aim'];
			_c = _c + [135];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M4A1_Aim_camo'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M4SPR'];
			_c = _c + [155];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M4A1_RCO_GL'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['M4A1_AIM_SD_camo'];
			_c = _c + [205];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];
			
			_w = _w + ['M4A1_HWS_GL_SD_Camo'];
			_c = _c + [245];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['M4A1_HWS_GL'];
			_c = _c + [205];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['M4A1_HWS_GL_camo'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['MP5SD'];
			_c = _c + [115];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['MP5A5'];
			_c = _c + [65];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['G36C'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['G36_C_SD_eotech'];
			_c = _c + [265];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['G36a'];
			_c = _c + [240];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['G36K'];
			_c = _c + [230];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['MG36'];
			_c = _c + [260];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['DMR'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['M1014'];
			_c = _c + [75];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['m107'];
			_c = _c + [315];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['m8_carbine'];
			_c = _c + [305];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['m8_carbineGL'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['m8_compact'];
			_c = _c + [310];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['m8_sharpshooter'];
			_c = _c + [315];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['m8_SAW'];
			_c = _c + [355];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['primaryClasses',_w];
			WF_Logic setVariable ['primaryCosts',_c];
			WF_Logic setVariable ['primaryPictures',_p];
			WF_Logic setVariable ['primaryNames',_d];
			WF_Logic setVariable ['primaryMagazines',_s];
			WF_Logic setVariable ['primaryUpgrades',_l];
			WF_Logic setVariable ['primaryAllowed',_b];

			//--- Secondary.

			_w = ['M136'];
			_c = [90];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['SMAW'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Javelin'];
			_c = _c + [650];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['Stinger'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Laserdesignator'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['secondaryClasses',_w];
			WF_Logic setVariable ['secondaryCosts',_c];
			WF_Logic setVariable ['secondaryPictures',_p];
			WF_Logic setVariable ['secondaryNames',_d];
			WF_Logic setVariable ['secondaryMagazines',_s];
			WF_Logic setVariable ['secondaryUpgrades',_l];
			WF_Logic setVariable ['secondaryAllowed',_b];

			//--- Sidearms.

			_w = ['Colt1911'];
			_c = [15];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['M9'];
			_c = _c + [20];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M9SD'];
			_c = _c + [25];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['sidearmClasses',_w];
			WF_Logic setVariable ['sidearmCosts',_c];
			WF_Logic setVariable ['sidearmPictures',_p];
			WF_Logic setVariable ['sidearmNames',_d];
			WF_Logic setVariable ['sidearmMagazines',_s];
			WF_Logic setVariable ['sidearmUpgrades',_l];
			WF_Logic setVariable ['sidearmAllowed',_b];

			//--- Misc.

			_w = ['HandGrenade_West'];
			_c = [10];
			_t = ['CfgMagazines'];
			_r = [false];
			_l = [0];
			_b =  [true];

			_w = _w + ['HandGrenade_Stone'];
			_c = _c + [2];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShell'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellRed'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellGreen'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellBlue'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellYellow'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellOrange'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellPurple'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareWhite_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareYellow_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareGreen_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareRed_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_M203'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_Smoke_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeRed_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeGreen_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeYellow_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Mine'];
			_c = _c + [40];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PipeBomb'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Binocular'];
			_c = _c + [10];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['NVGoggles'];
			_c = _c + [20];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemCompass'];
			_c = _c + [4];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemGPS'];
			_c = _c + [25];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemMap'];
			_c = _c + [6];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemRadio'];
			_c = _c + [15];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemWatch'];
			_c = _c + [5];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_curType = _t select _u;
				if (_curType == 'Special' || _curType == 'Item') then {_curType = 'CfgWeapons'};
				_p = _p + [getText(configFile >> _curType >> _x >> 'picture')];
				_d = _d + [getText(configFile >> _curType >> _x >> 'displayName')];
				if (_curType == 'CfgMagazines') then {
					_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
				} else {
					_s = _s + [1];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['miscClasses',_w];
			WF_Logic setVariable ['miscCosts',_c];
			WF_Logic setVariable ['miscPictures',_p];
			WF_Logic setVariable ['miscSpaces',_s];
			WF_Logic setVariable ['miscNames',_d];
			WF_Logic setVariable ['miscTypes',_t];
			WF_Logic setVariable ['miscMain',_r];
			WF_Logic setVariable ['miscUpgrades',_l];
			WF_Logic setVariable ['miscAllowed',_b];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [getText(configFile >> 'CfgWeapons' >> 'm16a4' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = [getText(configFile >> 'CfgWeapons' >> 'm16a4' >> 'picture')];
			_t = [['m16a4','Colt1911']];
			_m = [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'HandGrenade_West','HandGrenade_West','SmokeShellBlue','SmokeShellBlue','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = [['Binocular']];
			_i = [_items];
			_l = [0];
			_b = [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M16A4_GL' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M16A4_GL' >> 'picture')];
			_t = _t + [['M16A4_GL']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203',
				'1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'G36C' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M136' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'G36C' >> 'picture')];
			_t = _t + [['G36C','M136']];
			_m = _m + [['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M4A1_HWS_GL_SD_Camo' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'SMAW' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M4A1_HWS_GL_SD_Camo' >> 'picture')];
			_t = _t + [['M4A1_HWS_GL_SD_Camo','SMAW']];
			_m = _m + [['30Rnd_556x45_StanagSD','30Rnd_556x45_StanagSD','30Rnd_556x45_StanagSD','30Rnd_556x45_StanagSD','30Rnd_556x45_StanagSD','30Rnd_556x45_StanagSD','SMAW_HEAA',
				'SMAW_HEAA','SMAW_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'm8_carbine' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'SMAW' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'm8_carbine' >> 'picture')];
			_t = _t + [['m8_carbine','SMAW','M9']];
			_m = _m + [['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M4A1_Aim' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Javelin' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M4A1_Aim' >> 'picture')];
			_t = _t + [['M4A1_Aim','Javelin','Colt1911']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Javelin',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M16A2' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Stinger' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M16A2' >> 'picture')];
			_t = _t + [['M16A2','Stinger','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Stinger',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M1014' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'Mine' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M1014' >> 'picture')];
			_t = _t + [['M1014','M9']];
			_m = _m + [['8Rnd_B_Beneli_74Slug','8Rnd_B_Beneli_74Slug','8Rnd_B_Beneli_74Slug','8Rnd_B_Beneli_74Slug','8Rnd_B_Beneli_74Slug','8Rnd_B_Beneli_74Slug','Mine','Mine','Mine',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'MP5SD' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'PipeBomb' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'MP5SD' >> 'picture')];
			_t = _t + [['MP5SD','M9SD']];
			_m = _m + [['30Rnd_9x19_MP5SD','30Rnd_9x19_MP5SD','30Rnd_9x19_MP5SD','30Rnd_9x19_MP5SD','30Rnd_9x19_MP5SD','30Rnd_9x19_MP5SD','PipeBomb','PipeBomb','PipeBomb',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M240' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M240' >> 'picture')];
			_t = _t + [['M240','Colt1911']];
			_m = _m + [['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','SmokeShellRed','SmokeShellRed','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M249' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M249' >> 'picture')];
			_t = _t + [['M249','Colt1911']];
			_m = _m + [['200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','SmokeShellRed','SmokeShellRed','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'DMR' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'DMR' >> 'picture')];
			_t = _t + [['DMR','M9SD']];
			_m = _m + [['20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR',
				'20Rnd_762x51_DMR','20Rnd_762x51_DMR','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];
			
			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M40A3' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Laserdesignator' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M40A3' >> 'picture')];
			_t = _t + [['M40A3','Laserdesignator','M9SD']];
			_m = _m + [['5Rnd_762x51_M24','5Rnd_762x51_M24','5Rnd_762x51_M24','5Rnd_762x51_M24','5Rnd_762x51_M24','5Rnd_762x51_M24','5Rnd_762x51_M24','5Rnd_762x51_M24',
				'5Rnd_762x51_M24','5Rnd_762x51_M24','HandGrenade_West','Laserbatteries','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'm107' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'm107' >> 'picture')];
			_t = _t + [['m107','M9SD']];
			_m = _m + [['10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107',
				'10Rnd_127x99_m107','10Rnd_127x99_m107','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			_primary = WF_Logic getVariable 'primaryClasses';
			_primaryCosts = WF_Logic getVariable 'primaryCosts';
			_secondary = WF_Logic getVariable 'secondaryClasses';
			_secondaryCosts = WF_Logic getVariable 'secondaryCosts';
			_sidearm = WF_Logic getVariable 'sidearmClasses';
			_sidearmCosts = WF_Logic getVariable 'sidearmCosts';
			_misc = WF_Logic getVariable 'miscClasses';
			_miscCosts = WF_Logic getVariable 'miscCosts';
			_magazine = WF_Logic getVariable 'magazineClasses';
			_magazineCosts = WF_Logic getVariable 'magazineCosts';

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_index = _primary find _x;
					if (_index != -1) then {_cost = _cost + (_primaryCosts select _index)};
					_index = _secondary find _x;
					if (_index != -1) then {_cost = _cost + (_secondaryCosts select _index)};
					_index = _sidearm find _x;
					if (_index != -1) then {_cost = _cost + (_sidearmCosts select _index)};
				} forEach (_t select _count);
				
				{
					_index = _magazine find _x;
					if (_index != -1) then {_cost = _cost + (_magazineCosts select _index)};
					_index = _misc find _x;
					if (_index != -1) then {_cost = _cost + (_miscCosts select _index)};
				} forEach ((_m select _count) + (_s select _count) + (_i select _count));
				
				_c = _c + [_cost];
			};
			WF_Logic setVariable ['templateClasses',_t];
			WF_Logic setVariable ['templateNames',_d];
			WF_Logic setVariable ['templateCosts',_c];
			WF_Logic setVariable ['templatePictures',_p];
			WF_Logic setVariable ['templateMags',_m];
			WF_Logic setVariable ['templateItems',_i];
			WF_Logic setVariable ['templateSpecs',_s];
			WF_Logic setVariable ['templateUpgrades',_l];
			WF_Logic setVariable ['templateAllowed',_b];
		};
	};

	['WFBE_WESTDEFAULTWEAPONS',['M16A2','ItemCompass','ItemMap','ItemWatch','ItemRadio'],true] Call SetNamespace;
	['WFBE_WESTDEFAULTAMMO',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West'],true] Call SetNamespace;

	if (isServer) then {
		//--- AI Leaders Loadouts.
		//--- Upgrade 0.
		['WFBE_WESTLEADERWEAPONS01',['m16a4','M136','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO01',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS02',['G36C','M136','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO02',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS03',['M240','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;;
		['WFBE_WESTLEADERAMMO03',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 1.
		['WFBE_WESTLEADERWEAPONS11',['m16a4_acg','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO11',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS12',['G36K','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO12',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS13',['M4SPR','M9SD','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO13',['20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','20Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD'],true] Call SetNamespace;
		//--- Upgrade 2.
		['WFBE_WESTLEADERWEAPONS21',['M4A1_Aim_camo','SMAW','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO21',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS22',['m8_carbine','SMAW','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO22',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS23',['MG36','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO23',['100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_WESTLEADERWEAPONS31',['M4A1_HWS_GL','SMAW','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO31',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','SMAW_HEAA','SMAW_HEAA','SMAW_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS32',['m8_compact','Javelin','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO32',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','Javelin','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS33',['Mk_48','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO33',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
	};




	//*** EAST ***//
	if (!isServer || local player) then {
		if (side player == EAST) then {
			//--- Magazines.
			_m = ["30Rnd_762x39_AK47"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];

			_m = _m + ["30Rnd_545x39_AK"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["30Rnd_545x39_AKSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["64Rnd_9x19_Bizon"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["64Rnd_9x19_SD_Bizon"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["100Rnd_762x54_PK"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["75Rnd_545x39_RPK"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5x_22_LR_17_HMR"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["10Rnd_762x54_SVD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_B_Saiga12_74Slug"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5Rnd_127x108_KSVK"];
			_c = _c + [15];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["20Rnd_9x39_SP5_VSS"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["PG7V"];
			_c = _c + [75];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["PG7VL"];
			_c = _c + [90];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["OG7"];
			_c = _c + [95];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];

			_m = _m + ["PG7VR"];
			_c = _c + [105];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];

			_m = _m + ["RPG18"];
			_c = _c + [50];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["AT13"];
			_c = _c + [200];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];

			_m = _m + ["Igla"];
			_c = _c + [110];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];

			_m = _m + ["Strela"];
			_c = _c + [100];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];

			_m = _m + ["Laserbatteries"];
			_c = _c + [20];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [true];

			_m = _m + ["8Rnd_9x18_Makarov"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_9x18_MakarovSD"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgMagazines' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgMagazines' >> _x >> 'displayName')];
				_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
			} forEach _m;

			WF_Logic setVariable ['magazineClasses',_m];
			WF_Logic setVariable ['magazineCosts',_c];
			WF_Logic setVariable ['magazinePictures',_p];
			WF_Logic setVariable ['magazineNames',_d];
			WF_Logic setVariable ['magazineSpaces',_s];
			WF_Logic setVariable ['magazineMain',_r];
			WF_Logic setVariable ['magazineTypes',_t];
			WF_Logic setVariable ['magazineUpgrades',_l];
			WF_Logic setVariable ['magazineAllowed',_b];

			_magazinesT = _m;
			
			//--- Primary.
			_w = ['AK_47_M'];
			_c = [50];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['AK_47_S'];
			_c = _c + [60];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_74'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_74_GL'];
			_c = _c + [105];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_107_kobra'];
			_c = _c + [155];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['AK_107_GL_kobra'];
			_c = _c + [180];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_107_pso'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['AK_107_GL_pso'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['AKS_74_kobra'];
			_c = _c + [140];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AKS_74_pso'];
			_c = _c + [160];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['AKS_74_U'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AKS_74_UN_kobra'];
			_c = _c + [215];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['AKS_GOLD'];
			_c = _c + [500];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['bizon'];
			_c = _c + [240];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['bizon_silenced'];
			_c = _c + [275];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['PK'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['Pecheneg'];
			_c = _c + [340];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['RPK_74'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['huntingrifle'];
			_c = _c + [145];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SVD'];
			_c = _c + [210];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['SVD_CAMO'];
			_c = _c + [245];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Saiga12K'];
			_c = _c + [130];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ksvk'];
			_c = _c + [340];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['VSS_vintorez'];
			_c = _c + [310];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['primaryClasses',_w];
			WF_Logic setVariable ['primaryCosts',_c];
			WF_Logic setVariable ['primaryPictures',_p];
			WF_Logic setVariable ['primaryNames',_d];
			WF_Logic setVariable ['primaryMagazines',_s];
			WF_Logic setVariable ['primaryUpgrades',_l];
			WF_Logic setVariable ['primaryAllowed',_b];

			//--- Secondary.

			_w = ['RPG7V'];
			_c = [150];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['RPG18'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['MetisLauncher'];
			_c = _c + [460];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['Igla'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Strela'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Laserdesignator'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['secondaryClasses',_w];
			WF_Logic setVariable ['secondaryCosts',_c];
			WF_Logic setVariable ['secondaryPictures',_p];
			WF_Logic setVariable ['secondaryNames',_d];
			WF_Logic setVariable ['secondaryMagazines',_s];
			WF_Logic setVariable ['secondaryUpgrades',_l];
			WF_Logic setVariable ['secondaryAllowed',_b];

			//--- Sidearms.

			_w = ['Makarov'];
			_c = [8];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['MakarovSD'];
			_c = _c + [15];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['sidearmClasses',_w];
			WF_Logic setVariable ['sidearmCosts',_c];
			WF_Logic setVariable ['sidearmPictures',_p];
			WF_Logic setVariable ['sidearmNames',_d];
			WF_Logic setVariable ['sidearmMagazines',_s];
			WF_Logic setVariable ['sidearmUpgrades',_l];
			WF_Logic setVariable ['sidearmAllowed',_b];

			//--- Misc.
			
			_w = ['HandGrenade_East'];
			_c = [10];
			_t = ['CfgMagazines'];
			_r = [false];
			_l = [0];
			_b = [true];

			_w = _w + ['HandGrenade_Stone'];
			_c = _c + [2];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShell'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellRed'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellGreen'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellBlue'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellYellow'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellOrange'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellPurple'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareWhite_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareYellow_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareGreen_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareRed_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_GP25'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKE_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKERED_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKEGREEN_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKEYELLOW_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['MineE'];
			_c = _c + [40];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PipeBomb'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Binocular'];
			_c = _c + [10];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['NVGoggles'];
			_c = _c + [20];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemCompass'];
			_c = _c + [4];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemGPS'];
			_c = _c + [25];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemMap'];
			_c = _c + [6];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemRadio'];
			_c = _c + [15];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemWatch'];
			_c = _c + [5];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_curType = _t select _u;
				if (_curType == 'Special' || _curType == 'Item') then {_curType = 'CfgWeapons'};
				_p = _p + [getText(configFile >> _curType >> _x >> 'picture')];
				_d = _d + [getText(configFile >> _curType >> _x >> 'displayName')];
				if (_curType == 'CfgMagazines') then {
					_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
				} else {
					_s = _s + [1];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['miscClasses',_w];
			WF_Logic setVariable ['miscCosts',_c];
			WF_Logic setVariable ['miscPictures',_p];
			WF_Logic setVariable ['miscSpaces',_s];
			WF_Logic setVariable ['miscNames',_d];
			WF_Logic setVariable ['miscTypes',_t];
			WF_Logic setVariable ['miscMain',_r];
			WF_Logic setVariable ['miscUpgrades',_l];
			WF_Logic setVariable ['miscAllowed',_b];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'picture')];
			_t = [['AK_107_kobra','Makarov']];
			_m = [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'HandGrenade_East','HandGrenade_East','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = [['Binocular']];
			_i = [_items];
			_l = [0];
			_b = [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_GL_kobra' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_GL_kobra' >> 'picture')];
			_t = _t + [['AK_107_GL_kobra']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','HandGrenade_East','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25',
				'1Rnd_HE_GP25','1Rnd_HE_GP25']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_pso' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_pso' >> 'picture')];
			_t = _t + [['AK_107_pso','RPG7V']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_GL_pso' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_GL_pso' >> 'picture')];
			_t = _t + [['AK_107_GL_pso','RPG7V']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7V',
				'PG7V','PG7V','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_U' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_U' >> 'picture')];
			_t = _t + [['AKS_74_U','RPG7V','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MetisLauncher' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'picture')];
			_t = _t + [['AK_107_kobra','MetisLauncher','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','AT13',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_74' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Igla' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_74' >> 'picture')];
			_t = _t + [['AK_74','Igla','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','Igla',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'Saiga12K' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'MineE' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'Saiga12K' >> 'picture')];
			_t = _t + [['Saiga12K','Makarov']];
			_m = _m + [['8Rnd_B_Saiga12_74Slug','8Rnd_B_Saiga12_74Slug','8Rnd_B_Saiga12_74Slug','8Rnd_B_Saiga12_74Slug','8Rnd_B_Saiga12_74Slug','8Rnd_B_Saiga12_74Slug','MineE','MineE','MineE',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_UN_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'PipeBomb' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_UN_kobra' >> 'picture')];
			_t = _t + [['AKS_74_UN_kobra','MakarovSD']];
			_m = _m + [['30Rnd_545x39_AKSD','30Rnd_545x39_AKSD','30Rnd_545x39_AKSD','30Rnd_545x39_AKSD','30Rnd_545x39_AKSD','30Rnd_545x39_AKSD','PipeBomb','PipeBomb','PipeBomb',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'PK' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'PK' >> 'picture')];
			_t = _t + [['PK','Makarov']];
			_m = _m + [['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'Pecheneg' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'Pecheneg' >> 'picture')];
			_t = _t + [['Pecheneg','Makarov']];
			_m = _m + [['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SVD' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SVD' >> 'picture')];
			_t = _t + [['SVD','MakarovSD']];
			_m = _m + [['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD',
				'10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'VSS_vintorez' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Laserdesignator' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'VSS_vintorez' >> 'picture')];
			_t = _t + [['VSS_vintorez','Laserdesignator','MakarovSD']];
			_m = _m + [['20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS',
				'20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','HandGrenade_East','Laserbatteries','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'ksvk' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'ksvk' >> 'picture')];
			_t = _t + [['ksvk','MakarovSD']];
			_m = _m + [['5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK',
				'5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			_primary = WF_Logic getVariable 'primaryClasses';
			_primaryCosts = WF_Logic getVariable 'primaryCosts';
			_secondary = WF_Logic getVariable 'secondaryClasses';
			_secondaryCosts = WF_Logic getVariable 'secondaryCosts';
			_sidearm = WF_Logic getVariable 'sidearmClasses';
			_sidearmCosts = WF_Logic getVariable 'sidearmCosts';
			_misc = WF_Logic getVariable 'miscClasses';
			_miscCosts = WF_Logic getVariable 'miscCosts';
			_magazine = WF_Logic getVariable 'magazineClasses';
			_magazineCosts = WF_Logic getVariable 'magazineCosts';

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_index = _primary find _x;
					if (_index != -1) then {_cost = _cost + (_primaryCosts select _index)};
					_index = _secondary find _x;
					if (_index != -1) then {_cost = _cost + (_secondaryCosts select _index)};
					_index = _sidearm find _x;
					if (_index != -1) then {_cost = _cost + (_sidearmCosts select _index)};
				} forEach (_t select _count);
				
				{
					_index = _magazine find _x;
					if (_index != -1) then {_cost = _cost + (_magazineCosts select _index)};
					_index = _misc find _x;
					if (_index != -1) then {_cost = _cost + (_miscCosts select _index)};
				} forEach ((_m select _count) + (_s select _count) + (_i select _count));
				
				_c = _c + [_cost];
			};
			WF_Logic setVariable ['templateClasses',_t];
			WF_Logic setVariable ['templateNames',_d];
			WF_Logic setVariable ['templateCosts',_c];
			WF_Logic setVariable ['templatePictures',_p];
			WF_Logic setVariable ['templateMags',_m];
			WF_Logic setVariable ['templateItems',_i];
			WF_Logic setVariable ['templateSpecs',_s];
			WF_Logic setVariable ['templateUpgrades',_l];
			WF_Logic setVariable ['templateAllowed',_b];
		};
	};

	['WFBE_EASTDEFAULTWEAPONS',['AK_74','ItemCompass','ItemMap','ItemWatch','ItemRadio'],true] Call SetNamespace;
	['WFBE_EASTDEFAULTAMMO',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','HandGrenade_East'],true] Call SetNamespace;

	if (isServer) then {
		//--- AI Leaders Loadouts.
		//--- Upgrade 0.
		['WFBE_EASTLEADERWEAPONS01',['AK_107_kobra','RPG7V','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO01',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS02',['AKS_74_kobra','RPG7V','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO02',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS03',['PK','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;;
		['WFBE_EASTLEADERAMMO03',['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		//--- Upgrade 1.
		['WFBE_EASTLEADERWEAPONS11',['AK_107_pso','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO11',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS12',['RPK_74','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO12',['75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS13',['SVD','MakarovSD','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO13',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD'],true] Call SetNamespace;
		//--- Upgrade 2.
		['WFBE_EASTLEADERWEAPONS21',['VSS_vintorez','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO21',['20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS22',['bizon','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO22',['64Rnd_9x19_Bizon','64Rnd_9x19_Bizon','64Rnd_9x19_Bizon','64Rnd_9x19_Bizon','64Rnd_9x19_Bizon','64Rnd_9x19_Bizon','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS23',['Pecheneg','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO23',['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_EASTLEADERWEAPONS31',['AK_107_GL_pso','RPG7V','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO31',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS32',['AK_107_kobra','MetisLauncher','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO32',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','AT13','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS33',['SVD_CAMO','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO33',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
	};
};

/* Arrowhead */
if (WF_A2_Arrowhead) then {
	//*** WEST ***//
	if (!isServer || local player) then {
	
		['WFBE_BINOCULARS',['Binocular','Binocular_Vector'],true] Call SetNamespace;
	
		if (side player == WEST) then {
			//--- Magazines.
			/*
				Note: 
					_r define whether the magazine belong to the main ammo pool or to the handgun ammo pool.
					_l define the upgrade level required to display the ammo.
					_b define whether the ammunition shall displayed or not if advanced camp gear parameter is on.
			*/
			_m = ["30Rnd_556x45_Stanag"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];
			
			_m = _m + ["30Rnd_556x45_StanagSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_556x45_Stanag"];
			_c = _c + [5];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_556x45_G36"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_556x45_G36SD"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_556x45_BetaCMag"];
			_c = _c + [15];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["5Rnd_762x51_M24"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_DMR"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["10Rnd_127x99_m107"];
			_c = _c + [18];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_762x51_M240"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_556x45_M249"];
			_c = _c + [11];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];		
			
			_m = _m + ["200Rnd_556x45_M249"];
			_c = _c + [22];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_B_SCAR"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20rnd_762x51_B_SCAR"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];			
			
			_m = _m + ["20rnd_762x51_SB_SCAR"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["6Rnd_HE_M203"];
			_c = _c + [35];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareWhite_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareGreen_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareRed_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareYellow_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_Smoke_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeRed_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeGreen_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeYellow_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["M136"];
			_c = _c + [50];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["MAAWS_HEAT"];
			_c = _c + [135];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["MAAWS_HEDP"];
			_c = _c + [150];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["Dragon_EP1"];
			_c = _c + [220];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["Javelin"];
			_c = _c + [300];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];
			
			_m = _m + ["Stinger"];
			_c = _c + [100];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];
			
			_m = _m + ["Laserbatteries"];
			_c = _c + [20];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [true];
			
			_m = _m + ["15Rnd_9x19_M9"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["15Rnd_9x19_M9SD"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["7Rnd_45ACP_1911"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["17Rnd_9x19_glock17"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgMagazines' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgMagazines' >> _x >> 'displayName')];
				_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
			} forEach _m;

			WF_Logic setVariable ['magazineClasses',_m];
			WF_Logic setVariable ['magazineCosts',_c];
			WF_Logic setVariable ['magazinePictures',_p];
			WF_Logic setVariable ['magazineNames',_d];
			WF_Logic setVariable ['magazineSpaces',_s];
			WF_Logic setVariable ['magazineMain',_r];
			WF_Logic setVariable ['magazineTypes',_t];
			WF_Logic setVariable ['magazineUpgrades',_l];
			WF_Logic setVariable ['magazineAllowed',_b];
			
			_magazinesT = _m;

			//--- Primary.
			/*
				Note: _a define whether the default ammunitions are dumped from CfgMagazines or added manualy:
					Manual override require a nested array.

				Exemple:
					_w = _w + ['M16A2GL'];
					_c = _c + [85];
					_a = _a + [true];	
				OR
					_w = _w + ['M16A2GL'];
					_c = _c + [85];
					_a = _a + [['30Rnd_556x45_Stanag','30Rnd_556x45_StanagSD',...]];
				
			*/

			_w = ['M16A2'];
			_c = [80];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['M16A2GL'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M24_des_EP1'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['m240_scoped_EP1'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['M60A4_EP1'];
			_c = _c + [180];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['Mk_48_DES_EP1'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['M249_EP1'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['M249_TWS_EP1'];
			_c = _c + [285];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['M249_m145_EP1'];
			_c = _c + [205];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['M4A1'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M4A3_CCO_EP1'];
			_c = _c + [130];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['M4A3_RCO_GL_EP1'];
			_c = _c + [140];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['G36C_camo'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['G36_C_SD_camo'];
			_c = _c + [265];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['G36A_camo'];
			_c = _c + [240];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['G36K_camo'];
			_c = _c + [230];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['MG36_camo'];
			_c = _c + [260];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];
			
			_w = _w + ['M32_EP1'];
			_c = _c + [220];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];
			
			_w = _w + ['M79_EP1'];
			_c = _c + [105];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [false];
			
			_w = _w + ['Mk13_EP1'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['M14_EP1'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['m107'];
			_c = _c + [315];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];
			
			_w = _w + ['m107_TWS_EP1'];
			_c = _c + [455];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];
			
			_w = _w + ['M110_TWS_EP1'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];		
			
			_w = _w + ['M110_NVG_EP1'];
			_c = _c + [295];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];
			
			_w = _w + ['SCAR_L_CQC'];
			_c = _c + [210];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SCAR_L_CQC_Holo'];
			_c = _c + [220];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SCAR_L_STD_Mk4CQT'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SCAR_L_STD_EGLM_RCO'];
			_c = _c + [230];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SCAR_L_CQC_EGLM_Holo'];
			_c = _c + [245];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SCAR_L_STD_EGLM_TWS'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_L_STD_HOLO'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SCAR_H_CQC_CCO'];
			_c = _c + [240];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SCAR_H_CQC_CCO_SD'];
			_c = _c + [270];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_H_STD_EGLM_Spect'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_H_LNG_Sniper'];
			_c = _c + [305];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_H_LNG_Sniper_SD'];
			_c = _c + [345];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['SCAR_H_STD_TWS_SD'];
			_c = _c + [395];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['primaryClasses',_w];
			WF_Logic setVariable ['primaryCosts',_c];
			WF_Logic setVariable ['primaryPictures',_p];
			WF_Logic setVariable ['primaryNames',_d];
			WF_Logic setVariable ['primaryMagazines',_s];
			WF_Logic setVariable ['primaryUpgrades',_l];
			WF_Logic setVariable ['primaryAllowed',_b];

			//--- Secondary.

			_w = ['M136'];
			_c = [90];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['MAAWS'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['M47Launcher_EP1'];
			_c = _c + [450];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Javelin'];
			_c = _c + [650];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['Stinger'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Laserdesignator'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['secondaryClasses',_w];
			WF_Logic setVariable ['secondaryCosts',_c];
			WF_Logic setVariable ['secondaryPictures',_p];
			WF_Logic setVariable ['secondaryNames',_d];
			WF_Logic setVariable ['secondaryMagazines',_s];
			WF_Logic setVariable ['secondaryUpgrades',_l];
			WF_Logic setVariable ['secondaryAllowed',_b];

			//--- Sidearms.

			_w = ['Colt1911'];
			_c = [15];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['M9'];
			_c = _c + [20];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M9SD'];
			_c = _c + [25];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['glock17_EP1'];
			_c = _c + [35];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['sidearmClasses',_w];
			WF_Logic setVariable ['sidearmCosts',_c];
			WF_Logic setVariable ['sidearmPictures',_p];
			WF_Logic setVariable ['sidearmNames',_d];
			WF_Logic setVariable ['sidearmMagazines',_s];
			WF_Logic setVariable ['sidearmUpgrades',_l];
			WF_Logic setVariable ['sidearmAllowed',_b];

			//--- Misc.

			_w = ['HandGrenade_West'];
			_c = [10];
			_t = ['CfgMagazines'];
			_r = [false];
			_l = [0];
			_b =  [true];

			_w = _w + ['HandGrenade_Stone'];
			_c = _c + [2];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['IR_Strobe_Target'];
			_c = _c + [25];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['IR_Strobe_Marker'];
			_c = _c + [35];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShell'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellRed'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellGreen'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellBlue'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellYellow'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellOrange'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellPurple'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareWhite_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareYellow_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareGreen_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareRed_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_M203'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_Smoke_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeRed_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeGreen_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeYellow_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Mine'];
			_c = _c + [40];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PipeBomb'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Binocular'];
			_c = _c + [10];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['NVGoggles'];
			_c = _c + [20];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Binocular_Vector'];
			_c = _c + [50];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['ItemCompass'];
			_c = _c + [4];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemGPS'];
			_c = _c + [25];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemMap'];
			_c = _c + [6];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemRadio'];
			_c = _c + [15];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemWatch'];
			_c = _c + [5];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_curType = _t select _u;
				if (_curType == 'Special' || _curType == 'Item') then {_curType = 'CfgWeapons'};
				_p = _p + [getText(configFile >> _curType >> _x >> 'picture')];
				_d = _d + [getText(configFile >> _curType >> _x >> 'displayName')];
				if (_curType == 'CfgMagazines') then {
					_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
				} else {
					_s = _s + [1];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['miscClasses',_w];
			WF_Logic setVariable ['miscCosts',_c];
			WF_Logic setVariable ['miscPictures',_p];
			WF_Logic setVariable ['miscSpaces',_s];
			WF_Logic setVariable ['miscNames',_d];
			WF_Logic setVariable ['miscTypes',_t];
			WF_Logic setVariable ['miscMain',_r];
			WF_Logic setVariable ['miscUpgrades',_l];
			WF_Logic setVariable ['miscAllowed',_b];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'picture')];
			_t = [['SCAR_L_CQC','Colt1911']];
			_m = [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'HandGrenade_West','HandGrenade_West','SmokeShellBlue','SmokeShellBlue','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = [['Binocular']];
			_i = [_items];
			_l = [0];
			_b = [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M16A2GL' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M16A2GL' >> 'picture')];
			_t = _t + [['M16A2GL']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203',
				'1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'G36C_camo' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M136' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'G36C_camo' >> 'picture')];
			_t = _t + [['G36C_camo','M136']];
			_m = _m + [['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_STD_EGLM_Spect' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MAAWS' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_STD_EGLM_Spect' >> 'picture')];
			_t = _t + [['SCAR_H_STD_EGLM_Spect','MAAWS']];
			_m = _m + [['20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','MAAWS_HEAT',
				'MAAWS_HEAT','MAAWS_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MAAWS' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'picture')];
			_t = _t + [['SCAR_L_STD_HOLO','MAAWS','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M4A3_CCO_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Javelin' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M4A3_CCO_EP1' >> 'picture')];
			_t = _t + [['M4A3_CCO_EP1','Javelin','Colt1911']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Javelin',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_Mk4CQT' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Stinger' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_Mk4CQT' >> 'picture')];
			_t = _t + [['SCAR_L_STD_Mk4CQT','Stinger','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Stinger',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'Mine' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Mine','Mine','Mine',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_CQC_CCO_SD' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'PipeBomb' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_CQC_CCO_SD' >> 'picture')];
			_t = _t + [['SCAR_H_CQC_CCO_SD','M9SD']];
			_m = _m + [['20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','PipeBomb','PipeBomb','PipeBomb',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'm240_scoped_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'm240_scoped_EP1' >> 'picture')];
			_t = _t + [['m240_scoped_EP1','Colt1911']];
			_m = _m + [['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','SmokeShellRed','SmokeShellRed','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M249_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M249_EP1' >> 'picture')];
			_t = _t + [['M249_EP1','Colt1911']];
			_m = _m + [['200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','SmokeShellRed','SmokeShellRed','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M14_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M14_EP1' >> 'picture')];
			_t = _t + [['M14_EP1','M9SD']];
			_m = _m + [['20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR',
				'20Rnd_762x51_DMR','20Rnd_762x51_DMR','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];
			
			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M110_TWS_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Laserdesignator' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M110_TWS_EP1' >> 'picture')];
			_t = _t + [['M110_TWS_EP1','Laserdesignator','M9SD']];
			_m = _m + [['20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR',
				'20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','HandGrenade_West','Laserbatteries','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'm107_TWS_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'm107_TWS_EP1' >> 'picture')];
			_t = _t + [['m107_TWS_EP1','M9SD']];
			_m = _m + [['10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107',
				'10Rnd_127x99_m107','10Rnd_127x99_m107','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			_primary = WF_Logic getVariable 'primaryClasses';
			_primaryCosts = WF_Logic getVariable 'primaryCosts';
			_secondary = WF_Logic getVariable 'secondaryClasses';
			_secondaryCosts = WF_Logic getVariable 'secondaryCosts';
			_sidearm = WF_Logic getVariable 'sidearmClasses';
			_sidearmCosts = WF_Logic getVariable 'sidearmCosts';
			_misc = WF_Logic getVariable 'miscClasses';
			_miscCosts = WF_Logic getVariable 'miscCosts';
			_magazine = WF_Logic getVariable 'magazineClasses';
			_magazineCosts = WF_Logic getVariable 'magazineCosts';

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_index = _primary find _x;
					if (_index != -1) then {_cost = _cost + (_primaryCosts select _index)};
					_index = _secondary find _x;
					if (_index != -1) then {_cost = _cost + (_secondaryCosts select _index)};
					_index = _sidearm find _x;
					if (_index != -1) then {_cost = _cost + (_sidearmCosts select _index)};
				} forEach (_t select _count);
				
				{
					_index = _magazine find _x;
					if (_index != -1) then {_cost = _cost + (_magazineCosts select _index)};
					_index = _misc find _x;
					if (_index != -1) then {_cost = _cost + (_miscCosts select _index)};
				} forEach ((_m select _count) + (_s select _count) + (_i select _count));
				
				_c = _c + [_cost];
			};
			WF_Logic setVariable ['templateClasses',_t];
			WF_Logic setVariable ['templateNames',_d];
			WF_Logic setVariable ['templateCosts',_c];
			WF_Logic setVariable ['templatePictures',_p];
			WF_Logic setVariable ['templateMags',_m];
			WF_Logic setVariable ['templateItems',_i];
			WF_Logic setVariable ['templateSpecs',_s];
			WF_Logic setVariable ['templateUpgrades',_l];
			WF_Logic setVariable ['templateAllowed',_b];
		};
	};

	['WFBE_WESTDEFAULTWEAPONS',['M16A2','ItemCompass','ItemMap','ItemWatch','ItemRadio'],true] Call SetNamespace;
	['WFBE_WESTDEFAULTAMMO',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West'],true] Call SetNamespace;

	if (isServer) then {
		//--- AI Leaders Loadouts.
		//--- Upgrade 0.
		['WFBE_WESTLEADERWEAPONS01',['SCAR_L_CQC','M136','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO01',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS02',['G36C_camo','M136','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO02',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS03',['m240_scoped_EP1','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;;
		['WFBE_WESTLEADERAMMO03',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 1.
		['WFBE_WESTLEADERWEAPONS11',['M4A3_CCO_EP1','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO11',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS12',['G36K_camo','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO12',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS13',['M14_EP1','M9SD','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO13',['20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD'],true] Call SetNamespace;
		//--- Upgrade 2.
		['WFBE_WESTLEADERWEAPONS21',['SCAR_L_STD_HOLO','MAAWS','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO21',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS22',['G36C_camo','MAAWS','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO22',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS23',['MG36_camo','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO23',['100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_WESTLEADERWEAPONS31',['SCAR_L_CQC_EGLM_Holo','MAAWS','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO31',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS32',['SCAR_H_STD_EGLM_Spect','Javelin','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO32',['20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','Javelin','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS33',['Mk_48_DES_EP1','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO33',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
	};




	//*** EAST ***//
	if (!isServer || local player) then {
		if (side player == EAST) then {
			//--- Magazines.
			_m = ["30Rnd_762x39_AK47"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];
			
			_m = ["30Rnd_556x45_Stanag"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];

			_m = _m + ["30Rnd_545x39_AK"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["30Rnd_545x39_AKSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["100Rnd_762x54_PK"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["75Rnd_545x39_RPK"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["10Rnd_762x54_SVD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5Rnd_127x108_KSVK"];
			_c = _c + [15];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["10x_303"];
			_c = _c + [2];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_762x39_SA58"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_FNFAL"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["PG7V"];
			_c = _c + [75];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["PG7VL"];
			_c = _c + [90];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["OG7"];
			_c = _c + [95];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];

			_m = _m + ["PG7VR"];
			_c = _c + [105];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];

			_m = _m + ["RPG18"];
			_c = _c + [50];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["AT13"];
			_c = _c + [200];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];

			_m = _m + ["Igla"];
			_c = _c + [110];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];

			_m = _m + ["Strela"];
			_c = _c + [100];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];

			_m = _m + ["Laserbatteries"];
			_c = _c + [20];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [true];

			_m = _m + ["6Rnd_45ACP"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_9x18_Makarov"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_9x18_MakarovSD"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["10Rnd_B_765x17_Ball"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["20Rnd_B_765x17_Ball"];
			_c = _c + [4];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_UZI"];
			_c = _c + [4];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_UZI_SD"];
			_c = _c + [7];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgMagazines' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgMagazines' >> _x >> 'displayName')];
				_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
			} forEach _m;

			WF_Logic setVariable ['magazineClasses',_m];
			WF_Logic setVariable ['magazineCosts',_c];
			WF_Logic setVariable ['magazinePictures',_p];
			WF_Logic setVariable ['magazineNames',_d];
			WF_Logic setVariable ['magazineSpaces',_s];
			WF_Logic setVariable ['magazineMain',_r];
			WF_Logic setVariable ['magazineTypes',_t];
			WF_Logic setVariable ['magazineUpgrades',_l];
			WF_Logic setVariable ['magazineAllowed',_b];

			_magazinesT = _m;
			
			//--- Primary.
			_w = ['AK_47_M'];
			_c = [50];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['AK_47_S'];
			_c = _c + [60];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['M16A2'];
			_c = _c + [80];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M16A2GL'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_74'];
			_c = _c + [85];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_74_GL'];
			_c = _c + [105];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['AK_74_GL_kobra'];
			_c = _c + [105];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['AKS_74'];
			_c = _c + [115];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AKS_74_GOSHAWK'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_kobra'];
			_c = _c + [140];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_NSPU'];
			_c = _c + [180];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['AKS_74_pso'];
			_c = _c + [160];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['AKS_74_U'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FN_FAL'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['FN_FAL_ANPVS4'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['LeeEnfield'];
			_c = _c + [25];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PK'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['RPK_74'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Sa58P_EP1'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Sa58V_EP1'];
			_c = _c + [190];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['Sa58V_RCO_EP1'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Sa58V_CCO_EP1'];
			_c = _c + [205];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['SVD'];
			_c = _c + [210];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['SVD_des_EP1'];
			_c = _c + [210];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['SVD_NSPU_EP1'];
			_c = _c + [230];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['ksvk'];
			_c = _c + [340];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['primaryClasses',_w];
			WF_Logic setVariable ['primaryCosts',_c];
			WF_Logic setVariable ['primaryPictures',_p];
			WF_Logic setVariable ['primaryNames',_d];
			WF_Logic setVariable ['primaryMagazines',_s];
			WF_Logic setVariable ['primaryUpgrades',_l];
			WF_Logic setVariable ['primaryAllowed',_b];

			//--- Secondary.

			_w = ['RPG7V'];
			_c = [150];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['RPG18'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['MetisLauncher'];
			_c = _c + [460];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['Igla'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Strela'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Laserdesignator'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['secondaryClasses',_w];
			WF_Logic setVariable ['secondaryCosts',_c];
			WF_Logic setVariable ['secondaryPictures',_p];
			WF_Logic setVariable ['secondaryNames',_d];
			WF_Logic setVariable ['secondaryMagazines',_s];
			WF_Logic setVariable ['secondaryUpgrades',_l];
			WF_Logic setVariable ['secondaryAllowed',_b];

			//--- Sidearms.

			_w = ['Makarov'];
			_c = [8];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['revolver_EP1'];
			_c = _c + [10];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['revolver_gold_EP1'];
			_c = _c + [100];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['MakarovSD'];
			_c = _c + [15];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Sa61_EP1'];
			_c = _c + [25];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['UZI_EP1'];
			_c = _c + [55];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['UZI_SD_EP1'];
			_c = _c + [65];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['sidearmClasses',_w];
			WF_Logic setVariable ['sidearmCosts',_c];
			WF_Logic setVariable ['sidearmPictures',_p];
			WF_Logic setVariable ['sidearmNames',_d];
			WF_Logic setVariable ['sidearmMagazines',_s];
			WF_Logic setVariable ['sidearmUpgrades',_l];
			WF_Logic setVariable ['sidearmAllowed',_b];

			//--- Misc.
			
			_w = ['HandGrenade_East'];
			_c = [10];
			_t = ['CfgMagazines'];
			_r = [false];
			_l = [0];
			_b = [true];

			_w = _w + ['HandGrenade_Stone'];
			_c = _c + [2];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShell'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellRed'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellGreen'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellBlue'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellYellow'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellOrange'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellPurple'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareWhite_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareYellow_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareGreen_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareRed_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_M203'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_GP25'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKE_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKERED_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKEGREEN_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKEYELLOW_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['MineE'];
			_c = _c + [40];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PipeBomb'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Binocular'];
			_c = _c + [10];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['NVGoggles'];
			_c = _c + [20];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Binocular_Vector'];
			_c = _c + [50];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['ItemCompass'];
			_c = _c + [4];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemGPS'];
			_c = _c + [25];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemMap'];
			_c = _c + [6];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemRadio'];
			_c = _c + [15];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemWatch'];
			_c = _c + [5];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_curType = _t select _u;
				if (_curType == 'Special' || _curType == 'Item') then {_curType = 'CfgWeapons'};
				_p = _p + [getText(configFile >> _curType >> _x >> 'picture')];
				_d = _d + [getText(configFile >> _curType >> _x >> 'displayName')];
				if (_curType == 'CfgMagazines') then {
					_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
				} else {
					_s = _s + [1];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['miscClasses',_w];
			WF_Logic setVariable ['miscCosts',_c];
			WF_Logic setVariable ['miscPictures',_p];
			WF_Logic setVariable ['miscSpaces',_s];
			WF_Logic setVariable ['miscNames',_d];
			WF_Logic setVariable ['miscTypes',_t];
			WF_Logic setVariable ['miscMain',_r];
			WF_Logic setVariable ['miscUpgrades',_l];
			WF_Logic setVariable ['miscAllowed',_b];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [getText(configFile >> 'CfgWeapons' >> 'AKS_74_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = [getText(configFile >> 'CfgWeapons' >> 'AKS_74_kobra' >> 'picture')];
			_t = [['AKS_74_kobra','Makarov']];
			_m = [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'HandGrenade_East','HandGrenade_East','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = [['Binocular']];
			_i = [_items];
			_l = [0];
			_b = [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_74_GL_kobra' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_74_GL_kobra' >> 'picture')];
			_t = _t + [['AK_74_GL_kobra']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','HandGrenade_East','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25',
				'1Rnd_HE_GP25','1Rnd_HE_GP25']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_pso' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_pso' >> 'picture')];
			_t = _t + [['AKS_74_pso','RPG7V']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_74_GL' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_74_GL' >> 'picture')];
			_t = _t + [['AK_74_GL','RPG7V']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7V',
				'PG7V','PG7V','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'Sa58V_RCO_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'Sa58V_RCO_EP1' >> 'picture')];
			_t = _t + [['Sa58V_RCO_EP1','RPG7V','Makarov']];
			_m = _m + [['30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','PG7VL','PG7VL','PG7VL',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MetisLauncher' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_kobra' >> 'picture')];
			_t = _t + [['AKS_74_kobra','MetisLauncher','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','AT13',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_74' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Igla' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_74' >> 'picture')];
			_t = _t + [['AK_74','Igla','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','Igla',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_U' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'MineE' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_U' >> 'picture')];
			_t = _t + [['AKS_74_U','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','MineE','MineE','MineE',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_GOSHAWK' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'PipeBomb' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_GOSHAWK' >> 'picture')];
			_t = _t + [['AKS_74_GOSHAWK','MakarovSD']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PipeBomb','PipeBomb','PipeBomb',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'PK' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'PK' >> 'picture')];
			_t = _t + [['PK','Makarov']];
			_m = _m + [['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SVD_des_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SVD_des_EP1' >> 'picture')];
			_t = _t + [['SVD_des_EP1','MakarovSD']];
			_m = _m + [['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD',
				'10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_NSPU' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Laserdesignator' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_NSPU' >> 'picture')];
			_t = _t + [['AKS_74_NSPU','Laserdesignator','MakarovSD']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','Laserbatteries','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'ksvk' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'ksvk' >> 'picture')];
			_t = _t + [['ksvk','MakarovSD']];
			_m = _m + [['5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK',
				'5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			_primary = WF_Logic getVariable 'primaryClasses';
			_primaryCosts = WF_Logic getVariable 'primaryCosts';
			_secondary = WF_Logic getVariable 'secondaryClasses';
			_secondaryCosts = WF_Logic getVariable 'secondaryCosts';
			_sidearm = WF_Logic getVariable 'sidearmClasses';
			_sidearmCosts = WF_Logic getVariable 'sidearmCosts';
			_misc = WF_Logic getVariable 'miscClasses';
			_miscCosts = WF_Logic getVariable 'miscCosts';
			_magazine = WF_Logic getVariable 'magazineClasses';
			_magazineCosts = WF_Logic getVariable 'magazineCosts';

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_index = _primary find _x;
					if (_index != -1) then {_cost = _cost + (_primaryCosts select _index)};
					_index = _secondary find _x;
					if (_index != -1) then {_cost = _cost + (_secondaryCosts select _index)};
					_index = _sidearm find _x;
					if (_index != -1) then {_cost = _cost + (_sidearmCosts select _index)};
				} forEach (_t select _count);
				
				{
					_index = _magazine find _x;
					if (_index != -1) then {_cost = _cost + (_magazineCosts select _index)};
					_index = _misc find _x;
					if (_index != -1) then {_cost = _cost + (_miscCosts select _index)};
				} forEach ((_m select _count) + (_s select _count) + (_i select _count));
				
				_c = _c + [_cost];
			};
			WF_Logic setVariable ['templateClasses',_t];
			WF_Logic setVariable ['templateNames',_d];
			WF_Logic setVariable ['templateCosts',_c];
			WF_Logic setVariable ['templatePictures',_p];
			WF_Logic setVariable ['templateMags',_m];
			WF_Logic setVariable ['templateItems',_i];
			WF_Logic setVariable ['templateSpecs',_s];
			WF_Logic setVariable ['templateUpgrades',_l];
			WF_Logic setVariable ['templateAllowed',_b];
		};
	};

	['WFBE_EASTDEFAULTWEAPONS',['AK_74','ItemCompass','ItemMap','ItemWatch','ItemRadio'],true] Call SetNamespace;
	['WFBE_EASTDEFAULTAMMO',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','HandGrenade_East'],true] Call SetNamespace;

	if (isServer) then {
		//--- AI Leaders Loadouts.
		//--- Upgrade 0.
		['WFBE_EASTLEADERWEAPONS01',['AKS_74','RPG7V','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO01',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS02',['AKS_74_kobra','RPG7V','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO02',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS03',['PK','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;;
		['WFBE_EASTLEADERAMMO03',['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		//--- Upgrade 1.
		['WFBE_EASTLEADERWEAPONS11',['AKS_74_GOSHAWK','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO11',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS12',['RPK_74','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO12',['75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS13',['SVD','MakarovSD','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO13',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD'],true] Call SetNamespace;
		//--- Upgrade 2.
		['WFBE_EASTLEADERWEAPONS21',['AKS_74_NSPU','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO21',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS22',['SVD_des_EP1','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO22',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS23',['PK','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO23',['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_EASTLEADERWEAPONS31',['AK_74_GL','RPG7V','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO31',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS32',['Sa58V_RCO_EP1','MetisLauncher','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO32',['30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','AT13','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS33',['SVD_NSPU_EP1','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO33',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
	};
};

/* Combined Operations */
if (WF_A2_CombinedOps) then {
	//*** WEST ***//
	if (!isServer || local player) then {
	
		['WFBE_BINOCULARS',['Binocular','Binocular_Vector'],true] Call SetNamespace;
	
		if (side player == WEST) then {
			//--- Magazines.
			/*
				Note: 
					_r define whether the magazine belong to the main ammo pool or to the handgun ammo pool.
					_l define the upgrade level required to display the ammo.
					_b define whether the ammunition shall displayed or not if advanced camp gear parameter is on.
			*/

			_m = ["30Rnd_556x45_Stanag"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];
			
			_m = _m + ["30Rnd_556x45_StanagSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];			
						
			_m = _m + ["30Rnd_556x45_G36"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_556x45_G36SD"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_556x45_BetaCMag"];
			_c = _c + [15];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["5Rnd_762x51_M24"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_DMR"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_B_Beneli_74Slug"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["10Rnd_127x99_m107"];
			_c = _c + [18];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_762x51_M240"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_556x45_M249"];
			_c = _c + [11];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];		
			
			_m = _m + ["200Rnd_556x45_M249"];
			_c = _c + [22];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_B_SCAR"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20rnd_762x51_B_SCAR"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];			
			
			_m = _m + ["20rnd_762x51_SB_SCAR"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["6Rnd_HE_M203"];
			_c = _c + [35];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareWhite_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareGreen_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareRed_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareYellow_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_Smoke_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeRed_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeGreen_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeYellow_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["M136"];
			_c = _c + [100];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["SMAW_HEAA"];
			_c = _c + [175];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];
			
			_m = _m + ["SMAW_HEDP"];
			_c = _c + [200];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];
			
			_m = _m + ["MAAWS_HEAT"];
			_c = _c + [250];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [true];
			
			_m = _m + ["MAAWS_HEDP"];
			_c = _c + [300];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [true];

			_m = _m + ["Javelin"];
			_c = _c + [500];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];
			
			_m = _m + ["Stinger"];
			_c = _c + [500];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];
			
			_m = _m + ["Laserbatteries"];
			_c = _c + [20];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [true];
			
			_m = _m + ["15Rnd_9x19_M9"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["15Rnd_9x19_M9SD"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["7Rnd_45ACP_1911"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["17Rnd_9x19_glock17"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_UZI"];
			_c = _c + [4];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_UZI_SD"];
			_c = _c + [7];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgMagazines' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgMagazines' >> _x >> 'displayName')];
				_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
			} forEach _m;

			WF_Logic setVariable ['magazineClasses',_m];
			WF_Logic setVariable ['magazineCosts',_c];
			WF_Logic setVariable ['magazinePictures',_p];
			WF_Logic setVariable ['magazineNames',_d];
			WF_Logic setVariable ['magazineSpaces',_s];
			WF_Logic setVariable ['magazineMain',_r];
			WF_Logic setVariable ['magazineTypes',_t];
			WF_Logic setVariable ['magazineUpgrades',_l];
			WF_Logic setVariable ['magazineAllowed',_b];
			
			_magazinesT = _m;

			//--- Primary.
			/*
				Note: _a define whether the default ammunitions are dumped from CfgMagazines or added manualy:
					Manual override require a nested array.

				Exemple:
					_w = _w + ['M16A2GL'];
					_c = _c + [85];
					_a = _a + [true];	
				OR
					_w = _w + ['M16A2GL'];
					_c = _c + [85];
					_a = _a + [['30Rnd_556x45_Stanag','30Rnd_556x45_StanagSD',...]];
				
			*/

			//--- SHOTGUNS

			_w = ['M1014'];
			_c = [100];
			_a = [true];
			_l = [0];
			_b = [true];

			//--- SUBMACHINEGUNS
		
			_w = _w + ['MP5A5'];
			_c = _c + [100];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['MP5SD'];
			_c = _c + [110];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			//--- M16
			
			_w = _w + ['M16A2'];
			_c = _c + [115];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['M16A2GL'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M16A4_GL'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['M16A4_ACG'];
			_c = _c + [2];
			_a = _a + [true];
			_l = _l + [180];
			_b = _b + [true];
			
			_w = _w + ['M16A4_ACG_GL'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			//--- M4
			
			_w = _w + ['M4A1'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
						
			_w = _w + ['M4A1_Aim'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['M4A3_CCO_EP1'];
			_c = _c + [165];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
					
			_w = _w + ['M4A1_HWS_GL_camo'];
			_c = _c + [205];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['M4A1_HWS_GL_SD_Camo'];
			_c = _c + [215];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['M4A1_RCO_GL'];
			_c = _c + [230];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['M4A3_RCO_GL_EP1'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			//--- G36	
			
			_w = _w + ['G36C'];
			_c = _c + [125];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['G36C_camo'];
			_c = _c + [130];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['G36K'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['G36K_camo'];
			_c = _c + [155];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['G36_C_SD_eotech'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['G36_C_SD_camo'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['G36a'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['G36A_camo'];
			_c = _c + [205];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['MG36'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['MG36_camo'];
			_c = _c + [255];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			//--- XM8
			
			_w = _w + ['M8_compact'];
			_c = _c + [135];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['M8_carbine'];
			_c = _c + [155];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['M8_sharpshooter'];
			_c = _c + [190];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['M8_carbineGL'];
			_c = _c + [235];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];
								
			_w = _w + ['M8_SAW'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];
				
			//--- SCAR
			
			_w = _w + ['SCAR_L_CQC'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['SCAR_L_CQC_Holo'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
						
			_w = _w + ['SCAR_L_STD_HOLO'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_L_STD_Mk4CQT'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_L_CQC_CCO_SD'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_H_CQC_CCO'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['SCAR_H_CQC_CCO_SD'];
			_c = _c + [260];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['SCAR_L_CQC_EGLM_Holo'];
			_c = _c + [285];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['SCAR_L_STD_EGLM_RCO'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['SCAR_H_STD_EGLM_Spect'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];
											
			_w = _w + ['SCAR_H_LNG_Sniper'];
			_c = _c + [375];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['SCAR_H_LNG_Sniper_SD'];
			_c = _c + [390];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];
			
			_w = _w + ['SCAR_L_STD_EGLM_TWS'];
			_c = _c + [450];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];
			
			_w = _w + ['SCAR_H_STD_TWS_SD'];
			_c = _c + [550];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];	

			//--- MACHINEGUNS
			
			_w = _w + ['M249'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M240'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M60A4_EP1'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M249_m145_EP1'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['m240_scoped_EP1'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
													
			_w = _w + ['Mk_48'];
			_c = _c + [375];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['Mk_48_DES_EP1'];
			_c = _c + [380];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['M249_TWS_EP1'];
			_c = _c + [500];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			//--- SNIPER RIFLES
			
			_w = _w + ['M4SPR'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
					
			_w = _w + ['M24'];
			_c = _c + [275];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M24_des_EP1'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
					
			_w = _w + ['M40A3'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['M110_NVG_EP1'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['M107'];
			_c = _c + [400];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
						
			_w = _w + ['M110_TWS_EP1'];
			_c = _c + [475];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['m107_TWS_EP1'];
			_c = _c + [500];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];
			
			//--- GRENADE LAUNCHERS
			
			_w = _w + ['M79_EP1'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Mk13_EP1'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
					
			_w = _w + ['M32_EP1'];
			_c = _c + [500];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['primaryClasses',_w];
			WF_Logic setVariable ['primaryCosts',_c];
			WF_Logic setVariable ['primaryPictures',_p];
			WF_Logic setVariable ['primaryNames',_d];
			WF_Logic setVariable ['primaryMagazines',_s];
			WF_Logic setVariable ['primaryUpgrades',_l];
			WF_Logic setVariable ['primaryAllowed',_b];

			//--- Secondary.

			_w = ['M136'];
			_c = [100];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['SMAW'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [false];

			_w = _w + ['MAAWS'];
			_c = _c + [400];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];
			
			_w = _w + ['Javelin'];
			_c = _c + [750];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['Stinger'];
			_c = _c + [750];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Laserdesignator'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['secondaryClasses',_w];
			WF_Logic setVariable ['secondaryCosts',_c];
			WF_Logic setVariable ['secondaryPictures',_p];
			WF_Logic setVariable ['secondaryNames',_d];
			WF_Logic setVariable ['secondaryMagazines',_s];
			WF_Logic setVariable ['secondaryUpgrades',_l];
			WF_Logic setVariable ['secondaryAllowed',_b];

			//--- Sidearms.

			_w = ['Colt1911'];
			_c = [15];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['M9'];
			_c = _c + [20];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['M9SD'];
			_c = _c + [25];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['glock17_EP1'];
			_c = _c + [35];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['sidearmClasses',_w];
			WF_Logic setVariable ['sidearmCosts',_c];
			WF_Logic setVariable ['sidearmPictures',_p];
			WF_Logic setVariable ['sidearmNames',_d];
			WF_Logic setVariable ['sidearmMagazines',_s];
			WF_Logic setVariable ['sidearmUpgrades',_l];
			WF_Logic setVariable ['sidearmAllowed',_b];

			//--- Misc.

			_w = ['HandGrenade_West'];
			_c = [10];
			_t = ['CfgMagazines'];
			_r = [false];
			_l = [0];
			_b =  [true];

			_w = _w + ['HandGrenade_Stone'];
			_c = _c + [2];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['IR_Strobe_Target'];
			_c = _c + [25];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['IR_Strobe_Marker'];
			_c = _c + [35];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShell'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellRed'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellGreen'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellBlue'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellYellow'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellOrange'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellPurple'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareWhite_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareYellow_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareGreen_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareRed_M203'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_M203'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_Smoke_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeRed_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeGreen_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SmokeYellow_M203'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Mine'];
			_c = _c + [40];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PipeBomb'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v1'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v2'];
			_c = _c + [100];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v3'];
			_c = _c + [150];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v4'];
			_c = _c + [200];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['Binocular'];
			_c = _c + [10];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['NVGoggles'];
			_c = _c + [20];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Binocular_Vector'];
			_c = _c + [50];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['ItemCompass'];
			_c = _c + [4];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemGPS'];
			_c = _c + [25];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemMap'];
			_c = _c + [6];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemRadio'];
			_c = _c + [15];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemWatch'];
			_c = _c + [5];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_curType = _t select _u;
				if (_curType == 'Special' || _curType == 'Item') then {_curType = 'CfgWeapons'};
				_p = _p + [getText(configFile >> _curType >> _x >> 'picture')];
				_d = _d + [getText(configFile >> _curType >> _x >> 'displayName')];
				if (_curType == 'CfgMagazines') then {
					_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
				} else {
					_s = _s + [1];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['miscClasses',_w];
			WF_Logic setVariable ['miscCosts',_c];
			WF_Logic setVariable ['miscPictures',_p];
			WF_Logic setVariable ['miscSpaces',_s];
			WF_Logic setVariable ['miscNames',_d];
			WF_Logic setVariable ['miscTypes',_t];
			WF_Logic setVariable ['miscMain',_r];
			WF_Logic setVariable ['miscUpgrades',_l];
			WF_Logic setVariable ['miscAllowed',_b];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'picture')];
			_t = [['SCAR_L_CQC','Colt1911']];
			_m = [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'HandGrenade_West','HandGrenade_West','SmokeShellBlue','SmokeShellBlue','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = [['Binocular']];
			_i = [_items];
			_l = [0];
			_b = [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M16A4_GL' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M16A4_GL' >> 'picture')];
			_t = _t + [['M16A4_GL']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203',
				'1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'G36C_camo' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M136' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'G36C_camo' >> 'picture')];
			_t = _t + [['G36C_camo','M136']];
			_m = _m + [['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_STD_EGLM_Spect' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MAAWS' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_STD_EGLM_Spect' >> 'picture')];
			_t = _t + [['SCAR_H_STD_EGLM_Spect','MAAWS']];
			_m = _m + [['20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','20rnd_762x51_B_SCAR','MAAWS_HEAT',
				'MAAWS_HEAT','MAAWS_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MAAWS' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'picture')];
			_t = _t + [['SCAR_L_STD_HOLO','MAAWS','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M4A3_CCO_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Javelin' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M4A3_CCO_EP1' >> 'picture')];
			_t = _t + [['M4A3_CCO_EP1','Javelin','Colt1911']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Javelin',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_Mk4CQT' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Stinger' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_Mk4CQT' >> 'picture')];
			_t = _t + [['SCAR_L_STD_Mk4CQT','Stinger','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Stinger',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'Mine' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','Mine','Mine','Mine',
				'15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9','15Rnd_9x19_M9']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_CQC_CCO_SD' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'PipeBomb' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_H_CQC_CCO_SD' >> 'picture')];
			_t = _t + [['SCAR_H_CQC_CCO_SD','M9SD']];
			_m = _m + [['20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','PipeBomb','PipeBomb','PipeBomb',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'm240_scoped_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'm240_scoped_EP1' >> 'picture')];
			_t = _t + [['m240_scoped_EP1','Colt1911']];
			_m = _m + [['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','SmokeShellRed','SmokeShellRed','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M249_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M249_EP1' >> 'picture')];
			_t = _t + [['M249_EP1','Colt1911']];
			_m = _m + [['200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','200Rnd_556x45_M249','SmokeShellRed','SmokeShellRed','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M14_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M14_EP1' >> 'picture')];
			_t = _t + [['M14_EP1','M9SD']];
			_m = _m + [['20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR',
				'20Rnd_762x51_DMR','20Rnd_762x51_DMR','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];
			
			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'M110_TWS_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Laserdesignator' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'M110_TWS_EP1' >> 'picture')];
			_t = _t + [['M110_TWS_EP1','Laserdesignator','M9SD']];
			_m = _m + [['20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR',
				'20Rnd_762x51_B_SCAR','20Rnd_762x51_B_SCAR','HandGrenade_West','Laserbatteries','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'm107_TWS_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9SD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'm107_TWS_EP1' >> 'picture')];
			_t = _t + [['m107_TWS_EP1','M9SD']];
			_m = _m + [['10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107','10Rnd_127x99_m107',
				'10Rnd_127x99_m107','10Rnd_127x99_m107','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD',
				'15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			_primary = WF_Logic getVariable 'primaryClasses';
			_primaryCosts = WF_Logic getVariable 'primaryCosts';
			_secondary = WF_Logic getVariable 'secondaryClasses';
			_secondaryCosts = WF_Logic getVariable 'secondaryCosts';
			_sidearm = WF_Logic getVariable 'sidearmClasses';
			_sidearmCosts = WF_Logic getVariable 'sidearmCosts';
			_misc = WF_Logic getVariable 'miscClasses';
			_miscCosts = WF_Logic getVariable 'miscCosts';
			_magazine = WF_Logic getVariable 'magazineClasses';
			_magazineCosts = WF_Logic getVariable 'magazineCosts';

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_index = _primary find _x;
					if (_index != -1) then {_cost = _cost + (_primaryCosts select _index)};
					_index = _secondary find _x;
					if (_index != -1) then {_cost = _cost + (_secondaryCosts select _index)};
					_index = _sidearm find _x;
					if (_index != -1) then {_cost = _cost + (_sidearmCosts select _index)};
				} forEach (_t select _count);
				
				{
					_index = _magazine find _x;
					if (_index != -1) then {_cost = _cost + (_magazineCosts select _index)};
					_index = _misc find _x;
					if (_index != -1) then {_cost = _cost + (_miscCosts select _index)};
				} forEach ((_m select _count) + (_s select _count) + (_i select _count));
				
				_c = _c + [_cost];
			};
			WF_Logic setVariable ['templateClasses',_t];
			WF_Logic setVariable ['templateNames',_d];
			WF_Logic setVariable ['templateCosts',_c];
			WF_Logic setVariable ['templatePictures',_p];
			WF_Logic setVariable ['templateMags',_m];
			WF_Logic setVariable ['templateItems',_i];
			WF_Logic setVariable ['templateSpecs',_s];
			WF_Logic setVariable ['templateUpgrades',_l];
			WF_Logic setVariable ['templateAllowed',_b];
		};
	};

	['WFBE_WESTDEFAULTWEAPONS',['m16a4','ItemCompass','ItemMap','ItemWatch','ItemRadio'],true] Call SetNamespace;
	['WFBE_WESTDEFAULTAMMO',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','HandGrenade_West','HandGrenade_West'],true] Call SetNamespace;

	if (isServer) then {
		//--- AI Leaders Loadouts.
		//--- Upgrade 0.
		['WFBE_WESTLEADERWEAPONS01',['SCAR_L_CQC','M136','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO01',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS02',['G36C_camo','M136','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO02',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS03',['m240_scoped_EP1','Colt1911','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;;
		['WFBE_WESTLEADERAMMO03',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 1.
		['WFBE_WESTLEADERWEAPONS11',['M4A3_CCO_EP1','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO11',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS12',['G36K_camo','M136','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO12',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','M136','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS13',['M14_EP1','M9SD','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO13',['20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','20Rnd_762x51_DMR','HandGrenade_West','HandGrenade_West','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD','15Rnd_9x19_M9SD'],true] Call SetNamespace;
		//--- Upgrade 2.
		['WFBE_WESTLEADERWEAPONS21',['SCAR_L_STD_HOLO','MAAWS','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO21',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS22',['G36C_camo','MAAWS','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO22',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS23',['MG36_camo','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO23',['100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_WESTLEADERWEAPONS31',['SCAR_L_CQC_EGLM_Holo','MAAWS','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO31',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','MAAWS_HEDP','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS32',['SCAR_H_STD_EGLM_Spect','Javelin','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO32',['20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','20rnd_762x51_SB_SCAR','Javelin','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS33',['Mk_48_DES_EP1','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO33',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
	};




	//*** EAST ***//
	if (!isServer || local player) then {
		if (side player == EAST) then {

			//--- Magazines.

			_m = ["30Rnd_762x39_AK47"];
			_c = [5];
			_r = [false];
			_t = ['primary'];
			_l = [0];
			_b = [true];

			_m = _m + ["30Rnd_556x45_StanagSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_556x45_Stanag"];
			_c = _c + [5];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];			
			
			_m = _m + ["20Rnd_762x51_DMR"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5Rnd_127x99_as50"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [1];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_762x51_M240"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["100Rnd_556x45_M249"];
			_c = _c + [11];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];		
			
			_m = _m + ["200Rnd_556x45_M249"];
			_c = _c + [22];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["6Rnd_HE_M203"];
			_c = _c + [35];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareWhite_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareGreen_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareRed_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_FlareYellow_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_Smoke_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeRed_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeGreen_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["6Rnd_SmokeYellow_M203"];
			_c = _c + [25];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["30Rnd_545x39_AK"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5Rnd_86x70_L115A1"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["200Rnd_556x45_L110A1"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["200Rnd_762x54_GPMG"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["10Rnd_127x99_m107"];
			_c = _c + [18];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5x_22_LR_17_HMR"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["30Rnd_545x39_AKSD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["30Rnd_9x19_MP5"];
			_c = _c + [3];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_MP5SD"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["17Rnd_9x19_glock17"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_UZI"];
			_c = _c + [4];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_9x19_UZI_SD"];
			_c = _c + [7];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["64Rnd_9x19_Bizon"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["64Rnd_9x19_SD_Bizon"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["20Rnd_9x39_SP5_VSS"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["10Rnd_9x39_SP5_VSS"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_B_Saiga12_74Slug"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["20Rnd_762x51_DMR"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["100Rnd_762x54_PK"];
			_c = _c + [12];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["75Rnd_545x39_RPK"];
			_c = _c + [9];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["100Rnd_556x45_M249"];
			_c = _c + [11];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];		
			
			_m = _m + ["200Rnd_556x45_M249"];
			_c = _c + [22];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["20rnd_762x51_SB_SCAR"];
			_c = _c + [8];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["10Rnd_762x54_SVD"];
			_c = _c + [7];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["5Rnd_127x108_KSVK"];
			_c = _c + [15];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["10x_303"];
			_c = _c + [2];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["30Rnd_762x39_SA58"];
			_c = _c + [6];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];
			
			_m = _m + ["20Rnd_762x51_FNFAL"];
			_c = _c + [4];
			_r = _r + [false];
			_t = _t + ['primary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["OG7"];
			_c = _c + [100];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];

			_m = _m + ["PG7VL"];
			_c = _c + [125];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [true];

			_m = _m + ["PG7VR"];
			_c = _c + [150];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];	

			_m = _m + ["NLAW"];
			_c = _c + [400];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [false];

			_m = _m + ["RPG18"];
			_c = _c + [50];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["AT13"];
			_c = _c + [500];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [3];
			_b = _b + [false];

			_m = _m + ["Dragon_EP1"];
			_c = _c + [300];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [true];

			_m = _m + ["Igla"];
			_c = _c + [400];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];

			_m = _m + ["Strela"];
			_c = _c + [300];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [2];
			_b = _b + [false];

			_m = _m + ["Laserbatteries"];
			_c = _c + [20];
			_r = _r + [false];
			_t = _t + ['secondary'];
			_l = _l + [1];
			_b = _b + [true];

			_m = _m + ["6Rnd_45ACP"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_9x18_Makarov"];
			_c = _c + [2];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["8Rnd_9x18_MakarovSD"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["10Rnd_B_765x17_Ball"];
			_c = _c + [3];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_m = _m + ["20Rnd_B_765x17_Ball"];
			_c = _c + [4];
			_r = _r + [true];
			_t = _t + ['sidearm'];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];

			{
				_p = _p + [getText(configFile >> 'CfgMagazines' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgMagazines' >> _x >> 'displayName')];
				_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
			} forEach _m;

			WF_Logic setVariable ['magazineClasses',_m];
			WF_Logic setVariable ['magazineCosts',_c];
			WF_Logic setVariable ['magazinePictures',_p];
			WF_Logic setVariable ['magazineNames',_d];
			WF_Logic setVariable ['magazineSpaces',_s];
			WF_Logic setVariable ['magazineMain',_r];
			WF_Logic setVariable ['magazineTypes',_t];
			WF_Logic setVariable ['magazineUpgrades',_l];
			WF_Logic setVariable ['magazineAllowed',_b];

			_magazinesT = _m;
			
			//--- SHOTGUNS
			
			_w = ['Saiga12K'];
			_c = [100];
			_a = [true];
			_l = [0];
			_b = [true];
					
			//--- SUBMACHINEGUNS
			
			_w = _w + ['Bizon'];
			_c = _c + [110];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['bizon_silenced'];
			_c = _c + [155];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			//--- AK 74

			_w = _w + ['AKS_74_U'];
			_c = _c + [120];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['AK_74'];
			_c = _c + [130];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['AK_74_GL'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_UN_kobra'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_kobra'];
			_c = _c + [220];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['AK_74_GL_kobra'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_pso'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_NSPU'];
			_c = _c + [275];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['AKS_74_GOSHAWK'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			//--- AK 47
			
			_w = _w + ['AK_47_S'];
			_c = _c + [140];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AKS_GOLD'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['AK_47_M'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			//--- AK 107
			
			_w = _w + ['AK_107_kobra'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['AK_107_pso'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
		
			_w = _w + ['AK_107_GL_kobra'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['AK_107_GL_pso'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			//--- FOREIGN
			
			_w = _w + ['Sa58V_EP1'];
			_c = _c + [160];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['Sa58P_EP1'];
			_c = _c + [175];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Sa58V_CCO_EP1'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['Sa58V_RCO_EP1'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['FN_FAL'];
			_c = _c + [150];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FN_FAL_ANPVS4'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_RIS_Holo'];
			_c = _c + [220];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_RIS_SUSAT'];
			_c = _c + [230];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_RIS_ACOG'];
			_c = _c + [240];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_L86A2_ACOG'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_UGL_Holo'];
			_c = _c + [275];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_UGL_SUSAT'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_UGL_ACOG'];
			_c = _c + [310];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['BAF_L85A2_RIS_CWS'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];			

			
			//--- MACHINE GUNS
			
			_w = _w + ['RPK_74'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['PK'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['BAF_L7A2_GPMG'];
			_c = _c + [325];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Pecheneg'];
			_c = _c + [350];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];	

			_w = _w + ['BAF_L110A1_Aim'];
			_c = _c + [375];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			//--- SNIPER RIFLES
						
						
			_w = _w + ['LeeEnfield'];
			_c = _c + [100];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['Huntingrifle'];
			_c = _c + [125];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['M14_EP1'];
			_c = _c + [185];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['BAF_LRR_scoped_W'];
			_c = _c + [220];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['BAF_LRR_scoped'];
			_c = _c + [225];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
							
			_w = _w + ['SVD'];
			_c = _c + [250];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
		
			_w = _w + ['SVD_des_EP1'];
			_c = _c + [255];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['SVD_NSPU_EP1'];
			_c = _c + [280];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['VSS_vintorez'];
			_c = _c + [275];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['DMR'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];
			
			_w = _w + ['BAF_AS50_scoped'];
			_c = _c + [350];
			_a = _a + [['5Rnd_127x99_as50']];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['KSVK'];
			_c = _c + [400];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['BAF_AS50_TWS'];
			_c = _c + [500];
			_a = _a + [['5Rnd_127x99_as50']];
			_l = _l + [3];
			_b = _b + [true];		
		
			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['primaryClasses',_w];
			WF_Logic setVariable ['primaryCosts',_c];
			WF_Logic setVariable ['primaryPictures',_p];
			WF_Logic setVariable ['primaryNames',_d];
			WF_Logic setVariable ['primaryMagazines',_s];
			WF_Logic setVariable ['primaryUpgrades',_l];
			WF_Logic setVariable ['primaryAllowed',_b];

			//--- Secondary.

			_w = ['RPG18'];
			_c = [100];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['RPG7V'];
			_c = _c + [200];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['M47Launcher_EP1'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['BAF_NLAW_Launcher'];
			_c = _c + [400];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['MetisLauncher'];
			_c = _c + [750];
			_a = _a + [true];
			_l = _l + [3];
			_b = _b + [false];

			_w = _w + ['Strela'];
			_c = _c + [450];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Igla'];
			_c = _c + [500];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [false];

			_w = _w + ['Laserdesignator'];
			_c = _c + [300];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['secondaryClasses',_w];
			WF_Logic setVariable ['secondaryCosts',_c];
			WF_Logic setVariable ['secondaryPictures',_p];
			WF_Logic setVariable ['secondaryNames',_d];
			WF_Logic setVariable ['secondaryMagazines',_s];
			WF_Logic setVariable ['secondaryUpgrades',_l];
			WF_Logic setVariable ['secondaryAllowed',_b];

			//--- Sidearms.

			_w = ['Makarov'];
			_c = [8];
			_a = [true];
			_l = [0];
			_b = [true];

			_w = _w + ['revolver_EP1'];
			_c = _c + [10];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['revolver_gold_EP1'];
			_c = _c + [100];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['MakarovSD'];
			_c = _c + [15];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['Sa61_EP1'];
			_c = _c + [25];
			_a = _a + [true];
			_l = _l + [0];
			_b = _b + [true];
			
			_w = _w + ['UZI_EP1'];
			_c = _c + [55];
			_a = _a + [true];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['UZI_SD_EP1'];
			_c = _c + [65];
			_a = _a + [true];
			_l = _l + [2];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_p = _p + [getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];
				_d = _d + [getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];
				//--- Custom override, nested array.
				if (typeName(_a select _u) == 'BOOL') then {
					_tm = getArray(configFile >> 'CfgWeapons' >> _x >> 'magazines');
					_artm = _tm;
					{
						if (!(_x in _magazinesT)) then {_artm = _artm - [_x]};
					} forEach _tm;
					_s = _s + [_artm];
				} else {
					_s = _s + [_a select _u];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['sidearmClasses',_w];
			WF_Logic setVariable ['sidearmCosts',_c];
			WF_Logic setVariable ['sidearmPictures',_p];
			WF_Logic setVariable ['sidearmNames',_d];
			WF_Logic setVariable ['sidearmMagazines',_s];
			WF_Logic setVariable ['sidearmUpgrades',_l];
			WF_Logic setVariable ['sidearmAllowed',_b];

			//--- Misc.
			
			_w = ['HandGrenade_East'];
			_c = [10];
			_t = ['CfgMagazines'];
			_r = [false];
			_l = [0];
			_b = [true];

			_w = _w + ['HandGrenade_Stone'];
			_c = _c + [2];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShell'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellRed'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellGreen'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellBlue'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellYellow'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellOrange'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['SmokeShellPurple'];
			_c = _c + [8];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareWhite_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareYellow_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareGreen_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['FlareRed_GP25'];
			_c = _c + [9];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_M203'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_HE_GP25'];
			_c = _c + [15];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKE_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKERED_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKEGREEN_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['1Rnd_SMOKEYELLOW_GP25'];
			_c = _c + [12];
			_t = _t + ['CfgMagazines'];
			_r = _r + [true];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['MineE'];
			_c = _c + [40];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['PipeBomb'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v1'];
			_c = _c + [50];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v2'];
			_c = _c + [100];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v3'];
			_c = _c + [150];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [2];
			_b = _b + [true];

			_w = _w + ['BAF_ied_v4'];
			_c = _c + [200];
			_t = _t + ['CfgMagazines'];
			_r = _r + [false];
			_l = _l + [3];
			_b = _b + [true];

			_w = _w + ['Binocular'];
			_c = _c + [10];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['NVGoggles'];
			_c = _c + [20];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];
			
			_w = _w + ['Binocular_Vector'];
			_c = _c + [50];
			_t = _t + ['Special'];
			_r = _r + [false];
			_l = _l + [1];
			_b = _b + [true];

			_w = _w + ['ItemCompass'];
			_c = _c + [4];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemGPS'];
			_c = _c + [25];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemMap'];
			_c = _c + [6];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemRadio'];
			_c = _c + [15];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_w = _w + ['ItemWatch'];
			_c = _c + [5];
			_t = _t + ['Item'];
			_r = _r + [false];
			_l = _l + [0];
			_b = _b + [true];

			_p = [];
			_d = [];
			_s = [];
			_u = 0;

			{
				_curType = _t select _u;
				if (_curType == 'Special' || _curType == 'Item') then {_curType = 'CfgWeapons'};
				_p = _p + [getText(configFile >> _curType >> _x >> 'picture')];
				_d = _d + [getText(configFile >> _curType >> _x >> 'displayName')];
				if (_curType == 'CfgMagazines') then {
					_s = _s + [ceil(getNumber(configFile >> 'CfgMagazines' >> _x >> 'type') / 256)];
				} else {
					_s = _s + [1];
				};
				_u = _u + 1;
			} forEach _w;

			WF_Logic setVariable ['miscClasses',_w];
			WF_Logic setVariable ['miscCosts',_c];
			WF_Logic setVariable ['miscPictures',_p];
			WF_Logic setVariable ['miscSpaces',_s];
			WF_Logic setVariable ['miscNames',_d];
			WF_Logic setVariable ['miscTypes',_t];
			WF_Logic setVariable ['miscMain',_r];
			WF_Logic setVariable ['miscUpgrades',_l];
			WF_Logic setVariable ['miscAllowed',_b];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'picture')];
			_t = [['AK_107_kobra','Makarov']];
			_m = [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'HandGrenade_East','HandGrenade_East','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = [['Binocular']];
			_i = [_items];
			_l = [0];
			_b = [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_GL_kobra' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_GL_kobra' >> 'picture')];
			_t = _t + [['AK_107_GL_kobra']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK',
				'30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','HandGrenade_East','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25',
				'1Rnd_HE_GP25','1Rnd_HE_GP25']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_pso' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_pso' >> 'picture')];
			_t = _t + [['AK_107_pso','RPG7V']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_74_GL' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_74_GL' >> 'picture')];
			_t = _t + [['AK_74_GL','RPG7V']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7V',
				'PG7V','PG7V','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'Sa58V_RCO_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'RPG7V' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'Sa58V_RCO_EP1' >> 'picture')];
			_t = _t + [['Sa58V_RCO_EP1','RPG7V','Makarov']];
			_m = _m + [['30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','PG7VL','PG7VL','PG7VL',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [1];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MetisLauncher' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_kobra' >> 'picture')];
			_t = _t + [['AKS_74_kobra','MetisLauncher','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','AT13',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Igla' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AK_107_kobra' >> 'picture')];
			_t = _t + [['AK_107_kobra','Igla','Makarov']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','Igla',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'bizon_silenced' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'MineE' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'bizon_silenced' >> 'picture')];
			_t = _t + [['bizon_silenced','Makarov']];
			_m = _m + [['64Rnd_9x19_SD_Bizon','64Rnd_9x19_SD_Bizon','64Rnd_9x19_SD_Bizon','64Rnd_9x19_SD_Bizon','64Rnd_9x19_SD_Bizon','64Rnd_9x19_SD_Bizon','MineE','MineE','MineE',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_GOSHAWK' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName') + '/' + getText(configFile >> 'CfgMagazines' >> 'PipeBomb' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'AKS_74_GOSHAWK' >> 'picture')];
			_t = _t + [['AKS_74_GOSHAWK','MakarovSD']];
			_m = _m + [['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PipeBomb','PipeBomb','PipeBomb',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'PK' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Makarov' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'PK' >> 'picture')];
			_t = _t + [['PK','Makarov']];
			_m = _m + [['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','SmokeShellBlue','SmokeShellBlue','8Rnd_9x18_Makarov',
				'8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SVD_des_EP1' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SVD_des_EP1' >> 'picture')];
			_t = _t + [['SVD_des_EP1','MakarovSD']];
			_m = _m + [['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD',
				'10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular_Vector']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'VSS_vintorez' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Laserdesignator' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'VSS_vintorez' >> 'picture')];
			_t = _t + [['VSS_vintorez','Laserdesignator','MakarovSD']];
			_m = _m + [['20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS',
				'20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','HandGrenade_East','Laserbatteries','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [2];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'ksvk' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MakarovSD' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'ksvk' >> 'picture')];
			_t = _t + [['ksvk','MakarovSD']];
			_m = _m + [['5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','5Rnd_127x108_KSVK',
				'5Rnd_127x108_KSVK','5Rnd_127x108_KSVK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD',
				'8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD']];
			_s = _s + [['Binocular_Vector','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			_primary = WF_Logic getVariable 'primaryClasses';
			_primaryCosts = WF_Logic getVariable 'primaryCosts';
			_secondary = WF_Logic getVariable 'secondaryClasses';
			_secondaryCosts = WF_Logic getVariable 'secondaryCosts';
			_sidearm = WF_Logic getVariable 'sidearmClasses';
			_sidearmCosts = WF_Logic getVariable 'sidearmCosts';
			_misc = WF_Logic getVariable 'miscClasses';
			_miscCosts = WF_Logic getVariable 'miscCosts';
			_magazine = WF_Logic getVariable 'magazineClasses';
			_magazineCosts = WF_Logic getVariable 'magazineCosts';

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_index = _primary find _x;
					if (_index != -1) then {_cost = _cost + (_primaryCosts select _index)};
					_index = _secondary find _x;
					if (_index != -1) then {_cost = _cost + (_secondaryCosts select _index)};
					_index = _sidearm find _x;
					if (_index != -1) then {_cost = _cost + (_sidearmCosts select _index)};
				} forEach (_t select _count);
				
				{
					_index = _magazine find _x;
					if (_index != -1) then {_cost = _cost + (_magazineCosts select _index)};
					_index = _misc find _x;
					if (_index != -1) then {_cost = _cost + (_miscCosts select _index)};
				} forEach ((_m select _count) + (_s select _count) + (_i select _count));
				
				_c = _c + [_cost];
			};
			WF_Logic setVariable ['templateClasses',_t];
			WF_Logic setVariable ['templateNames',_d];
			WF_Logic setVariable ['templateCosts',_c];
			WF_Logic setVariable ['templatePictures',_p];
			WF_Logic setVariable ['templateMags',_m];
			WF_Logic setVariable ['templateItems',_i];
			WF_Logic setVariable ['templateSpecs',_s];
			WF_Logic setVariable ['templateUpgrades',_l];
			WF_Logic setVariable ['templateAllowed',_b];
		};
	};

	['WFBE_EASTDEFAULTWEAPONS',['AK_107_kobra','ItemCompass','ItemMap','ItemWatch','ItemRadio'],true] Call SetNamespace;
	['WFBE_EASTDEFAULTAMMO',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','HandGrenade_East','HandGrenade_East'],true] Call SetNamespace;

	if (isServer) then {
		//--- AI Leaders Loadouts.
		//--- Upgrade 0.
		['WFBE_EASTLEADERWEAPONS01',['AKS_74','RPG7V','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO01',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS02',['AK_107_kobra','RPG7V','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO02',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS03',['PK','Makarov','Binocular','ItemRadio','ItemMap'],true] Call SetNamespace;;
		['WFBE_EASTLEADERAMMO03',['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		//--- Upgrade 1.
		['WFBE_EASTLEADERWEAPONS11',['AKS_74_GOSHAWK','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO11',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS12',['RPK_74','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO12',['75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','75Rnd_545x39_RPK','PG7VL','PG7VL','PG7VR','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS13',['SVD','MakarovSD','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO13',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','HandGrenade_East','HandGrenade_East','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD','8Rnd_9x18_MakarovSD'],true] Call SetNamespace;
		//--- Upgrade 2.
		['WFBE_EASTLEADERWEAPONS21',['AK_107_pso','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO21',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS22',['SVD_des_EP1','RPG7V','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO22',['10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','10Rnd_762x54_SVD','PG7VL','PG7VL','PG7VL','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS23',['Pecheneg','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO23',['100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','100Rnd_762x54_PK','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_EASTLEADERWEAPONS31',['AK_107_GL_pso','RPG7V','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO31',['30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','30Rnd_545x39_AK','PG7VL','PG7VL','PG7VL','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25','1Rnd_HE_GP25'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS32',['Sa58V_RCO_EP1','MetisLauncher','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO32',['30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','30Rnd_762x39_SA58','AT13','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
		['WFBE_EASTLEADERWEAPONS33',['VSS_vintorez','Makarov','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_EASTLEADERAMMO33',['20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','20Rnd_9x39_SP5_VSS','HandGrenade_East','HandGrenade_East','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov','8Rnd_9x18_Makarov'],true] Call SetNamespace;
	};
};