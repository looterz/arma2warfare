/*
	New loadout system. | Hybrid
	  Only one side gear is defined at a time. west don't know east and vice versa.
*/

/* Backpacks */
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

/* Binocular (Used for spotting) */
['WFBE_BINOCULARS',['Binocular','Binocular_Vector','Laserdesignator'],true] Call SetNamespace;

/* Set the loadout depending on it's type. */
[] Call Compile PreprocessFile Format["Common\Config\Core_Loadout\%1\Loadout_%2.sqf",WFBE_V_West_LoadoutRootVersion,WFBE_V_West_Loadout];
[] Call Compile PreprocessFile Format["Common\Config\Core_Loadout\%1\Loadout_%2.sqf",WFBE_V_East_LoadoutRootVersion,WFBE_V_East_Loadout];

diag_log Format ["[WFBE (INIT)][frameno:%1 | ticktime:%2] Config_Loadout: Initialization - [Done]",diag_frameno,diag_tickTime];