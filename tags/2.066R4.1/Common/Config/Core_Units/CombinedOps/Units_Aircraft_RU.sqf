Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* Russian Aircraft Vehicles */
_u = [];
_u = _u + [['Mi17_Ins', 'UH1H_TK_EP1']];

if (_r == 0 || _r == 1) then {
	_u = _u		+ ['Mi17_medevac_RU'];
	_u = _u		+ ['Mi17_rockets_RU'];
	_u = _u		+ ['Mi24_V'];
	_u = _u		+ [['Mi24_D', 'Mi24_D_TK_EP1']];
	_u = _u		+ ['Mi24_P'];
	if !(paramRestrictionKamov) then {
		_u = _u		+ ['Ka52'];
		_u = _u		+ ['Ka52Black'];
	};
};

if (paramDLCPMC) then {
	_u = _u		+ ['Ka60_PMC'];
	_u = _u		+ ['Ka60_GL_PMC'];
};

if (_r == 0) then {

	if (!paramBuyAircraftInAirportOnly) then {
		_u = _u		+ ['An2_TK_EP1'];
		_u = _u		+ ['L39_TK_EP1'];
		_u = _u		+ ['Su34'];
		_u = _u		+ [['Su25_Ins', 'Su25_TK_EP1']];
		_u = _u		+ ['Su39'];
	};
};

_u call SelectCamo;
_u