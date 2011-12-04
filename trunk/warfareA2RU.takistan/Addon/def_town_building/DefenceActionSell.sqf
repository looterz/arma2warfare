_defence = cursorTarget;

		_defenceInfo = [WF_DefenceTypeData, { (_x select DEFENCEINFO_TYPENAME) == typeof(_defence) } ] call getFirstOrDefault;
		if (isNil "_defenceInfo") exitWith { false };

		_cost = _defenceInfo select DEFENCEINFO_COST;
		_cost = ceil(_cost * 0.5 * (1 - (getDammage _defence)));
		
		if (!WF_DEBUG) then {
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 7;
		};
		deleteVehicle _defence;

		(_cost) Call ChangePlayerFunds;
		player groupChat format ["$+%1 for sell %2", _cost, (_defenceInfo select DEFENCEINFO_DESCRIPTION)];

