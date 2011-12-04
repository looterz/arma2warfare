	_preview = player getVariable "DefencePreview";
	if (!(isNull _preview)) then {
		deleteVehicle _preview;
		player setVariable["DefencePreview", objNull];
	};
