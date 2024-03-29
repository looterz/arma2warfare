/* mando_missilevehicle3.sqf
By Mandoble January 2009

*/
mando_portable_fired = 
{
   private["_veh", "_ammo_class", "_missile", "_misparams", "_weapon", "_pos", "_target"];
   _veh = _this select 0;
   _weapon = _this select 1;
   _ammo_class = _this select 4;

//   if ((_ammo_class isKindOf "MissileBase") && (local (_this select 0))) then
   if (_ammo_class isKindOf "MissileBase") then
   {
//      Sleep 0.05;
//      _missile = nearestObject [_veh, _ammo_class];
     _missile = objNull;
     _missiles = getPos _veh nearObjects [_ammo_class, 100];

     if (count _missiles > 0) then
     {
        _nearest = 200;
        {
           if ((_x distance _veh) < _nearest) then
           {
              _nearest = _x distance _veh;
              _missile = _x;
           };
        } forEach _missiles;

        if (!local _missile) then
        {
           _missile = objNull;
        };
     };
Sleep 0.05;

      if (!isNull _missile) then
      {
         _target = _veh getVariable "mando_current_target";

         switch (mando_hud_guidance) do
         {         
            case 2: // SARH
            {
               _target = "Logic" createVehicleLocal (getPos _target);
            };

            case 3: // Manual
            {
               _pos = positionCameraToWorld [0,0,100];
               _target = "Logic" createVehicleLocal _pos;
               _target setPos _pos;
            };
         
            default
            {
               if (!isNil "_target") then
               {
                  _target = _veh getVariable "mando_current_target";
               }
               else
               {
                  _target = objNull;
               };
            };
         };

         _vdir = vectorDir _missile;
         _missparams = [];
         _missparams = _missparams + (mando_hud_misp select mando_hud_missile);
         _missilebody = typeOf _missile;
         _pos = _veh worldToModel (getPos _missile);
         _dir = (_vdir select 0) atan2 (_vdir select 1);;
//         _vangle = asin(_vdir select 2);
         _vangle        = asin (_vdir select 2) - asin (vectorDir _veh select 2);
//         _speedini = (((speed _missile)/3.6 - (speed _veh)/3.6) + (_missparams select 5)) min (_missparams select 6);
         _speedini = (((speed _missile)/3.6 - (speed _veh)/3.6) + (_missparams select 5)) min 200;
		 
		 _missile setPos [60000,60000,60000];
         [_missile] spawn
         {
            _missile = _this select 0;            
            Sleep 6;
            if (alive _missile) then
            { 
               deleteVehicle _missile;
            };
         };

         _missparams set [1, _missilebody];
         _missparams set [2, _pos];
         _missparams set [3, _dir];
         _missparams set [4, _vangle];
         _missparams set [5, _speedini];
         _missparams set [8, _target];

         _missparams execVM mando_missile_path+"mando_missile.sqf";
         mando_hud_fired = true;

         switch (mando_hud_guidance) do
         {         
            case 2: // SARH
            {
               Sleep 0.1;
               _missile = _veh getVariable "mando_missile_fired";

               [_target, _missile, _veh] spawn
               {
                  private["_log", "_mis", "_launcher", "_pos", "_target", "_ecm"];
                  _log = _this select 0;
                  _mis = _this select 1;
                  _launcher = _this select 2;
                  _target = _launcher getVariable "mando_current_target";

                  // Triger a missile launch warning
                  mando_missileincomming = _mis;
                  mando_missiletarget = _target;
                  mando_missilerequest = true;



                  publicVariable "mando_missileincomming";publicVariable "mando_missiletarget";publicVariable "mando_missilerequest";
                  _target setVariable ["mando_missileincomming", _mis, true];


                  while {alive _mis && alive _launcher} do
                  {
                     _target = _launcher getVariable "mando_current_target";

                     if (alive _target) then
                     {
                        _ecm = _target getVariable "mando_ecm_on";
                        if (isNil "_ecm") then 
                        {
                           _ecm = false;
                           _target setVariable ["mando_ecm_on", false];
                        };
                        
                        if ((_ecm && ((random 100) > 90)) || !_ecm) then
                        {
                           _dist = _target distance _mis;
                           _tti = (_dist / (((speed _mis)/3.6) max 100)) min 1;

                           _twpos = _target modelToWorld [0,0,0];
                           _tvel = velocity _target;
                           _twpos = [(_twpos select 0)+(_tvel select 0)*_tti,(_twpos select 1)+(_tvel select 1)*_tti,(_twpos select 2)+(_tvel select 2)*_tti];
                           _log setPos _twpos;
                        };
                     };
                     Sleep 0.003;
                  };
                  Sleep 6;
                  deleteVehicle _log;
               };
            };

            case 3: // Manual           
            {
               Sleep 0.2;
               _missile = _veh getVariable "mando_missile_fired";

               [_target, _missile, _veh, _weapon] spawn
               {
                  private["_log", "_mis", "_launcher", "_weapon", "_dist", "_pos", "_vdir"];
                  _log = _this select 0;
                  _mis = _this select 1;
                  _launcher = _this select 2;
                  _weapon = _this select 3;
   
                  while {alive _mis && alive _launcher} do
                  {
                     _vdir = _launcher weaponDirection _weapon;
                     _dist = (_launcher distance _mis)+20;
                     _pos = positionCameraToWorld [0,0,_dist];
                     _log setPos _pos;
                     Sleep 0.005;
                  };
                  Sleep 4;
                  deleteVehicle _log;
               };
            };

            default
            {
            };
         };
      };
   };
};

mando_update_flares = 
{
   _msg = "";
   if ((_unit getVariable "mando_maxflares") > 0) then
   {
      _msg = format["[%1/%2]",(_unit getVariable "mando_flaresleft"), (_unit getVariable "mando_maxflares")];
      _msg = _msg + "<br />";
   };

   if ((_unit getVariable "mando_ecm_max_time") > 0) then
   {
      // 0 -> OFF, 1 - ON 2 - WAIT
      if ((_unit getVariable "mando_ecm_sts") == 0) then
      {
         _msg = _msg + format["ECM: %1", _unit getVariable "mando_ecm_time"];
      }
      else
      {
         if ((_unit getVariable "mando_ecm_sts") == 1) then
         {
            _msg = _msg + format[">>ECM: %1", _unit getVariable "mando_ecm_time"];
         }
         else
         {
            _msg = _msg + format["[ECM: %1]", _unit getVariable "mando_ecm_time"];
         };
      };
   };

   ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 111) ctrlSetStructuredText parseText _msg;
};

mando_update_ammo = 
{
   _msg = "";
   _i = 0;
   {
      if ((_x select 0) >= 0) then
      {
         if ((vehicle player getVariable format["mando_maxmissiles%1", (_x select 0)]) >= 0) then
         {
            _msg = _msg + format["[%1/%2]",(vehicle player getVariable format["mando_missilesleft%1", (_x select 0)]),(vehicle player getVariable format["mando_maxmissiles%1", (_x select 0)])];
         }
         else
         {
            _msg = _msg + "[0/0]";
         };
      }
      else
      {
         _msg = _msg + format["[%1]",vehicle player ammo (_x select 1)];
      };

      if (_i == mando_hud_missile) then
      {
         _msg = _msg + "--";
      };

      _msg = _msg + "<br />";
      _i = _i + 1;

   } forEach mando_missileidxbase;
             
   ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 109) ctrlSetStructuredText parseText _msg;   
};


mando_get_targets = 
{
   private["_ttypes", "_dir", "_weaponname", "_unit", "_playerpos", "_trigger", "_sensor_y", "_sensor_x", "_list", "_min_targets_alt", "_max_targets_alt", "_loglos", "_deltaz", "_elapsed", "_max_targets", "_pos", "_posu"];

   _unit = _this select 0;
   _playerpos = _this select 1;
   _weaponname = _this select 2;
   _elapsed = (dayTime * 3600);
   _loglos = "logic" createVehicleLocal [0,0,0];
   _deltaz = 2;
   _trigger = objNull;



   while {!mando_exit_hud} do
   {
      if (mandotarget_disp_on && (mando_hud_num_modes > 0)) then
      {
         _ttypes =  _unit getVariable "mando_target_types";
         if ((_ttypes select 0) == "Air") then
         {
            _min_targets_alt = 10;
            _max_targets_alt = 40000;
         }
         else
         {
            _min_targets_alt = -3;
            _max_targets_alt = 9;
         };


         _sensor_x = (mando_hud_modes select mando_hud_mode) select 8;
         _sensor_y = (mando_hud_modes select mando_hud_mode) select 9;
         _max_targets = (mando_hud_modes select mando_hud_mode) select 7;


         _posu = getPos _unit;
         if (((_ttypes select 0) == "Air") ||((_ttypes select 0) == "LandVehicle")) then
         {
            _list = [];
            if (_weaponname == "") then
            {
               _dir = getDir _unit;
            }
            else
            {
               if (_weaponname == "sight") then
               {
                  _pos = positionCameraToWorld [0,0,100];
                  _dir = ((_pos select 0) - (_posu select 0)) atan2 ((_pos select 1) - (_posu select 1));
               } 
               else
               {
                  _dir = ((_unit weaponDirection _weaponname) select 0) atan2 ((_unit weaponDirection _weaponname) select 1);
               };
            }; 

            if (isNull _trigger) then
            {
               _trigger = createTrigger ["EmptyDetector", [(_posu select 0)+(_sensor_y+25)*sin(_dir),(_posu select 1)+(_sensor_y+25)*cos(_dir), 0]];
               _trigger setTriggerActivation ["ANY", "PRESENT", false];
               _trigger setTriggerArea [_sensor_x, _sensor_y, _dir, true];
               _trigger setTriggerType "NONE";
               _trigger setTriggerStatements ["this", "", ""];
               _trigger setTriggerTimeout [0, 0, 0, false ];
            }
            else
            {
               _trigger setPos [(_posu select 0)+(_sensor_y+25)*sin(_dir),(_posu select 1)+(_sensor_y+25)*cos(_dir), 0];
               _trigger setTriggerArea [_sensor_x, _sensor_y, _dir, true];
            };

            // Air, vehicles, ships
            {
               if (fuel _x < 1) then
               {
                  if (side _x != side _unit) then 
                  {
                     if (count (crew _x) > 0) then 
                     {
                        if (((getPos _x select 2) > _min_targets_alt) &&
                            ((getPos _x select 2) < _max_targets_alt)) then
                        {
                           if ((count _list) < _max_targets) then
                           {
                           // Only up to 6 target tracked by HUD
                              if ((typeOf _x) in mando_missile_stealth) then
                              {
                              // Is stealth target?
                                 if ((_x distance (getPos _unit)) < 1500) then
                                 {
                                    if ([_loglos, _unit, _x, 20, _deltaz] call mando_check_los) then
                                    {
                                       _list = _list + [_x];
                                    };
                                 };
                              }
                              else
                              {
                                 if ([_loglos, _unit, _x, 20, _deltaz] call mando_check_los) then
                                 {
                                    _list = _list + [_x];
                                 };
                              };
                           };
                        };
                     };
                  };
               };
            } forEach list _trigger;  
            _list = _list + ["A"];
            mando_hud_targets = +_list;       
         };


         if ((dayTime * 3600) > (_elapsed + 2)) then
         {
            _elapsed = (dayTime * 3600);

            if ((_ttypes select 0) == "REMOTE") then
            {
               _list = [];
               switch (side _unit) do
               {    
                  case west:
                  {
                     {
                        _list = _list + [_x];
                     } forEach mando_remote_targets_w;
                  };

                  case east:
                  {  
                     {
                        _list = _list + [_x];
                     } forEach  mando_remote_targets_e;
                  };

                  case resistance:
                  {
                     {
                        _list = _list + [_x];
                     } forEach  mando_remote_targets_r;
                  };
               };
               _list = _list + ["A"];
               mando_hud_targets = +_list;   
            }
            else
            {
               if ((_ttypes select 0) == "RADAR") then
               {
                  // Radars
                  _list = [];
                  {
                     if ((getPos _x select 2) < 10) then 
                     {
                        _list = _list + [_x];
                     };
                  } forEach mando_radars;
                  _list = _list + ["A"];
                  mando_hud_targets = +_list;   
               }
               else
               {
                  if ((_ttypes select 0) == "LOCATIONS") then
                  {
                     // Locations
                     _sensor_y = (mando_hud_modes select mando_hud_mode) select 9;

                     _list = [];
                     {
                        _pos = worldToScreen (locationPosition _x);
                        if ((count _pos) > 0) then
                        {
                           if (abs(0.5 - (_pos select 0)) < 0.3) then
                           {
                              _list = _list + [_x];
                           };
                        };
                     } forEach nearestLocations [[_posu select 0,_posu select 1, 0], ["NameCityCapital", "NameCity", "NameVillage"], _sensor_y*2];

                     _list = _list + ["A"];
                     mando_hud_targets = +_list;
                  }
                  else
                  {
                     if (((_ttypes select 0) == "") || ((_ttypes select 0) == "GROUND")) then
                     { 
                        mando_hud_targets = ["A"];
                     };
                  };
               };
            };
         };
      };

      Sleep(0.03);

   }; // End while

   deleteVehicle _loglos;
   if (!isNull _trigger) then
   {
      deleteVehicle _trigger;
   };
};



mando_rwr = 
{
   private["_misecm", "_incoming_missiles", "_unit", "_hudtype", "_i", "_posc", "_posm", "_dist", "_angh", "_hudtype", "_playerpos", "_posu"];

   _unit = _this select 0;
   _playerpos = _this select 1;
   _hudtype = _this select 2;


   // _back2 e _inc_lines pendientes de resolver
/*
   _misecm = _unit getVariable "mando_missileincomming";
   if (isNil "_misecm") then
   {
      _unit setVariable ["mando_missileincomming", objNull];
   };
*/

   _unit setVariable ["mando_missileincomming", objNull];
   _incoming_missiles = [];
   while {!mando_exit_hud} do
   {
      _misecm = _unit getVariable "mando_missileincomming";
      if (!isNull _misecm) then
      {   
         if (!(_misecm in _incoming_missiles)) then
         {
            if (count _incoming_missiles < 3) then
            {
               _incoming_missiles = _incoming_missiles + [_misecm];
            }
            else
            {
               _incoming_missiles set [2, _incoming_missiles select 1]; 
               _incoming_missiles set [1, _incoming_missiles select 0]; 
               _incoming_missiles set [0, _misecm]; 
            };
            mando_warning = _unit;
            publicVariable "mando_warning";
         };
         _unit setVariable ["mando_missileincomming", objNull];
      }; 



      if (count _incoming_missiles > 0) then
      {
         _posu = getPosASL _unit;
         if ((_hudtype < 2) && !ctrlShown ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 112)) then
         {
            ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 112) ctrlShow true;
         };


         for [{_i = 0},{_i < 3},{_i = _i + 1}] do
         {
            if (_i < count _incoming_missiles) then
            {
               _misecm =  _incoming_missiles select _i;
            } 
            else
            {
               _misecm = objNull;
            };

// 0.2/2 = 6km


            if (!isNull _misecm) then
            {            
               _posc = [(mando_rwrpos select 0)+(mando_rwrpos select 2)/2, (mando_rwrpos select 1)+(mando_rwrpos select 3)/2,0,0];
               _posm = getPos _misecm;
               _dist = (_misecm distance _unit)*((mando_rwrpos select 2)/2)/1000;
               _dist = _dist min ((mando_rwrpos select 2)/2);

// (0.2/2 - 2Km)
               _angh = ((_posm select 0) - (_posu select 0)) atan2 ((_posm select 1) - (_posu select 1));
               _angh = _angh - getDir _unit;      
               _posc set [2, sin(_angh)*_dist];
               _posc set [3, -(cos(_angh)*_dist)*4/3];

               if (((_misecm worldToModel _posu) select 1) > 0) then
               {
                  ((uiNameSpace getVariable "mandotarget_disp") displayCtrl (9000 + _i)) ctrlSetTextColor [0.75, 1, 0.75, 1];
                  ((uiNameSpace getVariable "mandotarget_disp") displayCtrl (9000 + _i)) ctrlSetPosition _posc;
                  ((uiNameSpace getVariable "mandotarget_disp") displayCtrl (9000 + _i)) ctrlCommit 0;
               }
               else
               { 
                  ((uiNameSpace getVariable "mandotarget_disp") displayCtrl (9000 + _i)) ctrlSetTextColor [0, 0, 0, 0];
                  _incoming_missiles set [_i, objNull];
               };
            }
            else
            {
               ((uiNameSpace getVariable "mandotarget_disp") displayCtrl (9000 + _i)) ctrlSetTextColor [0, 0, 0, 0];
            };
         };
         _incoming_missiles = _incoming_missiles - [objNull];
      }
      else
      {
         if ((_hudtype < 2) && ctrlShown ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 112)) then
         {
            ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 112) ctrlShow false;
         };
      };

      Sleep(0.03);
   };
};



mando_setup_hud = 
{
   _mandotarget_disp = uiNameSpace getVariable "mandotarget_disp";

   _back   = _mandotarget_disp displayCtrl 101;
   _back2  = _mandotarget_disp displayCtrl 112;
   _mark   = _mandotarget_disp displayCtrl 102;
   _type   = _mandotarget_disp displayCtrl 103;
   _cross  = _mandotarget_disp displayCtrl 107;
   _mode   = _mandotarget_disp displayCtrl 108;
   _ranges = _mandotarget_disp displayCtrl 113;


   _rwr = _mandotarget_disp  displayCtrl 102;
   _inc_lines = [_mandotarget_disp  displayCtrl 9000,
   _mandotarget_disp  displayCtrl 9001,
   _mandotarget_disp  displayCtrl 9002];

   [101, 103, 108, 109, 111, 113] call MandoScaleControls;


   _rects = [];
   _rects = _rects + [_mandotarget_disp displayCtrl 23930];
   _rects = _rects + [_mandotarget_disp displayCtrl 23931];
   _rects = _rects + [_mandotarget_disp displayCtrl 23932];
   _rects = _rects + [_mandotarget_disp displayCtrl 23933];
   _rects = _rects + [_mandotarget_disp displayCtrl 23934];
   _rects = _rects + [_mandotarget_disp displayCtrl 23935];


   _texts = [];
   _texts = _texts + [_mandotarget_disp displayCtrl 23940];
   _texts = _texts + [_mandotarget_disp displayCtrl 23941];
   _texts = _texts + [_mandotarget_disp displayCtrl 23942];
   _texts = _texts + [_mandotarget_disp displayCtrl 23943];
   _texts = _texts + [_mandotarget_disp displayCtrl 23944];
   _texts = _texts + [_mandotarget_disp displayCtrl 23945];

   _rombe = _mandotarget_disp displayCtrl 23929;
   _aspect_line1 = _mandotarget_disp displayCtrl 110;
   _aspect_line2 = _mandotarget_disp displayCtrl 114;

   _bracket_uleft = _mandotarget_disp displayCtrl 86;
   _bracket_dleft = _mandotarget_disp displayCtrl 87;
   _bracket_uright = _mandotarget_disp displayCtrl 88;
   _bracket_dright = _mandotarget_disp displayCtrl 89;
   (_mandotarget_disp displayCtrl 86) ctrlSetText (mando_missile_path+"mandotarget_lucorner.paa");
   (_mandotarget_disp displayCtrl 87) ctrlSetText (mando_missile_path+"mandotarget_ldcorner.paa");
   (_mandotarget_disp displayCtrl 88) ctrlSetText (mando_missile_path+"mandotarget_rucorner.paa");
   (_mandotarget_disp displayCtrl 89) ctrlSetText (mando_missile_path+"mandotarget_rdcorner.paa");



//   (_mandotarget_disp displayCtrl 23929) ctrlSetText (mando_missile_path+"mandocamera_rombe.paa");

   if ("LOCATIONS" in (_unit getVariable "mando_target_types")) then
   {
      (_mandotarget_disp displayCtrl 23930) ctrlSetText (mando_missile_path+"mandotarget_location.paa");
      (_mandotarget_disp displayCtrl 23931) ctrlSetText (mando_missile_path+"mandotarget_location.paa");
      (_mandotarget_disp displayCtrl 23932) ctrlSetText (mando_missile_path+"mandotarget_location.paa");
      (_mandotarget_disp displayCtrl 23933) ctrlSetText (mando_missile_path+"mandotarget_location.paa");
      (_mandotarget_disp displayCtrl 23934) ctrlSetText (mando_missile_path+"mandotarget_location.paa");
      (_mandotarget_disp displayCtrl 23935) ctrlSetText (mando_missile_path+"mandotarget_location.paa");
   }
   else
   {
      (_mandotarget_disp displayCtrl 23930) ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
      (_mandotarget_disp displayCtrl 23931) ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
      (_mandotarget_disp displayCtrl 23932) ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
      (_mandotarget_disp displayCtrl 23933) ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
      (_mandotarget_disp displayCtrl 23934) ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
      (_mandotarget_disp displayCtrl 23935) ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
   };

   if (mando_hud_num_modes > 0) then
   {
      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 101) ctrlSetText (mando_missile_path+"mandotarget_aimcircle.paa");
   }
   else
   {
      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 101) ctrlSetText "";
   };


//   (_mandotarget_disp displayCtrl 107) ctrlSetText (mando_missile_path +"mandotarget_cross.paa");


   _rwr_image = vehicle player getVariable "mando_rwrimg";
   if (isNil "_rwr_image") then
   {
      if (side _unit == west) then
      {
         _rwr_image = mando_rwrimg_west;
      }
      else
      {
         _rwr_image = mando_rwrimg_east;
      };
   };

   (_mandotarget_disp displayCtrl 112) ctrlSetText _rwr_image;
   _pos_rwr = vehicle player getVariable "mando_rwrpos_full";
   if (isNil "_pos_rwr") then
   {
      _pos_rwr = mando_rwrpos_full;
   };
   (_mandotarget_disp displayCtrl 112) ctrlSetPosition _pos_rwr;
   (_mandotarget_disp displayCtrl 112) ctrlCommit 0;
   _pos_rwr = vehicle player getVariable "mando_rwrpos";
   if (isNil "_pos_rwr") then
   {
      _pos_rwr = mando_rwrpos;
   };

   for [{_i=0},{_i<6},{_i=_i+1}] do
   { 
      (_rects select _i) ctrlSetTextColor [0,0,0,0];
      (_texts select _i) ctrlSetTextColor [0,0,0,0];
      (_texts select _i) ctrlSetText "";
   };
   _rombe ctrlSetTextColor [0,0,0,0];
   _aspect_line1 ctrlSetTextColor [0,0,0,0];
   _aspect_line2 ctrlSetTextColor [0,0,0,0];

   if (_hudtype == 0) then
   {
      _back2 ctrlShow false; // Visible only if warning
   };

   if (_hudtype == 1) then
   {
      _back ctrlShow false;
      _back2 ctrlShow false;  // Visible only if warning
      _mark ctrlShow false;
      _ranges ctrlShow false;
      _cross ctrlShow false;
      _type ctrlShow false;
      _mode ctrlShow false;
   };

   if (_hudtype == 2) then
   {
      _back2 ctrlShow false;
   };

   if (_hudtype == 3) then
   {
      _mark ctrlShow false;
      _ranges ctrlShow false;
      _cross ctrlShow false;
      _type ctrlShow false;
      _mode ctrlShow false;
      _back ctrlShow false;
      _back2 ctrlShow false;
   };

   // HUD Mode update
   if (mando_hud_num_modes > 0) then
   {
      [-1111, mando_keymode] spawn mando_hud_key_handler;
   };
     
   if (mando_ihavemissiles) then
   {
      call mando_update_ammo;
   }
   else
   {
      (_mandotarget_disp displayCtrl 109) ctrlSetText "";
   };
   (_mandotarget_disp displayCtrl 109) ctrlSetTextColor [0,0,0,0];

   if ((_unit getVariable "mando_maxflares") > 0) then
   {
      call mando_update_flares;
   }
   else
   {
      (_mandotarget_disp displayCtrl 111) ctrlSetText "";
   };
   (_mandotarget_disp displayCtrl 111) ctrlSetTextColor [0,0,0,0];
};




MandoScaleControls =
{
   disableSerialization;

   private["_controls", "_pos", "_disp"];
   _disp = uiNameSpace getVariable "mandotarget_disp";
   _controls = _this;

   mando_hud_coords = [];

   {
      _pos = ctrlPosition (_disp displayCtrl _x);
      
      if ((_pos select 0) < 0.5) then
      {
         _pos set [0, 0.5 - (0.5-(_pos select 0))*safeZoneW];
      }
      else
      {
         _pos set [0, 0.5 + (((_pos select 0)+(_pos select 2)/2) - 0.5)*safeZoneW - (_pos select 2)*safeZoneW/2];
      };

      if ((_pos select 1) < 0.5) then
      {
         _pos set [1, 0.5 - (0.5-(_pos select 1))*safeZoneH];
      }
      else
      {
         _pos set [1, 0.5 + ((_pos select 1) - 0.5)*safeZoneH];
      };
      _pos set [2,(_pos select 2)*safeZoneW];
      _pos set [3,(_pos select 3)*safeZoneH];

      (_disp displayCtrl _x) ctrlSetPosition _pos;
      (_disp displayCtrl _x) ctrlCommit 0;

       mando_hud_coords = mando_hud_coords + [[_pos select 0, _pos select 1]];

   } forEach _controls;

};


MandoWorldToScreen = 
{
   private["_target", "_weapon", "_pos", "_posu", "_pos2", "_disth", "_distv", "_hscreen", "_vscreen", "_sinhscreen", "_sinvscreen", "_angh", "_angv", "_vdir"];
   _target = _this select 0;
   _weapon = _this select 1;


   if (_weapon == "") then 
   {
      _pos = (vehicle player) worldToModel (getPos _target);
      _disth = sqrt((_pos select 0)^2+(_pos select 1)^2);
      _distv = sqrt(((getPosASL _target select 2) - (getPosASL (vehicle player) select 2))^2+_disth^2);

      if (_disth < 0.1) then
      {
         _disth = 0.1;
      };
      if (_distv < 0.1) then
      {
         _distv = 0.1;
      };
      _sinvscreen = (_pos select 2)/_distv;
      _angh = (_pos select 0) atan2 (_pos select 1);
      _angv  = asin(_sinvscreen);

   }
   else
   {
      _posu = getPosASL vehicle player;
      if (_weapon == "sight") then
      {
         _pos = positionCameraToWorld [0,0,100];
         _pos2 = positionCameraToWorld [0,0,0];
         _vdir = [((_pos select 0) - (_pos2 select 0))/100, ((_pos select 1) - (_pos2 select 1))/100,((_pos select 2) - (_pos2 select 2))/100];
      }
      else
      {
         _vdir = vehicle player weaponDirection _weapon;
      };
      _pos = getPosASL _target;


      _angh = (((_pos select 0)-(_posu select 0)) atan2 ((_pos select 1)-(_posu select 1))) - ((_vdir select 0) atan2 (_vdir select 1));
      _angv = asin(((_pos select 2)-(_posu select 2))/(_target distance (vehicle player))) - (asin(_vdir select 2));

   };

   _hscreen = _angh*0.5/45;
   _vscreen = _angv*0.5/35;


   [_hscreen, _vscreen, _angh, _angv]
};


disableSerialization;

private["_back", "_back2", "_mark", "_type", "_cross", "_mode", "_target", "_i_target", "_target_old","_screen", "_hscreen", "_vscreen", "_posu", "_post", "_color", "_vdir", "_hudtype", "_dif", "_posm", "_ranges", "_sensor_x", "_sensor_y", "_elapsed", "_color_l", "_color_h", "_list", "_min_targets_alt", "_max_targets_alt", "_rombe", "_rects", "_texts", "_mindifang", "_difang", "_mandotarget_disp", "_inc_lines", "_rwr", "_posc", "_dir", "_time_lock", "_blink", "_sccenter","_sccenter_diff", "_aspect_line1","_aspect_line2","_sccender_diff", "_ecm", "_tti", "_hudopenh", "_hudopenv", "_delta", "_fail_lock", "_fail_lock_timed", "_dist", "_angh","_angv", "_dist_id", "_var", "_ttypes", "_ttype", "_ttype_old", "_optics", "_bracket_uleft", "_bracket_dleft", "_bracket_uright", "_bracket_dright","_bracket_pos_ini", "_bracket_pos","_to_freeze", "_frozen", "_temp"];

_unit        = _this select 0;
_ttypes      = _this select 1;
_weaponname  = _this select 2;
_firingpos   = _this select 3;
_keyscript   = _this select 4;
_playerpos   = _this select 5;
_hudopenh    = _this select 6;  // Offset HUD x
_hudopenv    = _this select 7;  // Offset HUD y
_hudtype     = _this select 8;



_fail_lock = 0;
_fail_lock_timed = 0;
_posu = [0,0,0];
_vdir = [0,0,0];
_post = [0,0,0];
_color = [[0,1,0,1]];
_dist_id = mando_max_dist_id;

mando_hud_in_angle = true;
mando_dec_acc_factor = 0;
mando_hud_num_modes = 0;
mando_circle_h = 0.05;
mando_circle_h_max = 0.05;
mando_exit_hud = false;
mando_hud_aperture = 0.03;
mando_hud_max_alpha = 1;
mando_hud_max_alpha = -0.01;
mando_hud_do_warning = true;

mando_firing = false;

mando_ground_hud_target = "Logic" createVehicleLocal [0,0,0];

if (isNil "mandotarget_disp_on") then
{
   mandotarget_disp_on = true;
};
_mandotarget_disp = displayNull;



3 cutRsc["mando_target", "PLAIN"];
waitUntil {!isNull (uiNameSpace getVariable "mandotarget_disp")};
((uiNameSpace getVariable "mandotarget_disp") displayCtrl 109) ctrlSetTextColor [0,0,0,0];
((uiNameSpace getVariable "mandotarget_disp") displayCtrl 111) ctrlSetTextColor [0,0,0,0];

//call mando_setup_hud;


_unit setVariable ["mando_target_types",_ttypes];
_unit setVariable ["mando_weapon_name",_weaponname];
_unit setVariable ["mando_ecm_sts", 0];

//_unit setVariable ["mando_ecm_max_time", 20];

_unit setVariable ["mando_ecm_time", _unit getVariable "mando_ecm_max_time"];


mando_logdiraspec = "Logic" createVehicleLocal [0,0,0];



_unit setVariable ["mando_current_target", objNull];
_unit setVariable ["current_targetmcc", objNull];

mando_planefiretime   = 0;
mando_planechafftime  = 0;
mando_planelocktime   = 0;
mando_planemodetime   = 0;
mando_planetakeoff    = false;
mando_pilon           = 1;
mando_firingpos       = _firingpos;
mando_remote_selected = -1;
mando_radar_selected  = -1;
mando_maxthrustedrange = mando_loscheck_range;
mando_ccip_time       = 0;
mando_ccip_dist       = 0;
mando_lockingon       = objNull;
mando_key_pressed     = -1;
mando_hud_fired       = false;
mando_time_to_lock = 3;

if (vehicle player == _unit) then
{

// HUD Mode initialization
   mando_hud_mode = -1;
   if (_keyscript != "") then
   {
      call compile (preprocessFileLineNumbers _keyscript);
   };

   if (mando_hud_num_modes > 0) then
   {
   // HUD key missiles params setup      
      [displayNull, mando_keymode] spawn mando_hud_key_handler;
   };

   Sleep 0.1;
   call mando_setup_hud;
   []spawn
   {
      Sleep 1;
      if (mando_hud_max_alpha < 0) then
      {
         mando_hud_max_alpha = 1;
      };

      if ( ctrlText ((uiNameSpace getVariable "mandotarget_disp")displayCtrl 107) == "") then
      {
         ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 107) ctrlSetText (mando_missile_path +"mandotarget_cross.paa");
      };

   };

   if (!isNil "mando_main_display_keyeh") then
   {
      (findDisplay mando_main_display) displayRemoveEventHandler ["KeyDown", mando_main_display_keyeh];
   }; 
   mando_main_display_keyeh = (findDisplay mando_main_display) displayAddEventHandler ["KeyDown", "[_this] call mando_keyhandler"];
};

_msg = "";
if (mando_fire_exclusive) then
{
   _unit removeAllEventHandlers "Fired";
};

if (!isNil "mando_portable_fired_eh") then
{
   _unit removeEventHandler ["Fired", mando_portable_fired_eh];
};

mando_portable_fired_eh = _unit AddEventHandler ["Fired", {_this spawn mando_portable_fired}];


if (mando_ihavemissiles) then
{
   _msg = _msg + format["%1 -> Lock on target\n%2 -> Fire missile\n%3 -> Change modes\n", mando_keylockname, mando_keyfirename,mando_keymodename];
};
if (mando_ihaveflares) then
{
   _msg = _msg + format["%1 -> Flares\n", mando_keyflarename];
};

if ((_unit getVariable "mando_ecm_time") > 0) then
{
   _msg = _msg + format["%1 -> ECM\n", mando_keyecmname];
};

if (mando_ihavemissiles) then
{
   _msg = _msg + "\nMenu actions to toggle hud and remap keys.";
};

hintSilent format["%1", _msg];
_continue = true;


_target = objNull;
_target_old = objNull;
_target_destroyed = objNull;



_incoming_missiles = [];


if (!mandotarget_disp_on) then
{
   3 cutText["", "PLAIN"];
};


_sensor_x = 1000;
_sensor_y = 5000; // Range / 2
_elapsed = (dayTime * 3600);
_loglos = "logic" createVehicleLocal [0,0,0];


mando_get_vis_target = false;
mando_get_vis_timed_target = false;
mando_irtone_on = false;

mando_hud_targets = [];
[_unit, _playerpos, _weaponname] spawn mando_get_targets;
[_unit, _playerpos, _hudtype] spawn mando_rwr;

mando_hud_colors_toggled = false;
mando_hud_colors_idx = 0;
mando_hud_colors = +(mando_hud_colors_sets select mando_hud_colors_idx);

// mando_hud_colors = [[0.5,1,0.5],[0.5,1,0.5],[0.5,1,0.5],[0.5,1,0.5],[0.5,1,0.5],[0.5,1,0.5]];


[] spawn
{
   private["_map", "_hud_state"];
   _map = visibleMap;
   _hud_state = mandotarget_disp_on;
   while {!mando_exit_hud} do
   {
      if ((visibleMap || _map) && !(visibleMap && _map)) then
      {
         _map = visibleMap;
         if (_map) then
         {
            _hud_state = mandotarget_disp_on;
            mandotarget_disp_on = false;
            3 cutText["", "PLAIN"];
         }
         else
         {
            mandotarget_disp_on = _hud_state;
         };
      };
      Sleep 0.5;
      mando_hud_heartbeat = mando_hud_heartbeat + 1;
   };
};


[_unit]spawn
{
   private["_unit"];
   _unit = _this select 0;

   Sleep 2;
   while {!mando_exit_hud} do
   {
      Sleep 1;
      call mando_update_flares;
      call mando_update_ammo;
   };
};

_ttype_old = "?";


if (!isNil "mando_hud_init_code") then
{
   []spawn mando_hud_init_code;
};


while {!mando_exit_hud} do
{
   if ((isNull _mandotarget_disp) && mandotarget_disp_on) then
   {
      3 cutRsc["mando_target", "PLAIN"];
      waitUntil {!isNull (uiNameSpace getVariable "mandotarget_disp")};
      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 109) ctrlSetTextColor [0,0,0,0];
      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 111) ctrlSetTextColor [0,0,0,0];

      call mando_setup_hud;
      []spawn
      {
         Sleep 1;

         if ( ctrlText ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 107) == "") then
         {
            ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 107) ctrlSetText (mando_missile_path +"mandotarget_cross.paa");
         };

      };
   };



   if (mandotarget_disp_on) then
   {
      _ttypes =  _unit getVariable "mando_target_types";
      _ttype = _ttypes select 0;
      if (_ttype != _ttype_old) then
      {
         if (_ttype == "LOCATIONS") then
         {
            {
               _x ctrlSetText (mando_missile_path+"mandotarget_location.paa");             
            } forEach _rects;
         }
         else
         {
            if (_ttype_old == "LOCATIONS") then
            {
               {
                  _x ctrlSetText (mando_missile_path+"mandocamera_rect.paa");
               } forEach _rects;
            };
         };
         _ttype_old = _ttype;
      };

/*
      // Aiming center in screen
      if (cameraView != "GUNNER") then
      {
*/
         if (_weaponname == "") then
         {
            _sccenter = worldToScreen (_unit modelToWorld [0,20000,0]);
         }
         else
         {
            if (_weaponname == "sight") then
            {
               _sccenter = [0.5, 0.5];
            }
            else
            {
               _dir = (_unit weaponDirection _weaponname);
               _pos = getPos _unit;
               _pos = [(_pos select 0)+(_dir select 0)*250000,(_pos select 1)+(_dir select 1)*250000,(_pos select 2)+(_dir select 2)*250000];
               _sccenter = worldToScreen _pos;
            };
         }; 
         _optics = false;
/*
      }
      else
      {
         _sccenter = [0.5, 0.5];
         _optics = true;
      };
*/

      if (count _sccenter != 2) then
      {
         _sccenter = [-2,-2];
      };

      _sccenter = [(_sccenter select 0)+_hudopenh, (_sccenter select 1)+_hudopenv];
      _sccenter = [(_sccenter select 0)-0.5, (_sccenter select 1)-0.5];

      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 101) ctrlSetPosition [0.5 + (_sccenter select 0) - (mando_circle_h*3/4)/2, 0.5+(_sccenter select 1) - (mando_circle_h/2), mando_circle_h*3/4,mando_circle_h];
      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 101) ctrlCommit 0;
      ((uiNameSpace getVariable "mandotarget_disp") displayCtrl 101) ctrlSetTextColor ((mando_hud_colors select 0) + [mando_hud_max_alpha/2]);

      _sccenter_diff = sqrt(abs((_sccenter select 0)-_hudopenh)^2 + abs((_sccenter select 1)-_hudopenv)^2);
      if (_sccenter_diff < 0.16) then
      {
         _i = 1;
         {
            ((uiNameSpace getVariable "mandotarget_disp") displayCtrl _x) ctrlSetPosition [((mando_hud_coords select _i) select 0) + (_sccenter select 0), ((mando_hud_coords select _i) select 1)  + (_sccenter select 1)];
            ((uiNameSpace getVariable "mandotarget_disp") displayCtrl _x) ctrlCommit 0;

            if (_sccenter_diff > 0.1) then
            {
               ((uiNameSpace getVariable "mandotarget_disp") displayCtrl _x) ctrlSetTextColor ((mando_hud_colors select _i) + [mando_hud_max_alpha-(_sccenter_diff-0.1)*16]);
            }
            else
            {
               ((uiNameSpace getVariable "mandotarget_disp") displayCtrl _x) ctrlSetTextColor ((mando_hud_colors select _i) + [mando_hud_max_alpha]);
            };

            _i = _i + 1;
         } forEach [103, 108, 109, 111, 113];
         mando_hud_in_angle = true;
      }
      else
      {
         if (mando_hud_in_angle) then
         {
            {
               ((uiNameSpace getVariable "mandotarget_disp") displayCtrl _x) ctrlSetTextColor [0.5,1,0.5,0];
            } forEach [103, 108, 109, 111, 113];
            mando_hud_in_angle = false;
         };
      };


      if ((_ttypes select 0) != "REMOTE") then
      {
         if ((_ttypes select 0) != "RADAR") then
         {
           _color_h = (mando_hud_colors select 0) + [mando_hud_max_alpha/2];
           _color_l = [((mando_hud_colors select 0) select 0)/2,((mando_hud_colors select 0) select 1)/2,((mando_hud_colors select 0) select 2)/2] + [mando_hud_max_alpha/2];


            if ((_ttypes select 0) != "LOCATIONS") then 
            {
               _dist_id = mando_max_dist_id;
            }
            else
            {
               _dist_id = 12000;
            };
         }
         else
         {
         // RADAR targets
            _color_l = [0.7, 0.7, 0.4, mando_hud_max_alpha];
            _color_h = [1, 1, 0.8, mando_hud_max_alpha];
            _dist_id = 10000;
         };
      }
      else
      {
      // Remote targets
         _color_l = [0.75, 0.75, 0.75, mando_hud_max_alpha];
         _color_h = [1, 1, 1, mando_hud_max_alpha];
         _dist_id = 10000;
      };

      _list = +mando_hud_targets;
      _target = objNull;
      _i_target = -1;
      _mindifang = 9999;                           
      if ((count _list > 1) && ("A" in _list)) then
      {
         for [{_i=0},{_i<6},{_i=_i+1}] do
         { 
            if (_i < ((count _list)-1)) then
            {
               _temp = (_list select _i);
               if (!isNull _temp) then
               {
                  if (typeName _temp != "LOCATION") then
                  {
                     _screen = [_temp, _weaponname] call MandoWorldToScreen;
                     _angh = _screen select 2;
                     _angv = _screen select 3;

//                     _screen = worldToScreen getPos (_list select _i);
                     _posm = getPos _temp;
                     _posm set [2, (_posm select 2) + (((_temp modelToWorld [0,0,0]) select 2)-(_posm select 2))/2];
                     
                     _screen = worldToScreen _posm; 
                     _dist = _temp distance _unit;
                  }
                  else
                  {
                     _angh = 0;
                     _angv = 0;
                     _screen = worldToScreen locationPosition _temp; 
                     _dist = locationPosition _temp distance _unit;
                  };

                  if (count _screen != 2) then
                  {                              
                     _screen = [-2,-2];
                  };

                  if (!_optics) then
                  {
                     _hscreen = ((_screen select 0) - 0.04/2) min (0.6-0.04+(_sccenter select 0));
                     _hscreen = _hscreen max (0.4 + (_sccenter select 0));
   
                     _vscreen = ((_screen select 1)- 0.05/2) min (0.65-0.05+(_sccenter select 1));
                     _vscreen = _vscreen max (0.4 + (_sccenter select 1));
                  }
                  else
                  {
                     _hscreen = ((_screen select 0) - 0.04/2) min (0.9-0.04+(_sccenter select 0));
                     _hscreen = _hscreen max (0.1 + (_sccenter select 0));
   
                     _vscreen = ((_screen select 1)- 0.05/2) min (0.9-0.05+(_sccenter select 1));
                     _vscreen = _vscreen max (0.1 + (_sccenter select 1));
                  };

                  _dist = _dist - _dist % 1;



                  if ((abs(_angh) < 65) && (abs(_angv) < 65)) then
                  {
                     if (typeName _temp != "LOCATION") then
                     {
                        if (_temp == _target_old) then
                        {
                           _i_target = _i;
                        };
                     };

                     _difang = sqrt((0.5 + (_sccenter select 0) - ((_screen select 0) + 0.02))^2+(0.5 +(_sccenter select 1)- ((_screen select 1) + 0.025))^2);


///                     if ((abs(_angh) < 10) && (abs(_angv) < 10)) then
                     if (_difang < 0.1) then
                     {
                        if (_dist < _dist_id) then
                        {
                           if (typeName _temp == "LOCATION") then
                           {                       
                              _var = _temp getVariable "mando_nav_info";
                              if (isNil "_var") then
                              {
                                 (_texts select _i) ctrlSetText text (_list select _i);
                                 (_texts select _i) ctrlSetTextColor _color_h;
                                 (_rects select _i) ctrlSetTextColor _color_h;
                              }
                              else
                              {
                                 (_texts select _i) ctrlSetTextColor [0.7,0,0,mando_hud_max_alpha/2];
                                 (_texts select _i) ctrlSetText format["%1 (%2)", text _temp, _var];
                                 (_rects select _i) ctrlSetTextColor [0.7,0,0,mando_hud_max_alpha/2];
                              };
                           }
                           else
                           {
                              (_texts select _i) ctrlSetTextColor _color_h;
                              (_texts select _i) ctrlSetText typeOf _temp;
                              (_rects select _i) ctrlSetTextColor _color_h;
                           };
                           (_texts select _i) ctrlSetPosition [_hscreen- 0.01, _vscreen-0.02];
                           (_texts select _i) ctrlCommit 0;
                        }
                        else
                        {
                           (_rects select _i) ctrlSetTextColor _color_h;
                           (_texts select _i) ctrlSetTextColor [0, 0, 0, 0];
                        };


                        if (_difang < (mando_circle_h/2)) then
                        {
//                           _difang = sqrt(_angh^2 + _angv^2);
                           if (_difang < _mindifang) then
                           {
                              _mindifang = _difang;
                              _target = _temp;
                              if (isNull _target_old) then
                              {
                                 _i_target = _i;
                              };
                           };
                        };
                     }
                     else
                     {
                        (_rects select _i) ctrlSetTextColor _color_l;
                        (_texts select _i) ctrlSetTextColor [0, 0, 0, 0];
                     };

                     (_rects select _i) ctrlSetPosition [_hscreen, _vscreen];
                     (_rects select _i) ctrlCommit 0;
                  }
                  else
                  {
                     (_rects select _i) ctrlSetTextColor [0, 0, 0, 0];
                     (_texts select _i) ctrlSetTextColor [0, 0, 0, 0];
                  };
               }   
               else
               {
                  (_rects select _i) ctrlSetTextColor [0, 0, 0, 0];
                  (_texts select _i) ctrlSetTextColor [0, 0, 0, 0];
               };
            } 
            else
            {
               (_rects select _i) ctrlSetTextColor [0, 0, 0, 0];
               (_texts select _i) ctrlSetTextColor [0, 0, 0, 0];
            };
         };
      }
      else
      { 
         {
            _x ctrlSetTextColor [0, 0, 0, 0];
         } forEach _rects;

         {
            _x ctrlSetTextColor [0, 0, 0, 0];
         } forEach _texts;
      };


/****************** AQUI ******************** LOCK TIMED */                                      

      if (mando_get_vis_timed_target) then
      {
         mando_get_vis_timed_target = false;

         if (!isNull _target) then
         {
            _fail_lock_timed = 0;
            _target_old = _target;
            _time_lock = (dayTime * 3600);
            _blink = 0;
            _ecm = _target getVariable "mando_ecm_on";
            if (isNil "_ecm") then
            {
               _target setVariable ["mando_ecm_on", false];
               _ecm = false;
            };
            playSound "mando_target1";

            if (((_ttypes select 0) == "Air") && mando_hud_do_warning) then
            { 
               mando_lockedon=_target;
               publicVariable "mando_lockedon";
            };
            _frozen = false;
            mando_lockingon=_target;
         };
      };

      if (!isNull _target_old) then
      {
         if (_target_old in _list) then
         {
            _fail_lock_timed = 0;
            // Mismo target que ciclo anterior
            if (((dayTime * 3600) - _time_lock) > mando_time_to_lock) then
            {
               // Se confirma el lock 
               _unit setVariable ["mando_current_target", _target_old];
               _target_old = objNull;
               mando_lockingon=objNull;
               _bracket_uleft ctrlSetTextColor [0,0,0,0];
               _bracket_uright ctrlSetTextColor [0,0,0,0];
               _bracket_dleft ctrlSetTextColor [0,0,0,0];
               _bracket_dright ctrlSetTextColor [0,0,0,0];     
            }
            else
            { 
               // Blink
               if (_i_target >= 0) then
               {
                  _bracket_pos_ini = ctrlPosition (_rects select _i_target);
                  (_rects select _i_target) ctrlSetTextColor [0,0,0,0];

 
                  if ((abs(0.5+(_sccenter select 0)-((_bracket_pos_ini select 0)+(_bracket_pos_ini select 2)/2)) > mando_hud_aperture) || (abs(0.5+(_sccenter select 1)-((_bracket_pos_ini select 1)+(_bracket_pos_ini select 3)/2)) > mando_hud_aperture)) then
                  {
                     if (!_frozen) then
                     {
                        _to_freeze = (mando_time_to_lock - (mando_time_to_lock - ((dayTime * 3600) - _time_lock)));
                        _frozen = true;
                     };
                     _time_lock = (dayTime * 3600) - _to_freeze;
                  }
                  else
                  {
                     _frozen = false;
                  };


                  _bracket_pos = [(_bracket_pos_ini select 0) -
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6,
                                  (_bracket_pos_ini select 1) - 
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6];

                  _bracket_uleft ctrlSetPosition _bracket_pos;
                  _bracket_uleft ctrlCommit 0;
                  _bracket_uleft ctrlSetTextColor _color_h;

                  _bracket_pos = [(_bracket_pos_ini select 0) -
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6,
                                  (_bracket_pos_ini select 1) + 
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6];

                  _bracket_dleft ctrlSetPosition _bracket_pos;
                  _bracket_dleft ctrlCommit 0;
                  _bracket_dleft ctrlSetTextColor _color_h;

                  _bracket_pos = [(_bracket_pos_ini select 0) +
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6,
                                  (_bracket_pos_ini select 1) - 
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6];

                  _bracket_uright ctrlSetPosition _bracket_pos;
                  _bracket_uright ctrlCommit 0;
                  _bracket_uright ctrlSetTextColor _color_h;

                  _bracket_pos = [(_bracket_pos_ini select 0) +
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6,
                                  (_bracket_pos_ini select 1) + 
                                  (mando_time_to_lock - ((dayTime * 3600) - _time_lock))*0.2/6];

                  _bracket_dright ctrlSetPosition _bracket_pos;
                  _bracket_dright ctrlCommit 0;
                  _bracket_dright ctrlSetTextColor _color_h;

               };
               _blink = _blink + 1;
            };
         }
         else
         {
            _fail_lock_timed = _fail_lock_timed + 1;
            if (_fail_lock_timed == 5) then
            {
               _target_old = objNull;
               mando_lockingon=objNull;
               _fail_lock_timed = 0;
               _bracket_uleft ctrlSetTextColor [0,0,0,0];
               _bracket_uright ctrlSetTextColor [0,0,0,0];
               _bracket_dleft ctrlSetTextColor [0,0,0,0];
               _bracket_dright ctrlSetTextColor [0,0,0,0];

            };
         };
      };


      if (mando_get_vis_target) then
      {
         mando_get_vis_target = false;
         if (!isNull _target) then
         {
            _unit setVariable ["mando_current_target", _target];
            playSound "mando_target1";
            if ((_ttypes select 0) == "Air") then
            { 
               mando_lockedon=_target;
               publicVariable "mando_lockedon";
            };
         };
      };


      _posu = getPos _unit;

      _target = _unit getVariable "mando_current_target";

/*
      if (isNull _target) then
      {
         _target = _unit getVariable "current_targetmcc";
      };
*/

      if ((!isNull _target) && (!isNull _mandotarget_disp)) then
      {      
         _screen = [_target, _weaponname] call MandoWorldToScreen;

         _angh = _screen select 2;
         _angv = _screen select 3;

         _posm = getPos _target;
         _posm set [2, (_posm select 2) + (((_target modelToWorld [0,0,0]) select 2)-(_posm select 2))/2];

         _screen = worldToScreen _posm; 
         if (count _screen != 2) then
         {                              
            _screen = [-2,-2];
         };

         _hscreen = ((_screen select 0) - 0.04/2) min (0.6-0.04+(_sccenter select 0));
         _hscreen = _hscreen max (0.4 + (_sccenter select 0));

         _vscreen = ((_screen select 1)- 0.05/2) min (0.7-0.05+(_sccenter select 1));
         _vscreen = _vscreen max (0.4 + (_sccenter select 1));


         _dist = (_target distance _unit);
         _dist = _dist - _dist % 1;

         if (mando_hud_guidance != 4) then
         {
            _rombe ctrlSetPosition [_hscreen+random(0.005)-0.00025, _vscreen+random(0.005)-0.00025];
         }
         else
         {
            _rombe ctrlSetPosition [_hscreen, _vscreen];
         };
         _rombe ctrlCommit 0;


         _ecm = _target getVariable "mando_ecm_on";
         if (isNil "_ecm") then
         {
            _target setVariable ["mando_ecm_on", false];
            _ecm = false;
         };


         if (((abs(_angh) < 10) && (abs(_angv) < 10) && (_dist < mando_maxthrustedrange) && (_dist > mando_minimumrange)) || (mando_hud_guidance == 4)) then
         {
            if (_ecm) then
            {
               _rombe ctrlSetTextColor [0,0.75,1,mando_hud_max_alpha];
            }
            else
            {
               if (mando_hud_guidance == 4) then
               {
                  if ((_screen select 1) < (0.7 + (_sccenter select 1))) then
                  {
                     _rombe ctrlSetTextColor _color_h;
                  }
                  else
                  {
                     _rombe ctrlSetTextColor [0,0,0,0];
                  };
               }
               else
               {
                  _rombe ctrlSetTextColor _color_h;
               };
            };

            if (!mando_irtone_on && (mando_hud_guidance != 4)) then
            {
                mando_irtone_on = true;
               [_target] spawn
               {
                  if ((getPos (_this select 0) select 2) < 10) then
                  {
                     playSound "mando_irtone";
                     Sleep 1.3;
                  }
                  else
                  {
                     playSound "mando_irgrowl";
                     Sleep 0.5;
                  };
                 
                  mando_irtone_on = false;
               };
            };
         }
         else
         {
            if (_ecm) then
            {
               _rombe ctrlSetTextColor [0,0.25,1,mando_hud_max_alpha/2];
            }
            else
            {
               _rombe ctrlSetTextColor _color_l;
            };
         };


         // Target aspect
         _post = _target worldToModel _posu;
         _aspect_ang = ((_post select 0) atan2 (_post select 1));

         if ((_weaponname == "") || (_weaponname == "sight")) then
         {
            _aspect_ang = (getDir _unit) - (getDir _target);
         }
         else
         {
            _aspect_ang = (((_unit weaponDirection _weaponname) select 0) atan2 ((_unit weaponDirection _weaponname) select 1)) - (getDir _target);
         };
         mando_logdiraspec setDir _aspect_ang;


         if (_target isKindOf "Air") then
         {
            _delta = mando_circle_h_max - 0.1;
            if ((mando_hud_guidance == 0) || (mando_hud_guidance == 2)) then
            {
               if (_ecm) then
               {
                  mando_dec_acc_factor = (_dist min 1000)/1000;
                  mando_circle_h = mando_circle_h_max - _delta*mando_dec_acc_factor;
               }
               else
               {
                  mando_dec_acc_factor = 0;
                  mando_circle_h = mando_circle_h_max;
               };
            }
            else
            {
               if (mando_hud_guidance == 1) then
               {
                  mando_dec_acc_factor = abs(((vectorDir mando_logdiraspec) select 0) atan2 ((vectorDir mando_logdiraspec) select 1))/180;
                  mando_circle_h = mando_circle_h_max - _delta*mando_dec_acc_factor;
               }
               else
               {
                  mando_dec_acc_factor = 0;
                  mando_circle_h = mando_circle_h_max;
               };
            };  
         }
         else
         {
            mando_circle_h = mando_circle_h_max;
            mando_dec_acc_factor = 0;
         };


         if (mando_hud_guidance != 4) then
         {
            _post = [0.5 + (_sccenter select 0) + sin(_aspect_ang)*(mando_circle_h*3/4)/2, 0.5 + (_sccenter select 1) + cos(_aspect_ang)*mando_circle_h/2];

            _aspect_line1 ctrlSetPosition [_post select 0, _post select 1, sin(_aspect_ang-15)*0.02*3/4, cos(_aspect_ang -15)*0.02];
            _aspect_line1 ctrlCommit 0;
            _aspect_line1 ctrlSetTextColor _color_h;

            _aspect_line2 ctrlSetPosition [_post select 0, _post select 1, sin(_aspect_ang+15)*0.02*3/4, cos(_aspect_ang+15)*0.02];
            _aspect_line2 ctrlCommit 0;
            _aspect_line2 ctrlSetTextColor _color_h;
         }
         else
         {
            _post = [0.5 + (_sccenter select 0), 0.5 + (_sccenter select 1), (_hscreen + 0.02) - (0.5 + (_sccenter select 0)), (_vscreen + 0.025) - (0.5 + (_sccenter select 1))];

            _aspect_line1 ctrlSetPosition _post;
            _aspect_line1 ctrlCommit 0;
            _aspect_line1 ctrlSetTextColor _color_h;
            _aspect_line2 ctrlSetTextColor [0,0,0,0];
         };

         if (((_dist > _sensor_y*2) || (abs(_angh) > 45) || (abs(_angv) > 45)) && (((_ttypes select 0) == "Air") || ((_ttypes select 0) == "LandVehicle"))) then
         {
            _unit setVariable ["mando_current_target", objNull];
         };


         if (((_ttypes select 0) == "Air") || ((_ttypes select 0) == "LandVehicle")) then
         {
            if (!(_target in _list) && ("A" in _list)) then
            {
               _fail_lock = _fail_lock + 1;
               if (_fail_lock == 5) then
               {
                  _unit setVariable ["mando_current_target", objNull];
                  _fail_lock = 0;
               };
            }
            else
            {  
               _fail_lock = 0;
            };
         };

         _alt  = getPos _target select 2;
         _alt = _alt - _alt % 1;

         if (mando_hud_missile >= 0) then
         {
            if (mando_hud_guidance == 4) then
            {
               _tti = mando_ccip_time;
               _dist = mando_ccip_dist;
            }
            else
            {
               _tti = 2 + floor (_dist / ((mando_hud_misp select mando_hud_missile) select 6));
            };
         }
         else
         {
            _tti = 2 + floor (_dist / (speed _unit)/3.6);
         };

         if ((_dist < 2000) || (mando_hud_guidance == 4)) then
         {
            if (mando_hud_guidance == 4) then
            {
               _msg = format["CCIP <br />Range: %1 m <br />Altitude: %2 m <br />TTI: %3 s", _dist, _alt, _tti];
            }
            else
            {
               _msg = format["Target: %1 <br />Range: %2 m <br />Altitude: %3 m <br />TTI: %4 s", typeof _target, _dist, _alt, _tti];
            };
         }
         else
         {
            _msg = format["Target: unknown <br />Range: %1 m <br />Altitude: %2 m <br />TTI: %3 s", _dist, _alt, _tti];
         };

         _type ctrlSetStructuredText parseText _msg;



         // A�adir en RWR indicacion de blanco
         if ((damage _target > 0.9) && (_target != _target_destroyed)) then 
         {
            _target_destroyed = _target;
            _unit setVariable ["mando_current_target", objNull];
         };


         if ((_ttypes select 0) == "RADAR") then
         {
            if (!(_target in mando_radars)) then
            {
               _unit setVariable ["mando_current_target", objNull];
            };
         };

         if (_ecm) then
         {
            if ((random 1000) > 995) then
            {
               _unit setVariable ["mando_current_target", objNull];
            };
         };

      }
      else
      {
         mando_circle_h = mando_circle_h_max;
         if (!isNull _mandotarget_disp) then
         {
            _rombe ctrlSetTextColor [0, 0, 0, 0];
            _mark ctrlSetTextColor [0, 0, 0, 0];
            _type ctrlSetText "";
//            _type ctrlSetStructuredText parseText "Target: --- <br />Range: --- m <br />Altitude: --- m <br />TTI: --- s";
            _aspect_line1 ctrlSetTextColor [0,0,0,0];
            _aspect_line2 ctrlSetTextColor [0,0,0,0];
         };
      };
   };

/*
   if (!(alive _unit) || (isNull _unit) || ((_playerpos == 0) && (driver _unit != player)) || ((_playerpos == 1) && (gunner _unit != player))) then
   {
      _continue = false;
      mando_exit_hud = true;
   };
*/
   if (((currentWeapon vehicle player) != _weaponname) || (!alive player)) then
   {
      _continue = false;
      mando_exit_hud = true;
   };


   Sleep(0.03);
};

//(findDisplay mando_main_display) displaySetEventHandler ["KeyDown", ""];

(findDisplay mando_main_display) displayRemoveEventHandler ["KeyDown", mando_main_display_keyeh];
mando_main_display_keyeh = nil;
_unit removeEventHandler ["Fired", mando_portable_fired_eh];
mando_portable_fired_eh = nil;
3 cutText["", "PLAIN"];
hintSilent "";
deleteVehicle mando_logdiraspec;
deleteVehicle mando_ground_hud_target;