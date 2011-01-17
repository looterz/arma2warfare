_vehicle = _this select 0;

(driver _vehicle) action ["engineOff", _vehicle];
(driver _vehicle) disableAI "MOVE";
(driver _vehicle) disableAI "TARGET";
while {speed _vehicle > 1} do {
	sleep 1;
};

sleep 3;
