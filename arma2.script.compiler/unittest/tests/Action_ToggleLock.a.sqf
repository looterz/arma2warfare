private['_lock','_vehicle'];
#include "netsend.h"
_vehicle=_this select 0;_lock=if(locked _vehicle)then{false}else{true};_vehicle setVehicleInit format["this lock %1",_lock];processInitCommands;_vehicle lock _lock;