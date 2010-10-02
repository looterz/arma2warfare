Private ["_AITrucks","_destinations","_driver","_hq","_isDeployed","_maist","_side","_sideText","_team","_type","_vehicle"];
_side = _this select 0;
_sideText = str _side;
_maist = 'WFBE_MAXAISUPPLYTRUCKS' Call GetNamespace;

sleep ((Random 200) / 100);
sleep ((Random 200) / 100);

waitUntil {townInit};

while {!gameOver} do {
	sleep 60;
	_AITrucks = Format ["WFBE_%1_AISupplyTrucks",_sideText] Call GetNamespace;
	_full = false;
	if (count _AITrucks >= _maist) then {_full = true};
	if (!_full) then {
		_isDeployed = WF_Logic getVariable Format ["%1MHQDeployed",_sideText];
		_hq = WF_Logic getVariable Format ["%1MHQ",_sideText];
		if ((_isDeployed)&&(alive _hq)&&(!isNull _hq)) then {
			diag_log Format["[WFBE (INFORMATION)] AI_UpdateSupplyTruck: A %1 Supply truck has been created",_side];
			[_side] ExecFSM "Server\FSM\supplytruck.fsm";
		};
	};
};
