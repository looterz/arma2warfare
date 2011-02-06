private['_veh','_cammode','_wcamactionid'];

"Create Missle camera Action" call LogTrace;

_veh = _this select 0;

if (_veh isKindOf 'Air') then {
	_camMode = _veh getVariable "wcamEnabled";
	_wcamActionId = _veh getVariable "wcamActionId";

	if (!(isNil "_wcamActionId")) then {
		_veh removeaction _wcamActionId;
	};

	if (isNil "_camMode") then { _camMode = true; };

	if(!_camMode) then
	{
		_wcamActionId = _veh addAction [localize "STR_WF_MissleCamDisable", "Module\CamMissle\action_misslecam.sqf", [], 1, false, false, "", "(vehicle player) isKindOf 'Air'"];
		_camMode = true;
		"Missle webcam is On" call LogTrace;
		
		_veh setVariable ["wcamEnabled", _camMode, false];
		_veh setVariable ["wcamActionId", _wcamActionId, false];		
		
	} else {	
		_wcamActionId = _veh addaction [localize "STR_WF_MissleCamEnable", "Module\CamMissle\action_misslecam.sqf", [], 1, false, false, "", "(vehicle player) isKindOf 'Air'"];
		_camMode = false;
		"Missle webcam is Off" call LogTrace;

		_veh setVariable ["wcamEnabled", _camMode, false];
		_veh setVariable ["wcamActionId", _wcamActionId, false];		
	};
	
	if (!isNil "wcam_eh") then {
		_veh removeEventHandler ["Fired", wcam_eh];
		"Missle webcam: remove Fired Event Handler" call LogTrace;
	};
	
	if (_camMode) then {
		"Missle webcam: add event handler Fired" call LogTrace;
		wcam_eh = _veh addEventHandler ["Fired", { _this execVM "Module\CamMissle\misslecam.sqf"}];
	};
	

};


