#include "netsend.h"
private['_vehicle', '_lock'];
	_vehicle = _this select 0;

	_lock = if (locked _vehicle) then {false} else {true};
	[WBE_NETSEND_CLIENTID, NETSEND_MSGID_LOCKVEHICLE, [_vehicle, _lock]] spawn NetSend_ToServer;

	_vehicle lock _lock;