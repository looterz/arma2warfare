/* Dialogs */
//--- Town Market Dialog
class RscTownMarketControl {
	movingEnable = 1;
	idd = 18000;
	onLoad = "_this ExecVM ""Module\Market\Client\GUI_Market.sqf""";
	
	class controlsBackground {
		class Mainback : RscPicture {
			x = 0.185;
			y = 0.17;
			w = 1.2549;
			h = 0.9;
			moving = 1;
			text = "\ca\ui\data\ui_difficulty_background_ca.paa";
		};
	};
	
	class CA_Label: RscText {
		colorText[] = subcolor1;
		SizeEx = 0.03;
	};	
	
	class CA_ProductListA : RscListBoxA {
		drawSideArrows = 0;
		idcRight = -1;
		idcLeft = -1;
		x = 0.21;
		y = 0.27;
		w = 0.5;
		h = 0.03;
		rowHeight = 0.0219091;
		sizeEx = 0.03;
	};	
	
	class controls {

		class CA_Header: RscText {
			idc = 17001;
			text = $STR_WF_MarketMenu;
			x = 0.225;
			w = 0.4;
			y = 0.205;
		};	
		
		class CA_CloseButton : RscShortcutButton {
			idc = 17999;
			shortcuts[] = {0x00050000 + 1};
			default = 0;
			x = 0.706;
			y = 0.805;
			text = $STR_DISP_CLOSE;
			action = "closeDialog 0";
		};	
		
		class CA_MarketDepot : RscCombo {
			idc = 17003;
			x = 0.21;
			y = 0.27;
			w = 0.3;
			onLBSelChanged = "MenuAction = 17003";
		};		

		class CA_ProductListHeader : CA_ProductListA {
			columns[] = {0.00, 0.30, 0.40, 0.525, 0.65, 0.825};
			idc = 17004;
			y = 0.32;
			h = 0.03;	
		};
		
		
		class CA_ProductList : CA_ProductListA {
			columns[] = {0.00, 0.30, 0.40, 0.525, 0.65, 0.825};
			idc = 17005;
			y = 0.35;
			h = 0.45;
			onLBSelChanged = "MenuAction = 100";
		};		
		
		class CA_BuyProductVolume: CA_Label {
			idc = 17010;
			text = "Buy units: ";
			x = 0.71;
			y = 0.29;
			w = 0.26;
		};		

		class CA_BuyProductVolumeSlider : RscXSliderH {
			idc = 17011;
			x = 0.72;
			y = 0.33;
			w = 0.175;
		};
		
		class CA_BuyButton : RscShortcutButton {
			idc = 17012;
			shortcuts[] = {0x00050000 + 1};
			default = 0;
			x = 0.71;
			y = 0.34;
			h = 0.1;
			size = 0.03;
			sizeEx = 0.03;			
			text = "Buy";
			action = "MenuAction = 10";
		};		
		
		class CA_SellProductVolume: CA_Label {
			idc = 17020;
			text = "Sell units: ";
			x = 0.71;
			y = 0.45;
			w = 0.26;
		};		

		class CA_SellProductVolumeSlider : RscXSliderH {
			idc = 17021;
			x = 0.72;
			y = 0.49;
			w = 0.175;
		};		

		class CA_SellButton : CA_BuyButton {
			idc = 17022;
			y = 0.50;
			text = "Sell";
			action = "MenuAction = 20";
		};	

		class CA_CashLabel: CA_Label {
			idc = 17030;
			text = "Cash: $250000";
			x = 0.71;
			y = 0.70;
			w = 0.26;
		};

		class CA_CostLabel: CA_Label {
			idc = 17040;
			text = "Cost: $0";
			x = 0.71;
			y = 0.67;
			w = 0.26;
		};

		class CA_FreeCargo: CA_Label {
			idc = 17050;
			text = "Free cargo: $0";
			x = 0.71;
			y = 0.64;
			w = 0.26;
		};			
		
	}	
}



