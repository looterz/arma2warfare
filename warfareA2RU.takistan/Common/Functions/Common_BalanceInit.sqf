Private ["_unit"];
_unit = _this select 0;

switch (typeOf _unit) do {
	case "Ka52": {
		_unit removeWeapon "VikhrLauncher";
		_unit addweapon "AT9Launcher";
		_unit addweapon "R73Launcher";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_R73";
	};
	case "Ka52Black": {
		_unit removeWeapon "VikhrLauncher";
		_unit addweapon "AT9Launcher";
		_unit addweapon "R73Launcher";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_R73";
	}; 
	case "Mi24_D_TK_EP1": {
		_unit removeWeapon "AT2Launcher";
		_unit addWeapon "AT6Launcher";
		_unit addMagazine "4Rnd_AT6_Mi24V";
		
	};
	case "Mi24_V": {
		_unit removeWeapon "AT6Launcher";
		_unit removeWeapon "YakB";
		_unit removeMagazine "80Rnd_80mm";
		_unit addWeapon "AT9Launcher";
		_unit addWeapon "GSh23L";
		_unit addWeapon "R73Launcher_2";
		_unit addMagazine "40Rnd_80mm";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "4Rnd_AT9_Mi24P";
		_unit addMagazine "2Rnd_R73";
		_unit addMagazine "520Rnd_23mm_GSh23L";
	};
	case "Mi24_P": {
		_unit removeWeapon "HeliBombLauncher";
		_unit addMagazine "40Rnd_80mm";
	};	
	case "UH1Y": {
		_unit addMagazineTurret ["14Rnd_FFAR",[-1]];	
		_unit addMagazineTurret ["14Rnd_FFAR",[-1]];
	};
	case "An2_TK_EP1": {
		_unit addWeapon "CMFlareLauncher";
		_unit addMagazine "60Rnd_CMFlare_Chaff_Magazine";
		_unit addMagazine "500Rnd_TwinVickers";
		_unit addMagazine "500Rnd_TwinVickers";
		_unit addweapon "TwinVickers";
	};
	case "Su34": {
		_unit addMagazine "180Rnd_30mm_GSh301";
	};
		case "Su39": {
		_unit removeWeapon "GSh301";
		_unit addWeapon "GSh302";
		_unit addMagazine "750Rnd_30mm_GSh301";
	};
		case "Su25_TK_EP1": {
		_unit removeWeapon "GSh301";
		_unit addWeapon "GSh302";
		_unit addMagazine "750Rnd_30mm_GSh301";
	};
		case "Su25_Ins": {
		_unit removeWeapon "GSh301";
		_unit addWeapon "GSh302";
		_unit addMagazine "750Rnd_30mm_GSh301";
	};
	    case "M6_EP1": {
        _unit removeWeapon "StingerLaucher_4x";
        _unit addMagazine "8Rnd_9M311";
        _unit addWeapon "9M311Laucher";
        _rocketEH = _unit getVariable "M6_9M311LaucherEH";
        if (isNil "_rocketEH") then {
            _unit setVariable ["M6_9M311LaucherEH", 1, true];
            _unit addEventHandler["Fired", { _this spawn {
                private['_missile', '_type', '_launchPosition'];
                _missile = _this select 6;
                _type = typeof _missile;
                if (_type == "M_9M311_AA") then {
                    _launchPosition = position _missile;
                    _range = 3500 + ((random 1) - 0.5)*1000;
                    waitUntil { !(alive _missile) || _launchPosition distance _missile > _range};
                    if (alive _missile) then {
                        deleteVehicle _missile;        
                        //hint format["Missile SelfDestruction at %1", _launchPosition distance _missile];
                    };            
                };
            }}];
        }
    };
};
