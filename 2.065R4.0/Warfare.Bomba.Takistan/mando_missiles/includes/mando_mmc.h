class DlgMissileCommand
{
   idd = 23900;
   movingEnable = true;

   controlsBackground[] = {COMMAND_BACKGROUND,COMMAND_BACKGROUND2, COMMAND_FRAME};

   class COMMAND_BACKGROUND : RscMandBackground
   {
      colorBackground[] = {0, 0.1, 0.3, 1};
      text = ;
      idc = -1;
      style = MANDST_BACKGROUND;
      sizeEx = 0.015;
      x = 0.75;
      y = 0.0;
      w = 0.25;
      h = 0.7;
   };

   class COMMAND_BACKGROUND2 : RscMandBackground
   {
      colorBackground[] = {0, 1, 0, 0.5};
      text = ;
      idc = -1;
      style = MANDST_HUD_BACKGROUND;
      sizeEx = 0.015;
      x = 0.75;
      y = 0.7;
      w = 0.25;
      h = 0.3;
   };


   class COMMAND_FRAME : RscMandText
   {
      idc = 23901;
      style = MANDST_FRAME;
      colorText[] = {1, 1, 1, 1};
      text = "Commanded unit";
      font = "Bitstream";
      sizeEx = 0.02;
      x = 0.755;
      y = 0.7;
      w = 0.24;
      h = 0.29;
   };


   controls[] = {COMMAND_LIST, COMMAND_ON, COMMAND_OFF, COMMAND_ONOWN, COMMAND_OFFOWN, COMMAND_RADAR, COMMAND_MAP};

   class COMMAND_LIST : RscMandListBox
   {
      idc = 23902;
      style = MANDST_LEFT;
      x = 0.755;
      y = 0.005;
      w = 0.24;
      h = 0.4;
      colorText[] = {0.0, 1.0, 0, 1};
      font = "Bitstream";
      sizeEx = 0.02;
      onLBSelChanged = "mando_command_idx = _this select 1";
   };

   class COMMAND_ON : RscMandButton
   {
  	idc = -1;
   	x = 0.755;
  	y = 0.41;
  	w = 0.24;
  	h = 0.035;
        font = "Bitstream";
        sizeEx = 0.02;
  	text = "Switch commanded radar ON";
  	action = "mando_command_on=true";
   };

   class COMMAND_OFF : RscMandButton
   {
  	idc = -1;
   	x = 0.755;
  	y = 0.41 + 0.04;
  	w = 0.24;
  	h = 0.035;
        font = "Bitstream";
        sizeEx = 0.02;
  	text = "Switch commanded radar OFF";
  	action = "mando_command_off=true";
   };

   class COMMAND_ONOWN : RscMandButton
   {
  	idc = -1;
   	x = 0.755;
  	y = 0.41 + 0.04*2;
  	w = 0.24;
  	h = 0.035;
        font = "Bitstream";
        sizeEx = 0.02;
  	text = "Switch radar ON";
  	action = "mando_command_own_on=true";
   };

   class COMMAND_OFFOWN : RscMandButton
   {
  	idc = -1;
   	x = 0.755;
  	y = 0.41 + 0.04*3;
  	w = 0.24;
  	h = 0.035;
        font = "Bitstream";
        sizeEx = 0.02;
  	text = "Switch radar OFF";
  	action = "mando_command_own_off=true";
   };


   class COMMAND_RADAR : RscMandText
   {
  	idc = 23904;
   	x = 0.755;
  	y = 0.41 + 0.04*4;
  	w = 0.24;
  	h = 0.035;
        font = "Bitstream";
        sizeEx = 0.02;
	text = "RADAR ";
   };


   class COMMAND_MAP : RscMandMap 
   {
      idc = 23903;
      x = 0;
      y = 0;
      w = 0.75;
      h = 1;
      type = 101;
      style = 48;


      //sizeEx = 0.02;
      sizeExLabel = 0.02;
      sizeExGrid = 0.02;
      sizeExUnits = 0.02;
      sizeExNames = 0.02;
      sizeExInfo = 0.02;
      sizeExLevel = 0.02;
      showCountourInterval = "false";			
      onMouseZChanged = "";
      onMouseButtonDown = "if ((_this select 1) == 0) then {mando_com_coords = ((findDisplay 23900) displayCtrl 23903) ctrlMapScreenToWorld [_this select 2, _this select 3]}";
     


      colorBackground[] = {0, 0.7, 0, 1};
      colorSea[] = {0, 0.3, 0, 0.5};
      colorForest[] = {0, 0.8, 0, 0.5};
      colorRocks[] = {0, 0.5, 0, 0.5};
      colorCountlines[] = {0, 0.45, 0, 0.5};
      colorMainCountlines[] = {0, 0.45, 0, 1};
      colorCountlinesWater[] = {0, 0.53, 0, 0.5};
      colorMainCountlinesWater[] = {0, 0.53, 0, 1};
      colorForestBorder[] = {0, 0.8, 0, 1};
      colorRocksBorder[] = {0, 0.5, 0, 1};
      colorPowerLines[] = {0, 0, 0, 1};
      colorNames[] = {0, 0, 0, 1};
      colorInactive[] = {1, 1, 1, 0.5};
      colorLevels[] = {0, 0, 0, 1};

			
      class Command 
      {
         icon = "#(argb,8,8,3)color(1,1,1,1)";
         color[] = {0, 0, 0, 1};
         size = 18;
         importance = 1;
         coefMin = 1;
         coefMax = 1;
      };
      class ActiveMarker
      {
         color[] = {0, 0.1, 0, 1};
         size = 50;
      };

      class Bunker 
      {
		icon = "\ca\ui\data\map_bunker_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
      };
	
      class Bush 
      {
		icon = "\ca\ui\data\map_bush_ca.paa";
		color[] = {0, 0.64, 0, 1};
		size = 16;
		importance = 0.2 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
      };
	
      class BusStop 
      {
	        icon = "\ca\ui\data\map_busstop_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 10;
		importance = 1 * 10 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
      };
	
	class Cross 
        {
		icon = "\ca\ui\data\map_cross_ca.paa";
		color[] = {0, 0.64, 0, 1};
		size = 16;
		importance = 0.7 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fortress 
        {
		icon = "\ca\ui\data\map_bunker_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Fuelstation 
        {
		icon = "\ca\ui\data\map_fuelstation_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.75;
		coefMax = 4;
	};
	
	class Fountain 
        {
		icon = "\ca\ui\data\map_fountain_ca.paa";
		color[] = {0, 0.35, 0, 1};
		size = 12;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Hospital 
        {
		icon = "\ca\ui\data\map_hospital_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Chapel 
        {
		icon = "\ca\ui\data\map_chapel_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Church 
        {
		icon = "\ca\ui\data\map_church_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Lighthouse 
        {
		icon = "\ca\ui\data\map_lighthouse_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 20;
		importance = 3 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Quay 
        {
		icon = "\ca\ui\data\map_quay_ca.paa";
		color[] = {0, 0.64, 0, 1};
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Rock 
        {
		icon = "\ca\ui\data\map_rock_ca.paa";
		color[] = {0 0.64, 0, 1};
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Ruin 
        {
		icon = "\ca\ui\data\map_ruin_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
	};
	
	class SmallTree 
        {
		icon = "\ca\ui\data\map_smalltree_ca.paa";
		color[] = {0, 0.7, 0, 1};
		size = 16;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Stack 
        {
		icon = "\ca\ui\data\map_stack_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class Tree 
        {
		icon = "\ca\ui\data\map_tree_ca.paa";
		color[] = {0, 0.7, 0, 1};
		size = 16;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;	
	};
	
	class Tourism 
        {
		icon = "\ca\ui\data\map_tourism_ca.paa";
		color[] = {0, 1, 0, 1};
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
	};
	
	class Transmitter 
        {
		icon = "\ca\ui\data\map_transmitter_ca.paa";
		size = 20;
		color[] = {0, 0.35, 0, 1};
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	
	class ViewTower 
        {
		icon = "\ca\ui\data\map_viewtower_ca.paa";
		size = 16;
		color[] = {0, 0.35, 0, 1};
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
	};
	
	class Watertower 
        {
		icon = "\ca\ui\data\map_watertower_ca.paa";
		color[] = {0, 0.35, 0, 1};
		size = 32;
		importance = 1.2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
	};
	class Waypoint 
        {
		icon = "\ca\ui\data\map_waypoint_ca.paa";
		size = 16;
		color[] = {0, 0.35, 0, 1};
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;		
	};
	
	class WaypointCompleted 
        {
		icon = "\ca\ui\data\map_waypoint_completed_ca.paa";
		size = 16;
		color[] = {0, 0.35, 0, 1};
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;		
	};
   };
};
