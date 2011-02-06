private['_localize','_txt','_commandchat'];

_localize = _this Select 0;
_commandChat = true;

_txt = "";
switch (_localize) do {
	case "BuildingTeamkill": {_txt = Format [Localize "STR_WF_Teamkill_Building",_this select 1, _this select 2, _this select 3]};
	case "Teamswap": {_txt = Format [Localize "STR_WF_Teamswap",_this select 1, _this select 2, _this select 3, _this select 4]};
	case "UpgradeComplete": {_txt = Format [Localize "STR_WF_Upgrade_Complete_Message",('WFBE_UPGRADELABELS' Call GetNamespace) select (_this select 1), _this select 2]};
	case "CommanderDisconnected": {_txt = Localize "strwfcommanderdisconnected"};
	case "TacticalLaunch": {_txt = Localize "STR_WF_ICBM_Launch"};
	case "Teamkill": {_txt = Format [Localize "STR_WF_Teamkill",('WFBE_TEAMKILLPENALTY' Call GetNamespace)]; -('WFBE_TEAMKILLPENALTY' Call GetNamespace) Call ChangePlayerFunds};
	case "FundsTransfer": { _commandChat = false; _txt = Format [Localize "STR_WF_FundsTransfer",_this select 1,_this select 2]; };
	case "StructureSold": { _commandChat = true; _txt = Format [Localize "STR_WF_Structure_Sold",([_this select 1,'displayName'] Call GetConfigInfo)]};

	case "HeadHunterReceiveBounty": { _commandChat = false; _txt = Format [Localize "STR_WF_HeadHunterReceiveBounty",_this select 1,_this select 2]; };
	case "HeadHunterSendBounty": { 	_commandChat = false; _txt = Format [Localize "STR_WF_HeadHunterSendBounty",_this select 1,_this select 2]; };
	case "HeadHunterReceiveRefund": { _commandChat = false; _txt = Format [Localize "STR_WF_HeadHunterReceiveRefund",_this select 1,_this select 2]; };
	case "HeadHunterSendRefund": { _commandChat = false; _txt = Format [Localize "STR_WF_HeadHunterSendRefund",_this select 1,_this select 2]; };
	case "BaseHuntingRestriction" : { _commandChat = true; _txt = Format [Localize "STR_WF_BaseHuntingRestriction", (_this select 1), paramBaseHuntingTimeout]; };
};

if (_commandChat) then { _txt Call CommandChatMessage; } else { _txt Call GroupChatMessage; };