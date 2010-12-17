Private["_localize","_txt"];

_localize = _this Select 0;

_txt = "";
switch (_localize) do {
	case "BuildingTeamkill": {_txt = Format [Localize "STR_WF_Teamkill_Building",_this select 1, _this select 2, _this select 3]};
	case "Teamswap": {_txt = Format [Localize "STR_WF_Teamswap",_this select 1, _this select 2, _this select 3, _this select 4]};
	case "UpgradeComplete": {_txt = Format [Localize "STR_WF_Upgrade_Complete_Message",('WFBE_UPGRADELABELS' Call GetNamespace) select (_this select 1), _this select 2]};
	case "CommanderDisconnected": {_txt = Localize "strwfcommanderdisconnected"};
	case "TacticalLaunch": {_txt = Localize "STR_WF_ICBM_Launch"};
	case "Teamkill": {_txt = Format [Localize "STR_WF_Teamkill",('WFBE_TEAMKILLPENALTY' Call GetNamespace)]; -('WFBE_TEAMKILLPENALTY' Call GetNamespace) Call ChangePlayerFunds};
	case "FundsTransfer": {_txt = Format [Localize "STR_WF_FundsTransfer",_this select 1,_this select 2]};
};

if (_localize != 'FundsTransfer') then {
	_txt Call CommandChatMessage;
} else {
	_txt Call GroupChatMessage;
};