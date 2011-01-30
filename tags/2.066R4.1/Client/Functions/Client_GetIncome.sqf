private['_value'];
_value = WF_Logic getVariable format["%1Income", sideJoined];
if (isNil "_value") then { _value = 0; };

_value;