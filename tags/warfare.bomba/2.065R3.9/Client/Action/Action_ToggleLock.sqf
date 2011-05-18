#include "netsend.h"
private['_vehicle', '_lock'];
	_vehicle = _this select 0;

	_lock = if (locked _vehicle) then {false} else {true};
	//[WBE_NETSEND_CLIENTID, NETSEND_MSGID_LOCKVEHICLE, [_vehicle, _lock]] spawn NetSend_ToServer;

	_vehicle setVehicleInit format ["this lock %1", _lock]; 
	processInitCommands;
	_vehicle lock _lock;