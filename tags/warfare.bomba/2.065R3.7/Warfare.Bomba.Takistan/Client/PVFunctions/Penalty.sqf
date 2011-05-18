Private['_fee'];

_fee = 'WFBE_CIVILIANPENALTY' Call GetNamespace;
Format[Localize "STR_WF_Penalty",_fee] Call GroupChatMessage;
-(_fee) Call ChangePlayerFunds;