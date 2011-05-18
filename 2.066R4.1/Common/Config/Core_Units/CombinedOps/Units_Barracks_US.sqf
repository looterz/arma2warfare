Private ['_u'];

/* US Troops */
_u 			= [['US_Soldier_B_EP1']];		
_u = _u		+ [['USMC_Soldier_LAT', 'US_Soldier_LAT_EP1']];
_u = _u		+ [['USMC_Soldier_AT', 'US_Soldier_AT_EP1']];
_u = _u		+ [['USMC_Soldier_HAT', 'US_Soldier_HAT_EP1']];
_u = _u		+ [['USMC_Soldier_AA', 'US_Soldier_AA_EP1']];
_u = _u		+ [['USMC_Soldier_AR', 'US_Soldier_AR_EP1']];
_u = _u		+ [['USMC_Soldier_MG', 'US_Soldier_MG_EP1']];
_u = _u		+ [['USMC_Soldier_GL', 'US_Soldier_GL_EP1']];
_u = _u		+ [['USMC_Soldier_Crew', 'US_Soldier_Crew_EP1']];
_u = _u		+ [['USMC_Soldier_Pilot', 'US_Soldier_Pilot_EP1']];
_u = _u		+ [['USMC_Soldier_Medic', 'US_Soldier_Medic_EP1']];
_u = _u		+ [['USMC_SoldierS_Engineer', 'US_Soldier_Engineer_EP1']];
_u = _u		+ [['US_Soldier_Officer_EP1']];

_u = _u		+ [['USMC_SoldierS_Sniper', 'US_Soldier_Sniper_EP1']];
_u = _u		+ [['USMC_SoldierS_SniperH', 'US_Soldier_SniperH_EP1']];
_u = _u		+ [['USMC_SoldierS', 'US_Soldier_Sniper_NV_EP1']];
_u = _u		+ [['USMC_SoldierM_Marksman','US_Soldier_Marksman_EP1']];
_u = _u		+ [['US_Soldier_AMG_EP1']];
_u = _u		+ [['US_Soldier_AAR_EP1']];
_u = _u		+ [['US_Soldier_AHAT_EP1']];
_u = _u		+ [['US_Soldier_AAT_EP1']];

if (paramExtraUnits) then {
	_u = _u		+ [['USMC_Soldier', 'US_Soldier_EP1']];
	_u = _u		+ [['USMC_Soldier2', 'US_Soldier_Light_EP1']];

	_u = _u		+ [['USMC_SoldierS_Spotter', 'US_Soldier_Spotter_EP1']];
	_u = _u		+ [['USMC_Soldier_TL', 'US_Soldier_TL_EP1']];
	_u = _u		+ [['USMC_Soldier_SL', 'US_Soldier_SL_EP1']];

	_u = _u		+ [['US_Delta_Force_EP1']];
	_u = _u		+ [['US_Delta_Force_TL_EP1']];
	_u = _u		+ [['US_Delta_Force_Medic_EP1']];
	_u = _u		+ [['US_Delta_Force_Assault_EP1']];
	_u = _u		+ [['US_Delta_Force_SD_EP1']];
	_u = _u		+ [['US_Delta_Force_MG_EP1']];
	_u = _u		+ [['US_Delta_Force_AR_EP1']];
	_u = _u		+ [['US_Delta_Force_Night_EP1']];
	_u = _u		+ [['US_Delta_Force_Marksman_EP1']];
	_u = _u		+ [['US_Delta_Force_M14_EP1']];
	_u = _u		+ [['US_Delta_Force_Air_Controller_EP1']];

	_u = _u		+ [['FR_GL']];
	_u = _u		+ [['FR_Corpsman']];
	_u = _u		+ [['FR_Assault_R']];
	_u = _u		+ [['FR_Assault_GL']];
	_u = _u		+ [['FR_AR']];
	_u = _u		+ [['FR_R']];
	_u = _u		+ [['FR_Sapper']];
	_u = _u		+ [['FR_AC']];
	_u = _u		+ [['FR_Marksman']];	
};

/* USMC Troops */
if (paramExtraUnits && paramDLCBAF) then {
	/* BAF MTP Camo */
	_u = _u		+ [['BAF_Soldier_AA_W',   'BAF_Soldier_AA_DDPM', 'BAF_Soldier_AA_MTP']];
	_u = _u		+ [['BAF_Soldier_AAA_W',  'BAF_Soldier_AAA_DDPM', 'BAF_Soldier_AAA_MTP']];
	_u = _u		+ [['BAF_Soldier_AAT_W',  'BAF_Soldier_AAT_DDPM', 'BAF_Soldier_AAT_MTP']];
	_u = _u		+ [['BAF_Soldier_AHAT_W', 'BAF_Soldier_AHAT_DDPM', 'BAF_Soldier_AHAT_MTP']];
	_u = _u		+ [['BAF_Soldier_AAR_W',  'BAF_Soldier_AAR_DDPM', 'BAF_Soldier_AAR_MTP']];
	_u = _u		+ [['BAF_Soldier_AMG_W',  'BAF_Soldier_AMG_DDPM', 'BAF_Soldier_AMG_MTP']];
	_u = _u		+ [['BAF_Soldier_AT_W',   'BAF_Soldier_AT_DDPM', 'BAF_Soldier_AT_MTP']];
	_u = _u		+ [['BAF_Soldier_HAT_W',  'BAF_Soldier_HAT_DDPM', 'BAF_Soldier_HAT_MTP']];
	_u = _u		+ [['BAF_Soldier_AR_W',   'BAF_Soldier_AR_DDPM', 'BAF_Soldier_AR_MTP']];
	_u = _u		+ [['BAF_crewman_W',      'BAF_crewman_DDPM', 'BAF_crewman_MTP']];
	_u = _u		+ [['BAF_Soldier_EN_W',   'BAF_Soldier_EN_DDPM', 'BAF_Soldier_EN_MTP']];
	_u = _u		+ [['BAF_Soldier_GL_W',   'BAF_Soldier_GL_DDPM', 'BAF_Soldier_GL_MTP']];
	_u = _u		+ [['BAF_Soldier_FAC_W',  'BAF_Soldier_FAC_DDPM', 'BAF_Soldier_FAC_MTP']];
	_u = _u		+ [['BAF_Soldier_MG_W',   'BAF_Soldier_MG_DDPM', 'BAF_Soldier_MG_MTP']];
	_u = _u		+ [['BAF_Soldier_scout_W',	 'BAF_Soldier_scout_DDPM', 'BAF_Soldier_scout_MTP']];
	_u = _u		+ [['BAF_Soldier_Marksman_W', 'BAF_Soldier_Marksman_DDPM', 'BAF_Soldier_Marksman_MTP']];
	_u = _u		+ [['BAF_Soldier_Medic_W', 'BAF_Soldier_Medic_DDPM', 'BAF_Soldier_Medic_MTP']];
	_u = _u		+ [['BAF_Soldier_Officer_W', 'BAF_Soldier_Officer_DDPM', 'BAF_Soldier_Officer_MTP']];
	_u = _u		+ [['BAF_Pilot_W', 		'BAF_Pilot_DDPM', 'BAF_Pilot_MTP']];
	_u = _u		+ [['BAF_Soldier_W', 	'BAF_Soldier_DDPM', 'BAF_Soldier_MTP']];
	_u = _u		+ [['BAF_ASoldier_W', 	'BAF_ASoldier_DDPM', 'BAF_ASoldier_MTP']];
	_u = _u		+ [['BAF_Soldier_L_W', 	'BAF_Soldier_L_DDPM', 'BAF_Soldier_L_MTP']];
	_u = _u		+ [['BAF_Soldier_N_W', 	'BAF_Soldier_N_DDPM', 'BAF_Soldier_N_MTP']];
	_u = _u		+ [['BAF_Soldier_SL_W', 	'BAF_Soldier_SL_DDPM', 'BAF_Soldier_SL_MTP']];
	_u = _u		+ [['BAF_Soldier_SniperN_W', '', 'BAF_Soldier_SniperN_MTP']];
	_u = _u		+ [['BAF_Soldier_SniperH_W', '', 'BAF_Soldier_SniperH_MTP']];
	_u = _u		+ [['BAF_Soldier_Sniper_W', '',  'BAF_Soldier_Sniper_MTP']];
	_u = _u		+ [['BAF_Soldier_spotter_W', '', 'BAF_Soldier_spotter_MTP']];
	_u = _u		+ [['BAF_Soldier_spotterN_W', '', 'BAF_Soldier_spotterN_MTP']];
	_u = _u		+ [['BAF_Soldier_TL_W', 'BAF_Soldier_TL_DDPM', 'BAF_Soldier_TL_MTP']];
	/* BAF Desert Camo */
};

_u call SelectCamo;
_u