#include "nuke.h"

// This is not a version of DELFIC, we don't need/want that level of detail.
// Locations are used to check geometry of fallout pattern, do not assume a circle!
// Adjust value of SIM_SPEEDUP to speed up simulation time.

// For vehicles, if significantly above ground level ( 10m ) the hazard from fallout is largely
// negated, so air vehicles can safely travel over a zone, just don't land and kick up dust.

// Using Iodine-131 as principal fallout hazard to model. Intensity drops over time according
// the half-life formula. Once levels reach 1% of original level we stop inflicting damage. This
// takes about 7 half-life intervals.

// The global variable echo_fallout_decay_rate is used to alter decay rate, used for mission makers.
// Use a rate of 1440 (minutes in a day) to make a fallout zone disappear in about 1 hour.

if (!isServer) exitWith {};

// Use parentheses around any DEFINES to ensure calculations are correct.

// Time constants. DO NOT CHANGE!!
#define MINUTE 60
#define HOUR 60*MINUTE
#define DAY 24*HOUR
#define YEAR 365.25*DAY

// Data for I-131, 8 Gray dosage
#define HALF_LIFE 8.0197*DAY
#define LD_MINUTES 10

// Values for frictional forces of rising plume and decending particles
#define FALLRATE 0.27845
#define FALLDRAG 0.50

// Enable local marker display. Comment out to disable
// #define SHOW_NOW

// Use value of 60 to make minutes like seconds. Set to 1 to run at normal speed.
#define SIM_SPEEDUP 1
// Enable logging
//#define DIAGNOSTICS

//#squint filter '_fallout_marker' - value is never actually used - consider removing
//#squint filter Careful - this may not evaluate as you expect - use brackets

private [
	"_pos",
	"_yield",
	"_C1",
	"_airburst_threshold",
	"_fireball_life",
	"_delay",
	"_wind",
	"_mean",
	"_mean_mag",
	"_mean_dir",
	"_drift",
	"_a_axis",
	"_b_axis",
	"_my_fallout_number",
	"_fallout_center",
	"_fallout_name",
	"_fallout_marker",
	"_fallout_zone",
	"_area",
	"_zone_name",
	"_zone_data",
	"_to_wait",
	"_fallout_start",
	"_check_radius",
	"_hasNBC",
	"_obj_position",
	"_radiation_intensity",
	"_rad_damage",
	"_objects",
	"_object_damage"
];

_pos  = _this select 0;
_yield  = _this select 1;

_C1 = _yield^(1/5);

_airburst_threshold = 33.528*_C1^2;

if isNil("echo_fallout_decay_rate") then {
	echo_fallout_decay_rate = 1.0;
};

if (isNil "echo_logic_center") then {
	echo_logic_center = createCenter sideLogic;
	echo_logic_group = createGroup echo_logic_center;
};

if (isNil "ECHO_FalloutGL") then {
	"Logic" createUnit [[0, 0, 0], echo_logic_group, "ECHO_FalloutGL = this"];
	publicVariable "ECHO_FalloutGL";
};

if ( (_pos select 2) < _airburst_threshold ) then {
	_fireball_life = 1.75*_airburst_threshold;
	_delay = _fireball_life*FALLRATE;
	_area = (537.5*_C1)^2;
	
	_mean = [0, 0, 0];
	_mean_mag = 0;

	for "_i" from 1 to _delay do {
		_wind = wind;

		for "_j" from 0 to 2 do {
			_mean set[_j, (_mean select _j) + (_wind select _j)];
		};

		sleep ((MINUTE)/SIM_SPEEDUP); 
	};

	for "_j" from 0 to 2 do {
		_mean set[_j, (_mean select _j)/_delay];
	};

	_mean_mag = sqrt ( (_mean select 0)^2 + (_mean select 1)^2 + (_mean select 2)^2 );

	if ( _mean_mag == 0 ) then {
		_mean_dir = 0;
	} else {
		_mean_dir = (_mean select 0) atan2 (_mean select 1);

		if ( _mean_dir < 0 ) then {
			_mean_dir = _mean_dir + 360;
		};
	};

	_drift = FALLDRAG*60*_delay;

	_a_axis = sqrt(_area) + 0.25*_drift*_mean_mag;
	_b_axis = _area/_a_axis;

	_fallout_center = [0, 0, 0];

	for "_j" from 0 to 2 do {
		_fallout_center set[_j, (_pos select _j) + 0.95*_drift*(_mean select _j)];
	};

// Define my local ID number, global will change over time.
	_my_fallout_number = echo_fallout_number + 1;
	echo_fallout_number = _my_fallout_number;
	publicVariable "echo_fallout_number";

	_fallout_name = format["ECHO_FalloutMarker%1", _my_fallout_number];
	_fallout_marker = createMarker[_fallout_name, [_fallout_center select 0, (_fallout_center select 1)]];
#ifdef SHOW_NOW
	_fallout_name setMarkerShape "ELLIPSE";
	_fallout_name setMarkerColor "ColorOrange";
#else
	_fallout_name setMarkerShape "ICON";
	_fallout_name setMarkerType "Empty";
#endif
	_fallout_name setMarkerSize [_b_axis, _a_axis];
	_fallout_name setMarkerDir _mean_dir;

	_fallout_zone = createLocation["Name", [_fallout_center select 0, _fallout_center select 1], _b_axis, _a_axis];
	_fallout_zone setDirection _mean_dir;

	_zone_name = format["%1", _my_fallout_number];
	_zone_data = [1.0, _fallout_marker, _fallout_zone, _fallout_center, _a_axis, _b_axis, _mean_dir];
	ECHO_FalloutGL setVariable[_zone_name, _zone_data, true];

	_check_radius = _a_axis max _b_axis;
	_fallout_start = time;

	while {
		_radiation_intensity = 2^((SIM_SPEEDUP)*(_fallout_start - time)*echo_fallout_decay_rate/(HALF_LIFE));
#ifdef DIAGNOSTICS
		diag_log format["%1 # Zone %2, Intensity %3", time, _my_fallout_number, _radiation_intensity];
#endif
		(_radiation_intensity >= 0.01) 
	} do {
		_fallout_zone setVariable["Intensity", _radiation_intensity];
		_zone_data set[0, _radiation_intensity];
		ECHO_FalloutGL setVariable[_zone_name, _zone_data, true];

#ifdef SHOW_NOW
		_fallout_name setMarkerAlpha _radiation_intensity;
#endif

		_to_wait = 0;
		_objects = nearestObjects[_fallout_center, ["Car", "Motorcycle", "Tank", "Air", "Ship"], _check_radius];
		_to_wait = (count _objects)*0.1;
		{
			_obj_position = getPosATL _x;
			if ( (alive _x)  && (_obj_position in _fallout_zone) && ((_obj_position select 2) < 10) ) then {
				if ((count crew _x) > 0) then {
					{
						if (alive _x) then {
							_hasNBC = _x getVariable "ECHO_HasNBC";

							if (isNil "_hasNBC") then {
								_object_damage = damage _x;
								_rad_damage = _radiation_intensity/LD_MINUTES;
								_x setDamage (_object_damage + _rad_damage);
							} else {
								// Depends on value of _hasNBC
							};
						};

					} forEach crew _x;
				};
			};
			sleep 0.1;
		} forEach _objects;

		_objects = nearestObjects[_fallout_center, ["Man"], _check_radius];
		_to_wait = _to_wait + (count _objects)*0.1;
		{
			if ((local _x) && (alive _x)  && (_obj_position in _fallout_zone) ) then {
				_hasNBC = _x getVariable "ECHO_HasNBC";

				if (isNil "_hasNBC") then {
					_object_damage = damage _x;
					_rad_damage = _radiation_intensity/LD_MINUTES;
					_x setDamage (_object_damage + _rad_damage);
				} else {
					// Depends on value of _hasNBC
				};

			};

			sleep 0.1;
		} forEach _objects;
		
#ifdef DIAGNOSTICS
		diag_log format["%1 # Zone %2, Diagnostic %3", time, _my_fallout_number, ECHO_FalloutGL getVariable _zone_name];
#endif
		sleep (((MINUTE - _to_wait) max 1)/SIM_SPEEDUP);
	};

#ifdef DIAGNOSTICS
	diag_log format["%1 # Zone %2 Done", time, _my_fallout_number];
#endif
	_fallout_zone setVariable["Intensity", 0];
	_zone_data set[0, 0];
	_zone_data set[1, objNull];
	ECHO_FalloutGL setVariable[_zone_name, _zone_data, true];
	deleteMarker _fallout_name;
};
