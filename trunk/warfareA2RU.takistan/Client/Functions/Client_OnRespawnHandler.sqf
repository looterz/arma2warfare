Private ["_buildings","_charge","_funds","_loadDefault","_listbp","_mode","_price","_skip","_spawn","_spawnInside","_temp","_unit","_weaps"];

_unit = _this select 0;
_spawn = _this select 1;
_loadDefault = true;

//--- Respawn.
_spawnInside = false;
if ((typeOf _spawn) in (Format ["WFBE_%1AMBULANCES",sideJoinedText] Call GetNamespace) && alive _spawn) then {
	if (_spawn emptyPositions "cargo" > 0 && !(locked _spawn)) then {_unit moveInCargo _spawn;_spawnInside = true};
};

if !(_spawnInside) then {_unit setPos ([getPos _spawn,10,20] Call GetRandomPosition)};

//--- Loadout.
if (!isNil "respawnWeapons" && !WFBE_RespawnDefaultGear) then {
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
				(Format[localize 'STR_WF_CHAT_Gear_RespawnCharge',_price]) Call GroupChatMessage;
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