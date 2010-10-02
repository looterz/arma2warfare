_logic = _this select 3;
_startPos = _this select 4;
_source = _this select 5;

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

if (_tooFar) exitWith {hint  (localize 'STR_WF_BaseArea_Reached')};//--- Base area reached.

uinamespace setvariable ["COIN_displayMain",finddisplay 46];

//--- Terminate of system is already running
if !(isnil {player getvariable "bis_coin_logic"}) exitwith {};
player setvariable ["bis_coin_logic",_logic];
bis_coin_player = player;

_camera = BIS_CONTROL_CAM;
if (isnil "BIS_CONTROL_CAM") then {
	_camera = "camconstruct" camcreate [position player select 0,position player select 1,15];
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
showcinemaborder false;

1122 cutrsc ["constructioninterface","plain"];

//--- Prevent uikey override for other mods.
WF_COIN_DEH1 = (uinamespace getvariable "COIN_displayMain") displayAddEventHandler ["KeyDown",		"if !(isnil 'BIS_CONTROL_CAM_Handler') then {BIS_temp = ['keydown',_this,commandingmenu] spawn BIS_CONTROL_CAM_Handler; BIS_temp = nil;}"];
WF_COIN_DEH2 = (uinamespace getvariable "COIN_displayMain") displayAddEventHandler ["KeyUp",		"if !(isnil 'BIS_CONTROL_CAM_Handler') then {BIS_temp = ['keyup',_this] spawn BIS_CONTROL_CAM_Handler; BIS_temp = nil;}"];
WF_COIN_DEH3 = (uinamespace getvariable "COIN_displayMain") displayAddEventHandler ["MouseButtonDown",	"if !(isnil 'BIS_CONTROL_CAM_Handler') then {BIS_temp = ['mousedown',_this,commandingmenu] spawn BIS_CONTROL_CAM_Handler; BIS_temp = nil; BIS_CONTROL_CAM_onMouseButtonDown = _this; if (_this select 1 == 1) then {BIS_CONTROL_CAM_RMB = true}; if (_this select 1 == 0) then {BIS_CONTROL_CAM_LMB = true};}"];
WF_COIN_DEH4 = (uinamespace getvariable "COIN_displayMain") displayAddEventHandler ["MouseButtonUp",	"if !(isnil 'BIS_CONTROL_CAM_Handler') then {BIS_CONTROL_CAM_RMB = false; BIS_CONTROL_CAM_LMB = false;}"];

BIS_CONTROL_CAM_keys = [];

if (isnil "BIS_CONTROL_CAM_ASL") then {
	createcenter sidelogic;
	_logicGrp = creategroup sidelogic;
	_logicASL = _logicGrp createunit ["Logic",position player,[],0,"none"];
	BIS_CONTROL_CAM_ASL = _logicASL;
};

_logic setvariable ["BIS_COIN_selected",objnull];
_logic setvariable ["BIS_COIN_params",[]];
_logic setvariable ["BIS_COIN_tooltip",""];
_logic setvariable ["BIS_COIN_menu","#USER:BIS_Coin_categories_0"];
_logic setvariable ["BIS_COIN_restart",true];
_logic setVariable ["WF_RequestUpdate",false];
_get = _logic getVariable 'WF_NVGPersistent';
_nvgstate = true;
if (isNil '_get') then {
	_nvgstate = if (daytime > 18.5 || daytime < 5.5) then {true} else {false};
	_logic setVariable ['WF_NVGPersistent',_nvgstate];
} else {
	_nvgstate = _logic getVariable 'WF_NVGPersistent';
};
camusenvg _nvgstate;
_logic setvariable ["BIS_COIN_nvg",_nvgstate];

_bns = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;
_greenList = [WESTBAR,WESTLVF,WESTHEAVY,WESTAIR,EASTBAR,EASTLVF,EASTHEAVY,EASTAIR];
//--- Building Limit Init.
_buildingsNames = _bns;
_buildingsNames = _buildingsNames - [_buildingsNames select 0];
_buildingsType = Format["WFBE_%1STRUCTURES",sideJoinedText] Call GetNamespace;
_buildingsType = _buildingsType - [_buildingsType select 0];

//--- Open menu
_logic spawn {
	_logic = _this;
	waituntil {!isnil {_this getvariable "BIS_COIN_fundsOld"}};
	while {!isnil "BIS_CONTROL_CAM"} do {
		waituntil {
			_params = _logic getvariable "BIS_COIN_params";
			if (isnil "_params") then {_params = []};
			(commandingmenu == "" && count _params == 0 && !BIS_CONTROL_CAM_RMB) || isnil "BIS_CONTROL_CAM"
		};
		if (isnil "BIS_CONTROL_CAM") exitwith {};
		showcommandingmenu "#USER:BIS_Coin_categories_0";
		sleep 0.01;
	};
};

//--- Border - temporary solution //TODO: move border if position of logic changes (eg. by placing hq)
_createBorder = {
	_logic = _this select 0;
	_startpos = _this select 1;
	_oldBorder = missionnamespace getvariable "BIS_COIN_border";
	if (!isnil "_oldBorder") then {
		{deletevehicle _x} foreach _oldBorder;
	};
	missionnamespace setvariable ["BIS_COIN_border",nil];
	
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
		_dir = (360 / _total) * _i;
		_xpos = (_center select 0) + (sin _dir * _size);
		_ypos = (_center select 1) + (cos _dir * _size);
		_zpos = (_center select 2);

		_a = "transparentwall" createvehiclelocal [_xpos,_ypos,_zpos];
		_a setposasl [_xpos,_ypos,0];
		_a setdir (_dir + 90);
		_border = _border + [_a];
	};
	missionnamespace setvariable ["BIS_COIN_border",_border];
};
_createBorderScope = [_logic,_startpos] spawn _createBorder;

//--- This block is pretty important
if !(isnil "BIS_CONTROL_CAM_Handler") exitwith {endLoadingScreen};

BIS_CONTROL_CAM_Handler = {
	_mode = _this select 0;
	_input = _this select 1;
	_camera = BIS_CONTROL_CAM;
	_logic = bis_coin_player getvariable "bis_coin_logic";
	_terminate = false;
  
  	if (isnil "_logic") exitwith {};

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
		if (_key in _keysCancel && isnil "BIS_Coin_noExit") then {_terminate = true};

		//--- Start NVG
		if (_key in _keyNightVision) then {
			_NVGstate = !(_logic getvariable "BIS_COIN_nvg");
			_logic setvariable ["BIS_COIN_nvg",_NVGstate];
			_logic setVariable ['WF_NVGPersistent',_NVGstate];
			camusenvg _NVGstate;
		};
		
		//--- Last Built Defense (Ctrl + L).
		if (_key == 38 && _ctrl && count lastBuilt > 0) then {
			_currentCash = Call GetPlayerFunds;
			if (_currentCash > (lastBuilt select 2) select 1) then {
				showcommandingmenu '';
				_logic setvariable ["BIS_COIN_params",lastBuilt];
			};
		};
		
		//--- Manning Defense (Ctrl + M).
		if (_key == 39 && _ctrl && paramAutoDefense) then {
			if (manningDefense) then {manningDefense = false} else {manningDefense = true};
			_status = if (manningDefense) then {"Enabled"} else {"Disabled"};
			_logic setVariable ["WF_RequestUpdate",true];
		};
		
		//--- Sell Defense. (Commander only) (Ctrl + K).
		if (_key == 37 && _ctrl && !isNull(commanderTeam)) then {
			if(commanderTeam == clientTeam) then {
				_preview = _logic getvariable "BIS_COIN_preview";
				if (isNil "_preview") then {//--- Proceed when there is no preview.
					_targeting = screenToWorld [0.5,0.5];
					_near = nearestObjects [_targeting,Format["WFBE_%1DEFENSENAMES",sideJoinedText] Call GetNamespace,25];
					if (count _near > 0) then {
						_closest = _near select 0;
						_closestType = typeOf (_closest);
						_get = _closestType Call GetNamespace;
						if !(isNil '_get') then {
							_price = _get select QUERYUNITPRICE;
							if (!(isNil "townDefenceRange")) then {
								if (townDefenceRange) then {
									_price = (ceil(_price * 0.25 /10))*10;							
									if (_price < 10) then {
										_price = 10;
									};		
								};	
							};	   
							(_price/2) Call ChangePlayerFunds;
							deleteVehicle _closest;
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
		if (isnil "BIS_Coin_noExit") then {
			if (_menu == "#USER:BIS_Coin_categories_0") then {
				BIS_CONTROL_CAM cameraeffect ["terminate","back"];
				camdestroy BIS_CONTROL_CAM;
				BIS_CONTROL_CAM = nil;
			} else {
				_preview = _logic getvariable "BIS_COIN_preview";
				if !(isnil "_preview") then {deletevehicle _preview};
				_logic setvariable ["BIS_COIN_preview",nil];
				_logic setvariable ["BIS_COIN_params",[]];
				_get = _logic getVariable 'WFBE_Helper';
				if !(isNil '_get') then {
					deleteVehicle _get;
					_logic setVariable ['WFBE_Helper',nil];
				};
			};
		};
	};

	//--- Camera no longer exists - terminate and start cleanup	
	if (isnil "BIS_CONTROL_CAM" || player != bis_coin_player || !isnil "BIS_COIN_QUIT") exitwith {
		if !(isnil "BIS_CONTROL_CAM") then {BIS_CONTROL_CAM cameraeffect ["terminate","back"];camdestroy BIS_CONTROL_CAM;};
		BIS_CONTROL_CAM = nil;
		BIS_CONTROL_CAM_Handler = nil;
		1122 cuttext ["","plain"];
		_player = bis_coin_player;
		_player setvariable ["bis_coin_logic",nil];
		bis_coin_player = objnull;
		_preview = _logic getvariable "BIS_COIN_preview";
		if !(isnil "_preview") then {deletevehicle _preview};
		_logic setvariable ["BIS_COIN_preview",nil];
		_get = _logic getVariable 'WFBE_Helper';
		if !(isNil '_get') then {
			deleteVehicle _get;
			_logic setVariable ['WFBE_Helper',nil];
		};
		_logic setvariable ["BIS_COIN_selected",nil];
		_logic setvariable ["BIS_COIN_params",nil];
		_logic setvariable ["BIS_COIN_lastdir",nil];
		_logic setvariable ["BIS_COIN_tooltip",nil];
		_logic setvariable ["BIS_COIN_fundsOld",nil];
		_logic setvariable ["BIS_COIN_restart",nil];
		_logic setvariable ["BIS_COIN_nvg",nil];
		_logic setVariable ["WF_RequestUpdate",nil];
		showcommandingmenu "";

		//_display = finddisplay 46;
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["KeyDown",WF_COIN_DEH1];
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["KeyUp",WF_COIN_DEH2];
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonDown",WF_COIN_DEH3];
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonUp",WF_COIN_DEH4];

		//--- Behold the placeholders
		BIS_COIN_QUIT = nil;
		_border = missionnamespace getvariable "BIS_COIN_border";
		{deletevehicle _x} foreach _border;
		missionnamespace setvariable ["BIS_COIN_border",nil];
	};
};

waituntil {scriptdone _createBorderScope};
endLoadingScreen;


///*** LOOOP ****
_canAffordCount = 0;
_canAffordCountOld = 0;
_oldMenu = commandingmenu;
_limitHOld = -1;
_limitVOld = -1;
_loaded = false;
_localtime = time;

while {!isnil "BIS_CONTROL_CAM"} do {
	if (isnull (uinamespace getvariable 'BIS_CONTROL_CAM_DISPLAY') && !_loaded) then {
		cameraEffectEnableHUD true;
		1122 cutrsc ["constructioninterface","plain"];
		_loaded = true;
		_logic setvariable ["BIS_COIN_restart",true];
		_localtime = time;
	};
	if ((time - _localtime) >= 1 && _loaded) then {_loaded = false};
	_logic = bis_coin_player getvariable "bis_coin_logic";

	_mode = "mousemoving";
	_camera = BIS_CONTROL_CAM;
	
  	if (isnil "_logic") exitwith {};
	
	//--- Player dies on construction mode or the source die.
	if (!alive player || !alive _source) exitWith {
		startLoadingScreen [localize "str_coin_exit" + " " + localize "str_coin_name","RscDisplayLoadMission"];

		if !(isnil "BIS_CONTROL_CAM") then {BIS_CONTROL_CAM cameraeffect ["terminate","back"];camdestroy BIS_CONTROL_CAM;};
		BIS_CONTROL_CAM = nil;
		BIS_CONTROL_CAM_Handler = nil;
		1122 cuttext ["","plain"];
		_player = bis_coin_player;
		_player setvariable ["bis_coin_logic",nil];
		bis_coin_player = objnull;
		_preview = _logic getvariable "BIS_COIN_preview";
		if !(isnil "_preview") then {deletevehicle _preview};
		_logic setvariable ["BIS_COIN_preview",nil];
		_get = _logic getVariable 'WFBE_Helper';
		if !(isNil '_get') then {
			deleteVehicle _get;
			_logic setVariable ['WFBE_Helper',nil];
		};
		_logic setvariable ["BIS_COIN_selected",nil];
		_logic setvariable ["BIS_COIN_params",nil];
		_logic setvariable ["BIS_COIN_lastdir",nil];
		_logic setvariable ["BIS_COIN_tooltip",nil];
		_logic setvariable ["BIS_COIN_fundsOld",nil];
		_logic setvariable ["BIS_COIN_restart",nil];
		_logic setvariable ["BIS_COIN_nvg",nil];
		_logic setVariable ["WF_RequestUpdate",nil];
		showcommandingmenu "";

		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["KeyDown",WF_COIN_DEH1];
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["KeyUp",WF_COIN_DEH2];
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonDown",WF_COIN_DEH3];
		(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonUp",WF_COIN_DEH4];

		//--- Behold the placeholders
		BIS_COIN_QUIT = nil;
		WF_COIN_DEH1 = nil;
		WF_COIN_DEH2 = nil;
		WF_COIN_DEH3 = nil;
		WF_COIN_DEH4 = nil;
		_border = missionnamespace getvariable "BIS_COIN_border";
		{deletevehicle _x} foreach _border;
		missionnamespace setvariable ["BIS_COIN_border",nil];

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
		_params = _logic getvariable "BIS_COIN_params";
		_tooltip = "empty";
		_tooltipType = "empty";
		_selected = objnull;
		if (count _params > 0) then {
			//--- Basic colors
			_colorGreen = "#(argb,8,8,3)color(0,1,0,0.3,ca)";
			_colorRed = "#(argb,8,8,3)color(1,0,0,0.3,ca)";
			_colorGray = "#(argb,8,8,3)color(1,1,1,0.1,ca)";
			_colorGray = "#(argb,8,8,3)color(0,0,0,0.25,ca)";
			_color = _colorGreen;

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
			_itemname = if (count _params > 3) then {_params select 3} else {gettext (configfile >> "CfgVehicles" >> _itemclass >> "displayName")};
			_itemclass_preview = gettext (configfile >> "CfgVehicles" >> _itemclass >> "ghostpreview");
			if (_itemclass_preview == "") then {_itemclass_preview = _itemclass};

			_structs = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;  
			_isBuilding = _itemclass in _structs;
			
			//--- Preview building
			_preview = camtarget BIS_CONTROL_CAM;
			if (typeof _preview != _itemclass_preview) then {
				//--- No preview
				deletevehicle _preview;
				if !(isnil {_logic getvariable "BIS_COIN_preview"}) then {deletevehicle (_logic getvariable "BIS_COIN_preview")}; //--- Serialization hack
				_get = _logic getVariable 'WFBE_Helper';
				if !(isNil '_get') then {
					deleteVehicle _get;
					_logic setVariable ['WFBE_Helper',nil];
				};
				_hqDeployed = WF_Logic getVariable Format ["%1MHQDeployed",sideJoinedText];
				_index = _bns find _itemclass;
				if (_index == 0 && _hqDeployed) exitWith {

					WFBE_RequestStructure = ['SRVFNCREQUESTSTRUCTURE',[sideJoined,_itemclass,[0,0,0],0]];
					publicVariable 'WFBE_RequestStructure';
					if !(isMultiplayer) then {['SRVFNCREQUESTSTRUCTURE',[sideJoined,_itemclass,[0,0,0],0]] Spawn HandleSPVF};

					['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile PreprocessFile "Client\Init\Init_Coin.sqf";
					
					_structuresCosts = Format["WFBE_%1STRUCTURECOSTS",sideJoinedText] Call GetNamespace;
					_supply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
					_supply = _supply - (_structuresCosts select _index);
					WF_Logic setVariable [Format ["%1Supplies",sideJoinedText],_supply,true];
					
					//////////////////////////////////////////////////
					startLoadingScreen [localize "str_coin_exit" + " " + localize "str_coin_name","RscDisplayLoadMission"];
					//////////////////////////////////////////////////

					if !(isnil "BIS_CONTROL_CAM") then {BIS_CONTROL_CAM cameraeffect ["terminate","back"];camdestroy BIS_CONTROL_CAM;};
					BIS_CONTROL_CAM = nil;
					BIS_CONTROL_CAM_Handler = nil;
					1122 cuttext ["","plain"];
					_player = bis_coin_player;
					_player setvariable ["bis_coin_logic",nil];
					bis_coin_player = objnull;
					_preview = _logic getvariable "BIS_COIN_preview";
					if !(isnil "_preview") then {deletevehicle _preview};
					_logic setvariable ["BIS_COIN_preview",nil];
					_logic setvariable ["BIS_COIN_selected",nil];
					_logic setvariable ["BIS_COIN_params",nil];
					_logic setvariable ["BIS_COIN_lastdir",nil];
					_logic setvariable ["BIS_COIN_tooltip",nil];
					_logic setvariable ["BIS_COIN_fundsOld",nil];
					_logic setvariable ["BIS_COIN_restart",nil];
					_logic setvariable ["BIS_COIN_nvg",nil];
					_logic setVariable ["WF_RequestUpdate",nil];
					showcommandingmenu "";

					(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["KeyDown",WF_COIN_DEH1];
					(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["KeyUp",WF_COIN_DEH2];
					(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonDown",WF_COIN_DEH2];
					(uinamespace getvariable "COIN_displayMain") displayRemoveEventHandler ["MouseButtonUp",WF_COIN_DEH3];

					//--- Behold the placeholders
					BIS_COIN_QUIT = nil;
					WF_COIN_DEH1 = nil;
					WF_COIN_DEH2 = nil;
					WF_COIN_DEH3 = nil;
					WF_COIN_DEH4 = nil;
					_border = missionnamespace getvariable "BIS_COIN_border";
					{deletevehicle _x} foreach _border;
					missionnamespace setvariable ["BIS_COIN_border",nil];
					
					[] Spawn {
						_hqDeployed = WF_Logic getVariable Format ["%1MHQDeployed",sideJoinedText];
						_start = time;
						waitUntil {_hqDeployed = WF_Logic getVariable Format ["%1MHQDeployed",sideJoinedText];!_hqDeployed || time - _start > 15};
						if (time - _start < 15) then {
							sleep 2;
							_mhq = WF_Logic getVariable Format ["%1MHQ",sideJoinedText];
							if (alive _mhq) then {
								_mhq addAction [localize "STR_WF_Unlock_MHQ","Client\Action\Action_ToggleLock.sqf", [], 95, false, true, '', 'alive _target && locked _target'];
								_mhq addAction [localize "STR_WF_Lock_MHQ","Client\Action\Action_ToggleLock.sqf", [], 94, false, true, '', 'alive _target && !(locked _target)'];
							};
						};
					};

					endLoadingScreen;
				};
				
				_preview = _itemclass_preview createvehiclelocal (screentoworld [0.5,0.5]);
				BIS_CONTROL_CAM camsettarget _preview;
				BIS_CONTROL_CAM camcommit 0;
				_logic setvariable ["BIS_COIN_preview",_preview];
				
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
				_preview setvariable ["BIS_COIN_color",_colorGray];

				//--- Exception - preview not created
				if (isnull _preview) then {
					deletevehicle _preview;
					_logic setvariable ["BIS_COIN_preview",nil];
					_logic setvariable ["BIS_COIN_params",[]];
					_get = _logic getVariable 'WFBE_Helper';
					if !(isNil '_get') then {
						deleteVehicle _get;
						_logic setVariable ['WFBE_Helper',nil];
					};
				};

			} else {
				//--- Check zone
				if (
					([position _preview,_startPos] call BIS_fnc_distance2D) > _limitH
				) then {
					_color = _colorGray
				} else {

					//--- No money
					_funds = 0;
					call compile format ["_funds = %1",_itemFunds];
					_fundsRemaining = _funds - _itemcost;
					if (_fundsRemaining < 0) then {_color = _colorRed};
					
					_list = position _preview nearObjects 50;
					
					{	
						if (_color != _colorRed && _x != _preview) then {
							_positionBuilding = position _x;
							_sizeBuilding = (sizeof typeof _x)/2.9;
							_meters = _preview distance _positionBuilding;
							
							if (_meters < _sizeBuilding) then 
							{
								_color = _colorRed;
								//hint Format['%1 dist %2 = %3 (%4)', typeof _x, typeof _preview, _meters, _sizeBuilding] ;
							};						
						};
					} forEach _list;
					
					if (_color != _colorRed) then { hint ''; };

					if (_isBuilding) then {
 						//--- No Place To Build
						_isFlat = (position _preview) isflatempty [
								(sizeof typeof _preview) / 128,	//--- Minimal distance from another object
							0,				//--- If 0, just check position. If >0, select new one
							0.7,				//--- Max gradient
							(sizeof typeof _preview),	//--- Gradient area
							0,				//--- 0 for restricted water, 2 for required water,
							false,				//--- True if some water can be in 25m radius
							_preview			//--- Ignored object
					];
					//if (count _isFlat == 0) then {_color = _colorRed};
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

				((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112201) ctrlsettextcolor _colorGUI;
				((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112201) ctrlcommit 0;
			};

			//--- Place
			if (!isnull _preview && ((BIS_CONTROL_CAM_LMB && 65536 in (actionKeys "DefaultAction")) || {_x in (actionKeys "DefaultAction")} count BIS_CONTROL_CAM_keys > 0) && _color == _colorGreen) then {
				_pos = position _preview;
				_dir = direction _preview;
				deletevehicle _preview;
				_logic setvariable ["BIS_COIN_preview",nil];
				_logic setvariable ["BIS_COIN_params",[]];
				_get = _logic getVariable 'WFBE_Helper';
				if !(isNil '_get') then {
					deleteVehicle _get;
					_logic setVariable ['WFBE_Helper',nil];
				};

				//--- Remove funds
				call compile format ["%1 = %1 - _itemcost",_itemFunds];

				//--- Execute designer defined code
				[_logic,_itemclass,_pos,_dir,_params] spawn {
					_logic = _this select 0;
					_itemclass = _this select 1;
					_pos = _this select 2;
					_dir = _this select 3;
					_par = _this select 4;

					//--- On Purchase.
					[_logic,_itemclass] call {
						Private["_cash","_class","_costs","_index","_logic","_price","_supply"];
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
								_hqDeployed = WF_Logic getVariable Format ["%1MHQDeployed",sideJoinedText];
								if (_hqDeployed) then {
									['WFBE_AREAHQUNDEPLOYED' Call GetNamespace,false,MCoin] Call Compile PreprocessFile "Client\Init\Init_Coin.sqf";
								} else {
									['WFBE_AREAHQDEPLOYED' Call GetNamespace,true,MCoin] Call Compile PreprocessFile "Client\Init\Init_Coin.sqf";
								};
								_logic setVariable ["BIS_COIN_restart",true];
							} else {
								WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERBUILDSCORE' Call GetNamespace)]];
								publicVariable 'WFBE_RequestChangeScore';
								if !(isMultiplayer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERBUILDSCORE' Call GetNamespace)]] Spawn HandleSPVF};
							};
						};
						
						//--- Defense.
						_get = _class Call GetNamespace;
						if !(isNil '_get') then {
							_price = _get select QUERYUNITPRICE;	
							if (!(isNil "townDefenceRange")) then {
								if (townDefenceRange) then {
									_price = (ceil(_price * 0.25 /10))*10;							
									if (_price < 10) then {
										_price = 10;
									};		
								};	
							};
							-_price Call ChangePlayerFunds;
						};
					};

					//--- Execute designer defined code On Construct
					[_logic,_itemclass,_pos,_dir,_par] spawn {    
						private ["_class","_defenses","_deployed","_dir","_logic","_par","_pos","_structures"];
						_logic = _this select 0;
						_class = _this select 1;
						_pos = _this select 2;
						_dir = _this select 3;
						_par = _this select 4;
						_deployed = WF_Logic getVariable Format["%1MHQDeployed",sideJoinedText];
						_structures = Format["WFBE_%1STRUCTURENAMES",sideJoinedText] Call GetNamespace;
						_defenses = Format["WFBE_%1DEFENSENAMES",sideJoinedText] Call GetNamespace;
						if (_class in _structures) then {
							WFBE_RequestStructure = ['SRVFNCREQUESTSTRUCTURE',[sideJoined,_class,_pos,_dir]];
							publicVariable 'WFBE_RequestStructure';
							if !(isMultiplayer) then {['SRVFNCREQUESTSTRUCTURE',[sideJoined,_class,_pos,_dir]] Spawn HandleSPVF};
						};
						if (_class in _defenses) then {
							WFBE_RequestDefense = ['SRVFNCREQUESTDEFENSE',[sideJoined,_class,_pos,_dir,manningDefense]];
							publicVariable 'WFBE_RequestDefense';
							if !(isMultiplayer) then {['SRVFNCREQUESTDEFENSE',[sideJoined,_class,_pos,_dir,manningDefense]] Spawn HandleSPVF};
							lastBuilt = _par;
						};
					};
				};

				//--- Temporary solution
				_colorGUI = [1,1,1,0.1];
				((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112201) ctrlsettextcolor _colorGUI;
				((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112201) ctrlcommit 0;
			};
		} else {
			_colorGUI = [1,1,1,0.1];
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112201) ctrlsettextcolor _colorGUI;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112201) ctrlcommit 0;
		};

		_oldTooltip = _logic getvariable "BIS_COIN_tooltip";
		if ((_tooltipType + _tooltip) != _oldTooltip || commandingmenu != _oldMenu || _logic getVariable "WF_RequestUpdate") then {
			_logic setVariable ["WF_RequestUpdate",false];
			
			//--- Description
			_type = _tooltip;

			//--- Header & preview picture
			_textHeader = "<t size='1.2'><br /></t>";
			_textPicture = "<t size='2.8'><br /></t><br /><br />";
			_fileIcon = gettext (configfile >> "cfgvehicles" >> _type >> "icon");
			if (str(configfile >> "CfgVehicleIcons" >> _fileIcon) != "") then {_fileIcon = gettext (configfile >> "CfgVehicleIcons" >> _fileIcon)};
			_filePicture = gettext (configfile >> "cfgvehicles" >> _type >> "picture");
			if (str(configfile >> "CfgVehicleIcons" >> _filePicture) != "") then {_filePicture = gettext (configfile >> "CfgVehicleIcons" >> _filePicture)};

			if (_tooltipType != "empty") then {
				_textHeader = format ["<t align='center'><t size='1.4'>%1</t><br /><t size='1'></t></t>",
					gettext (configfile >> "cfgvehicles" >> _type >> "displayname"),
					if (isnull _selected) then {""} else {str round ((1 - damage _selected) * 100) + "%"}
				];
				_textPicture = format ["<t align='left' size='2.8' shadow='0'><img image='%1'/></t> ",_filePicture];
			};

			_text1 = if (count _params > 0) then {localize "str_coin_rotate" + "<t align='right'>" + call compile (keyname 29) + "</t><br />"} else {"<br />"};
			
			_status = if (manningDefense) then {"Enabled"} else {"Disabled"};
			_text2 = if (count _params > 0) then {localize "str_coin_build" + "<t align='right'>" + call compile (actionKeysNames ["DefaultAction",1]) + "</t><br />"} else {localize "STR_WF_Gameplay_AutoDefense" + ":<t align='right'>" + _status + "</t><br />"};

			_text3 = if (commandingmenu != "#USER:BIS_Coin_categories_0") then {
				//--- Back hint
				if (isnil "BIS_Coin_noExit") then {
					localize "str_coin_back" + "<t align='right'>" + call compile (actionKeysNames ["MenuBack",1]) + "</t>";
				} else {""};
			} else {
			
				//--- Exit hint
				if (isnil "BIS_Coin_noExit") then {
					"<t color='#ff5544'>" + localize "str_coin_exit" + "<t align='right'>" + call compile (actionKeysNames ["MenuBack",1]) + "</t></t>";
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
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112211) ctrlshow true;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112211) ctrlcommit 0;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112214) ctrlsetstructuredtext (parsetext _textHint);
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112214) ctrlshow true;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112214) ctrlcommit 0;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112215) ctrlsetstructuredtext (parsetext _textControls);
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112215) ctrlshow true;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112215) ctrlcommit 0;
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
		{_cashValues = _cashValues + [_x]} foreach _funds;
		_cashValuesOld = _logic getvariable "BIS_COIN_fundsOld";
		if (isnil "_cashValuesOld") then {_cashValuesOld = []; _cashValuesOld set [count _cashValues - 1,-1]};
		_restart = _logic getvariable "BIS_COIN_restart";
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
			_cashPos = ctrlposition ((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112224);
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112224) ctrlsetstructuredtext (parsetext _cashText);
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112224) ctrlsetposition [_cashPos select 0,_cashPos select 1,_cashPos select 2,(_cashPos select 3)/*0.1*/ + _cashLines];
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112224) ctrlshow true;
			((uiNamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112224) ctrlcommit 0;

			//--- Categories menu
			_categories = +(_logic getVariable "BIS_COIN_categories");
			_categoriesMenu = [];
			//--- Ammo Upgrade.
			_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
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
						_itemname = if (count _x > 3) then {_x select 3} else {gettext (configfile >> "CfgVehicles" >> _itemclass >> "displayName")};
						//--- Build Limit reached?
						_buildLimit = false;
						_find = _buildingsNames find _itemclass;
						if (_find != -1) then {
							_buildings = WF_Logic getVariable Format ["%1BaseStructures",sideJoinedText];
							_checks = [sideJoined, Format ["WFBE_%1%2TYPE",sideJoinedText,(_buildingsType select _find)] Call GetNamespace,_buildings] Call GetFactories;
							_limit = (Format['WFBE_BUILDINGMAX%1',(_buildingsType select _find)]) Call GetNamespace;
							if (isNil "_limit") then {_limit = 4}; //--- Default.
							if (count _checks >= _limit) then {_buildLimit = true};
						};
						if (_itemcategory == _i/*_category*/) then {
							_canAfford = if (_cashValue - _itemcost >= 0 && !_buildLimit) then {1} else {0};
							_canAffordCount = _canAffordCount + _canAfford;
							_text = _itemname + " - " + _cashDescription + str _itemcost;
							_arrayNames = _arrayNames + [_text];
							_arrayNamesLong = _arrayNamesLong + [_text + "                   "];
							_arrayEnable = _arrayEnable + [_canAfford];
							_arrayParams = _arrayParams + [[_logic getvariable "BIS_COIN_ID"] + [_x,_i]];
						};  
					};
				} foreach _items;
				
				[[_category,true],format ["BIS_Coin_%1_items",_i],[_arrayNames,_arrayNamesLong,_arrayEnable],"","
					BIS_CONTROL_CAM_LMB = false;
					scopename 'main';
					_item = '%1';
					_id = %2;
					_array = (call compile '%3') select _id;
					_logic = call compile ('BIS_COIN_'+ str (_array select 0));

					_params = _array select 1;
					_logic setvariable ['BIS_COIN_params',_params];
					_logic setvariable ['BIS_COIN_menu',commandingmenu];
					showcommandingmenu '';

				",_arrayParams] call BIS_fnc_createmenu;	
			};

			if (_canAffordCount != _canAffordCountOld) then {showcommandingmenu (commandingmenu)}; //<-- Open menu again to show disabled items
		};
		_logic setvariable ["BIS_COIN_fundsOld",_cashValues];
		_logic setvariable ["BIS_COIN_tooltip",_tooltipType + _tooltip];

		if (_restart) then {
			_logic setvariable ["BIS_COIN_restart",false];
		};
	};
	_oldMenu = commandingmenu;
	sleep 0.01;
};

showcommandingmenu '';