Private ["_AITrucks","_destinations","_driver","_hq","_isDeployed","_maist","_side","_sideText","_team","_type","_vehicle"];
_side = _this select 0;
_sideText = str _side;
_maist = 'WFBE_MAXAISUPPLYTRUCKS' Call GetNamespace;

sleep ((Random 200) / 100);
sleep ((Random 200) / 100);

waitUntil {townInit};

while {!gameOver} do {
	sleep 60;
	_AITrucks = Call Compile Format["%1AISupplyTrucks",_sideText];
	_full = false;
	if (count _AITrucks >= _maist) then {_full = true};
	if (!_full) then {
		_isDeployed = WF_Logic getVariable Format ["%1MHQDeployed",_sideText];
		_hq = WF_Logic getVariable Format ["%1MHQ",_sideText];
		if ((_isDeployed)&&(getDammage _hq < 1)&&(!isNull _hq)) then {[_side] ExecFSM "Server\FSM\supplytruck.fsm"};
	};
};
