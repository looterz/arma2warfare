Private["_localize","_txt", "_name"];

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
	case "FundsTransfer": {
		_txt = Format [Localize "STR_WF_FundsTransfer",_this select 1,_this select 2];
		_commandChat = false;
	};
	case "HeadHunterReceiveBounty": {
		_txt = Format [Localize "STR_WF_HeadHunterReceiveBounty",_this select 1,_this select 2];
		_commandChat = false;
	};
	case "HeadHunterSendBounty": {
		_txt = Format [Localize "STR_WF_HeadHunterSendBounty",_this select 1,_this select 2];
		_commandChat = false;
	};
	
	case "HeadHunterReceiveRefund": {
		_txt = Format [Localize "STR_WF_HeadHunterReceiveRefund",_this select 1,_this select 2];
		_commandChat = false;
	};
	case "HeadHunterSendRefund": {
		_txt = Format [Localize "STR_WF_HeadHunterSendRefund",_this select 1,_this select 2];
		_commandChat = false;
	};
	
	case "SellFactory": {
		_name = [_this select 1, 'displayName'] Call GetConfigInfo;
		_txt = Format [Localize "STR_WF_SellFactory", _name];
		_commandChat = true;
	};	
};

if (_commandChat) then {
	_txt Call CommandChatMessage;
} else {
	_txt Call GroupChatMessage;
};

if (_localize != 'FundsTransfer') then {
} else {
};