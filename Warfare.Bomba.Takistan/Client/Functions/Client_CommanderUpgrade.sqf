private['_i','_index','_index2','_name','_time','_upgrades'];
_time = _this select 0;
_index = _this select 1;
_index2 = _this select 2;
_name = _this select 3;
isUpgrading = true;

hint Format [localize "STR_WF_Upgrade_Start",_name];

WFBE_RequestChangeScore = ['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERUPGRADESCORE' Call GetNamespace)]];
publicVariable 'WFBE_RequestChangeScore';
if (IsClientServer) then {['SRVFNCREQUESTCHANGESCORE',[player,score player + ('WFBE_COMMANDERUPGRADESCORE' Call GetNamespace)]] Spawn HandleSPVF};

_i = _time;
if (WF_DEBUG) then { _i = 1; };

while {_i > 0} do {
	_i = _i - 1;
	upgradingTime = _i;
	sleep 1;
};
_upgrades = (sideJoined) Call GetSideUpgrades;
_upgrades Set [_index,_index2 + 1];
[_upgrades, sideJoined] call SetSideUpgrades;

upgradingTime = -1;
isUpgrading = false;
hint Format [localize "STR_WF_Upgrade_Complete",_name,_index2 + 1];
WFBE_LocalizeMessage = [sideJoined,'CLTFNCLOCALIZEMESSAGE',['UpgradeComplete',_index,(_index2 + 1)]];
publicVariable 'WFBE_LocalizeMessage';
if (IsClientServer) then {[sideJoined,'CLTFNCLOCALIZEMESSAGE',['UpgradeComplete',_index,(_index2 + 1)]] Spawn HandlePVF};

sleep 0.3;

WFBE_RequestSpecial = ['SRVFNCREQUESTSPECIAL',['upgrade',sideJoined]];
publicVariable 'WFBE_RequestSpecial';
if (IsClientServer) then {['SRVFNCREQUESTSPECIAL',['upgrade',sideJoined]] Spawn HandleSPVF};
