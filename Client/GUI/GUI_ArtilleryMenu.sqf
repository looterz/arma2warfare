disableSerialization;

MenuAction = -1;
mouseButtonUp = -1;
_display = _this select 0;
_lastRange = artyRange;
_lastUpdate = 0;

ctrlEnable [17010,commandInRange];
SliderSetRange[17005,10,'WFBE_MAXARTILLERYAREA' Call GetNamespace];
SliderSetPosition[17005,artyRange];

_markers = [];
_FTLocations = [];
_checks = [];
_fireTime = 0;
_status = 0;
_canFT = false;
_ftr = 'WFBE_FASTTRAVELRANGE' Call GetNamespace;
_startPoint = objNull;

_marker = "artilleryMarker";
CreateMarkerLocal [_marker,artyPos];
_marker setMarkerTypeLocal "mil_destroy";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerSizeLocal [1,1];

_area = "artilleryAreaMarker";
CreateMarkerLocal [_area,artyPos];
_area SetMarkerShapeLocal "Ellipse";
_area setMarkerColorLocal "ColorRed";
_area setMarkerSizeLocal [artyRange,artyRange];

_map = _display DisplayCtrl 17002;
_pard = 'WFBE_PARADELAY' Call GetNamespace;
{lbAdd[17008,_x]} forEach artilleryDescs;
lbSetCurSel[17008,0];

_IDCS = [17005,17006,17007,17008];
if !(paramArty) then {{ctrlEnable [_x,false]} forEach _IDCS};
if !(paramFastTravel) then {ctrlEnable [17014,false]};
if !(paramICBM) then {ctrlEnable [17015,false]};

//--- OA Takistanies don't have any UAV.
if (WF_A2_Arrowhead && sideJoined == east) then {
	{ctrlEnable [_x,false]} forEach [17012,17013];
};

while {alive player && dialog} do {
	if (side player != sideJoined) exitWith {deleteMarkerLocal _marker;deleteMarkerLocal _area;{deleteMarkerLocal _x} forEach _markers;closeDialog 0};
	if (!dialog) exitWith {deleteMarkerLocal _marker;deleteMarkerLocal _area;{deleteMarkerLocal _x} forEach _markers};
	
	_currentUpgrades = (sideJoinedText) Call GetSideUpgrades;
	
	if (paramFastTravel) then {
		_currentLevel = _currentUpgrades select 12;
		if (time - _lastUpdate > 15 && _currentLevel > 0) then {
			{deleteMarkerLocal _x} forEach _markers;
			_markers = [];
			_FTLocations = [];
			_canFT = false;
			_startPoint = objNull;
			_lastUpdate = time;
			_base = (sideJoinedText) Call GetSideHQ;
			_isDeployed = (sideJoinedText) Call GetSideHQDeployed;
			if (player distance _base < _ftr && alive _base && vehicle player != _base && _isDeployed) then {
				_canFT = true;
				_startPoint = _base;
			} else {
				_sorted = [player,towns] Call SortByDistance;
				_closest = _sorted select 0;
				_sideID = _closest getVariable "sideID";
				_camps = [_closest,sideJoined] Call GetFriendlyCamps;
				_allCamps = _closest getVariable "camps";
				if (_sideID == sideID && player distance _closest < _ftr && (count _camps == count _allCamps)) then {_canFT = true;_startPoint = _closest} else {
					_buildings = (sideJoinedText) Call GetSideStructures;
					_checks = [sideJoined,Format ["WFBE_%1COMMANDCENTERTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
					if (count _checks > 0) then {
						_sorted = [player,_checks] Call SortByDistance;
						_closest = _sorted select 0;
						if (player distance _closest < _ftr) then {
							_canFT = true;
							_closest = _sorted select 0;
							_startPoint = _closest;			
						};
					};
				};
			};
			if (!canMove (vehicle player)) then {_canFT = false};
			if (_canFT) then {
				_buildings = (sideJoinedText) Call GetSideStructures;
				_checks = [sideJoined,Format ["WFBE_%1COMMANDCENTERTYPE",sideJoinedText] Call GetNamespace,_buildings] Call GetFactories;
				_locations = towns + _checks;
				if (alive _base && _isDeployed) then {_locations = _locations + [_base]};
				_i = 0;
				{
					if (_x distance player <= ('WFBE_FASTTRAVELMAXRANGE' Call GetNamespace) && _x distance player > _ftr) then {
						_skip = false;
						if (_x in towns) then {
							_sideID = _x getVariable "sideID";
							_camps = [_x,sideJoined] Call GetFriendlyCamps;
							_allCamps = _x getVariable "camps";
							if (_sideID != sideID || (count _camps != count _allCamps)) then {_skip = true};
						};
						if !(_skip) then {
							_FTLocations = _FTLocations + [_x];
							_markerName = Format ["FTMarker%1",_i];
							_markers = _markers + [_markerName];
							createMarkerLocal [_markerName,getPos _x];
							_markerName setMarkerTypeLocal "mil_circle";
							_markerName setMarkerColorLocal "ColorGreen";
							_markerName setMarkerSizeLocal [1,1];
							_i = _i + 1;
						};
					};
				} forEach _locations;
			};
		};
		if (count _FTLocations == 0 && _currentLevel == 0) then {ctrlEnable [17014,false]} else {ctrlEnable [17014,true]};
	};
	
	artyRange = Floor (SliderPosition 17005);
	if (_lastRange != artyRange) then {_area setMarkerSizeLocal [artyRange,artyRange];};
	
	_funds = Call GetPlayerFunds;
	
	if (paramICBM) then {
		_commander = false;
		if (!isNull(commanderTeam)) then {
			if (commanderTeam == group player) then {_commander = true};
		};
		_currentLevel = _currentUpgrades select 11;
		_enable = if (_currentLevel > 0 && _commander && _funds >= 150000) then {true} else {false};
		ctrlEnable [17015,_enable];
	};
	_currentLevel = _currentUpgrades select 4;
	_enable = if (_funds >= 7800 && _currentLevel > 0 && time - lastParaCall > _pard) then {true} else {false};
	ctrlEnable [17010,commandInRange];
	ctrlEnable [17011,_enable];
	_currentLevel = _currentUpgrades select 5;
	_enable = if (_funds >= 12500 && _currentLevel > 0) then {true} else {false};
	if !(isNull playerUAV) then {if (alive playerUAV) then {_enable = true}};
	ctrlEnable [17012,_enable];
	ctrlEnable [17013,_enable];
	_currentLevel = _currentUpgrades select 16;
	_enable = if (_funds >= 3500 && _currentLevel > 0 && time - lastSupplyCall > _pard) then {true} else {false};
	ctrlEnable [17017,_enable];
	_enable = if (_funds >= 9500 && _currentLevel > 0 && time - lastSupplyCall > _pard) then {true} else {false};
	ctrlEnable [17018,_enable];
	
	if (mouseButtonUp == 0) then {
		mouseButtonUp = -1;
		//--- Set Artillery Marker on map.
		if (MenuAction == 1) then {
			MenuAction = -1;
			artyPos = _map posScreenToWorld[mouseX,mouseY];
			_marker setMarkerPosLocal artyPos;
			_area setMarkerPosLocal artyPos;
		};
		//--- Paratroops.
		if (MenuAction == 3) then {
			MenuAction = -1;
			_callPos = _map posScreenToWorld[mouseX,mouseY];
			if (!surfaceIsWater _callPos) then {
				lastParaCall = time;
				-(11500) Call ChangePlayerFunds;
				WFBE_RequestSpecial = ['SRVFNCREQUESTSPECIAL',["Paratroops",sideJoined,_callPos,clientTeam]];
				publicVariable 'WFBE_RequestSpecial';
				if (!isMultiplayer || (isServer && local player)) then {['SRVFNCREQUESTSPECIAL',["Paratroops",sideJoined,_callPos,clientTeam]] Spawn HandleSPVF};
				hint (localize "STR_WF_Paratroop_Info");
			};
		};
		//--- Fast Travel.
		if (MenuAction == 7) exitWith {
			_callPos = _map PosScreenToWorld[mouseX,mouseY];
			_sorted = [_callPos,_FTLocations] Call SortByDistance;
			if (_callPos distance (_sorted select 0) < 500) then {
				closeDialog 0;
				deleteMarkerLocal _marker;
				deleteMarkerLocal _area;
				
				_destination = _sorted select 0;
				_travelingWith = [];
				{if (_x distance _startPoint < _ftr && !(_x in _travelingWith) && canMove _x && !(vehicle _x isKindOf "StaticWeapon") && !stopped _x) then {_travelingWith = _travelingWith + [vehicle _x]}} forEach units (group player);
				
				ForceMap true;
				_compass = shownCompass;
				_GPS = shownGPS;
				_pad = shownPad;
				_radio = shownRadio;
				_watch = shownWatch;

				showCompass false;
				showGPS false;
				showPad false;
				showRadio false;
				showWatch false;

				mapAnimClear;
				mapAnimCommit;

				_locationPosition = getPos _destination;
				_camera = "camera" camCreate _locationPosition;
				_camera camSetDir 0;
				_camera camSetFov 1;
				_camera cameraEffect["Internal","TOP"];

				_camera camSetTarget _locationPosition;
				_camera camSetPos [_locationPosition select 0,(_locationPosition select 1) + 2,100];
				_camera camCommit 0;
				
				mapAnimAdd [0,0.05,GetPos _startPoint];
				mapAnimCommit;
				
				_delay = ((_startPoint distance _destination) / 50) * ('WFBE_FASTTRAVELTIMECOEF' Call GetNamespace);
				mapAnimAdd [_delay,.18,getPos _destination];
				mapAnimCommit;
				
				waitUntil {mapAnimDone || !alive player};
				_skip = false;
				if (!alive player) then {_skip = true};
				if (!_skip) then {
					{[_x,_locationPosition,120] Call PlaceSafe;_x setVelocity [0,0,-1]} forEach _travelingWith;
				};
				sleep 1;
				
				{deleteMarkerLocal _x} forEach _markers;
				
				ForceMap false;
				showCompass _compass;
				showGPS _GPS;
				showPad _pad;
				showRadio _radio;
				showWatch _watch;
				
				_camera cameraEffect["TERMINATE","BACK"];
				camDestroy _camera;
			};
		};
		//--- ICBM Strike.
		if (MenuAction == 8) then {
			MenuAction = -1;
			-150000 Call ChangePlayerFunds;
			_callPos = _map PosScreenToWorld[mouseX,mouseY];
			_obj = "HeliHEmpty" createVehicle _callPos;
			_nukeMarker = createMarkerLocal ["icbmstrike", position _obj];
			_nukeMarker setMarkerTypeLocal "mil_warning";
			_nukeMarker setMarkerTextLocal "ICBM";
			_nukeMarker setMarkerColorLocal "ColorRed";
			[_obj,_nukeMarker] Spawn NukeIncomming;
		};
		//--- Vehicle Paradrop.
		if (MenuAction == 9) then {
			MenuAction = -1;
			lastSupplyCall = time;
			-3500 Call ChangePlayerFunds;
			_callPos = _map PosScreenToWorld[mouseX,mouseY];
			WFBE_RequestSpecial = ['SRVFNCREQUESTSPECIAL',["ParaVehi",sideJoined,_callPos,clientTeam]];
			publicVariable 'WFBE_RequestSpecial';
			if (!isMultiplayer || (isServer && local player)) then {['SRVFNCREQUESTSPECIAL',["ParaVehi",sideJoined,_callPos,clientTeam]] Spawn HandleSPVF};
		};
		//--- Ammo Paradrop.
		if (MenuAction == 10) then {
			MenuAction = -1;
			lastSupplyCall = time;
			-9500 Call ChangePlayerFunds;
			_callPos = _map PosScreenToWorld[mouseX,mouseY];
			WFBE_RequestSpecial = ['SRVFNCREQUESTSPECIAL',["ParaAmmo",sideJoined,_callPos,clientTeam]];
			publicVariable 'WFBE_RequestSpecial';
			if (!isMultiplayer || (isServer && local player)) then {['SRVFNCREQUESTSPECIAL',["ParaAmmo",sideJoined,_callPos,clientTeam]] Spawn HandleSPVF};
		};
	};
	if (paramArty) then {
		//--- Artillery Status.
		_fireTime = (Format["WFBE_FIREMISSIONTIMEOUT%1",(_currentUpgrades select 10)] Call GetNamespace);
		_status = round(_fireTime - (time - fireMissionTime));
		
		_txt = '';
		if (time - fireMissionTime > _fireTime) then {

			_txt = localize 'STR_WF_Available';
		
			_artilleryMarker = GetMarkerPos "artilleryMarker";
			_units = [Group player,GetPos player,false,lbCurSel(17008)] Call GetTeamArtillery;
			_countInRange = 0;

			if (count _units == 0) then {
				_txt = localize 'STR_WF_ArtyNoGuns';
			} else {
				{
					_artillery = _x;
					_type = artilleryNames Find (typeOf _artillery);
					_minRange = artilleryMinRanges Select _type;
					_maxRange = artilleryMaxRanges Select _type;
					
					_dist = _artilleryMarker distance _artillery;
					if ( _minRange <= _dist && _dist <= _maxRange) then { _countInRange = _countInRange + 1; };
				} forEach _units;
				
				if (_countInRange == 0) then { 
					_txt = localize 'STR_WF_ArtyOutOfRange'; 
				} else {
					if (_countInRange <= count _units) then { _txt = Format[localize 'STR_WF_ArtyReadyToFire', _countInRange, count _units] };		
				};
			};
		} else {
		
			_txt = Format ['%1 %2', _status, localize 'STR_WF_Seconds'];
		};
		
		_txt = Format['%1: %2', localize 'STR_WF_Status', _txt]; 
		
		(_display displayCtrl 17016) ctrlSetStructuredText (parseText _txt);
		_enable = if (_status > 0) then {false} else {true};
		ctrlEnable [17007,_enable];
	};
	
	//--- Request Fire Mission.
	if (MenuAction == 2) then {
		MenuAction = -1;
		_units = [Group player,GetPos player,false,lbCurSel(17008)] Call GetTeamArtillery;
		if (Count _units > 0) then {
			fireMissionTime = time;
			[GetMarkerPos "artilleryMarker",lbCurSel(17008)] Spawn RequestFireMission		
		} else {
			hint (localize "STR_WF_NoArty");
		};			
	};
	
	//--- Units Camera.
	if (MenuAction == 4) then {
		MenuAction = -1;
		closeDialog 0;
		createDialog "RscUnitCamera";
	};
	
	//--- UAV Deployer.
	if (MenuAction == 5) then {
		MenuAction = -1;
		closeDialog 0;
		ExecVM "Client\Module\UAV\uav.sqf";
	};
	
	//--- UAV Destroyer.
	if (MenuAction == 6) then {
		MenuAction = -1;
		{_x setDammage 1} forEach (crew playerUAV);
		playerUAV setDammage 1;
		playerUAV = objNull;
	};
	
	_lastRange = artyRange;
	sleep 0.1;
};

deleteMarkerLocal _marker;
deleteMarkerLocal _area;
{deleteMarkerLocal _x} forEach _markers;