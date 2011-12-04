_defenceTypeId = _this select 0;

	_defenceInfo = (WF_DefenceTypeData select _defenceTypeId);
	
	_pos = getPos player;
	_dir = getDir player;
	_dis = 5;
	_location = [(_pos select 0) + sin _dir * _dis,(_pos select 1) + cos _dir * _dis];

	_previewType = if ((_defenceInfo select DEFENCEINFO_WEAPONTYPE)) then { "Sign_arrow_down_large_EP1" } else { (_defenceInfo select DEFENCEINFO_TYPENAME); };
	_preview = _previewType createVehicleLocal (_location);
	 
	_preview setDir _dir;
	_preview attachTo [player,[0, (_defenceInfo select DEFENCEINFO_RANGE), 0.7]];
	_preview lock true;
	
	player setVariable["DefencePreview", _preview];
	player setVariable["DefencePreviewInfo", _defenceInfo];
