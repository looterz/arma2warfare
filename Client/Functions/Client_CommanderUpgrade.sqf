Private ["_i","_index","_index2","_name","_time"];
_time = _this select 0;
_index = _this select 1;
_index2 = _this select 2;
_name = _this select 3;
isUpgrading = true;

hint Format [localize "STR_WF_Upgrade_Start",_name];
[CMDREQUESTCHANGESCORE,player,score player + ('WFBE_COMMANDERUPGRADESCORE' Call GetNamespace)] Spawn CommandToServer;

_i = _time;
while {_i > 0} do {
	_i = _i - 1;
	upgradingTime = _i;
	sleep 1;
};
_upgrades = WF_Logic getVariable Format ["%1Upgrades",sideJoinedText];
_upgrades Set [_index,_index2 + 1];
WF_Logic setVariable [Format ["%1Upgrades",sideJoinedText],_upgrades,true];
upgradingTime = -1;
isUpgrading = false;
hint Format [localize "STR_WF_Upgrade_Complete",_name,_index2 + 1];
[sideJoined,CMDLOCALIZEMESSAGE,"UpgradeComplete",[_index,(_index2 + 1)]] Spawn CommandToSide;
sleep 0.3;
[CMDREQUESTSPECIAL,"upgrade"] Spawn CommandToServer;