Private["_localize","_param","_txt"];

_localize = _this Select 0;
_param = [];
if (count _this > 1) then {_param = _this Select 1};

_txt = "";
switch (_localize) do {
	case "BuildingTeamkill": {_txt = Format [Localize "STR_WF_Teamkill_Building",_param select 0, _param select 1, _param select 2]};
	case "Teamswap": {_txt = Format [Localize "STR_WF_Teamswap",_param select 0, _param select 1, _param select 2, _param select 3]};
	case "UpgradeComplete": {_txt = Format [Localize "STR_WF_Upgrade_Complete_Message",('WFBE_UPGRADELABELS' Call GetNamespace) select (_param select 0), _param select 1]};
	case "CommanderDisconnected": {_txt = Localize "strwfcommanderdisconnected"};
	case "TacticalLaunch": {_txt = Localize "STR_WF_ICBM_Launch"};
	case "Teamkill": {_txt = Format [Localize "STR_WF_Teamkill",('WFBE_TEAMKILLPENALTY' Call GetNamespace)]; -('WFBE_TEAMKILLPENALTY' Call GetNamespace) Call ChangePlayerFunds};
};

_txt Call CommandChatMessage;