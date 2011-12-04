
class MySlider {
    idc = 0; 
	type = 43;
	style = "0x400  + 0x10";
    x = 0.4; 
    y = 0.997; 
    w = 0.3; 
    h = 0.025; 
	color[] = {1,1,1,0.4 };
	colorActive[] = {1,1,1,1 };
	colorDisabled[] = {1,1,1,0.2 };
	arrowEmpty = "\ca\ui\data\ui_arrow_left_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_left_active_ca.paa";
	border = "\ca\ui\data\ui_border_frame_ca.paa";
	thumb = "\ca\ui\data\ui_slider_bar_ca.paa";
    onSliderPosChanged = "Slayd_nm = _this select 1";
};

class MyRscCombo {
  idc = 0;
  type = 4;
  style = 256;

  x = 0;
  y = 0.22;
  w = 0.5;
  h = 0.05;
    
  font = "TahomaB";
  sizeEx = 0.045;
  
rowHeight = 0.025;
wholeHeight = 10 * 0.05;
maxHistoryDelay = 1.000000;
autoScrollSpeed = -1;
autoScrollDelay = 10;
autoScrollRewind = 0;

color[] = {1,1,1,1};
colorSelect[] = {0.023529,0,0.031372,1 };
colorText[] = {0.023529,0,0.031372,1 };
colorBackground[] = {0.950000,0.950000,0.950000,1 };
colorSelectBackground[] = {0.543000,0.574200,0.410200,1.000000 };
colorScrollbar[] = {0.023529,0,0.031372,1 };
colorActive[] = {0,0,0,1 };
colorDisabled[] = {0,0,0,0.300000 };
arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";

soundSelect[] = {"\ca\ui\data\sound\mouse2",0.090000,1};
soundExpand[] = {"\ca\ui\data\sound\new1",0.090000,1};
soundCollapse[] = {"\ca\ui\data\sound\mouse1",0.090000,1 };
  
  	class ScrollBar  {
		color[] = {1,1,1,0.600000 };
		colorActive[] = {1,1,1,1 };
		colorDisabled[] = {1,1,1,0.300000 };
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};
 
class RscEdit  {
	access = 0;
	type = 2;
	style = 0;
	idc = 0;
	colorBackground[] = {0,0,0,0 };
	colorText[] = {1,1,1,1 };
	colorSelection[] = {1,1,1,0.250000 };
	font = "TahomaB";
	sizeEx = 0.080000;
	autocomplete = "";
	text = "";
	size = 0.200000;
};
