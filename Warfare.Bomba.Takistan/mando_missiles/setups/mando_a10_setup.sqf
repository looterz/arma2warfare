// The following scripts are for players only, no need to run on dedi servers
[]spawn
{
   while {!alive player} do
   {
      Sleep 1;
   };

   if (isNil "mando_a10s") then
   {
      mando_a10s = ["A10","a10","p85_us_a10","A10_US_EP1","A10_CBU", "A10_CBU87","A10_CBU89", "A10_CAS_MK20","A10_MK20","STI_A10_BLACK","STI_A10_HOG_BLACK","STI_A10_SHARK_BLACK","STI_A10_PANTH_BLACK","STI_A10_GREY","STI_A10_HOG_GREY","STI_A10_SHARK_GREY","STI_A10_PANTH_GREY","STI_A10_GREEN","STI_A10_HOG_GREEN","STI_A10_SHARK_GREEN","STI_A10_DESERT","STI_A10_WINTER","ATOW_A10","ACE_A10_Mk82","ACE_A10_CBU87"];
   }
   else
   {
      mando_a10s = mando_a10s + ["A10","a10","p85_us_a10","A10_US_EP1","A10_CBU", "A10_CBU87","A10_CBU89", "A10_CAS_MK20","A10_MK20","STI_A10_BLACK","STI_A10_HOG_BLACK","STI_A10_SHARK_BLACK","STI_A10_PANTH_BLACK","STI_A10_GREY","STI_A10_HOG_GREY","STI_A10_SHARK_GREY","STI_A10_PANTH_GREY","STI_A10_GREEN","STI_A10_HOG_GREEN","STI_A10_SHARK_GREEN","STI_A10_DESERT","STI_A10_WINTER","ATOW_A10","ACE_A10_Mk82","ACE_A10_CBU87"];
   };

   // BIS A10 cameras setup (onboard LGBs)

   // The MCC script is executed upon activation of the corresponding TV, and setting up all the TV parameters
   // including missile parameters, this is the control script for this TV system and mission editors can 
   // create their owns at will. "mando_missiles\tv\tv_types\" folder has several preconfigured types.
   _mcc_tv_script = mando_missile_path+"tv\tv_types\mando_tv_lgb_a10.sqs";

   // TV camera position relative to launcher + angles
   // angles is composed by initial horizontal angle (relative to TV vehicle) and max angle diff with origin
   // [0, 181] = 100% free camera initially heading to vehicle direction
   _cam_pos_angles = [-5.8,2.2,0.6,0,181];

   // Weapon index, if >= 0, it is a virtual missile, non existing in the TV vehicle
   // if < 0, then it is (the arma weapon idx + 1) in negative. -6 to use ArmA AV8 idx 5 (LGB bomb)
   _weapon_idx = -1;

   // Launch position is the relative position to the TV vehicle 
   // or a displacement offset to be applied to real weapons fired from the TV vehicle
   // with mando_tv_keepgeo = true for the first case and false for the second (set in the control script)
   // [0,0,-2] makes each LGB bomb dropped to be displayed 2m below the plane at spawn time 
   // This prevents collissions between AV8B and the LGB in air.
   _launch_pos = [0,0,-2];

   _background_mfd = []; // Default values for MDF paa and button placements
   [mando_a10s, 0, 0, ["Vehicles", "REMOTE"], "MMA LGB Camera", _mcc_tv_script, _launch_pos, _cam_pos_angles, {(driver _plane == player) && ("BombLauncherA10" in weapons _plane)}, 0, _weapon_idx, _background_mfd, 1, -3]execVM"mando_missiles\mcc\mando_mccallow_by_type.sqf";

   _weapon_idx = -1;
   _mcc_tv_script = mando_missile_path+"tv\tv_types\mando_tv_agm65.sqs";
   [mando_a10s, 0, 0, ["Vehicles"], "MMA AGM65 Camera", _mcc_tv_script, _launch_pos, _cam_pos_angles, {(driver _plane == player) && ("MaverickLauncher" in weapons _plane)}, 0, _weapon_idx, _background_mfd, 1, -3]execVM"mando_missiles\mcc\mando_mccallow_by_type.sqf";



// BIS A10
   [mando_a10s, 0, "", [4,6], [4,6], 15, 15, 0,[4,3,-2.5], mando_missile_path+"huds\mando_hud_a10.sqf", 0, 0, [[-7,"SidewinderLaucher_AH1Z"],[-6,"MaverickLauncher"]],0]execVm"mando_missiles\units\mando_assignvehicle_by_type.sqf";

};
