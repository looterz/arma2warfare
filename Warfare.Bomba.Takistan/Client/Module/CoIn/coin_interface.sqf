private ["_a","_alt","_areasize","_array","_arrayEnable","_arrayNames","_arrayNamesLong","_arrayParams","_b","_bns","_border","_buildings","_buildingsNames","_buildingsType","_buildLimit","_camera","_canAfford","_canAffordCount","_canAffordCountOld","_canBuild","_cashDescription","_cashLines","_cashPos","_cashSize","_cashText","_cashValue","_cashValues","_cashValuesCount","_cashValuesOld","_categories","_categoriesMenu","_category","_checkPlaceZone","_color","_colorGray","_colorGreen","_colorGUI","_colorRed","_count","_createBorder","_createBorderScope","_ctrl","_current","_defenseId","_dir","_direction","_distance","_fileIcon","_filePicture","_find","_fnCountFreePlaceObjects","_fnIsFreePlaceClass","_funds","_fundsDescription","_fundsRemaining","_gdir","_get","_greenList","_helper","_hqDeployed","_index","_isBuilding","_isCommander","_itemcash","_itemcategory","_itemclass","_itemclass_preview","_itemcost","_itemFunds","_itemname","_items","_keys","_keysBanned","_keysCancel","_limit","_limitH","_limitHOld","_limitV","_limitVOld","_loaded","_localtime","_logic","_logicASL","_logicGrp","_maxGrad","_mhq","_minDist","_mode","_nearLog","_new","_npos","_nvgstate","_oldMenu","_oldTooltip","_params","_player","_pos","_preview","_restart","_selected","_shift","_source","_startPos","_status","_structs","_structuresCosts","_supply","_text","_text1","_text2","_text3","_textControls","_textHeader","_textHint","_textPicture","_tooFar","_tooltip","_tooltipType","_type","_upgrades","_y","_x","_input"];

_logic = _this select 3;
_startPos = _this select 4;
_source = _this select 5;
COIN_RearmVehicle = _this select 5;

if (isNil "COIN_RearmVehicle") then {
	COIN_RearmVehicle = vehicle player;
};

if (isNull COIN_RearmVehicle) then {
	COIN_RearmVehicle = vehicle player;
};

if (COIN_RearmVehicle == player) then {
	COIN_RearmVehicle = objNull;
};

coinFreePlaceTypeNames = [ "Land_CamoNet_EAST", "Land_CamoNet_NATO"];

coinFreePlaceClasses = [];
{ 
    coinFreePlaceClasses = coinFreePlaceClasses + [ (configFile >> "CfgVehicles" >> _x) ]; 
} forEach coinFreePlaceTypeNames;


//--- Area limits.
_tooFar = false;
if (paramBaseArea) then {
	if (_source isKindOf "Man") then {
		if (count(WF_Logic getVariable Format ['%1Area',SideJoinedText]) >= ('WFBE_BASEAREAMAX' Call GetNamespace)) then {
			_nearLog = [_startPos,WF_Logic getVariable Format ['%1Area',SideJoinedText]] Call SortByDistance;
			_startpos = position (_nearLog select 0);
			if (_source distance _startpos > ('WFBE_MHQBUILDINGRANGE' Call GetNamespace)) exitWith {
				_tooFar = true;
			};
		};
	};
};

_fnCountFreePlaceObjects = {
private['_position', '_radius', '_count' ];

	_position = _this select 0;
	_radius = _this select 1;
	
	_count = 0;
	{ _count = _count + (count (_position nearObjects [_x, _radius])); } forEach coinFreePlaceClasses;
	
	_count;
};

_fnIsFreePlaceClass = {
private['_itemTypeName', '_status', '_classType' ];

	_itemTypeName = _this;

	_classType = (configFile >> "CfgVehicles" >> _itemTypeName);
	_status = false;
	while { !_status && (isClass _classType)  } do {
		if (_classType in coinFreePlaceClasses) then 
		{ 
			_status = true; 
		};
		_classType = inheritsFrom _classType;
	};
    _status;
};


if (_tooFar) exitWith {hint  (localize 'STR_WF_BaseArea_Reached')};//--- Base area reached.

uiNamespace setVariable ["COIN_displayMain",finddisplay 46];

//--- Terminate of system is already running
if !(isNil {player getVariable "bis_coin_logic"}) exitWith {};
player setVariable ["bis_coin_logic",_logic];
bis_coin_player = player;

_camera = BIS_CONTROL_CAM;
if (isNil "BIS_CONTROL_CAM") then {
	_camera = "camconstruct" camCreate [position player select 0,position player select 1,15];
	_camera cameraEffect ["internal","back"];
	_camera camPrepareFov 0.900;
	_camera camPrepareFocus [-1,-1];
	_camera camCommitPrepared 0;
	cameraEffectEnableHUD true;
	_camera setdir direction player;
	[_camera,-30,0] call BIS_fnc_setPitchBank;
	_camera camConstuctionSetParams ([_startPos] + (_logic getVariable "BIS_COIN_areasize"));
};
BIS_CONTROL_CAM = _camera;
BIS_CONTROL_CAM_LMB = false;
BIS_CONTROL_CAM_RMB = false;
showCinemaBorder false;

1122 cutrsc ["constructioninterface","plain"];

//--- Prevent uikey override for other mods.
WF_COIN_DEH1 = (uiNamespace getVariable "COIN_displayMain") displayAddEventHandler ["KeyDown",		"if !(isNil 'BIS_CONTROL_CAM_Handler') then {BIS_temp = ['keydown',_this,commandingMenu] spawn BIS_CONTROL_CAM_Handler; BIS_temp = nil;}"];
WF_COIN_DEH2 = (uiNamespace getVariable "COIN_displayMain") displayAddEventHandler ["KeyUp",		"if !(isNil 'BIS_CONTROL_CAM_Handler') then {BIS_temp = ['keyup',_this] spawn BIS_CONTROL_CAM_Handler; BIS_temp = nil;}"];
WF_COIN_DEH3 = (uiNamespace getVariable "COIN_displayMain") displayAddEventHandler ["MouseButtonDown",	"if !(isNil 'BIS_CONTROL_CAM_Handler') then {BIS_temp = ['mousedown',_this,commandingMenu] spawn BIS_CONTROL_CAM_Handler; BIS_temp = nil; BIS_CONTROL_CAM_onMouseButtonDown = _this; if (_this select 1 == 1) then {BIS_CONTROL_CAM_RMB = true}; if (_this select 1 == 0) then {BIS_CONTROL_CAM_LMB = true};}"];
WF_COIN_DEH4 = (uiNamespace getVariable "COIN_displayMain") displayAddEventHandler ["MouseButtonUp",	"if !(isNil 'BIS_CONTROL_CAM_Handler') then {BIS_CONTROL_CAM_RMB = false; BIS_CONTROL_CAM_LMB = false;}"];

BIS_CONTROL_CAM_keys = [];

if (isNil "BIS_CONTROL_CAM_ASL") then {
	createCenter sideLogic;
	_logicGrp = createGroup sidelogic;
	_logicASL = _logicGrp createUnit ["Logic",position player,[],0,"none"];
	BIS_CONTROL_CAM_ASL = _logicASL;
};

_logic setVariable ["BIS_COIN_selected",objNull];
_logic setVariable ["BIS_COIN_params",[]];
_logic setVariable ["BIS_COIN_tooltip",""];
_logic setVariable ["BIS_COIN_menu","#USER:BIS_Coin_categories_0"];
_logic setVariable ["BIS_COIN_restart",true];
_logic setVariable ["WF_RequestUpdate",false];
_get = _logic getVariable 'WF_NVGPersistent';
_nvgstate = true;
if (isNil '_get') then {
	_nvgstate = if (daytime > 18.5 || daytime < 5.5) then {true} else {false};
	_logic setVariable ['WF_NVGPersistent',_nvgstate];
} else {
	_nvgstate = _logic getVariable 'WF_NVGPersistent';
};
camUseNVG _nvgstate;
_logic setVariable ["BIS_COIN_nvg",_nvgstate];

_bns = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;
_greenList = [WESTBAR,WESTLVF,WESTHEAVY,WESTAIR,EASTBAR,EASTLVF,EASTHEAVY,EASTAIR];
//--- Building Limit Init.
_buildingsNames = _bns;
_buildingsNames = _buildingsNames - [_buildingsNames select 0];
_buildingsType = Format["WFBE_%1STRUCTURES",sideJoinedText] Call GetNamespace;
_buildingsType = _buildingsType - [_buildingsType select 0];

//--- Open menu
_logic spawn {
	
private ["_params","_logic"];
	_logic = _this;
	waitUntil {!isNil {_this getVariable "BIS_COIN_fundsOld"}};
	while {!isNil "BIS_CONTROL_CAM"} do {
		waitUntil {
			_params = _logic getVariable "BIS_COIN_params";
			if (isNil "_params") then {_params = []};
			(commandingMenu == "" && count _params == 0 && !BIS_CONTROL_CAM_RMB) || isNil "BIS_CONTROL_CAM"
		};
		if (isNil "BIS_CONTROL_CAM") exitWith {};
		showCommandingMenu "#USER:BIS_Coin_categories_0";
		sleep 0.01;
	};
};

//--- Border - temporary solution //TODO: move border if position of logic changes (eg. by placing hq)
_createBorder = {
	
     private ["_border","_logic","_startpos","_oldBorder","_center","_size","_width","_pi","_perimeter","_wallcount","_total"];
	_logic = _this select 0;
	_startpos = _this select 1;
	_oldBorder = missionNamespace getVariable "BIS_COIN_border";
	if (!isNil "_oldBorder") then {
		{deleteVehicle _x} forEach _oldBorder;
	};
	missionNamespace setVariable ["BIS_COIN_border",nil];
	
	_border = [];
	_center = _startpos;
	_size = (_logic getVariable "BIS_COIN_areasize") select 0;
	_width = 9.998; //200/126
	_width = 9.996; //150/96
	_width = 9.992; //100/64
	_width = 9.967; //50/32
	_width = 9.917; //30/20
	_width = 9.83; //20/14
	_width = 9.48; //10/8
	_width = 10 - (0.1/(_size * 0.2));
	_width = 10;

	_pi = 3.14159265358979323846;
	_perimeter = (_size * _pi);
	_perimeter = _perimeter + _width - (_perimeter % _width);
	_size = (_perimeter / _pi);
	_wallcount = _perimeter / _width * 2;
	_total = _wallcount;

	for "_i" from 1 to _total do {
		private['_dir','_xpos','_ypos','_zpos','_a'];
		_dir = (360 / _total) * _i;
        _xpos = (_center select 0) + (sin _dir) * _size;
        _ypos = (_center select 1) + (cos _dir) * _size;
		_zpos = (_center select 2);

		_a = "transparentwall" createVehicleLocal [_xpos,_ypos,_zpos];
		_a setposasl [_xpos,_ypos,0];
		_a setdir (_dir + 90);
		_border = _border + [_a];
	};
	missionNamespace setVariable ["BIS_COIN_border",_border];
};
_createBorderScope = [_logic,_startpos] spawn _createBorder;

//--- This block is pretty important
if !(isNil "BIS_CONTROL_CAM_Handler") exitWith {endLoadingScreen};

BIS_CONTROL_CAM_Handler = {
    private ['_camera','_areasize','_limitH','_limitV','_status','_sold','_crewCount','_defenseName','_sellForMoney','_txt','_selled','_repairName','_tryFoldToVehicle','_state','_dammage',"_terminate","_key","_NVGstate","_currentCash","_price","_closest","_closestType","_get","_targeting","_near","_preview",
    "_ctrl","_menu","_player","_border","_mode","_input",
    "_logic","_keysCancel","_keysBanned","_keyNightVision"];
	_mode = _this select 0;
	_input = _this select 1;
	_camera = BIS_CONTROL_CAM;
	_logic = bis_coin_player getVariable "bis_coin_logic";
	_terminate = false;
  
  	if (isNil "_logic") exitWith {};

	_areasize = (_logic getVariable "BIS_COIN_areasize");
	_limitH = _areasize select 0;
	_limitV = _areasize select 1;

	_keysCancel		= actionKeys "MenuBack";

	_keysBanned		= [1];
	_keyNightVision		= actionKeys "NightVision";

	//--- Mouse DOWN
	if (_mode == "mousedown") then {
		_key = _input select 1;
		if (_key == 1 && 65665 in (actionkeys "MenuBack")) then {_terminate = true};
	};

	//--- Key DOWN
	if (_mode == "keydown") then {

		_key = _input select 1;
		_ctrl = _input select 3;
		if !(_key in (BIS_CONTROL_CAM_keys + _keysBanned)) then {BIS_CONTROL_CAM_keys = BIS_CONTROL_CAM_keys + [_key]};

		//--- Terminate CoIn
		if (_key in _keysCancel && isNil "BIS_Coin_noExit") then {_terminate = true};

		//--- Start NVG
		if (_key in _keyNightVision) then {
			_NVGstate = !(_logic getVariable "BIS_COIN_nvg");
			_logic setVariable ["BIS_COIN_nvg",_NVGstate];
			_logic setVariable ['WF_NVGPersistent',_NVGstate];
			camUseNVG _NVGstate;
		};
		
		//--- Last Built Defense (Custom Action #1).
		if ((_key in (actionKeys "User15")) && count lastBuilt > 0) then {
			_currentCash = Call GetPlayerFunds;
			if (_currentCash > (lastBuilt select 2) select 1) then {
				showCommandingMenu '';
				_logic setVariable ["BIS_COIN_params",lastBuilt];
			};
		};
		
		//--- Manning Defense (Custom Action #2).
		if ((_key in (actionKeys "User16")) && (('WFBE_AIDEFENSE' Call GetNamespace) > 0)) then {
			if (manningDefense) then {manningDefense = false} else {manningDefense = true};
			_status = if (manningDefense) then {"Enabled"} else {"Disabled"};
			_logic setVariable ["WF_RequestUpdate",true];
		};
		
		//--- Sell Defense. (Commander only) (Custom Action #3).		
		if ((_key in (actionKeys "User17"))) then { //  && 
			if(true) then { // commanderTeam == clientTeam
				
			
				_preview = _logic getVariable "BIS_COIN_preview";
				if (isNil "_preview") then {//--- Proceed when there is no preview.
					_targeting = screenToWorld [0.5,0.5];
					_near = nearestObjects [_targeting,Format["WFBE_%1DEFENSENAMES",sideJoinedText] Call GetNamespace,25];
					if (count _near > 0) then {
						_closest = _near select 0;
						_sold = _closest getVariable 'sold';
						_closestType = typeOf (_closest);
						_get = _closestType Call GetNamespace;
						
						_crewCount = 0;
						{ if (alive _x) then {_crewCount = _crewCount + 1} } forEach (crew _closest);
						
						if (!isNil '_get' && isNil '_sold' && _crewCount == 0) then {
							_closest setVariable ['sold',true];
							
							_defenseName = [typeof _closest, 'displayName'] Call GetConfigInfo;							
							_sellForMoney = false;
							if (!isNull(commanderTeam)) then {
								if (commanderTeam == clientTeam) then { _sellForMoney = true };
							};
							
							_txt = "";
							_selled = false;
							if (paramTrade && !(isNull COIN_RearmVehicle)) then {
								
								_repairName = [typeof COIN_RearmVehicle, 'displayName'] Call GetConfigInfo;							
								_sellForMoney = false;
								_tryFoldToVehicle = true;
								if (getDammage _closest > 0.3) then {
									hint parseText (format[ localize "STR_WF_StaticDefenseFoldDammaged", _defenseName, _repairName]);
									_tryFoldToVehicle = false;
								};
							
								if (_tryFoldToVehicle) then {
									_state = ([COIN_RearmVehicle, typeof _closest, 1] call marketChangeCargoProductValue);
									if (_state select 0) then {
										hint parseText (format[ localize "STR_WF_StaticDefenseFold", _defenseName, _repairName]);
										_logic setVariable ["BIS_COIN_restart", true];
										_selled = true;
									};
									_txt = _state select 1;
								};
							};
							
							if (_sellForMoney) then {
								_price = _get select QUERYUNITPRICE;   
								_dammage = (getDammage _closest);
								if (_dammage > 1) then { _dammage = 1; };
								round((_price/2)*(1 - _dammage)) Call ChangePlayerFunds;
								_selled = true;
							};
							
							if (_selled) then {
								deleteVehicle _closest;
							} else {
								_closest setVariable ['sold', nil];
							}
						};
					};
				};
			};
		};
	};
	//--- Key UP
	if (_mode == "keyup") then {
		_key = _input select 1;
		if (_key in BIS_CONTROL_CAM_keys) then {BIS_CONTROL_CAM_keys = BIS_CONTROL_CAM_keys - [_key]};
	};

	//--- Deselect or Close
	if (_terminate) then {
		_menu = _this select 2;

		//--- Close
		if (isNil "BIS_Coin_noExit") then {
			if (_menu == "#USER:BIS_Coin_categories_0") then {
				BIS_CONTROL_CAM cameraEffect ["terminate","back"];
				camDestroy BIS_CONTROL_CAM;
				BIS_CONTROL_CAM = nil;
			} else {
				_preview = _logic getVariable "BIS_COIN_preview";
				if !(isNil "_preview") then {deleteVehicle _preview};
				_logic setVariable ["BIS_COIN_preview",nil];
				_logic setVariable ["BIS_COIN_params",[]];
				_get = _logic getVariable 'WFBE_Helper';
				if !(isNil '_get') then {
					deleteVehicle _get;
					_logic setVariable ['WFBE_Helper',nil];
				};
			};
		};
	};

	//--- Camera no longer exists - terminate and start cleanup	
	if (isNil "BIS_CONTROL_CAM" || player != bis_coin_player || !isNil "BIS_COIN_QUIT") exitWith {
		if !(isNil "BIS_CONTROL_CAM") then {BIS_CONTROL_CAM cameraEffect ["terminate","back"];camDestroy BIS_CONTROL_CAM;};
		BIS_CONTROL_CAM = nil;
		BIS_CONTROL_CAM_Handler = nil;
		1122 cuttext ["","plain"];
		_player = bis_coin_player;
		_player setVariable ["bis_coin_logic",nil];
		bis_coin_player = objNull;
		_preview = _logic getVariable "BIS_COIN_preview";
		if !(isNil "_preview") then {deleteVehicle _preview};
		_logic setVariable ["BIS_COIN_preview",nil];
		_get = _logic getVariable 'WFBE_Helper';
		if !(isNil '_get') then {
			deleteVehicle _get;
			_logic setVariable ['WFBE_Helper',nil];
		};
		_logic setVariable ["BIS_COIN_selected",nil];
		_logic setVariable ["BIS_COIN_params",nil];
		_logic setVariable ["BIS_COIN_lastdir",nil];
		_logic setVariable ["BIS_COIN_tooltip",nil];
		_logic setVariable ["BIS_COIN_fundsOld",nil];
		_logic setVariable ["BIS_COIN_restart",nil];
		_logic setVariable ["BIS_COIN_nvg",nil];
		_logic setVariable ["WF_RequestUpdate",nil];
		showCommandingMenu "";

		//_display = finddisplay 46;
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["KeyDown",WF_COIN_DEH1];
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["KeyUp",WF_COIN_DEH2];
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonDown",WF_COIN_DEH3];
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonUp",WF_COIN_DEH4];

		//--- Behold the placeholders
		BIS_COIN_QUIT = nil;
		_border = missionNamespace getVariable "BIS_COIN_border";
		{deleteVehicle _x} forEach _border;
		missionNamespace setVariable ["BIS_COIN_border",nil];
	};
};

waitUntil {scriptDone _createBorderScope};
endLoadingScreen;


///*** LOOOP ****
_canAffordCount = 0;
_canAffordCountOld = 0;
_oldMenu = commandingMenu;
_limitHOld = -1;
_limitVOld = -1;
_loaded = false;
_localtime = time;

_maxGrad = 'WFBE_COINMAXGRADIENT' Call GetNamespace;
_minDist = 'WFBE_COINMINDISTANCE' Call GetNamespace;

while {!isNil "BIS_CONTROL_CAM"} do {
	if (isnull (uiNamespace getVariable 'BIS_CONTROL_CAM_DISPLAY') && !_loaded) then {
		cameraEffectEnableHUD true;
		1122 cutrsc ["constructioninterface","plain"];
		_loaded = true;
		_logic setVariable ["BIS_COIN_restart",true];
		_localtime = time;
	};
	if ((time - _localtime) >= 1 && _loaded) then {_loaded = false};
	_logic = bis_coin_player getVariable "bis_coin_logic";

	_mode = "mousemoving";
	_camera = BIS_CONTROL_CAM;
	
  	if (isNil "_logic") exitWith {};
	
	//--- Player dies on construction mode or the source die.
	if (!alive player || !alive _source) exitWith {
		startLoadingScreen [localize "str_coin_exit" + " " + localize "str_coin_name","RscDisplayLoadMission"];

		if !(isNil "BIS_CONTROL_CAM") then {BIS_CONTROL_CAM cameraEffect ["terminate","back"];camDestroy BIS_CONTROL_CAM;};
		BIS_CONTROL_CAM = nil;
		BIS_CONTROL_CAM_Handler = nil;
		1122 cuttext ["","plain"];
		_player = bis_coin_player;
		_player setVariable ["bis_coin_logic",nil];
		bis_coin_player = objNull;
		_preview = _logic getVariable "BIS_COIN_preview";
		if !(isNil "_preview") then {deleteVehicle _preview};
		_logic setVariable ["BIS_COIN_preview",nil];
		_get = _logic getVariable 'WFBE_Helper';
		if !(isNil '_get') then {
			deleteVehicle _get;
			_logic setVariable ['WFBE_Helper',nil];
		};
		_logic setVariable ["BIS_COIN_selected",nil];
		_logic setVariable ["BIS_COIN_params",nil];
		_logic setVariable ["BIS_COIN_lastdir",nil];
		_logic setVariable ["BIS_COIN_tooltip",nil];
		_logic setVariable ["BIS_COIN_fundsOld",nil];
		_logic setVariable ["BIS_COIN_restart",nil];
		_logic setVariable ["BIS_COIN_nvg",nil];
		_logic setVariable ["WF_RequestUpdate",nil];
		showCommandingMenu "";

		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["KeyDown",WF_COIN_DEH1];
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["KeyUp",WF_COIN_DEH2];
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonDown",WF_COIN_DEH3];
		(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonUp",WF_COIN_DEH4];

		//--- Behold the placeholders
		BIS_COIN_QUIT = nil;
		WF_COIN_DEH1 = nil;
		WF_COIN_DEH2 = nil;
		WF_COIN_DEH3 = nil;
		WF_COIN_DEH4 = nil;
		_border = missionNamespace getVariable "BIS_COIN_border";
		{deleteVehicle _x} forEach _border;
		missionNamespace setVariable ["BIS_COIN_border",nil];

		endLoadingScreen;
	};

	_areasize = (_logic getVariable "BIS_COIN_areasize");
	_limitH = _areasize select 0;
	_limitV = _areasize select 1;

	if (_limitH != _limitHOld || _limitV != _limitVOld) then {
		[_logic,_startpos] spawn _createBorder;
		BIS_CONTROL_CAM camConstuctionSetParams ([_startPos] + (_logic getVariable "BIS_COIN_areasize"));
	};
	_limitHOld = _limitH;
	_limitVOld = _limitV;
	
	_keysCancel		= actionKeys "MenuBack";
	_keysBanned		= [1];

	//--- Mouse moving or holding
	if (_mode in ["mousemoving","mouseholding"]) then {

		_x = _input select 1;
		_y = _input select 2;

		//--- Check pressed keys
		_keys = BIS_CONTROL_CAM_keys;
		_ctrl = (29 in _keys) || (157 in _keys);
		_shift = (42 in _keys) || (54 in _keys);
		_alt = (56 in _keys);

		//--- Construction or Selection
		_params = _logic getVariable "BIS_COIN_params";
		_tooltip = "empty";
		_tooltipType = "empty";
		_selected = objNull;
		if (count _params > 0) then {
			//--- Basic colors
			_colorGreen = "#(argb,8,8,3)color(0,1,0,0.3,ca)";
			_colorRed = "#(argb,8,8,3)color(1,0,0,0.3,ca)";
			_colorGray = "#(argb,8,8,3)color(1,1,1,0.1,ca)";
			_colorGray = "#(argb,8,8,3)color(0,0,0,0.25,ca)";
			_color = _colorGray;

			//--- Class, Category, Cost, (preview class), (display name)
			_itemclass = _params select 0;
			_itemcategory = _params select 1;
			_itemcost = _params select 2;
			_itemcash = 0;
			if (typename _itemcost == "ARRAY") then {_itemcash = _itemcost select 0; _itemcost = _itemcost select 1};
			_funds = _logic getVariable "BIS_COIN_funds";
			if (typename _funds == "ARRAY") then {
				_a = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
				_b = Call GetPlayerFunds;
				_funds = [_a]+[_b];
			} else {
				_funds = [Call GetPlayerFunds];
			};
			
			_itemFunds = _funds select _itemcash;
			_itemname = if (count _params > 3) then {_params select 3} else {getText (configFile >> "CfgVehicles" >> _itemclass >> "displayName")};
			_itemclass_preview = getText (configFile >> "CfgVehicles" >> _itemclass >> "ghostpreview");
			if (_itemclass_preview == "") then {_itemclass_preview = _itemclass};

			_structs = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;  
			_isBuilding = if (_itemclass in _structs) then { true; } else { false; };
			
			//--- Preview building
			_preview = camtarget BIS_CONTROL_CAM;
			_new = false;
			if (typeof _preview != _itemclass_preview) then {
				//--- No preview
				deleteVehicle _preview;
				if !(isNil {_logic getVariable "BIS_COIN_preview"}) then {deleteVehicle (_logic getVariable "BIS_COIN_preview")}; //--- Serialization hack
				_get = _logic getVariable 'WFBE_Helper';
				if !(isNil '_get') then {
					deleteVehicle _get;
					_logic setVariable ['WFBE_Helper',nil];
				};
				_hqDeployed = (sideJoinedText) Call GetSideHQDeployed;
				_index = _bns find _itemclass;
				
				// check can we unfold mhq
				_canBuild = false;
				if (_index == 0 && _hqDeployed) then {
					_mhq = (sideJoinedText) Call GetSideHQ;
					_canBuild = if (alive _mhq) then { true } else { false };
				};
				
				if (_index == 0 && _hqDeployed && _canBuild) exitWith {
					_mhq = (sideJoinedText) Call GetSideHQ;
					(_mhq) Spawn HandleHQAction;

					WFBE_RequestStructure = ['SRVFNCREQUESTSTRUCTURE',[sideJoined,_itemclass,[0,0,0],0]];
					publicVariable 'WFBE_RequestStructure';
					if (IsClientServer) then {['SRVFNCREQUESTSTRUCTURE',[sideJoined,_itemclass,[0,0,0],0]] Spawn HandleSPVF};

					['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
					
					_structuresCosts = Format["WFBE_%1STRUCTURECOSTS",sideJoinedText] Call GetNamespace;
					_supply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
					_supply = _supply - (_structuresCosts select _index);
					WF_Logic setVariable [Format ["%1Supplies",sideJoinedText],_supply,true];
					
					//////////////////////////////////////////////////
					startLoadingScreen [localize "str_coin_exit" + " " + localize "str_coin_name","RscDisplayLoadMission"];
					//////////////////////////////////////////////////

					if !(isNil "BIS_CONTROL_CAM") then {BIS_CONTROL_CAM cameraEffect ["terminate","back"];camDestroy BIS_CONTROL_CAM;};
					BIS_CONTROL_CAM = nil;
					BIS_CONTROL_CAM_Handler = nil;
					1122 cuttext ["","plain"];
					_player = bis_coin_player;
					_player setVariable ["bis_coin_logic",nil];
					bis_coin_player = objNull;
					_preview = _logic getVariable "BIS_COIN_preview";
					if !(isNil "_preview") then {deleteVehicle _preview};
					_logic setVariable ["BIS_COIN_preview",nil];
					_logic setVariable ["BIS_COIN_selected",nil];
					_logic setVariable ["BIS_COIN_params",nil];
					_logic setVariable ["BIS_COIN_lastdir",nil];
					_logic setVariable ["BIS_COIN_tooltip",nil];
					_logic setVariable ["BIS_COIN_fundsOld",nil];
					_logic setVariable ["BIS_COIN_restart",nil];
					_logic setVariable ["BIS_COIN_nvg",nil];
					_logic setVariable ["WF_RequestUpdate",nil];
					showCommandingMenu "";

					(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["KeyDown",WF_COIN_DEH1];
					(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["KeyUp",WF_COIN_DEH2];
					(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonDown",WF_COIN_DEH2];
					(uiNamespace getVariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonUp",WF_COIN_DEH3];

					//--- Behold the placeholders
					BIS_COIN_QUIT = nil;
					WF_COIN_DEH1 = nil;
					WF_COIN_DEH2 = nil;
					WF_COIN_DEH3 = nil;
					WF_COIN_DEH4 = nil;
					_border = missionNamespace getVariable "BIS_COIN_border";
					{deleteVehicle _x} forEach _border;
					missionNamespace setVariable ["BIS_COIN_border",nil];
					
					[] Spawn {
						private['_start','_mhq'];
						_start = time;
						waitUntil {!((sideJoinedText) Call GetSideHQDeployed) || time - _start > 15};
						if (time - _start < 15) then {
							sleep 2;
							_mhq = (sideJoinedText) Call GetSideHQ;
							if (alive _mhq) then {
								_mhq addAction [localize "STR_WF_Unlock_MHQ","Client\Action\Action_ToggleLock.sqf", [], 95, false, true, '', 'alive _target && locked _target'];
								_mhq addAction [localize "STR_WF_Lock_MHQ","Client\Action\Action_ToggleLock.sqf", [], 94, false, true, '', 'alive _target && !(locked _target)'];
							};
						};
					};

					endLoadingScreen;
				};
				
				_preview = _itemclass_preview createVehicleLocal (screenToWorld [0.5,0.5]);
				_gdir = _logic getVariable 'BIS_COIN_lastdir';
				if !(isNil '_gdir') then {_preview setDir _gdir};
				BIS_CONTROL_CAM camSetTarget _preview;
				BIS_CONTROL_CAM camCommit 0;
				_logic setVariable ["BIS_COIN_preview",_preview];
				_new = true;
				
				//--- Preview Helper.
				if (_itemclass in _greenList && _index != -1) then {
					_distance = (Format ["WFBE_%1STRUCTUREDISTANCES",sideJoinedText] Call GetNamespace) select _index;
					_direction = (Format ["WFBE_%1STRUCTUREDIRECTIONS",sideJoinedText] Call GetNamespace) select _index;
					_npos = [getPos _preview,_distance,getDir _preview + _direction] Call GetPositionFrom;
					_helper = "Sign_Danger" createVehicleLocal _npos;
					_helper setPos _npos;
					_helper setDir (_direction+65);
					
					_array = _preview worldToModel (getPos _helper);
					_array set [2,0];
					_helper attachTo [_preview,_array]; 
					
					_logic setVariable ['WFBE_Helper',_helper];
				};

				_preview setObjectTexture [0,_colorGray];
				_preview setVariable ["BIS_COIN_color",_colorGray];

				//--- Exception - preview not created
				if (isNull _preview) then {
					deleteVehicle _preview;
					_logic setVariable ["BIS_COIN_preview",nil];
					_logic setVariable ["BIS_COIN_params",[]];
					_get = _logic getVariable 'WFBE_Helper';
					if !(isNil '_get') then {
						deleteVehicle _get;
						_logic setVariable ['WFBE_Helper',nil];
					};
				};

			} else {
				//--- Check zone
				if (([position _preview,_startPos] call BIS_fnc_distance2D) <= _limitH) then {

					//--- No money
					_funds = 0;
					call compile format ["_funds = %1;",_itemFunds];
					_fundsRemaining = _funds - _itemcost;
					if (_fundsRemaining < 0) then {
						_color = _colorRed;
					} else {
					
						_color = _colorGreen;
						
						_isCommander = false;
						if (!isNull(commanderTeam)) then {if (commanderTeam == group player) then {_isCommander = true}};
						
						_checkPlaceZone = if (_isCommander && (_itemclass call _fnIsFreePlaceClass)) then { false } else { true };
						
						if (!_checkPlaceZone) then {
							_count = [position _preview, 10] call _fnCountFreePlaceObjects;
							if (_count > 3) then {
								_color = _colorRed;
							};
						};
						
						if (_checkPlaceZone) then {
					
							if ( !([position _preview, 50, true, _preview] call GetIsFlatPosition) ) then {
								_color = _colorRed;
							};
						};
					};
				};
				_preview setObjectTexture [0,_color];
				_preview setVariable ["BIS_COIN_color",_color];

				_tooltip = _itemclass;
				_tooltipType = "preview";

				//--- Temporary solution
				_colorGUI = [1,1,1,0.1];
				if (_color == _colorGreen) then {_colorGUI = [0.3,1,0.3,0.3]};
				if (_color == _colorRed) then {_colorGUI = [1,0.2,0.2,0.4]};

				((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112201) ctrlSetTextColor _colorGUI;
				((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112201) ctrlCommit 0;
			};

			_canBuild = if (_color == _colorGreen) then { true } else { false };
			
			if (_isBuilding && _canBuild) then {
				_mhq = (sideJoinedText) Call GetSideHQ;
				_canBuild = if (alive _mhq) then { true } else { false };
			};
			
			//--- Place
			if (_canBuild && !isnull _preview && ((BIS_CONTROL_CAM_LMB && 65536 in (actionKeys "DefaultAction")) || {_x in (actionKeys "DefaultAction")} count BIS_CONTROL_CAM_keys > 0)) then {
				_pos = position _preview;
				_dir = direction _preview;
				deleteVehicle _preview;
				_logic setVariable ["BIS_COIN_preview",nil];
				_logic setVariable ["BIS_COIN_params",[]];
				_get = _logic getVariable 'WFBE_Helper';
				if !(isNil '_get') then {
					deleteVehicle _get;
					_logic setVariable ['WFBE_Helper',nil];
				};

				//--- Remove funds
				//call compile format ["%1 = %1 - _itemcost;",_itemFunds];

				//--- Execute designer defined code
				[_logic,_itemclass,_pos,_dir,_params] spawn {
                    private ["_logic","_itemclass","_pos","_dir","_par","_noammo","_hqDeployed","_get"];
					_logic = _this select 0;
					_itemclass = _this select 1;
					_pos = _this select 2;
					_dir = _this select 3;
					_par = _this select 4;

					//--- Define the last direction used.
					_logic setVariable ["BIS_COIN_lastdir",_dir];
					
					_noammo = false;

					//--- On Purchase.
					[_logic,_itemclass] call {
						Private['_structures','_defenses','_buildForMoney','_repairName','_defenseName','_state',"_class","_costs","_index","_logic","_price","_supply"];
						_logic = _this select 0;
						_class = _this select 1;
						_structures = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;
						_defenses = Format["WFBE_%1DEFENSENAMES",sideJoinedText] Call GetNamespace;
						_costs = Format["WFBE_%1STRUCTURECOSTS",sideJoinedText] Call GetNamespace;

						//--- Structures.
						_index = _structures find _class;
						if (_index != -1) then {
							_price = _costs select _index;
							_supply = WF_Logic getVariable Format["%1Supplies",sideJoinedText];
							_supply = _supply - _price;
							WF_Logic setVariable [Format["%1Supplies",sideJoinedText],_supply,true];
							if (_index == 0) then {
								_hqDeployed = (sideJoinedText) Call GetSideHQDeployed;
								if (_hqDeployed) then {
									['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
								} else {
									['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile preprocessFile "Client\Init\Init_Coin.sqf";
								};
								_logic setVariable ["BIS_COIN_restart",true];
							} else {
								WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERBUILDSCORE' Call GetNamespace)]];
								publicVariable 'WFBE_RequestChangeScore';
								if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERBUILDSCORE' Call GetNamespace)]] Spawn HandleSPVF};
							};
						};
						
						//--- Defense.
						_get = _class Call GetNamespace;
						if !(isNil '_get') then {
							
							_buildForMoney = (isNull COIN_RearmVehicle);
							if (paramTrade && !isNull COIN_RearmVehicle) then {
								_repairName = [typeof COIN_RearmVehicle, 'displayName'] Call GetConfigInfo;
								_defenseName = [_class, 'displayName'] Call GetConfigInfo;
							
								_state = ([COIN_RearmVehicle, _class, -1] call marketChangeCargoProductValue);
								if (_state select 0) then {
									_buildForMoney = false;
									_logic setVariable ["BIS_COIN_restart", true];
									_noammo = true;
									
									hint parseText (format[ localize "STR_WF_StaticDefenseUnfold", _defenseName, _repairName]);																
								};						
							};
							
							if (_buildForMoney) then {
								_price = _get select QUERYUNITPRICE;
								-_price Call ChangePlayerFunds;
							};
						};
					};

					//--- Execute designer defined code On Construct
					[_logic,_itemclass,_pos,_dir,_par, _noammo] call {    
						private ['_current',"_class","_defenses","_deployed","_dir",'_find',"_logic","_par","_pos","_structures"];
						_logic = _this select 0;
						_class = _this select 1;
						_pos = _this select 2;
						_dir = _this select 3;
						_par = _this select 4;
						_noammo = _this select 5;
						_deployed = (sideJoinedText) Call GetSideHQDeployed;
						_structures = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;
						_defenses = Format["WFBE_%1DEFENSENAMES",sideJoinedText] Call GetNamespace;
						
						_find = _structures find _class;
						if (_find != -1) then {
							//--- Increment the buildings.
							if ((_find - 1) > -1) then {
								_current = Call Compile Format ['%1BuildingsCurrent',sideJoinedText];
								_current set [_find - 1, (_current select (_find-1)) + 1];
								Call Compile Format ['%1BuildingsCurrent = _current',sideJoinedText];
								publicVariable Format ['%1BuildingsCurrent',sideJoinedText];
							};
							
							WFBE_RequestStructure = ['SRVFNCREQUESTSTRUCTURE',[sideJoined,_class,_pos,_dir]];
							publicVariable 'WFBE_RequestStructure';
							if (IsClientServer) then {['SRVFNCREQUESTSTRUCTURE',[sideJoined,_class,_pos,_dir]] Spawn HandleSPVF};
						};
						if (_class in _defenses) then {
							WFBE_RequestDefense = ['SRVFNCREQUESTDEFENSE',[sideJoined,_class,_pos,_dir,manningDefense, _noammo]];
							publicVariable 'WFBE_RequestDefense';
							if (IsClientServer) then {['SRVFNCREQUESTDEFENSE',[sideJoined,_class,_pos,_dir,manningDefense, _noammo]] Spawn HandleSPVF};
							lastBuilt = _par;
						};
					};
				};

				//--- Temporary solution
				_colorGUI = [1,1,1,0.1];
				((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112201) ctrlSetTextColor _colorGUI;
				((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112201) ctrlCommit 0;
			};
		} else {
			_colorGUI = [1,1,1,0.1];
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112201) ctrlSetTextColor _colorGUI;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112201) ctrlCommit 0;
		};

		_oldTooltip = _logic getVariable "BIS_COIN_tooltip";
		if ((_tooltipType + _tooltip) != _oldTooltip || commandingMenu != _oldMenu || _logic getVariable "WF_RequestUpdate") then {
			_logic setVariable ["WF_RequestUpdate",false];
			
			//--- Description
			_type = _tooltip;

			//--- Header & preview picture
			_textHeader = "<t size='1.2'><br /></t>";
			_textPicture = "<t size='2.8'><br /></t><br /><br />";
			_fileIcon = getText (configFile >> "cfgvehicles" >> _type >> "icon");
			if (str(configFile >> "CfgVehicleIcons" >> _fileIcon) != "") then {_fileIcon = getText (configFile >> "CfgVehicleIcons" >> _fileIcon)};
			_filePicture = getText (configFile >> "cfgvehicles" >> _type >> "picture");
			if (str(configFile >> "CfgVehicleIcons" >> _filePicture) != "") then {_filePicture = getText (configFile >> "CfgVehicleIcons" >> _filePicture)};

			if (_tooltipType != "empty") then {
				_textHeader = format ["<t align='center'><t size='1.4'>%1</t><br /><t size='1'></t></t>",
					getText (configFile >> "cfgvehicles" >> _type >> "displayname"),
					if (isnull _selected) then {""} else {str round ((1 - damage _selected) * 100) + "%"}
				];
				_textPicture = format ["<t align='left' size='2.8' shadow='0'><img image='%1'/></t> ",_filePicture];
			};

            _text1 = if (count _params > 0) then {localize "str_coin_rotate" + "<t align='right'>" + (call compile (keyname 29)) + "</t><br />"} else {"<br />"};
			
			_status = if (manningDefense) then {"Enabled"} else {"Disabled"};
            _text2 = if (count _params > 0) then {localize "str_coin_build" + "<t align='right'>" + (call compile (actionKeysNames ["DefaultAction",1])) + "</t><br />"} else {localize "STR_WF_Gameplay_AutoDefense" + ":<t align='right'>" + _status + "</t><br />"};

			_text3 = if (commandingMenu != "#USER:BIS_Coin_categories_0") then {
				//--- Back hint
				if (isNil "BIS_Coin_noExit") then {
                    localize "str_coin_back" + "<t align='right'>" + (call compile (actionKeysNames ["MenuBack",1])) + "</t>";
				} else {""};
			} else {
			
				//--- Exit hint
				if (isNil "BIS_Coin_noExit") then {
                    "<t color='#ff5544'>" + localize "str_coin_exit" + "<t align='right'>" + (call compile (actionKeysNames ["MenuBack",1])) + "</t></t>";
				} else {""};
			};

			//--- Compose text
			_textHint = (
			 	_textPicture + 
				_textHeader + 
				""
			);

			_textControls = (
				_text1 + 
				_text2 + 
				_text3 + 
				""
			);

			//--- Set box
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112211) ctrlShow true;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112211) ctrlCommit 0;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112214) ctrlSetStructuredText (parseText _textHint);
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112214) ctrlShow true;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112214) ctrlCommit 0;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112215) ctrlSetStructuredText (parseText _textControls);
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112215) ctrlShow true;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112215) ctrlCommit 0;
		};

		//--- Amount of funds changed
		_funds = _logic getVariable "BIS_COIN_funds";
		if (typename _funds == "ARRAY") then {
			_a = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
			_b = Call GetPlayerFunds;
			_funds = [_a]+[_b];
		} else {
			_funds = [Call GetPlayerFunds];
		};
		_fundsDescription = _logic getVariable "BIS_COIN_fundsDescription";
		_cashValues = [];
		{_cashValues = _cashValues + [_x]} forEach _funds;
		_cashValuesOld = _logic getVariable "BIS_COIN_fundsOld";
		if (isNil "_cashValuesOld") then {_cashValuesOld = []; _cashValuesOld set [count _cashValues - 1,-1]};
		_restart = _logic getVariable "BIS_COIN_restart";
		if (!([_cashValues,_cashValuesOld] call bis_fnc_arraycompare) || _restart) then {
			_cashValuesCount = count _cashValues;
			_cashSize = if (_cashValuesCount <= 1) then {2} else {2.8 / _cashValuesCount};
			_cashText = format ["<t size='%1' align='left' valign='middle'>",_cashSize];
			_cashLines = 0;
			for "_i" from 0 to (count _funds - 1) do {
				_cashValue = _cashValues select _i;
				_cashDescription = if (count _fundsDescription > _i) then {_fundsDescription select _i} else {"?"};
				_cashText = _cashText + format ["%1 %2<br />",_cashDescription,round _cashValue];
				_cashLines = _cashLines + 0.05;
			};
			_cashText = _cashText + "</t>";
			_cashPos = ctrlPosition ((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112224);
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112224) ctrlSetStructuredText (parseText _cashText);
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112224) ctrlSetPosition [_cashPos select 0,_cashPos select 1,_cashPos select 2,(_cashPos select 3)/*0.1*/ + _cashLines];
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112224) ctrlShow true;
			((uiNamespace getVariable "BIS_CONTROL_CAM_DISPLAY") displayCtrl 112224) ctrlCommit 0;

			//--- Categories menu
			_categories = +(_logic getVariable "BIS_COIN_categories");
			_categoriesMenu = [];
			//--- Ammo Upgrade.
			_upgrades = (sideJoinedText) Call GetSideUpgrades;
			if (_upgrades select 14 < 1) then {_categories = _categories - [localize 'STR_WF_Ammo']}; 
			
			for "_i" from 0 to (count _categories - 1) do {
				_categoriesMenu = _categoriesMenu + [_i];
			};

			[["Categories",true],"BIS_Coin_categories",[_categoriesMenu,_categories],"#USER:BIS_Coin_%1_items_0","",""] call BIS_fnc_createmenu;

			//--- Items menu
			_items = _logic getVariable "BIS_COIN_items";
			_canAffordCountOld = _canAffordCount;
			_canAffordCount = 0;
			for "_i" from 0 to (count _categories - 1) do {
				_category = _categories select _i;
				_arrayNames = [];
				_arrayNamesLong = [];
				_arrayEnable = [];
				_arrayParams = [];
				{
					_itemclass = _x select 0;
					_itemcategory = _x select 1;
					if (typename _itemcategory == typename "") then {//--- Backward compatibility
						_itemcategory = _categories find _itemcategory;
					} else {100};

					if (_itemcategory < count _categories) then {
						_itemcost = _x select 2;
						_itemcash = 0;
						if (typename _itemcost == "ARRAY") then {_itemcash = _itemcost select 0; _itemcost = _itemcost select 1};
						_cashValue = _cashValues select _itemcash;
						_cashDescription = if (count _fundsDescription > _itemcash) then {_fundsDescription select _itemcash} else {"?"};
						_itemname = if (count _x > 3) then {_x select 3} else {getText (configFile >> "CfgVehicles" >> _itemclass >> "displayName")};
						//--- Build Limit reached?
						_buildLimit = false;
						_find = _buildingsNames find _itemclass;
						if (_find != -1) then {
							_buildings = (sideJoinedText) Call GetSideStructures;
							_current = Call Compile Format ['%1BuildingsCurrent',sideJoinedText];
							_limit = (Format['WFBE_BUILDINGMAX%1',(_buildingsType select _find)]) Call GetNamespace;
							if (isNil '_limit') then {_limit = 4}; //--- Default.
							if ((_current select _find) >= _limit) then {_buildLimit = true};
						};
						if (_itemcategory == _i/*_category*/) then {
						
							_canAfford = if (_cashValue - _itemcost >= 0 && !_buildLimit) then {1} else {0};
							_text = _itemname + " - " + _cashDescription + str _itemcost;
							
							if (paramTrade && (!isNull COIN_RearmVehicle)) then {
								_defenseId = _itemclass call marketGetProductIdByType;
//								format["coin_menu_item: %1 %2", _defenseId, _itemclass] call LogHigh;
								if (_defenseId != -1) then {
									_count = if (!isNull COIN_RearmVehicle) then {[COIN_RearmVehicle, _defenseId] call marketGetProductValue} else {0};
									if (_count == 0) then { _canAfford = 0; };
									_text = _itemname;
									if (_count > 0) then { 
										_text = _text + format[localize "STR_WF_StaticDefenseLeft", _itemname, _count] };
								};								
							};
						
							_canAffordCount = _canAffordCount + _canAfford;

							_arrayNames = _arrayNames + [_text];
							_arrayNamesLong = _arrayNamesLong + [_text + "                   "];
							_arrayEnable = _arrayEnable + [_canAfford];
							_arrayParams = _arrayParams + [[_logic getVariable "BIS_COIN_ID"] + [_x,_i]];
						};  
					};
				} forEach _items;
				
				[[_category,true],format ["BIS_Coin_%1_items",_i],[_arrayNames,_arrayNamesLong,_arrayEnable],"","
					BIS_CONTROL_CAM_LMB = false;
					scopename 'main';
					_item = '%1';
					_id = %2;
					_array = (call compile '%3') select _id;
					_logic = call compile ('BIS_COIN_'+ str (_array select 0));

					_params = _array select 1;
					_logic setVariable ['BIS_COIN_params',_params];
					_logic setVariable ['BIS_COIN_menu',commandingMenu];
					showCommandingMenu '';

				",_arrayParams] call BIS_fnc_createmenu;	
			};

			if (_canAffordCount != _canAffordCountOld) then {showCommandingMenu (commandingMenu)}; //<-- Open menu again to show disabled items
		};
		_logic setVariable ["BIS_COIN_fundsOld",_cashValues];
		_logic setVariable ["BIS_COIN_tooltip",_tooltipType + _tooltip];

		if (_restart) then {
			_logic setVariable ["BIS_COIN_restart",false];
		};
	};
	_oldMenu = commandingMenu;
	sleep 0.01;
};

showCommandingMenu '';
