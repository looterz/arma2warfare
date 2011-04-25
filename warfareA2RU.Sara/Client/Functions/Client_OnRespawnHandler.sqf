Private ["_buildings","_charge","_funds","_loadDefault","_listbp","_mode","_price","_skip","_spawn","_temp","_unit","_weaps"];

_unit = _this select 0;
_spawn = _this select 1;
_loadDefault = true;

if !(isNil "respawnWeapons") then {
	_mode = 'WFBE_RESPAWNPENALTY' Call GetNamespace;
	
	if (_mode in [0,2,3,4,5]) then {
		//--- Calculate the price/funds.
		_skip = false;
		if (_mode != 0) then {
			_price = 0;
			
			//--- Get the mode pricing.
			switch (_mode) do {
				case 2: {_price = respawnGearCost};
				case 3: {_price = round(respawnGearCost/2)};
				case 4: {_price = round(respawnGearCost/4)};
				case 5: {_price = respawnGearCost};
			};
			
			//--- Are we charging only on mobile respawn?
			_charge = true;
			if (_mode == 5) then {
				_buildings = (sideJoinedText) Call GetSideStructures;
				if (_spawn in _buildings || _spawn == ((sideJoinedText) Call GetSideHQ)) then {_charge = false};
			};
			
			//--- Charge if possible.
			_funds = Call GetPlayerFunds;
			if (_funds >= _price && _charge) then {
				-(_price) Call ChangePlayerFunds;
				(Format[localize 'STR_WF_Gear_RespawnCharge',_price]) Call GroupChatMessage;
			};
			
			//--- Check that the player has enough funds.
			if (_funds < _price) then {_skip = true};
		};
		
		//--- Use the respawn loadout.
		if !(_skip) then {
			_temp = +(respawnWeapons);
			_listbp = 'WFBE_BACKPACKS' Call GetNamespace;
			{if (_x in _listbp) then {_temp = _temp - [_x]}} forEach respawnWeapons;
			_weaps = _temp;
			
			[_unit,_weaps,respawnAmmo] Call EquipLoadout;
			if !(WF_A2_Vanilla) then {Call RespawningBag};
			_loadDefault = false;
		};
	};
};

//--- Load the default loadout.
if (_loadDefault) then {
	[_unit,Format ["WFBE_%1DEFAULTWEAPONS",sideJoinedText] Call GetNamespace,Format ["WFBE_%1DEFAULTAMMO",sideJoinedText] Call GetNamespace] Call EquipLoadout;
};