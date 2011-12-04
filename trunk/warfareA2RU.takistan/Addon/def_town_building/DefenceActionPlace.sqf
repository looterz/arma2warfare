	
	_previewDefence = player getVariable "DefencePreview";
	if (_previewDefence == objNull) exitWith {};
	
	detach _previewDefence;	
	deleteVehicle _previewDefence;	
	player setVariable ["DefencePreview", objNull];
	
	_defenceInfo = player getVariable "DefencePreviewInfo";
	player setVariable["DefencePreviewInfo", objNull];

	_cost = (_defenceInfo select DEFENCEINFO_COST);
	_money = (clientTeam) Call GetTeamFunds;	
	
	if (_money < _cost) exitWith {
		hint format ["%1\n", localize "PC_not_anough_money"];
	};
	
	_dir = getDir player;
	_dis = (_defenceInfo select DEFENCEINFO_RANGE);
	_pos = getPosATL player;	
	_pos = [(_pos select 0) + sin _dir * _dis, (_pos select 1) + cos _dir * _dis, (_pos select 2) + (_defenceInfo select DEFENCEINFO_ZOFFSET)];

	if (!WF_DEBUG) then {
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 7;	
	};
	
	if (_defenceInfo select DEFENCEINFO_WEAPONTYPE) then {
		WFBE_RequestDefense = ['SRVFNCREQUESTDEFENSE',[sideJoined, (_defenceInfo select DEFENCEINFO_TYPENAME), _pos,_dir,true]];
		publicVariable 'WFBE_RequestDefense';
		if (isHostedServer) then { ['SRVFNCREQUESTDEFENSE',[sideJoined, (_defenceInfo select DEFENCEINFO_TYPENAME), _pos,_dir,true]] Spawn HandleSPVF };
		
		[_pos, (_defenceInfo select DEFENCEINFO_TYPENAME), _dir, [], {   
			_defence = _this select 0;
			_args = _this select 1;
			_defence setVariable["DefenceOwnerId", (getPlayerUID player), true];		
			_defence setVariable["DefenceSupply", (call DefenceConditionGetSupplyObject), true];		
			_defence spawn DefenceHandleEvent;
			
		}] spawn DefenceGetServerDefence;
		
	} else {
		_defence = (_defenceInfo select DEFENCEINFO_TYPENAME) createVehicle _pos;
		_defence setPosATL _pos;
		_defence setDir _dir;
		_defence setVariable["DefenceOwnerId", (getPlayerUID player), true];
		_defence setVariable["DefenceSupply", (call DefenceConditionGetSupplyObject), true];
		_defence spawn DefenceHandleEvent;				
	};	
	
	
	
	(-_cost) Call ChangePlayerFunds;
	player groupChat format ["-$%1 For the construction of %2", _cost, (_defenceInfo select DEFENCEINFO_DESCRIPTION)];

	 

