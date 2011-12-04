While {!(Alive Player)} do {sleep 1;};

player addAction [localize "STR_actions_ChangeWheels", "addon\wheel\action\car_wheel.sqf", [], 1, false, true, "", "(cursorTarget isKindOf 'Car')&&(player distance cursorTarget<5)"];
