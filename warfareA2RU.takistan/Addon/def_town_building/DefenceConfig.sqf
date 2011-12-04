﻿DEFENCEINFO_TYPENAME  = 0;
DEFENCEINFO_BUILDTIME = 1;
DEFENCEINFO_RANGE = 2;
DEFENCEINFO_COST = 3;
DEFENCEINFO_ZOFFSET = 4;
DEFENCEINFO_DESCRIPTION = 5;
DEFENCEINFO_CANREPLACEMENT = 6;
DEFENCEINFO_ZTAKEOFFSET = 7;
DEFENCEINFO_WEAPONTYPE = 8;
DEFENCEINFO_SIDE = 9; 
DEFENCEINFO_MAXOVERHEIGHT = 10; 

_WEAPON = true;
_STRUCT = false;

_SIDE_EAST = [east];
_SIDE_WEST = [west];
_SIDE_BOTH = [west, east];
 
WF_DefenceTypeList = [
     //                  [type,time,range,cost,z,name,roof, isweapon, side ]
	 ["Land_Ind_SawMill"           , 10, 1   ,  250 ,  0.0 , "", "y",   0.50, _STRUCT, _SIDE_BOTH, -1 ],
	 ["Land_Ind_SawMillPen"           , 10, 1   ,  250 ,  0.0 , "", "y",   0.50, _STRUCT, _SIDE_BOTH, -1 ],
	 
	 ["Land_ladder_half"             , 10, 1   ,  250 ,  0.0 , "", "y",   0.50, _STRUCT, _SIDE_BOTH, -1 ],
     ["KORD_high_TK_EP1"             , 10, 1   ,  250 ,  0.0 , "", "y",   0.50, _WEAPON, _SIDE_EAST, -1 ],
     ["KORD_TK_EP1"                  , 10, 1   ,  250 , -0.1 , "", "y",   0.50, _WEAPON, _SIDE_EAST, -1 ],
     ["AGS_TK_EP1"                   , 10, 1   , 1300 ,  0.0 , "", "y",   0.50, _WEAPON, _SIDE_EAST, -1 ],
     ["SPG9_TK_INS_EP1"              , 10, 1.5 ,  950 ,  0.0 , "", "y",  -0.50, _WEAPON, _SIDE_EAST, -1 ],
     ["2b14_82mm_TK_EP1"       		 , 10, 1   , 1225 ,  0.0 , "", "y",   0.25, _WEAPON, _SIDE_EAST, -1 ],
	                    

	 ["MK19_TriPod_US_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["TOW_TriPod_US_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_HBarrier3"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_HBarrier5"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_HBarrier_large"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_fort_bagfence_long"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_fort_bagfence_corner"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_fort_bagfence_round"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_fortified_nest_small_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_fort_rampart_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Land_fort_artillery_nest_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Hhedgehog_concreteBig"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 ["Hedgehog_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 [if (WF_Camo) then {"Land_CamoNet_NATO"} else {"Land_CamoNet_NATO_EP1"}, 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_BOTH, -1 ],	
	 
	 ["Concrete_Wall_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _STRUCT, _SIDE_BOTH, -1 ],	
	 ["SearchLight_TK_EP1"           , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _STRUCT, _SIDE_BOTH, -1 ],	
	 
	
     ["M2StaticMG_US_EP1"            , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["M2HD_mini_TriPod_US_EP1"      , 10, 1   ,  500 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["MK19_TriPod_US_EP1"           , 10, 1   , 1400 , -0.1 , "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["BAF_GMG_Tripod_W"             , 10, 1   , 1600 , -0.15, "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["BAF_GPMG_Minitripod_W"        , 10, 1   ,  500 , -0.15, "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["BAF_L2A1_Tripod_W"            , 10, 1.5 ,  650 , -0.15, "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["BAF_L2A1_Minitripod_W"        , 10, 1.5 ,  650 , -0.15, "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],
     ["M252_US_EP1"                  , 10, 1   , 1225 , -0.15, "", "y", 0.00,   _WEAPON, _SIDE_WEST, -1 ],

	 ["WarfareBMGNest_M240_US_EP1"   , 10, 3   ,  250,   0.0 , "", "y",   2.50, _WEAPON, _SIDE_WEST, 0.5 ],
	 ["RU_WarfareBMGNest_PK",          10, 3   ,  250,   0.0 , "", "y",   2.50, _WEAPON, _SIDE_EAST, 0.5 ],
	 ["Land_Ind_IlluminantTower"     , 10, 3   , 1100,   0.0 , "", "y",   0.0,  _STRUCT, _SIDE_BOTH, 0.5 ],
     ["Fort_Barricade"               , 30, 3   , 100 , 0.00 ,  "", "n", 0.00,   _STRUCT, _SIDE_BOTH, 0.5 ],
     ["Fort_RazorWire"               , 20, 2   ,  30 , 0.00 ,  "", "n", 0.00,   _STRUCT, _SIDE_BOTH, -1 ],	 
     ["Hedgehog"                     , 20, 2   ,  50 , 0.00 ,  "", "n", 0.00,   _STRUCT, _SIDE_BOTH, 0.5 ],
     ["Land_BagFenceLong"            , 5 , 1   ,  30 , 0.00 ,  "", "y", 0.00,   _STRUCT, _SIDE_BOTH, -1 ],
     ["Land_BagFenceShort"           , 5 , 1   ,  15 , 0.00 ,  "", "y", 0.00,   _STRUCT, _SIDE_BOTH, -1 ],
     ["Fort_EnvelopeBig"             , 10, 1   ,  50 , 0.15 ,  "", "n", 0.00,   _STRUCT, _SIDE_BOTH, 0.5 ],
     ["Fort_EnvelopeSmall"           , 10, 1   ,  25 , 0.15 ,  "", "n", 0.00,   _STRUCT, _SIDE_BOTH, 0.5 ]
];


{ 	_name = getText(configFile >> 'CfgVehicles' >> (_x select DEFENCEINFO_TYPENAME) >> "displayName");
	_x set [DEFENCEINFO_DESCRIPTION, _name];
} foreach WF_DefenceTypeList;

WF_DefenceTypeData = [];
{ if (playerSide in (_x select DEFENCEINFO_SIDE)) then { WF_DefenceTypeData = WF_DefenceTypeData + [_x] }; } forEach WF_DefenceTypeList;

 