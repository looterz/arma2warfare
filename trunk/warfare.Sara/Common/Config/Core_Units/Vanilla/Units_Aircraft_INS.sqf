Private ['_r','_u'];

_r = 'WFBE_RESTRICTIONADVAIR' Call GetNamespace;

/* Overall Configuration */
['WFBE_EASTPILOT','Ins_Soldier_Pilot',false] Call SetNamespace;

/* Insurgent Aircraft Vehicles */
_u			= ['Mi17_Ins'];
_u = _u		+ ['Mi17_medevac_Ins'];
if (_r == 0) then {
	_u = _u		+ ['Su25_Ins'];
};

_u