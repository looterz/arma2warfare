private['_val','_level','_u','_dependencie','_maxlevel','_tooltip_text','_name','_tooltip','_tooltip_text_content','_dependent','_enabled','_tooltip_h','_display','_requiredfunds','_requiredsupply','_controls','_upgrades','_condition','_tooltip_w','_curidc','_time','_canupgrade','_hasfunds','_supply','_upgr','_upgrlev','_upgrdep','_upgrcond','_bpath','_needed','_currentsupply','_currentfunds','_colorsupply','_colorfunds','_tooltip_x','_tooltip_y','_commander','_txt'];

disableSerialization;

_display = _this select 0;
displayUpgrade = "";

MenuAction = -1;
mouseX = -1;
mouseY = -1;

_requiredFunds = 0;
_requiredSupply = 0;

_tooltip = _display DisplayCtrl 18998;
_tooltip_text = _display DisplayCtrl 18999;

_controls = [];
_u = 18001;
_curIDC = _display DisplayCtrl _u;
while {!isNull _curIDC} do {_controls = _controls + [_curIDC];_u = _u + 1;_curIDC = _display DisplayCtrl _u};

_level = 0;
_val = 0;
_time = 0;
_name = '';
_tooltip_text_content = '';
_canUpgrade = false;
_dependent = false;
_upgr = 'WFBE_UPGRADELABELS' Call GetNamespace;
_upgrlev = 'WFBE_UPGRADELEVELS' Call GetNamespace;
_upgrdep = 'WFBE_UPGRADEDEPENDENCIES' Call GetNamespace;
_upgrcond = 'WFBE_UPGRADECONDITION' Call GetNamespace;

while {alive player && dialog} do {
	if (Side player != sideJoined) exitWith {closeDialog 0};
	if !(dialog) exitWith {};
	
	_upgrades = (sideJoinedText) Call GetSideUpgrades;
	
	_u = 0;
	{
		_level = _upgrades select _u;
		_maxLevel = _upgrlev select _u;
		_dependencie = _upgrdep select _u;
		_condition = _upgrcond select _u;
		if (_level == _maxLevel) then {_x ctrlSetTextColor [0, 1, 0, 1]};
		if (!_condition) then {_x ctrlSetTextColor [1, 0, 0, 1]};
		if (count _dependencie > 0 && _level != _maxLevel && _condition) then {
			if (_upgrades select (_dependencie select 0) < (_dependencie select 1)) then {
				_x ctrlSetTextColor [1, 0, 0, 1];
			} else {
				if (_level != _maxLevel) then {
					_x ctrlSetTextColor [0.75,0.75,0.75,1];
				};
			};
		};
		_u = _u + 1;
	} forEach _controls;
	
	//--- Tooltips.
	if (displayUpgrade != "") then {
		
		switch (displayUpgrade) do {
			case "infantry": {_val = 0};
			case "light": {_val = 1};
			case "heavy": {_val = 2};
			case "air": {_val = 3};
			case "parachutist": {_val = 4};
			case "uav": {_val = 5};
			case "supply": {_val = 6};
			case "ambuSpawn": {_val = 7};
			case "airlift": {_val = 8};
			case "flares": {_val = 9};
			case "artillery": {_val = 10};
			case "icbm": {_val = 11};
			case "fasttravel": {_val = 12};
			case "gear": {_val = 13};
			case "ammo": {_val = 14};
			case "easa": {_val = 15};
			case "paradrop": {_val = 16};
			case "shells": {_val = 17};
		};

		ctrlSetFocus (_controls select _val);
		
		_dependencie = _upgrdep select _val;
		_condition = _upgrcond select _val;
		_maxLevel = _upgrlev select _val;
		_name = _upgr select _val;
		_level = _upgrades select _val;

		_enabled = true;
		if (!_condition) then {_enabled = false};
		if (count _dependencie > 0 && _enabled) then {
			if (_upgrades select (_dependencie select 0) < (_dependencie select 1)) then {
				_dependent = true;
			} else {_dependent = false};
		} else {_dependent = false};
		
		_bpath = if (_level == _maxLevel) then {_level} else {_level + 1};
		_time = (Format["WFBE_UPGRADETIMESLEVEL%1",_bpath] Call GetNamespace) select _val;
		_needed = (Format["WFBE_UPGRADEPRICESLEVEL%1",_bpath] Call GetNamespace) select _val;
		_requiredSupply = _needed select 0;
		_requiredFunds = _needed select 1;

		_currentSupply = WF_Logic getVariable Format ["%1Supplies",sideJoinedText];
		_currentFunds = Call GetPlayerfunds;
		
		_colorSupply = "'#3366cc'";
		_colorFunds = "'#3366cc'";
		_hasFunds = true;
		if (_currentSupply < _requiredSupply) then {_colorSupply = "'#ff0033'";_hasFunds = false};
		if (_currentFunds < _requiredFunds) then {_colorFunds = "'#ff0033'";_hasFunds = false};
		
		if (!isUpgrading && _level < _maxLevel && !_dependent && _enabled && _hasFunds) then {_canUpgrade = true} else {_canUpgrade = false};
		
		_tooltip_w = 0.28;
		_tooltip_h = 0.18;
		_tooltip_x = if ((1 - mouseX) < _tooltip_w) then {mouseX - _tooltip_w - 0.02} else {mouseX + 0.02};
		_tooltip_y = if (mouseY > 0.5) then {mouseY - _tooltip_h - 0.02} else {mouseY + 0.02};
		
		if (_level != _maxLevel) then {
			_tooltip_text_content = parsetext (
				Format ["<t size='1.2' color='#ff9900' shadow='0'>%1:</t><br />",_name] +
				Format ["<t size='0.8' color='#ffffff' font='Zeppelin33'> %1</t><br />",Format [localize 'STR_WF_Level',"<t color='#3366cc'>" + str(_level) + '</t>' + "/<t color='#3366cc'>" + str(_maxLevel) + '</t>']] +
				Format ["<t size='0.8' color='#ffffff' font='Zeppelin33'> %1</t><br />",Format [localize 'STR_WF_Require',"<t color=" + _colorSupply + ">" + str(_requiredSupply) + '</t>' + '/' + "<t color='#3366cc'>" + str(_currentSupply) + '</t> S']] +
				Format ["<t size='0.8' color='#ffffff' font='Zeppelin33'> %1</t><br />",Format [localize 'STR_WF_Require',"<t color=" + _colorFunds + ">" + str(_requiredFunds) + '</t>' + '/' + "<t color='#3366cc'>" + str(_currentFunds) + '</t> $']] +
				Format ["<t size='0.8' color='#ffffff' font='Zeppelin33'> %1</t><br />",Format [localize 'STR_WF_Require',"<t color='#3366cc'>" + str(_time) + ' </t>' + localize 'STR_WF_Seconds']]
			);

			if (isUpgrading) then {
				_tooltip_h = 0.12;
				_tooltip_text_content = parsetext (
					Format ["<t size='1.2' color='#ff9900' shadow='0'>%1:</t><br />",_name] +
					Format ["<t size='0.8' color='#ff0033' font='Zeppelin33'> %1</t><br />",localize 'STR_WF_Upgrade_Running']
				);
			};
			if (!_enabled) then {
				_tooltip_text_content = parsetext (
					Format ["<t size='1.2' color='#ff9900' shadow='0'>%1:</t><br />",_name] +
					Format ["<t size='0.8' color='#ff0033' font='Zeppelin33'> %1</t><br />",localize 'STR_WF_Upgrade_Condition']
				);			
			};
			if (_dependent && !isUpgrading && _enabled) then {
				_tooltip_text_content = parsetext (
					Format ["<t size='1.2' color='#ff9900' shadow='0'>%1:</t><br />",_name] +
					Format ["<t size='0.8' color='#ff0033' font='Zeppelin33'> %1</t><br />",Format[localize 'STR_WF_Upgrade_Dependent',_upgr select (_dependencie select 0),_dependencie select 1]]
				);			
			};
		} else {
			_tooltip_h = 0.12;
			_tooltip_text_content = parsetext (
				Format ["<t size='1.2' color='#ff9900' shadow='0'>%1:</t><br />",_name] +
				Format ["<t size='0.8' color='#ff0033' font='Zeppelin33'> %1</t><br />",localize 'STR_WF_Upgrade_Maximum']
			);
		};
		
		if ((ctrlPosition _tooltip select 0) == 0 || true) then {_tooltip ctrlSetPosition [_tooltip_x,_tooltip_y,_tooltip_w,_tooltip_h]};
		_tooltip ctrlCommit 0;
		
		_tooltip_text ctrlSetStructuredText _tooltip_text_content;
		if ((ctrlPosition _tooltip_text select 0) == 0 || true) then {_tooltip_text ctrlSetPosition [_tooltip_x,_tooltip_y,_tooltip_w,_tooltip_h]};
		_tooltip_text ctrlCommit 0;
		
	} else {
		if ((ctrlPosition _tooltip select 0) != 0) then {_tooltip ctrlSetPosition [0,0,0,0];_tooltip ctrlCommit 0};
		if ((ctrlPosition _tooltip_text select 0) != 0) then {_tooltip_text ctrlSetPosition [0,0,0,0];_tooltip_text ctrlCommit 0};
	};
	
	_commander = false;
	if (!isNull(commanderTeam)) then {
		if (commanderTeam == group player) then {_commander = true};
	};
	
	if (MenuAction == 1 && _canUpgrade && _commander) then {
		MenuAction = -1;
		-_requiredFunds Call ChangePlayerFunds;
		_supply = WF_Logic getVariable Format["%1Supplies",sideJoinedText];
		_supply = _supply - _requiredSupply;
		WF_Logic setVariable [Format["%1Supplies",sideJoinedText],_supply,true];
		[_time,_val,_level,_name] Spawn CommanderUpgrade;
	} else {MenuAction = -1};
	
	_txt = if (upgradingTime != -1) then {localize "STR_WF_TimeLeft" + " " + str(upgradingTime)} else {""};
	ctrlSetText[18802,_txt];
	
	sleep 0.05;
};