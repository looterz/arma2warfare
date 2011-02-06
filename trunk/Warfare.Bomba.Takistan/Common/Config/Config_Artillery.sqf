private['_maxrange'];
_maxRange = 'WFBE_ARTILLERYMAXRANGE' Call GetNamespace;

if (WF_A2_Vanilla) then {
	/* WEST Artillery */
	//--- Label shown in the GUI.
	['WFBE_WEST_ARTILLERY_DESC',['M119','M252','MLRS'],true] Call SetNamespace;
	//--- Class name of the Artillery unit.
	['WFBE_WEST_ARTILLERY_NAMES',
	  [
		['M119'],
		['M252'],
		['MLRS']
	  ]
	,true] Call SetNamespace;
	//--- Artillery Weapon used to fire the shells.
	['WFBE_WEST_ARTILLERY_WEAPONS',['M119','M252','MLRS'],true] Call SetNamespace;
	//--- Compatible ammo.
	['WFBE_WEST_ARTILLERY_AMMOS',
	  [
		['ARTY_Sh_105_HE','Sh_105_HE','ARTY_Sh_105_WP','ARTY_Sh_105_SADARM','ARTY_Sh_105_LASER','ARTY_Sh_105_SMOKE','ARTY_Sh_105_ILLUM'],
		['ARTY_Sh_81_HE','Sh_81_HE','ARTY_Sh_81_WP','ARTY_Sh_81_ILLUM'],
		['ARTY_R_227mm_HE_Rocket','R_MLRS']
	  ]
	,true] Call SetNamespace;
	//--- Extended ammo.
	['WFBE_WEST_ARTILLERY_EXTENDED_MAGS',
	  [
		['ARTY_30Rnd_105mmWP_M119','ARTY_30Rnd_105mmSADARM_M119','ARTY_30Rnd_105mmLASER_M119','ARTY_30Rnd_105mmSMOKE_M119','ARTY_30Rnd_105mmILLUM_M119'],
		['ARTY_8Rnd_81mmWP_M252','ARTY_8Rnd_81mmILLUM_M252'],
		[]
	  ]
	,true] Call SetNamespace;
	//--- Upgrade level required for the extended ammo.
	['WFBE_WEST_ARTILLERY_EXTENDED_MAGS_UPGRD',
	  [
		[2,3,3,1,1],
		[2,1],
		[]
	  ]
	,true] Call SetNamespace;
	//--- Artillery Minimal fire distance.
	['WFBE_WEST_ARTILLERY_MINRANGES',[1000,500,1200],true] Call SetNamespace;
	//--- Artillery Maximal fire distance multiplied by the artillery range parameter.
	['WFBE_WEST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange],true] Call SetNamespace;
	//--- Artillery Reload time between each shot.
	['WFBE_WEST_ARTILLERY_RELOADTIME',[7,4,2],true] Call SetNamespace;
	//--- Amount of shells fired during a fire mission.
	['WFBE_WEST_ARTILLERY_BURST',[10,4,6],true] Call SetNamespace;
	//--- Velocity of the shell (note: try to keep it above 400 for a realistic result).
	['WFBE_WEST_ARTILLERY_VELOCITIES',[500,475,550],true] Call SetNamespace;
	//--- Shell land dispersion.
	['WFBE_WEST_ARTILLERY_DISPERSIONS',[50,60,40],true] Call SetNamespace;
	//--- Laser Guided Ammunitions.
	['WFBE_WEST_ARTILLERY_AMMO_LASER',['ARTY_Sh_105_LASER'],true] Call SetNamespace;
	//--- Search And Destroy Armor ammunition.
	['WFBE_WEST_ARTILLERY_AMMO_SADARM',['ARTY_Sh_105_SADARM'],true] Call SetNamespace;
	//--- Illum rounds.
	['WFBE_WEST_ARTILLERY_AMMO_ILLUMN',['ARTY_Sh_105_ILLUM'],true] Call SetNamespace;
	//--- Deploy smoke on impact if it's this type.
	['WFBE_WEST_ARTILLERY_DEPLOY_SMOKE',['ARTY_Sh_105_WP','ARTY_Sh_105_SMOKE'],true] Call SetNamespace;
		
	/* EAST Artillery */
	['WFBE_EAST_ARTILLERY_DESC',['D30','2B14','GRAD'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_NAMES',
	  [
		['D30_RU'],
		['2b14_82mm'],
		['GRAD_RU']
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_WEAPONS',['D30','2B14','GRAD'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMOS',
	  [
		['ARTY_Sh_122_HE','Sh_122_HE','ARTY_Sh_122_WP','ARTY_Sh_122_SADARM','ARTY_Sh_122_LASER','ARTY_Sh_122_SMOKE','ARTY_Sh_122_ILLUM'],
		['ARTY_Sh_82_HE','Sh_82_HE','ARTY_Sh_82_WP','ARTY_Sh_82_ILLUM'],
		['ARTY_R_227mm_HE_Rocket','R_GRAD']
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_EXTENDED_MAGS',
	  [
		['ARTY_30Rnd_122mmWP_D30','ARTY_30Rnd_122mmSADARM_D30','ARTY_30Rnd_122mmLASER_D30','ARTY_30Rnd_122mmSMOKE_D30','ARTY_30Rnd_122mmILLUM_D30'],
		['ARTY_8Rnd_82mmWP_2B14','ARTY_8Rnd_82mmILLUM_2B14'],
		[]
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_EXTENDED_MAGS_UPGRD',
	  [
		[2,3,3,1,1],
		[2,1],
		[]
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_MINRANGES',[1000,500,800],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_RELOADTIME',[7,4,2],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_BURST',[10,4,10],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_VELOCITIES',[500,475,550],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_DISPERSIONS',[50,60,40],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMO_LASER',['ARTY_Sh_122_LASER'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMO_SADARM',['ARTY_Sh_122_SADARM'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMO_ILLUMN',['ARTY_Sh_122_ILLUM'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_DEPLOY_SMOKE',['ARTY_Sh_122_WP','ARTY_Sh_122_SMOKE'],true] Call SetNamespace;
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	/* WEST Artillery */
	['WFBE_WEST_ARTILLERY_DESC',['M119','M252','MLRS','Stryker MC'],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_NAMES',
	  [
		['M119_US_EP1','M119'],
		['M252_US_EP1','M252'],
		['MLRS','MLRS_DES_EP1'],
		['M1129_MC_EP1']
	  ]
	,true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_WEAPONS',['M119','M252','MLRS','M120'],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_AMMOS',
	  [
		['Sh_105_HE','Sh_105_WP','Sh_105_SADARM','Sh_105_LASER','Sh_105_SMOKE','Sh_105_ILLUM'],
		['Sh_81_HE','Sh_81_WP','Sh_81_ILLUM'],
		['R_MLRS'],
		['120mmHE_M120']
	  ]
	,true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_EXTENDED_MAGS',
	  [
		['30Rnd_105mmWP_M119','30Rnd_105mmSADARM_M119','30Rnd_105mmLASER_M119','30Rnd_105mmSMOKE_M119','30Rnd_105mmILLUM_M119'],
		['8Rnd_81mmWP_M252','8Rnd_81mmILLUM_M252'],
		[],
		[]
	  ]
	,true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_EXTENDED_MAGS_UPGRD',
	  [
		[2,3,3,1,1],
		[2,1],
		[],
		[]
	  ]
	,true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_MINRANGES',[1000,500,1200,550],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange,2150*_maxRange],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_RELOADTIME',[7,4,2,4],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_BURST',[10,4,6,6],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_VELOCITIES',[500,475,550,475],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_DISPERSIONS',[50,60,40,55],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_AMMO_LASER',['Sh_105_LASER'],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_AMMO_SADARM',['Sh_105_SADARM'],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_AMMO_ILLUMN',['Sh_105_ILLUM'],true] Call SetNamespace;
	['WFBE_WEST_ARTILLERY_DEPLOY_SMOKE',['Sh_105_WP','Sh_105_SMOKE'],true] Call SetNamespace;

	/* EAST Artillery */
	['WFBE_EAST_ARTILLERY_DESC',['D30','2B14','GRAD'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_NAMES',
	  [
		['D30_TK_EP1','D30_RU'],
		['2b14_82mm_TK_EP1','2b14_82mm'],
		['GRAD_RU','GRAD_TK_EP1']
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_WEAPONS',['D30','2B14','GRAD'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMOS',
	  [
		['Sh_122_HE','Sh_122_WP','Sh_122_SADARM','Sh_122_LASER','Sh_122_SMOKE','Sh_122_ILLUM'],
		['Sh_82_HE','Sh_82_WP','Sh_82_ILLUM'],
		['R_GRAD']
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_EXTENDED_MAGS',
	  [
		['30Rnd_122mmWP_D30','30Rnd_122mmSADARM_D30','30Rnd_122mmLASER_D30','30Rnd_122mmSMOKE_D30','30Rnd_122mmILLUM_D30'],
		['8Rnd_82mmWP_2B14','8Rnd_82mmILLUM_2B14'],
		[]
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_EXTENDED_MAGS_UPGRD',
	  [
		[2,3,3,1,1],
		[2,1],
		[]
	  ]
	,true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_MINRANGES',[1000,500,800],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_MAXRANGES',[2333*_maxRange,1833*_maxRange,3000*_maxRange],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_RELOADTIME',[7,4,2],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_BURST',[10,4,10],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_VELOCITIES',[500,475,550],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_DISPERSIONS',[50,60,40],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMO_LASER',['Sh_122_LASER'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMO_SADARM',['Sh_122_SADARM'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_AMMO_ILLUMN',['Sh_122_ILLUM'],true] Call SetNamespace;
	['WFBE_EAST_ARTILLERY_DEPLOY_SMOKE',['Sh_122_WP','Sh_122_SMOKE'],true] Call SetNamespace;
};

'Config_Artillery: Initialization - [Done]' call LogMedium;