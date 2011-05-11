Private ["_index","_index2","_name","_side","_sideText","_time","_upgrades"];
_time = _this select 0;
_index = _this select 1;
_index2 = _this select 2;
_name = _this select 3;
_side = _this select 4;
_sideText = Str _side;

Call Compile Format ["WFBE_%1_Upgrading = true; publicVariable 'WFBE_%1_Upgrading';",_sideText];

if (WF_DEBUG) then {
	_time = 2;
};

sleep _time;

_upgrades = (_sideText) Call GetSideUpgrades;
_upgrades set [_index2,_index + 1];
Call Compile Format ["%1Upgrades = _upgrades; publicVariable '%1Upgrades';",_sideText];

WFBE_LocalizeMessage = [_side,'CLTFNCLOCALIZEMESSAGE',['UpgradeComplete',_index2,(_index + 1)]];
publicVariable 'WFBE_LocalizeMessage';
if (!isMultiplayer || (isServer && local player)) then {[_side,'CLTFNCLOCALIZEMESSAGE',['UpgradeComplete',_index2,(_index + 1)]] Spawn HandlePVF};
[Format["WFBE_%1_Upgrading",_sideText],false,true] Call SetNamespace;

["NewIntelAvailable","",_side,""] Spawn SideMessage;

Call Compile Format ["WFBE_%1_Upgrading = false; publicVariable 'WFBE_%1_Upgrading';",_sideText];