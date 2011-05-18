Private ['_config','_element','_get','_i','_info','_prefix','_proceed','_u','_z'];

_u = [];
_i = [];

/* _i = _i + [[label, picture, config, belong to type, cost, upgrade level, allowed in camps, belong to the handgun pool, magazines, magazine space]]*/

/* Magazines - West */
_u = _u + ['20Rnd_B_AA12_Pellets'];
_i = _i + [['','','CfgMagazines','primary',20,0,true,false,0,0]];

_u = _u + ['20Rnd_B_AA12_74Slug'];
_i = _i + [['','','CfgMagazines','primary',30,1,true,false,0,0]];

_u = _u + ['20Rnd_B_AA12_HE'];
_i = _i + [['','','CfgMagazines','primary',30,1,true,false,0,0]];

_u = _u + ['8Rnd_B_Saiga12_Pellets'];
_i = _i + [['','','CfgMagazines','primary',30,0,true,false,0,0]];

_u = _u + ['8Rnd_B_Beneli_Pellets'];
_i = _i + [['','','CfgMagazines','primary',30,0,true,false,0,0]];

_u = _u + ['14Rnd_57mm'];
_i = _i + [['','','CfgMagazines','primary',30,0,true,false,0,0]];

/* Primary Weapons - West */
_u = _u + ['AA12_PMC'];
_i = _i + [['','','CfgWeapons','',495,3,true,false,1,0]];

_u = _u + ['PMC_AS50_scoped'];
_i = _i + [['','','CfgWeapons','',395,3,true,false,2,0]];

_u = _u + ['PMC_AS50_TWS'];
_i = _i + [['','','CfgWeapons','',595,3,true,false,3,0]];

_u = _u + ['m8_tws'];
_i = _i + [['','','CfgWeapons','',595,3,true,false,3,0]];

_u = _u + ['m8_tws_sd'];
_i = _i + [['','','CfgWeapons','',695,3,true,false,3,0]];

_u = _u + ['m8_holo_sd'];
_i = _i + [['','','CfgWeapons','',395,3,true,false,1,0]];

_u = _u + ['m8_compact_pmc'];
_i = _i + [['','','CfgWeapons','',295,3,true,false,0,0]];

_u = _u + ['m8_carbine_pmc'];
_i = _i + [['','','CfgWeapons','',395,3,true,false,0,0]];

/* Secondary weapons - West */
/* Misc - West */


/* Misc - East */
_u = _u + ['PMC_ied_v1'];
_i = _i + [['','','CfgMagazines','CfgMagazines',25,0,true,false,0,0]];

_u = _u + ['PMC_ied_v2'];
_i = _i + [['','','CfgMagazines','CfgMagazines',35,1,true,false,0,0]];

_u = _u + ['PMC_ied_v3'];
_i = _i + [['','','CfgMagazines','CfgMagazines',45,2,true,false,0,0]];

_u = _u + ['PMC_ied_v4'];
_i = _i + [['','','CfgMagazines','CfgMagazines',55,2,true,false,0,0]];

for '_z' from 0 to (count _u)-1 do {
	_info = (_i select _z);
	_element = (_u select _z);
	_config = (_info select 2);
	
	if (isClass (configFile >> _config >> _element)) then {
		//--- The loadout has a prefix since we can have two elements with the same name but with different class.
		_get = _element Call GetNamespace;
		_proceed = false;
		_prefix = "";
		
		if (isNil '_get') then {
			_proceed = true;
		} else {
			//--- Two elements can have the same name, like "Javelin(Weapon) >> Javelin (Magazine)", if two elements are found, we compare the class to see if they're already defined or not.
			if ((_get select 2) == _config) then {
				Format ["Core_PMC_G: Duplicated Loadout Element found '%1' for class '%2'",_element,_config] call LogMedium;
			} else {
				//--- Is it a special class?
				_get = (_element+'_W') Call GetNamespace;
				if (isNil '_get') then {
					_prefix = '_W';
					_proceed = true;
				} else {
					Format ["Core_PMC_G: Duplicated Loadout Element found '%1' for class '%2'",_element,_config] call LogMedium;
				};
			};
		};
		
		if (_proceed) then {
			//--- A custom loadout displayName can be set.
			if ((_info select 1) == '') then {_info set [0, [_element,'displayName',_config] Call GetConfigInfo]};
			_info set [1, [_element,'picture',_config] Call GetConfigInfo];
			
			if (_config == 'CfgWeapons') then {
				//--- A custom loadout magazine can be set.
				if (typeName (_info select 8) != 'ARRAY') then {
					_info set [8, getArray (configFile >> _config >> _element >> 'magazines')];
				};
			};
			
			//--- Set the magazine space.
			if (_config == 'CfgMagazines') then {
				if ((_info select 3) in ['CfgMagazines','primary','secondary','sidearm']) then {
					_info set [9, ceil(getNumber(configFile >> _config >> _element >> 'type') / 256)];
				};
			};

			[_element+_prefix,_info] Call SetNamespace;
		};
	} else {
		Format ["Core_PMC_G: Loadout Element '%1' with class '%2' is not a defined a class!",_element,_config] call LogError;
	};
};

Format ["Core_PMC_G: Loadout Initialization (%1 Elements) - [Done]",count _u] call LogMedium; 