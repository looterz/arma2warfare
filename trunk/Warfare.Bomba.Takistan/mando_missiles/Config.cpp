class CfgPatches
{
	class Mando_Missile_Addon
	{
		units[] ={Logic_X};
		weapons[] ={};
		requiredAddons[] = {"CAData","caMisc2"};
		requiredVersion  = 1.05;
		version          = 2.4b96;
	};
};

#include <\mando_missiles\mando_missile.h>

class RscTitles
{
// Needed for Mando Missile ArmA
#include <\mando_missiles\mando_missiletitles.h>
// End of Needed for Mando Missile ArmA
};


//**************************************

class CfgSounds
{
// Mando Sounds
// Needed for Mando Missile ArmA
#include <\mando_missiles\mando_sounds.h>	
};


class CfgVehicleClasses
{
 class MMA_Logics
 {
  displayName = "MMA Logics";
 };
};


class cfgVehicles
{
	class Logic;
	class Mando_Missile_ArmA : Logic
 	{
                vehicleClass = "MMA_Logics";
  		displayName = "Mando Missile ArmA init";
  		model = "\ca\weapons\empty";
		Icon = "\mando_missiles\mando_missile_icon.paa";

                class EventHandlers
		{
                   init = "[true] execVM""\mando_missiles\mando_missileinit.sqf"""; 
		};	
	};

	class Mando_Missile_ArmA_full : Logic
 	{
                vehicleClass = "MMA_Logics";
  		displayName = "Mando Missile ArmA full";
  		model = "\ca\weapons\empty";
		Icon = "\mando_missiles\mando_missile_full_ico.paa";

                class EventHandlers
		{
                   init = "[] execVM""\mando_missiles\mando_setup_full.sqf"""; 
		};	
	};

	class Mando_Missile_ArmA_ace : Logic
 	{
                vehicleClass = "MMA_Logics";
  		displayName = "Mando Missile ArmA ACE";
  		model = "\ca\weapons\empty";
		Icon = "\mando_missiles\mando_missile_ace_ico.paa";

                class EventHandlers
		{
                   init = "[] execVM""\mando_missiles\mando_setup_ace.sqf"""; 
		};	
	};

	class Mando_Missile_ArmA_ffaa : Logic
 	{
                vehicleClass = "MMA_Logics";
  		displayName = "Mando Missile ArmA FFAA";
  		model = "\ca\weapons\empty";
		Icon = "\mando_missiles\mando_missile_ffaa_ico.paa";

                class EventHandlers
		{
                   init = "[] execVM""\mando_missiles\mando_setup_ffaa.sqf"""; 
		};	
	};

	class Mando_Gun_ArmA_init : Logic
 	{
                vehicleClass = "MMA_Logics";
  		displayName = "Mando Gun ArmA init";
  		model = "\ca\weapons\empty";
		Icon = "\mando_missiles\mando_gun_init_ico.paa";

                class EventHandlers
		{
                   init = "[]execVM""\mando_missiles\mando_gun\mando_guninit.sqf"""; 
		};	
	};

	class Mando_Kuz_init : Logic
 	{
                vehicleClass = "MMA_Logics";
  		displayName = "Mando Kuznetsov init";
  		model = "\ca\weapons\empty";
		Icon = "\mando_missiles\mma_kuz_init.paa";

                class EventHandlers
		{
                   init = "_this execVM""\mando_missiles\setups\mma_gnt_kuz_init.sqf"""; 
		};	
	};
};
