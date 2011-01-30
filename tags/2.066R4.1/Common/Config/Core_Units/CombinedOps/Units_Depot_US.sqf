Private ['_u'];

/* US Depot Vehicles */
_u 			= [["MMT_Civ", "Old_bike_TK_CIV_EP1"]];
_u = _u		+ ["Old_moto_TK_Civ_EP1"];
_u = _u		+ [["SkodaBlue", "Lada1_TK_CIV_EP1"]];
_u = _u		+ ["car_sedan", "Volha_1_TK_CIV_EP1"];
_u = _u		+ ["car_hatchback"];
_u = _u		+ ["datsun1_civil_1_open"];
_u = _u		+ ["datsun1_civil_3_open"];
_u = _u		+ [["hilux1_civil_1_open", "LandRover_TK_CIV_EP1"]];

_u = _u		+ ["V3S_Open_TK_CIV_EP1"];
_u = _u		+ ["Ikarus_TK_CIV_EP1"];
if (paramPurchaseInfDepot) then {
	_u = _u		+ ['WFBE_WESTSOLDIER' Call GetNamespace];
};

_u call SelectCamo;
_u