call compile preprocessFile (DefenceAddonPath + "DefenceConfig.sqf"); // Массивы для строительства

createDialog "DefenceDialog";
{ lbAdd [5100,format ["(%1$) %2",_x select DEFENCEINFO_COST, _x select DEFENCEINFO_DESCRIPTION]]} forEach WF_DefenceTypeData;
