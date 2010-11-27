Private["_bounty","_get","_name","_type"];

_type = _this;

_get = _type Call GetNamespace;

_name = _get select QUERYUNITLABEL;
_bounty = (_get select QUERYUNITPRICE) * ('WFBE_BOUNTYMODIFIER' Call GetNamespace);
_bounty = _bounty - (_bounty % 1);

Format[Localize "STR_WF_Award_Bounty",_bounty,_name] Call GroupChatMessage;
_bounty Call ChangePlayerFunds;