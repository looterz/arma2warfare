Private["_bounty","_name","_type"];

_type = _this select 0;

_name = ('WFBE_UNITBOUNTYDESCRIPTIONS' Call GetNamespace) select _type;
_bounty = (('WFBE_UNITBOUNTIES' Call GetNamespace) select _type) * ('WFBE_BOUNTYMODIFIER' Call GetNamespace);
_bounty = _bounty - (_bounty % 1);

Format[Localize "STR_WF_Award_Bounty",_bounty,_name] Call GroupChatMessage;
_bounty Call ChangePlayerFunds;