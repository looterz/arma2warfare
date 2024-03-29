#include "nuke.h"

private [
	"_pos",
	"_yield",
	"_range",
	"_vp",
	"_dist",
	"_bang"
];

_pos  = _this select 0;
_yield  = _this select 1;

_range = 179.52*_yield^(1/3);

_bang = "Can_small" createVehicleLocal _pos;
_bang say3D["Nuke", 2*_range, 1];

_vp = vehicle player;
_dist = (vehicle player) distance _pos;

if ( _dist < 3*_range ) then 
{
	sleep (_dist/SPEED_SOUND);
	playSound "eq";
	_vp say3D "wind_4";
};

sleep 10;

deleteVehicle _bang;
