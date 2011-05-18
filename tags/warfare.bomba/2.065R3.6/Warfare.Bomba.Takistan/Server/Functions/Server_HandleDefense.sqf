#include "profiler.h"
PROFILER_BEGIN("Server_HandleDefense");

Private ["_dt", "_alives","_buildings","_defense","_index","_side","_team","_type","_unit"];
_defense = _this select 0;
_unit = _this select 1;
_side = _this select 2;
_team = _this select 3;

while {alive _defense} do {
	if (isNull(gunner _defense) || !alive gunner _defense) then {
		_alives = (units _team) Call GetLiveUnits;
		if (count _alives < ('WFBE_MAXAIDEFENSE' Call GetNamespace)) then {
			_buildings = (str _side) Call GetSideStructures;
			_check = ['BARRACKSTYPE',_buildings,'WFBE_DEFENSEMANRANGE' Call GetNamespace,_side,_defense] Call BuildingInRange;
			_closest = _check select 0;
			_barrackNearby = _check select 1;
			
			if (_barrackNearby) then {
				sleep 7;
				
				if (alive _closest && !(isNull _closest )) then {
					_type = typeOf _closest;
					_index = (Format["WFBE_%1STRUCTURENAMES",str _side] Call GetNamespace) find _type;
					_distance = (Format["WFBE_%1STRUCTUREDISTANCES",str _side] Call GetNamespace) select _index;
					_direction = (Format["WFBE_%1STRUCTUREDIRECTIONS",str _side] Call GetNamespace) select _index;
					_position = [getPos _closest,_distance,getDir _closest + _direction] Call GetPositionFrom;
					
					_type = Format ["WFBE_%1SOLDIER",str _side] Call GetNamespace;
					_soldier = [_type,_team,_position,_side] Call CreateMan;
					[_soldier] allowGetIn true;
					_soldier assignAsGunner _defense;
					[_soldier] orderGetIn true;
					
					Format["Server_HandleDefense: A Soldier has been dispatched to the %1 defense %2",str _side,_type]  call LogInform;
					
					//--- Calculate the average time in function of the distance and the speed.
					_dt = (((_soldier distance _defense)/(14*1000))*3600)+20;
					if (_dt > 60) then { _dt = 60; };
					
					sleep _dt;
					
					if ((vehicle _unit != _defense)&& alive _unit &&(!isNull _unit)) then {
						if ((_defense EmptyPositions "gunner" > 0)&& alive _defense &&(!isNull _defense)) then {_unit MoveInGunner _defense} else {deleteVehicle _unit};
					};
				} else {
					"Server_HandleDefense.sqf: Canceled auto manning, the barracks is destroyed."  call LogInform;
				};
			};
		};
	};
	sleep 420;
};
PROFILER_END();