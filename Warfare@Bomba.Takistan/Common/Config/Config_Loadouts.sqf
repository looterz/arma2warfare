/*
	New loadout system. | Hybrid
	  Only one side gear is defined at a time. west don't know east and vice versa.
*/

/* Backpacks */
//--- ADD OPFOR STATICS!
['WFBE_BACKPACKS',
 ['US_UAV_Pack_EP1','US_Assault_Pack_EP1','US_Assault_Pack_Ammo_EP1','US_Assault_Pack_AmmoSAW_EP1','US_Assault_Pack_AT_EP1','US_Assault_Pack_Explosives_EP1','US_Patrol_Pack_EP1',
 'US_Patrol_Pack_Ammo_EP1','US_Patrol_Pack_Specops_EP1','US_Backpack_EP1','US_Backpack_AmmoMG_EP1','US_Backpack_AT_EP1','US_Backpack_Specops_EP1','DE_Backpack_Specops_EP1',
 'CZ_Backpack_EP1','CZ_Backpack_Ammo_EP1','CZ_Backpack_Specops_EP1','CZ_Backpack_AmmoMG_EP1','CZ_VestPouch_EP1','CZ_VestPouch_Sa58_EP1','CZ_VestPouch_M4_EP1',
 'TK_RPG_Backpack_EP1','TK_ALICE_Pack_EP1','TK_ALICE_Pack_Explosives_EP1','TK_ALICE_Pack_AmmoMG_EP1','TKA_ALICE_Pack_Ammo_EP1','TKG_ALICE_Pack_AmmoAK47_EP1','TKG_ALICE_Pack_AmmoAK74_EP1',
 'TK_Assault_Pack_EP1','TK_Assault_Pack_RPK_EP1','TKA_Assault_Pack_Ammo_EP1','Tripod_Bag','M2HD_mini_TriPod_US_Bag_EP1','M2StaticMG_US_Bag_EP1','MK19_TriPod_US_Bag_EP1',
 'TOW_TriPod_US_Bag_EP1','M252_US_Bag_EP1','BAF_AssaultPack_ARAmmo','BAF_AssaultPack_MGAmmo','BAF_AssaultPack_ATAmmo','BAF_AssaultPack_HATAmmo','BAF_AssaultPack_Special',
 'BAF_AssaultPack_FAC','BAF_AssaultPack_HAAAmmo','BAF_AssaultPack_LRRAmmo','BAF_AssaultPack_RifleAmmo','BAF_L2A1_ACOG_minitripod_bag','BAF_L2A1_ACOG_tripod_bag',
 'BAF_GPMG_Minitripod_D_bag','BAF_GMG_ACOG_minitripod_bag','KORD_TK_Bag_EP1','KORD_high_TK_Bag_EP1','SPG9_TK_INS_Bag_EP1','AGS_TK_Bag_EP1','Metis_TK_Bag_EP1','2b14_82mm_TK_Bag_EP1'
 ]
,true] Call SetNamespace;

/* Vanilla */
if (WF_A2_Vanilla) then {
	//*** WEST ***//
	if (!isServer || local player) then {
	
		['WFBE_BINOCULARS',['Binocular'],true] Call SetNamespace;
		
		if (side player == WEST) then {
			/* Magazines. */
			_m = ["30Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_556x45_StanagSD"];
			_m = _m + ["20Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_556x45_G36"];
			_m = _m + ["30Rnd_556x45_G36SD"];
			_m = _m + ["100Rnd_556x45_BetaCMag"];
			_m = _m + ["5Rnd_762x51_M24"];
			_m = _m + ["20Rnd_762x51_DMR"];
			_m = _m + ["10Rnd_127x99_m107"];
			_m = _m + ["100Rnd_762x51_M240"];
			_m = _m + ["200Rnd_556x45_M249"];
			_m = _m + ["30Rnd_9x19_MP5"];
			_m = _m + ["30Rnd_9x19_MP5SD"];
			_m = _m + ["8Rnd_B_Beneli_74Slug"];
			_m = _m + ["M136"];
			_m = _m + ["SMAW_HEAA"];
			_m = _m + ["SMAW_HEDP"];
			_m = _m + ["Javelin"];
			_m = _m + ["Stinger"];
			_m = _m + ["Laserbatteries"];
			_m = _m + ["15Rnd_9x19_M9"];
			_m = _m + ["15Rnd_9x19_M9SD"];
			_m = _m + ["7Rnd_45ACP_1911"];

			WF_Logic setVariable ['magazineClasses',_m];

			/* Primary. */
			_w = ['M16A2'];
			_w = _w + ['M16A2GL'];
			_w = _w + ['m16a4'];
			_w = _w + ['m16a4_acg'];
			_w = _w + ['M16A4_GL'];
			_w = _w + ['M16A4_ACG_GL'];
			_w = _w + ['M24'];
			_w = _w + ['M40A3'];
			_w = _w + ['M240'];
			_w = _w + ['Mk_48'];
			_w = _w + ['M249'];
			_w = _w + ['M4A1'];
			_w = _w + ['M4A1_Aim'];
			_w = _w + ['M4A1_Aim_camo'];
			_w = _w + ['M4SPR'];
			_w = _w + ['M4A1_RCO_GL'];
			_w = _w + ['M4A1_AIM_SD_camo'];
			_w = _w + ['M4A1_HWS_GL_SD_Camo'];
			_w = _w + ['M4A1_HWS_GL'];
			_w = _w + ['M4A1_HWS_GL_camo'];
			_w = _w + ['MP5SD'];
			_w = _w + ['MP5A5'];
			_w = _w + ['G36C'];
			_w = _w + ['G36_C_SD_eotech'];
			_w = _w + ['G36a'];
			_w = _w + ['G36K'];
			_w = _w + ['MG36'];
			_w = _w + ['DMR'];
			_w = _w + ['M1014'];
			_w = _w + ['m107'];
			_w = _w + ['m8_carbine'];
			_w = _w + ['m8_carbineGL'];
			_w = _w + ['m8_compact'];
			_w = _w + ['m8_sharpshooter'];
			_w = _w + ['m8_SAW'];

			WF_Logic setVariable ['primaryClasses',_w];

			/* Secondary. */
			_w = ['M136'];
			_w = _w + ['SMAW'];
			_w = _w + ['Javelin'];
			_w = _w + ['Stinger'];
			_w = _w + ['Laserdesignator'];

			WF_Logic setVariable ['secondaryClasses',_w];

			/* Sidearms. */
			_w = ['Colt1911'];
			_w = _w + ['M9'];
			_w = _w + ['M9SD'];

			WF_Logic setVariable ['sidearmClasses',_w];

			/* Misc. */
			_w = ['HandGrenade_West'];
			_w = _w + ['HandGrenade_Stone'];
			_w = _w + ['SmokeShell'];
			_w = _w + ['SmokeShellRed'];
			_w = _w + ['SmokeShellGreen'];
			_w = _w + ['SmokeShellBlue'];
			_w = _w + ['SmokeShellYellow'];
			_w = _w + ['SmokeShellOrange'];
			_w = _w + ['SmokeShellPurple'];
			_w = _w + ['FlareWhite_M203'];
			_w = _w + ['FlareYellow_M203'];
			_w = _w + ['FlareGreen_M203'];
			_w = _w + ['FlareRed_M203'];
			_w = _w + ['1Rnd_HE_M203'];
			_w = _w + ['1Rnd_Smoke_M203'];
			_w = _w + ['1Rnd_SmokeRed_M203'];
			_w = _w + ['1Rnd_SmokeGreen_M203'];
			_w = _w + ['1Rnd_SmokeYellow_M203'];
			_w = _w + ['Mine'];
			_w = _w + ['PipeBomb'];
			_w = _w + ['Binocular'];
			_w = _w + ['NVGoggles'];
			_w = _w + ['ItemCompass'];
			_w = _w + ['ItemGPS'];
			_w = _w + ['ItemMap'];
			_w = _w + ['ItemRadio'];
			_w = _w + ['ItemWatch'];
			_w = _w + ['DogtagsLockpick'];
			_w = _w + ['DogtagsMedic'];
			_w = _w + ['DogtagsSaboteur'];
			_w = _w + ['DogtagsEngineer'];
			_w = _w + ['DogtagsCommander'];
			WF_Logic setVariable ['miscClasses',_w];

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

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_get = (_x+"_W") Call GetNamespace;
					if (isNil '_get') then {
						_get = _x Call GetNamespace;
					};
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
				} forEach (_t select _count);
				
				{
					_get = _x Call GetNamespace;
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
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
			/* Magazines. */
			_m = ["30Rnd_762x39_AK47"];
			_m = _m + ["30Rnd_545x39_AK"];
			_m = _m + ["30Rnd_545x39_AKSD"];
			_m = _m + ["64Rnd_9x19_Bizon"];
			_m = _m + ["64Rnd_9x19_SD_Bizon"];
			_m = _m + ["100Rnd_762x54_PK"];
			_m = _m + ["75Rnd_545x39_RPK"];
			_m = _m + ["5x_22_LR_17_HMR"];
			_m = _m + ["10Rnd_762x54_SVD"];
			_m = _m + ["8Rnd_B_Saiga12_74Slug"];
			_m = _m + ["5Rnd_127x108_KSVK"];
			_m = _m + ["10Rnd_9x39_SP5_VSS"];
			_m = _m + ["20Rnd_9x39_SP5_VSS"];
			_m = _m + ["PG7V"];
			_m = _m + ["PG7VL"];
			_m = _m + ["OG7"];
			_m = _m + ["PG7VR"];
			_m = _m + ["RPG18"];
			_m = _m + ["AT13"];
			_m = _m + ["Igla"];
			_m = _m + ["Strela"];
			_m = _m + ["Laserbatteries"];
			_m = _m + ["8Rnd_9x18_Makarov"];
			_m = _m + ["8Rnd_9x18_MakarovSD"];

			WF_Logic setVariable ['magazineClasses',_m];

			/* Primary. */
			_w = ['AK_47_M'];
			_w = _w + ['AK_47_S'];
			_w = _w + ['AK_74'];
			_w = _w + ['AK_74_GL'];
			_w = _w + ['AK_107_kobra'];
			_w = _w + ['AK_107_GL_kobra'];
			_w = _w + ['AK_107_pso'];
			_w = _w + ['AK_107_GL_pso'];
			_w = _w + ['AKS_74_kobra'];
			_w = _w + ['AKS_74_pso'];
			_w = _w + ['AKS_74_U'];
			_w = _w + ['AKS_74_UN_kobra'];
			_w = _w + ['AKS_GOLD'];
			_w = _w + ['bizon'];
			_w = _w + ['bizon_silenced'];
			_w = _w + ['PK'];
			_w = _w + ['Pecheneg'];
			_w = _w + ['RPK_74'];
			_w = _w + ['huntingrifle'];
			_w = _w + ['SVD'];
			_w = _w + ['SVD_CAMO'];
			_w = _w + ['Saiga12K'];
			_w = _w + ['ksvk'];
			_w = _w + ['VSS_vintorez'];

			WF_Logic setVariable ['primaryClasses',_w];

			/* Secondary. */
			_w = ['RPG7V'];
			_w = _w + ['RPG18'];
			_w = _w + ['MetisLauncher'];
			_w = _w + ['Igla'];
			_w = _w + ['Strela'];
			_w = _w + ['Laserdesignator'];

			WF_Logic setVariable ['secondaryClasses',_w];

			/* Sidearms. */

			_w = ['Makarov'];
			_w = _w + ['MakarovSD'];

			WF_Logic setVariable ['sidearmClasses',_w];

			/* Misc. */
			_w = ['HandGrenade_East'];
			_w = _w + ['HandGrenade_Stone'];
			_w = _w + ['SmokeShell'];
			_w = _w + ['SmokeShellRed'];
			_w = _w + ['SmokeShellGreen'];
			_w = _w + ['SmokeShellBlue'];
			_w = _w + ['SmokeShellYellow'];
			_w = _w + ['SmokeShellOrange'];
			_w = _w + ['SmokeShellPurple'];
			_w = _w + ['FlareWhite_GP25'];
			_w = _w + ['FlareYellow_GP25'];
			_w = _w + ['FlareGreen_GP25'];
			_w = _w + ['FlareRed_GP25'];
			_w = _w + ['1Rnd_HE_GP25'];
			_w = _w + ['1Rnd_SMOKE_GP25'];
			_w = _w + ['1Rnd_SMOKERED_GP25'];
			_w = _w + ['1Rnd_SMOKEGREEN_GP25'];
			_w = _w + ['1Rnd_SMOKEYELLOW_GP25'];
			_w = _w + ['MineE'];
			_w = _w + ['PipeBomb'];
			_w = _w + ['Binocular'];
			_w = _w + ['NVGoggles'];
			_w = _w + ['ItemCompass'];
			_w = _w + ['ItemGPS'];
			_w = _w + ['ItemMap'];
			_w = _w + ['ItemRadio'];
			_w = _w + ['ItemWatch'];
			_w = _w + ['DogtagsLockpick'];
			_w = _w + ['DogtagsMedic'];
			_w = _w + ['DogtagsSaboteur'];
			_w = _w + ['DogtagsEngineer'];
			_w = _w + ['DogtagsCommander'];
			
			WF_Logic setVariable ['miscClasses',_w];

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

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_get = (_x+"_W") Call GetNamespace;
					if (isNil '_get') then {
						_get = _x Call GetNamespace;
					};
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
				} forEach (_t select _count);
				
				{
					_get = _x Call GetNamespace;
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
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
			/* Magazines. */
			_m = ["30Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_556x45_StanagSD"];
			_m = _m + ["20Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_556x45_G36"];
			_m = _m + ["30Rnd_556x45_G36SD"];
			_m = _m + ["100Rnd_556x45_BetaCMag"];
			_m = _m + ["5Rnd_762x51_M24"];
			_m = _m + ["20Rnd_762x51_DMR"];
			_m = _m + ["10Rnd_127x99_m107"];
			_m = _m + ["100Rnd_762x51_M240"];
			_m = _m + ["100Rnd_556x45_M249"];
			_m = _m + ["200Rnd_556x45_M249"];
			_m = _m + ["20Rnd_762x51_B_SCAR"];
			_m = _m + ["20Rnd_762x51_SB_SCAR"];
			_m = _m + ["6Rnd_HE_M203"];
			_m = _m + ["6Rnd_FlareWhite_M203"];
			_m = _m + ["6Rnd_FlareGreen_M203"];
			_m = _m + ["6Rnd_FlareRed_M203"];
			_m = _m + ["6Rnd_FlareYellow_M203"];
			_m = _m + ["6Rnd_Smoke_M203"];
			_m = _m + ["6Rnd_SmokeRed_M203"];
			_m = _m + ["6Rnd_SmokeGreen_M203"];
			_m = _m + ["6Rnd_SmokeYellow_M203"];
			_m = _m + ["M136"];
			_m = _m + ["MAAWS_HEAT"];
			_m = _m + ["MAAWS_HEDP"];
			_m = _m + ["Javelin"];
			_m = _m + ["Stinger"];
			_m = _m + ["Laserbatteries"];
			_m = _m + ["15Rnd_9x19_M9"];
			_m = _m + ["15Rnd_9x19_M9SD"];
			_m = _m + ["7Rnd_45ACP_1911"];
			_m = _m + ["17Rnd_9x19_glock17"];

			if (paramDLCBAF) then {
				_m = _m + ["5Rnd_127x99_AS50"];
				_m = _m + ["5Rnd_86x70_L115A1"];
				_m = _m + ["200Rnd_556x45_L110A1"];
				_m = _m + ["NLAW"];
			};

			WF_Logic setVariable ['magazineClasses',_m];

			/* Primary. */
			_w = ['M16A2'];
			_w = _w + ['M16A2GL'];
			_w = _w + ['M24_des_EP1'];
			_w = _w + ['m240_scoped_EP1'];
			_w = _w + ['M60A4_EP1'];
			_w = _w + ['Mk_48_DES_EP1'];
			_w = _w + ['M249_EP1'];
			_w = _w + ['M249_TWS_EP1'];
			_w = _w + ['M249_m145_EP1'];
			_w = _w + ['M4A1'];
			_w = _w + ['M4A3_CCO_EP1'];
			_w = _w + ['M4A3_RCO_GL_EP1'];
			_w = _w + ['G36C_camo'];
			_w = _w + ['G36_C_SD_camo'];
			_w = _w + ['G36A_camo'];
			_w = _w + ['G36K_camo'];
			_w = _w + ['MG36_camo'];
			_w = _w + ['M32_EP1'];
			_w = _w + ['M79_EP1'];
			_w = _w + ['Mk13_EP1'];
			_w = _w + ['M14_EP1'];
			_w = _w + ['m107'];
			_w = _w + ['m107_TWS_EP1'];
			_w = _w + ['M110_TWS_EP1'];
			_w = _w + ['M110_NVG_EP1'];
			_w = _w + ['SCAR_L_CQC'];
			_w = _w + ['SCAR_L_CQC_Holo'];
			_w = _w + ['SCAR_L_STD_Mk4CQT'];
			_w = _w + ['SCAR_L_STD_EGLM_RCO'];
			_w = _w + ['SCAR_L_CQC_EGLM_Holo'];
			_w = _w + ['SCAR_L_STD_EGLM_TWS'];
			_w = _w + ['SCAR_L_STD_HOLO'];
			_w = _w + ['SCAR_H_CQC_CCO'];
			_w = _w + ['SCAR_H_CQC_CCO_SD'];
			_w = _w + ['SCAR_H_STD_EGLM_Spect'];
			_w = _w + ['SCAR_H_LNG_Sniper'];
			_w = _w + ['SCAR_H_LNG_Sniper_SD'];
			_w = _w + ['SCAR_H_STD_TWS_SD'];
			
			if (paramDLCBAF) then {
				_w = _w + ['BAF_AS50_scoped'];
				_w = _w + ['BAF_AS50_TWS'];
				_w = _w + ['BAF_LRR_scoped'];
				_w = _w + ['BAF_LRR_scoped_W'];
				_w = _w + ['BAF_L85A2_RIS_Holo'];
				_w = _w + ['BAF_L85A2_UGL_Holo'];
				_w = _w + ['BAF_L85A2_RIS_SUSAT'];
				_w = _w + ['BAF_L85A2_UGL_SUSAT'];
				_w = _w + ['BAF_L85A2_RIS_ACOG'];
				_w = _w + ['BAF_L85A2_UGL_ACOG'];
				_w = _w + ['BAF_L85A2_RIS_CWS'];
				_w = _w + ['BAF_L86A2_ACOG'];
				_w = _w + ['BAF_L110A1_Aim'];
				_w = _w + ['BAF_L7A2_GPMG'];
			};

			WF_Logic setVariable ['primaryClasses',_w];

			/* Secondary. */

			_w = ['M136'];
			_w = _w + ['MAAWS'];
			
			if (paramDLCBAF) then {
				_w = _w + ['BAF_NLAW_Launcher'];
			};

			_w = _w + ['Javelin'];
			_w = _w + ['Stinger'];
			_w = _w + ['Laserdesignator'];
			
			/* Not all units are able to carry a backpack */
			_get = getNumber(configFile >> 'CfgVehicles' >> typeOf player >> 'canCarryBackPack');
			
			if (_get == 1) then {
				_w = _w + ['US_Assault_Pack_EP1'];
				_w = _w + ['US_Patrol_Pack_EP1'];
				_w = _w + ['US_Backpack_EP1'];
				
				if (paramDLCBAF) then {
					_w = _w + ['BAF_AssaultPack_RifleAmmo'];
				};
				
				_w = _w + ['Tripod_Bag'];
				
				if (paramDLCBAF) then {
					_w = _w + ['BAF_L2A1_ACOG_minitripod_bag'];
					_w = _w + ['BAF_L2A1_ACOG_tripod_bag'];
					_w = _w + ['BAF_GPMG_Minitripod_D_bag'];
					_w = _w + ['BAF_GMG_ACOG_minitripod_bag'];
				};

				_w = _w + ['M2HD_mini_TriPod_US_Bag_EP1'];
				_w = _w + ['M2StaticMG_US_Bag_EP1'];
				_w = _w + ['MK19_TriPod_US_Bag_EP1'];
				_w = _w + ['TOW_TriPod_US_Bag_EP1'];
				_w = _w + ['M252_US_Bag_EP1'];
			};

			WF_Logic setVariable ['secondaryClasses',_w];
			
			/* Sidearm. */
			_w = ['Colt1911'];
			_w = _w + ['M9'];
			_w = _w + ['M9SD'];
			_w = _w + ['glock17_EP1'];

			WF_Logic setVariable ['sidearmClasses',_w];

			/* Misc. */

			_w = ['HandGrenade_West'];
			
			if (paramDLCBAF) then {
				_w = _w + ['BAF_L109A1_HE'];
			};

			_w = _w + ['HandGrenade_Stone'];
			_w = _w + ['IR_Strobe_Target'];
			_w = _w + ['IR_Strobe_Marker'];
			_w = _w + ['SmokeShell'];
			_w = _w + ['SmokeShellRed'];
			_w = _w + ['SmokeShellGreen'];
			_w = _w + ['SmokeShellBlue'];
			_w = _w + ['SmokeShellYellow'];
			_w = _w + ['SmokeShellOrange'];
			_w = _w + ['SmokeShellPurple'];
			_w = _w + ['FlareWhite_M203'];
			_w = _w + ['FlareYellow_M203'];
			_w = _w + ['FlareGreen_M203'];
			_w = _w + ['FlareRed_M203'];
			_w = _w + ['1Rnd_HE_M203'];
			_w = _w + ['1Rnd_Smoke_M203'];
			_w = _w + ['1Rnd_SmokeRed_M203'];
			_w = _w + ['1Rnd_SmokeGreen_M203'];
			_w = _w + ['1Rnd_SmokeYellow_M203'];
			_w = _w + ['Mine'];
			_w = _w + ['PipeBomb'];
			_w = _w + ['Binocular'];
			_w = _w + ['NVGoggles'];
			_w = _w + ['Binocular_Vector'];
			_w = _w + ['ItemCompass'];
			_w = _w + ['ItemGPS'];
			_w = _w + ['ItemMap'];
			_w = _w + ['ItemRadio'];
			_w = _w + ['ItemWatch'];
			_w = _w + ['DogtagsLockpick'];
			_w = _w + ['DogtagsMedic'];
			_w = _w + ['DogtagsSaboteur'];
			_w = _w + ['DogtagsEngineer'];
			_w = _w + ['DogtagsCommander'];
			
			WF_Logic setVariable ['miscClasses',_w];

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
				'MAAWS_HEAT','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MAAWS' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'picture')];
			_t = _t + [['SCAR_L_STD_HOLO','MAAWS','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT',
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
			_m = _m + [['20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','PipeBomb','PipeBomb','PipeBomb',
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

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_get = (_x+"_W") Call GetNamespace;
					if (isNil '_get') then {
						_get = _x Call GetNamespace;
					};
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
				} forEach (_t select _count);
				
				{
					_get = _x Call GetNamespace;
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
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
		['WFBE_WESTLEADERAMMO21',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS22',['G36C_camo','MAAWS','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO22',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','MAAWS_HEAT','MAAWS_HEAT','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS23',['MG36_camo','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO23',['100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_WESTLEADERWEAPONS31',['SCAR_L_CQC_EGLM_Holo','MAAWS','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO31',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS32',['SCAR_H_STD_EGLM_Spect','Javelin','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO32',['20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','Javelin','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS33',['Mk_48_DES_EP1','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO33',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
	};




	//*** EAST ***//
	if (!isServer || local player) then {
		if (side player == EAST) then {
			/* Magazines. */
			_m = ["30Rnd_762x39_AK47"];
			_m = _m + ["30Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_545x39_AK"];
			_m = _m + ["30Rnd_545x39_AKSD"];
			_m = _m + ["100Rnd_762x54_PK"];
			_m = _m + ["75Rnd_545x39_RPK"];
			_m = _m + ["10Rnd_762x54_SVD"];
			_m = _m + ["5Rnd_127x108_KSVK"];
			_m = _m + ["10x_303"];
			_m = _m + ["30Rnd_762x39_SA58"];
			_m = _m + ["20Rnd_762x51_FNFAL"];
			_m = _m + ["PG7V"];
			_m = _m + ["PG7VL"];
			_m = _m + ["OG7"];
			_m = _m + ["PG7VR"];
			_m = _m + ["RPG18"];
			_m = _m + ["Dragon_EP1"];
			_m = _m + ["AT13"];
			_m = _m + ["Igla"];
			_m = _m + ["Strela"];
			_m = _m + ["Laserbatteries"];
			_m = _m + ["6Rnd_45ACP"];
			_m = _m + ["8Rnd_9x18_Makarov"];
			_m = _m + ["8Rnd_9x18_MakarovSD"];
			_m = _m + ["10Rnd_B_765x17_Ball"];
			_m = _m + ["20Rnd_B_765x17_Ball"];
			_m = _m + ["30Rnd_9x19_UZI"];
			_m = _m + ["30Rnd_9x19_UZI_SD"];

			WF_Logic setVariable ['magazineClasses',_m];

			/* Primary. */
			_w = ['AK_47_M'];
			_w = _w + ['AK_47_S'];
			_w = _w + ['M16A2'];
			_w = _w + ['M16A2GL'];
			_w = _w + ['AK_74'];
			_w = _w + ['AK_74_GL'];
			_w = _w + ['AK_74_GL_kobra'];
			_w = _w + ['AKS_74'];
			_w = _w + ['AKS_74_GOSHAWK'];
			_w = _w + ['AKS_74_kobra'];
			_w = _w + ['AKS_74_NSPU'];
			_w = _w + ['AKS_74_pso'];
			_w = _w + ['AKS_74_U'];
			_w = _w + ['FN_FAL'];
			_w = _w + ['FN_FAL_ANPVS4'];
			_w = _w + ['LeeEnfield'];
			_w = _w + ['PK'];
			_w = _w + ['RPK_74'];
			_w = _w + ['Sa58P_EP1'];
			_w = _w + ['Sa58V_EP1'];
			_w = _w + ['Sa58V_RCO_EP1'];
			_w = _w + ['Sa58V_CCO_EP1'];
			_w = _w + ['SVD'];
			_w = _w + ['SVD_des_EP1'];
			_w = _w + ['SVD_NSPU_EP1'];
			_w = _w + ['ksvk'];;

			WF_Logic setVariable ['primaryClasses',_w];

			/* Secondary. */
			_w = ['RPG7V'];
			_w = _w + ['RPG18'];
			_w = _w + ['M47Launcher_EP1'];
			_w = _w + ['MetisLauncher'];
			_w = _w + ['Igla'];
			_w = _w + ['Strela'];
			_w = _w + ['Laserdesignator'];
			
			/* Not all units are able to carry a backpack */
			_get = getNumber(configFile >> 'CfgVehicles' >> typeOf player >> 'canCarryBackPack');
			
			if (_get == 1) then {
				_w = _w + ['TK_Assault_Pack_EP1'];
				_w = _w + ['TK_RPG_Backpack_EP1'];
				_w = _w + ['TK_ALICE_Pack_EP1'];
				_w = _w + ['Tripod_Bag'];
				_w = _w + ['KORD_TK_Bag_EP1'];
				_w = _w + ['KORD_high_TK_Bag_EP1'];
				_w = _w + ['SPG9_TK_INS_Bag_EP1'];
				_w = _w + ['AGS_TK_Bag_EP1'];
				_w = _w + ['Metis_TK_Bag_EP1'];
				_w = _w + ['2b14_82mm_TK_Bag_EP1'];
			};

			WF_Logic setVariable ['secondaryClasses',_w];

			/* Sidearm. */
			_w = ['Makarov'];
			_w = _w + ['revolver_EP1'];
			_w = _w + ['revolver_gold_EP1'];
			_w = _w + ['MakarovSD'];
			_w = _w + ['Sa61_EP1'];
			_w = _w + ['UZI_EP1'];
			_w = _w + ['UZI_SD_EP1'];

			WF_Logic setVariable ['sidearmClasses',_w];

			/* Misc. */
			_w = ['HandGrenade_East'];
			_w = _w + ['HandGrenade_Stone'];
			_w = _w + ['SmokeShell'];
			_w = _w + ['SmokeShellRed'];
			_w = _w + ['SmokeShellGreen'];
			_w = _w + ['SmokeShellBlue'];
			_w = _w + ['SmokeShellYellow'];
			_w = _w + ['SmokeShellOrange'];
			_w = _w + ['SmokeShellPurple'];
			_w = _w + ['FlareWhite_GP25'];
			_w = _w + ['FlareYellow_GP25'];
			_w = _w + ['FlareGreen_GP25'];
			_w = _w + ['FlareRed_GP25'];
			_w = _w + ['1Rnd_HE_M203'];
			_w = _w + ['1Rnd_HE_GP25'];
			_w = _w + ['1Rnd_SMOKE_GP25'];
			_w = _w + ['1Rnd_SMOKERED_GP25'];
			_w = _w + ['1Rnd_SMOKEGREEN_GP25'];
			_w = _w + ['1Rnd_SMOKEYELLOW_GP25'];

			if (paramDLCBAF) then {
				_w = _w + ['BAF_ied_v1'];
				_w = _w + ['BAF_ied_v2'];
				_w = _w + ['BAF_ied_v3'];
				_w = _w + ['BAF_ied_v4'];
			};

			_w = _w + ['MineE'];
			_w = _w + ['PipeBomb'];
			_w = _w + ['Binocular'];
			_w = _w + ['NVGoggles'];
			_w = _w + ['Binocular_Vector'];
			_w = _w + ['ItemCompass'];
			_w = _w + ['ItemGPS'];
			_w = _w + ['ItemMap'];
			_w = _w + ['ItemRadio'];
			_w = _w + ['ItemWatch'];
			_w = _w + ['DogtagsLockpick'];
			_w = _w + ['DogtagsMedic'];
			_w = _w + ['DogtagsSaboteur'];
			_w = _w + ['DogtagsEngineer'];
			_w = _w + ['DogtagsCommander'];
			
			WF_Logic setVariable ['miscClasses',_w];

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
			_s = _s + [['Binocular_Vector','NVGoggles']];
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
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_c = [];
			_totalTemplates = count _d;

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_get = (_x+"_W") Call GetNamespace;
					if (isNil '_get') then {
						_get = _x Call GetNamespace;
					};
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
				} forEach (_t select _count);
				
				{
					_get = _x Call GetNamespace;
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
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
			/* Magazines. */
			_m = ["30Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_556x45_StanagSD"];
			_m = _m + ["20Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_556x45_G36"];
			_m = _m + ["30Rnd_556x45_G36SD"];
			_m = _m + ["100Rnd_556x45_BetaCMag"];
			_m = _m + ["5Rnd_762x51_M24"];
			_m = _m + ["20Rnd_762x51_DMR"];
			_m = _m + ["10Rnd_127x99_m107"];
			_m = _m + ["100Rnd_762x51_M240"];
			_m = _m + ["100Rnd_556x45_M249"];
			_m = _m + ["200Rnd_556x45_M249"];
			_m = _m + ["30Rnd_9x19_MP5"];
			_m = _m + ["30Rnd_9x19_MP5SD"];
			_m = _m + ["8Rnd_B_Beneli_74Slug"];
			_m = _m + ["20Rnd_762x51_B_SCAR"];
			_m = _m + ["20Rnd_762x51_SB_SCAR"];
			_m = _m + ["6Rnd_HE_M203"];
			_m = _m + ["6Rnd_FlareWhite_M203"];
			_m = _m + ["6Rnd_FlareGreen_M203"];
			_m = _m + ["6Rnd_FlareRed_M203"];
			_m = _m + ["6Rnd_FlareYellow_M203"];
			_m = _m + ["6Rnd_Smoke_M203"];
			_m = _m + ["6Rnd_SmokeRed_M203"];
			_m = _m + ["6Rnd_SmokeGreen_M203"];
			_m = _m + ["6Rnd_SmokeYellow_M203"];
			_m = _m + ["M136"];
			_m = _m + ["MAAWS_HEAT"];
			_m = _m + ["MAAWS_HEDP"];
			_m = _m + ["Javelin"];
			_m = _m + ["Stinger"];
			_m = _m + ["Laserbatteries"];
			_m = _m + ["15Rnd_9x19_M9"];
			_m = _m + ["15Rnd_9x19_M9SD"];
			_m = _m + ["7Rnd_45ACP_1911"];
			_m = _m + ["17Rnd_9x19_glock17"];

			if (paramDLCBAF) then {
				_m = _m + ["5Rnd_127x99_AS50"];
				_m = _m + ["5Rnd_86x70_L115A1"];
				_m = _m + ["200Rnd_556x45_L110A1"];
				_m = _m + ["NLAW"];
			};

			WF_Logic setVariable ['magazineClasses',_m];

			/* Primary. */
			_w = ['M16A2'];
			_w = _w + ['M16A2GL'];
			_w = _w + ['m16a4'];
			_w = _w + ['m16a4_acg'];
			_w = _w + ['M16A4_GL'];
			_w = _w + ['M16A4_ACG_GL'];
			_w = _w + ['M24'];
			_w = _w + ['M40A3'];
			_w = _w + ['M24_des_EP1'];
			_w = _w + ['M240'];
			_w = _w + ['m240_scoped_EP1'];
			_w = _w + ['M60A4_EP1'];
			_w = _w + ['Mk_48'];
			_w = _w + ['Mk_48_DES_EP1'];
			_w = _w + ['M249_EP1'];
			_w = _w + ['M249_TWS_EP1'];
			_w = _w + ['M249_m145_EP1'];
			_w = _w + ['M4A1'];
			_w = _w + ['M4A1_Aim'];
			_w = _w + ['M4A1_Aim_camo'];
			_w = _w + ['M4A1_RCO_GL'];
			_w = _w + ['M4A1_AIM_SD_camo'];
			_w = _w + ['M4A1_HWS_GL_SD_Camo'];
			_w = _w + ['M4A1_HWS_GL'];
			_w = _w + ['M4A1_HWS_GL_camo'];
			_w = _w + ['M4SPR'];
			_w = _w + ['M4A3_CCO_EP1'];
			_w = _w + ['M4A3_RCO_GL_EP1'];
			_w = _w + ['MP5SD'];
			_w = _w + ['MP5A5'];
			_w = _w + ['G36C'];
			_w = _w + ['G36C_camo'];
			_w = _w + ['G36_C_SD_eotech'];
			_w = _w + ['G36_C_SD_camo'];
			_w = _w + ['G36a'];
			_w = _w + ['G36A_camo'];
			_w = _w + ['G36K'];
			_w = _w + ['G36K_camo'];
			_w = _w + ['MG36'];
			_w = _w + ['MG36_camo'];
			_w = _w + ['DMR'];
			_w = _w + ['M32_EP1'];
			_w = _w + ['M79_EP1'];
			_w = _w + ['Mk13_EP1'];
			_w = _w + ['M14_EP1'];
			_w = _w + ['m107'];
			_w = _w + ['m107_TWS_EP1'];
			_w = _w + ['M110_TWS_EP1'];
			_w = _w + ['M110_NVG_EP1'];
			_w = _w + ['SCAR_L_CQC'];
			_w = _w + ['SCAR_L_CQC_Holo'];
			_w = _w + ['SCAR_L_STD_Mk4CQT'];
			_w = _w + ['SCAR_L_STD_EGLM_RCO'];
			_w = _w + ['SCAR_L_CQC_EGLM_Holo'];
			_w = _w + ['SCAR_L_STD_EGLM_TWS'];
			_w = _w + ['SCAR_L_STD_HOLO'];
			_w = _w + ['SCAR_H_CQC_CCO'];
			_w = _w + ['SCAR_H_CQC_CCO_SD'];
			_w = _w + ['SCAR_H_STD_EGLM_Spect'];
			_w = _w + ['SCAR_H_LNG_Sniper'];
			_w = _w + ['SCAR_H_LNG_Sniper_SD'];
			_w = _w + ['SCAR_H_STD_TWS_SD'];
			_w = _w + ['m8_carbine'];
			_w = _w + ['m8_carbineGL'];
			_w = _w + ['m8_compact'];
			_w = _w + ['m8_sharpshooter'];
			_w = _w + ['m8_SAW'];
			
			if (paramDLCBAF) then {
				_w = _w + ['BAF_AS50_scoped'];
				_w = _w + ['BAF_AS50_TWS'];
				_w = _w + ['BAF_LRR_scoped'];
				_w = _w + ['BAF_LRR_scoped_W'];
				_w = _w + ['BAF_L85A2_RIS_Holo'];
				_w = _w + ['BAF_L85A2_UGL_Holo'];
				_w = _w + ['BAF_L85A2_RIS_SUSAT'];
				_w = _w + ['BAF_L85A2_UGL_SUSAT'];
				_w = _w + ['BAF_L85A2_RIS_ACOG'];
				_w = _w + ['BAF_L85A2_UGL_ACOG'];
				_w = _w + ['BAF_L85A2_RIS_CWS'];
				_w = _w + ['BAF_L86A2_ACOG'];
				_w = _w + ['BAF_L110A1_Aim'];
				_w = _w + ['BAF_L7A2_GPMG'];
			};

			WF_Logic setVariable ['primaryClasses',_w];

			/* Secondary. */

			_w = ['M136'];
			_w = _w + ['MAAWS'];
			if (paramDLCBAF) then {
				_w = _w + ['BAF_NLAW_Launcher'];
			};
			
			_w = _w + ['Javelin'];
			_w = _w + ['Stinger'];
			_w = _w + ['Laserdesignator'];

			/* Not all units are able to carry a backpack */
			_get = getNumber(configFile >> 'CfgVehicles' >> typeOf player >> 'canCarryBackPack');
			
			if (_get == 1) then {
				_w = _w + ['US_Assault_Pack_EP1'];
				_w = _w + ['US_Patrol_Pack_EP1'];
				_w = _w + ['US_Backpack_EP1'];

				if (paramDLCBAF) then {
					_w = _w + ['BAF_AssaultPack_RifleAmmo'];
				};
				
				_w = _w + ['Tripod_Bag'];

				if (paramDLCBAF) then {
					_w = _w + ['BAF_L2A1_ACOG_minitripod_bag'];
					_w = _w + ['BAF_L2A1_ACOG_tripod_bag'];
					_w = _w + ['BAF_GPMG_Minitripod_D_bag'];
					_w = _w + ['BAF_GMG_ACOG_minitripod_bag'];
				};

				_w = _w + ['M2HD_mini_TriPod_US_Bag_EP1'];
				_w = _w + ['M2StaticMG_US_Bag_EP1'];
				_w = _w + ['MK19_TriPod_US_Bag_EP1'];
				_w = _w + ['TOW_TriPod_US_Bag_EP1'];
				_w = _w + ['M252_US_Bag_EP1'];
			};

			WF_Logic setVariable ['secondaryClasses',_w];

			/* Sidearms. */
			_w = ['Colt1911'];
			_w = _w + ['M9'];
			_w = _w + ['M9SD'];
			_w = _w + ['glock17_EP1'];

			WF_Logic setVariable ['sidearmClasses',_w];

			/* Misc. */
			_w = ['HandGrenade_West'];

			if (paramDLCBAF) then {
				_w = _w + ['BAF_L109A1_HE'];
			};

			_w = _w + ['HandGrenade_Stone'];
			_w = _w + ['IR_Strobe_Target'];
			_w = _w + ['IR_Strobe_Marker'];
			_w = _w + ['SmokeShell'];
			_w = _w + ['SmokeShellRed'];
			_w = _w + ['SmokeShellGreen'];
			_w = _w + ['SmokeShellBlue'];
			_w = _w + ['SmokeShellYellow'];
			_w = _w + ['SmokeShellOrange'];
			_w = _w + ['SmokeShellPurple'];
			_w = _w + ['FlareWhite_M203'];
			_w = _w + ['FlareYellow_M203'];
			_w = _w + ['FlareGreen_M203'];
			_w = _w + ['FlareRed_M203'];
			_w = _w + ['1Rnd_HE_M203'];
			_w = _w + ['1Rnd_Smoke_M203'];
			_w = _w + ['1Rnd_SmokeRed_M203'];
			_w = _w + ['1Rnd_SmokeGreen_M203'];
			_w = _w + ['1Rnd_SmokeYellow_M203'];
			_w = _w + ['Mine'];
			_w = _w + ['PipeBomb'];
			_w = _w + ['Binocular'];
			_w = _w + ['NVGoggles'];
			_w = _w + ['Binocular_Vector'];
			_w = _w + ['ItemCompass'];
			_w = _w + ['ItemGPS'];
			_w = _w + ['ItemMap'];
			_w = _w + ['ItemRadio'];
			_w = _w + ['ItemWatch'];
			_w = _w + ['DogtagsLockpick'];
			_w = _w + ['DogtagsMedic'];
			_w = _w + ['DogtagsSaboteur'];
			_w = _w + ['DogtagsEngineer'];
			_w = _w + ['DogtagsCommander'];

			WF_Logic setVariable ['miscClasses',_w];

			//--- Templates.
			_items = ['ItemCompass','ItemGPS','ItemMap','ItemRadio','ItemWatch'];

			_d = [];
			_p = []; 
			_t = []; 
			_m = []; 
			_s = []; 
			_i = []; 
			_l = []; 
			_b = []; 
	
			_d = _d + ["Assault Backpack"];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'US_Assault_Pack_EP1' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','US_Assault_Pack_EP1']];
			_m = _m + [];
			_s = _s + [['Binocular']];
			_i = _i + [_items + ['CDF_dogtags']];
			_l = _l + [0];
			_b = _b + [true];
	
			_d = _d + ["Engineer Backpack"];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'US_Assault_Pack_EP1' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','US_Assault_Pack_EP1']];
			_m = _m + [['CDF_dogtags']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];
			
			_d = _d + ["Medic Backpack"];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'US_Assault_Pack_EP1' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','US_Assault_Pack_EP1']];
			_m = _m + [['CDF_dogtags']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];	

			_d = _d + ["Commander Backpack"];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'US_Assault_Pack_EP1' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','US_Assault_Pack_EP1']];
			_m = _m + [['CDF_dogtags']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];				
			
			_d = _d + ["Saboteur Backpack"];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','US_Assault_Pack_EP1']];
			_m = _m + [['CDF_dogtags']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];
			
			
			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'Colt1911' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_CQC' >> 'picture')];
			_t = _t + [['SCAR_L_CQC','Colt1911']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag',
				'HandGrenade_West','HandGrenade_West','SmokeShellBlue','SmokeShellBlue','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911',
				'7Rnd_45ACP_1911','7Rnd_45ACP_1911']];
			_s = _s + [['Binocular']];
			_i = _i + [_items];
			_l = _l + [0];
			_b = _b + [true];

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
				'MAAWS_HEAT','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203']];
			_s = _s + [['Binocular','NVGoggles']];
			_i = _i + [_items];
			_l = _l + [3];
			_b = _b + [false];

			_d = _d + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'MAAWS' >> 'displayName') + '/' + getText(configFile >> 'CfgWeapons' >> 'M9' >> 'displayName')];
			_p = _p + [getText(configFile >> 'CfgWeapons' >> 'SCAR_L_STD_HOLO' >> 'picture')];
			_t = _t + [['SCAR_L_STD_HOLO','MAAWS','M9']];
			_m = _m + [['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT',
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
			_m = _m + [['20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','PipeBomb','PipeBomb','PipeBomb',
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

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_get = (_x+"_W") Call GetNamespace;
					if (isNil '_get') then {
						_get = _x Call GetNamespace;
					};
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
				} forEach (_t select _count);
				
				{
					_get = _x Call GetNamespace;
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
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
		['WFBE_WESTLEADERAMMO21',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS22',['G36C_camo','MAAWS','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO22',['30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','30Rnd_556x45_G36','MAAWS_HEAT','MAAWS_HEAT','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS23',['MG36_camo','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO23',['100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','100Rnd_556x45_BetaCMag','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		//--- Upgrade 3.
		['WFBE_WESTLEADERWEAPONS31',['SCAR_L_CQC_EGLM_Holo','MAAWS','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO31',['30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','30Rnd_556x45_Stanag','MAAWS_HEAT','MAAWS_HEAT','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203','1Rnd_HE_M203'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS32',['SCAR_H_STD_EGLM_Spect','Javelin','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO32',['20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','20Rnd_762x51_SB_SCAR','Javelin','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
		['WFBE_WESTLEADERWEAPONS33',['Mk_48_DES_EP1','Colt1911','Binocular','NVGoggles','ItemRadio','ItemMap'],true] Call SetNamespace;
		['WFBE_WESTLEADERAMMO33',['100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','100Rnd_762x51_M240','HandGrenade_West','HandGrenade_West','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911','7Rnd_45ACP_1911'],true] Call SetNamespace;
	};




	//*** EAST ***//
	if (!isServer || local player) then {
		if (side player == EAST) then {
			/* Magazines. */
			_m = ["30Rnd_762x39_AK47"];
			_m = _m + ["30Rnd_556x45_Stanag"];
			_m = _m + ["30Rnd_545x39_AK"];
			_m = _m + ["30Rnd_545x39_AKSD"];
			_m = _m + ["64Rnd_9x19_Bizon"];
			_m = _m + ["64Rnd_9x19_SD_Bizon"];
			_m = _m + ["100Rnd_762x54_PK"];
			_m = _m + ["75Rnd_545x39_RPK"];
			_m = _m + ["5x_22_LR_17_HMR"];
			_m = _m + ["10Rnd_762x54_SVD"];
			_m = _m + ["8Rnd_B_Saiga12_74Slug"];
			_m = _m + ["5Rnd_127x108_KSVK"];
			_m = _m + ["10Rnd_9x39_SP5_VSS"];
			_m = _m + ["20Rnd_9x39_SP5_VSS"];
			_m = _m + ["10x_303"];
			_m = _m + ["30Rnd_762x39_SA58"];
			_m = _m + ["20Rnd_762x51_FNFAL"];
			_m = _m + ["PG7V"];
			_m = _m + ["PG7VL"];
			_m = _m + ["OG7"];
			_m = _m + ["PG7VR"];
			_m = _m + ["RPG18"];
			_m = _m + ["Dragon_EP1"];
			_m = _m + ["AT13"];
			_m = _m + ["Igla"];
			_m = _m + ["Strela"];
			_m = _m + ["Laserbatteries"];
			_m = _m + ["6Rnd_45ACP"];
			_m = _m + ["8Rnd_9x18_Makarov"];
			_m = _m + ["8Rnd_9x18_MakarovSD"];
			_m = _m + ["10Rnd_B_765x17_Ball"];
			_m = _m + ["20Rnd_B_765x17_Ball"];
			_m = _m + ["30Rnd_9x19_UZI"];
			_m = _m + ["30Rnd_9x19_UZI_SD"];

			WF_Logic setVariable ['magazineClasses',_m];

			/* Primary. */
			_w = ['AK_47_M'];
			_w = _w + ['AK_47_S'];
			_w = _w + ['M16A2'];
			_w = _w + ['M16A2GL'];
			_w = _w + ['AK_74'];
			_w = _w + ['AK_74_GL'];
			_w = _w + ['AK_74_GL_kobra'];
			_w = _w + ['AK_107_kobra'];
			_w = _w + ['AK_107_GL_kobra'];
			_w = _w + ['AK_107_pso'];
			_w = _w + ['AK_107_GL_pso'];
			_w = _w + ['AKS_74'];
			_w = _w + ['AKS_74_GOSHAWK'];
			_w = _w + ['AKS_74_kobra'];
			_w = _w + ['AKS_74_NSPU'];
			_w = _w + ['AKS_74_pso'];
			_w = _w + ['AKS_74_U'];
			_w = _w + ['AKS_74_UN_kobra'];
			_w = _w + ['AKS_GOLD'];
			_w = _w + ['bizon'];
			_w = _w + ['bizon_silenced'];
			_w = _w + ['FN_FAL'];
			_w = _w + ['FN_FAL_ANPVS4'];
			_w = _w + ['LeeEnfield'];
			_w = _w + ['PK'];
			_w = _w + ['Pecheneg'];
			_w = _w + ['RPK_74'];
			_w = _w + ['huntingrifle'];
			_w = _w + ['Sa58P_EP1'];
			_w = _w + ['Sa58V_EP1'];
			_w = _w + ['Sa58V_RCO_EP1'];
			_w = _w + ['Sa58V_CCO_EP1'];
			_w = _w + ['SVD'];
			_w = _w + ['SVD_des_EP1'];
			_w = _w + ['SVD_NSPU_EP1'];
			_w = _w + ['SVD_CAMO'];
			_w = _w + ['Saiga12K'];
			_w = _w + ['ksvk'];
			_w = _w + ['VSS_vintorez'];

			WF_Logic setVariable ['primaryClasses',_w];

			/* Secondary. */

			_w = ['RPG7V'];
			_w = _w + ['RPG18'];
			_w = _w + ['M47Launcher_EP1'];
			_w = _w + ['MetisLauncher'];
			_w = _w + ['Igla'];
			_w = _w + ['Strela'];
			_w = _w + ['Laserdesignator'];
			
			/* Not all units are able to carry a backpack */
			_get = getNumber(configFile >> 'CfgVehicles' >> typeOf player >> 'canCarryBackPack');
			
			if (_get == 1) then {
				_w = _w + ['TK_Assault_Pack_EP1'];
				_w = _w + ['TK_RPG_Backpack_EP1'];
				_w = _w + ['TK_ALICE_Pack_EP1'];
				_w = _w + ['Tripod_Bag'];
				_w = _w + ['KORD_TK_Bag_EP1'];
				_w = _w + ['KORD_high_TK_Bag_EP1'];
				_w = _w + ['SPG9_TK_INS_Bag_EP1'];
				_w = _w + ['AGS_TK_Bag_EP1'];
				_w = _w + ['Metis_TK_Bag_EP1'];
				_w = _w + ['2b14_82mm_TK_Bag_EP1'];
			};

			WF_Logic setVariable ['secondaryClasses',_w];

			/* Sidearms. */
			_w = ['Makarov'];
			_w = _w + ['revolver_EP1'];
			_w = _w + ['revolver_gold_EP1'];
			_w = _w + ['MakarovSD'];
			_w = _w + ['Sa61_EP1'];
			_w = _w + ['UZI_EP1'];
			_w = _w + ['UZI_SD_EP1'];

			WF_Logic setVariable ['sidearmClasses',_w];

			/* Misc. */
			_w = ['HandGrenade_East'];
			_w = _w + ['HandGrenade_Stone'];
			_w = _w + ['SmokeShell'];
			_w = _w + ['SmokeShellRed'];
			_w = _w + ['SmokeShellGreen'];
			_w = _w + ['SmokeShellBlue'];
			_w = _w + ['SmokeShellYellow'];
			_w = _w + ['SmokeShellOrange'];
			_w = _w + ['SmokeShellPurple'];
			_w = _w + ['FlareWhite_GP25'];
			_w = _w + ['FlareYellow_GP25'];
			_w = _w + ['FlareGreen_GP25'];
			_w = _w + ['FlareRed_GP25'];
			_w = _w + ['1Rnd_HE_M203'];
			_w = _w + ['1Rnd_HE_GP25'];
			_w = _w + ['1Rnd_SMOKE_GP25'];
			_w = _w + ['1Rnd_SMOKERED_GP25'];
			_w = _w + ['1Rnd_SMOKEGREEN_GP25'];
			_w = _w + ['1Rnd_SMOKEYELLOW_GP25'];
			_w = _w + ['MineE'];
			_w = _w + ['PipeBomb'];
			_w = _w + ['Binocular'];
			_w = _w + ['NVGoggles'];
			_w = _w + ['Binocular_Vector'];
			_w = _w + ['ItemCompass'];
			_w = _w + ['ItemGPS'];
			_w = _w + ['ItemMap'];
			_w = _w + ['ItemRadio'];
			_w = _w + ['ItemWatch'];
			_w = _w + ['DogtagsLockpick'];
			_w = _w + ['DogtagsMedic'];
			_w = _w + ['DogtagsSaboteur'];
			_w = _w + ['DogtagsEngineer'];
			_w = _w + ['DogtagsCommander'];
			
			WF_Logic setVariable ['miscClasses',_w];

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

			for [{_count = 0},{_count < _totalTemplates},{_count = _count + 1}] do {
				_cost = 0;
				{
					_get = (_x+"_W") Call GetNamespace;
					if (isNil '_get') then {
						_get = _x Call GetNamespace;
					};
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
				} forEach (_t select _count);
				
				{
					_get = _x Call GetNamespace;
					if !(isNil '_get') then {_cost = _cost + (_get select QUERYGEARCOST)};
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

"Config_Loadout: Initialization - [Done]" call LogMedium;