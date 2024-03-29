Private["_canJoin","_clientID","_get","_name","_side","_sideOrigin","_uid"];

_uid = _this select 0;
_side = _this select 1;
_name = _this select 2;
_clientID = _this select 3;

_canJoin = true;

_get = Format["WFBE_JIP_USER%1",_uid] Call GetNamespace;

if !(isNil '_get') then {
	_sideOrigin = _get select 3;
	
	if (_sideOrigin != _side) then {
		if !(paramShowUID) then {_uid = "xxxxxxx"};
	
		WFBE_LocalizeMessage = [nil,'CLTFNCLOCALIZEMESSAGE',['Teamswap',_name,_uid,_sideOrigin,_side]];
		publicVariable 'WFBE_LocalizeMessage';
		
		_canJoin = false;
		
		diag_log Format["[WFBE (INFORMATION)][frameno:%3 | ticktime:%4] RequestJoin: Player %1 (%2) has been sent back to the lobby for teamswapping",_name,_get select 0,diag_frameno,diag_tickTime];
	};
};

WFBE_CanJoin = [[_clientID,_side],'CLTFNCCANJOIN',[_name,_canJoin]];
publicVariable 'WFBE_CanJoin';