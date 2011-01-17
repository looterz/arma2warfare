Private ['_u'];

/* Russian Depot Vehicles */
_u 			= [["MMT_Civ", "Old_bike_TK_CIV_EP1"]];
_u = _u		+ ["TT650_Civ"];
_u = _u		+ ["Tractor"];
_u = _u		+ [["SkodaRed", "Lada2_TK_CIV_EP1"]];
_u = _u		+ ["VolhaLimo_TK_CIV_EP1"];
_u = _u		+ [["VWGolf", "Volha_2_TK_CIV_EP1"]];
_u = _u		+ ["datsun1_civil_2_covered"];
_u = _u		+ [["hilux1_civil_2_covered", "S1203_TK_CIV_EP1"]];

_u = _u		+ ["Ural_TK_CIV_EP1"];
if (paramPurchaseInfDepot) then {
	_u = _u		+ ['WFBE_EASTSOLDIER' Call GetNamespace];
};

_u call SelectCamo;
_u