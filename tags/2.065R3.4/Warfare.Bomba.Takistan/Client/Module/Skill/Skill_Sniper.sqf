/*
	Script: Sniper Skill System by Benny.
	Description: Add special skills to the defined sniper.
*/

_binoculars = 'WFBE_BINOCULARS' Call GetNamespace;
if !((currentWeapon player) in _binoculars) exitWith {hint (localize "STR_WF_Action_Spot_Info")};

if (isNil "markerID") then {markerID = 1};
_screenPos = screenToWorld [0.5,0.5];

_markerName = Format ["Spot%1",markerID];
createMarkerLocal [_markerName,_screenPos];
_markertime = [daytime] call bis_fnc_timetostring;
_markerName setMarkerText Format ['SPOTTED: %2',_id,_markertime];
_markerName setMarkerTypeLocal "mil_destroy";
_markerName setMarkerColorLocal "ColorRed";
_markerName setMarkerSizeLocal [0.5,0.5];
markerID = markerID + 1;

lastUseSkill set [1, time];

[_markerName] Spawn {
	Private ["_marker"];
	_marker = _this select 0;
	sleep 180;
	deleteMarkerLocal _marker;
};