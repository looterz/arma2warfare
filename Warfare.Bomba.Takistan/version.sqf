/*
	Description:
		Define which 'part' to run.
*/

/* DEBUG */
#define WF_DEBUG 1

/* Gameplay: Change the overall camo */
//#define WF_CAMO 1

/* Gamemode to run */
#define COMBINEDOPS 1
//#define VANILLA 1
//#define ARROWHEAD 1
//#define MANDOMISSILES

/* Description.ext Specific */
#define WF_MAXPLAYERS 40
#define WF_MISSIONNAME "$MISSIONNAME"
#define WF_RESPAWNDELAY 2

#define WF_WESTTEAMS [Group WestSlot1,Group WestSlot2,Group WestSlot3,Group WestSlot4,Group WestSlot5,Group WestSlot6,Group WestSlot7,Group WestSlot8,Group WestSlot9,Group WestSlot10,Group WestSlot11,Group WestSlot12,Group WestSlot13,Group WestSlot14,Group WestSlot15,Group WestSlot16,Group WestSlot17,Group WestSlot18,Group WestSlot19,Group WestSlot20]

#define WF_EASTTEAMS [Group EastSlot1,Group EastSlot2,Group EastSlot3,Group EastSlot4,Group EastSlot5,Group EastSlot6,Group EastSlot7,Group EastSlot8,Group EastSlot9,Group EastSlot10,Group EastSlot11,Group EastSlot12,Group EastSlot13,Group EastSlot14,Group EastSlot15,Group EastSlot16,Group EastSlot17,Group EastSlot18,Group EastSlot19,Group EastSlot20]

#define WF_WESTSLOTNAMES [vehicleVarName WestSlot1,vehicleVarName WestSlot2,vehicleVarName WestSlot3,vehicleVarName WestSlot4,vehicleVarName WestSlot5,vehicleVarName WestSlot6,vehicleVarName WestSlot7,vehicleVarName WestSlot8,vehicleVarName WestSlot9,vehicleVarName WestSlot10,vehicleVarName WestSlot11,vehicleVarName WestSlot12,vehicleVarName WestSlot13,vehicleVarName WestSlot14,vehicleVarName WestSlot15,vehicleVarName WestSlot16,vehicleVarName WestSlot17,vehicleVarName WestSlot18,vehicleVarName WestSlot19,vehicleVarName WestSlot20]

#define WF_EASTSLOTNAMES [vehicleVarName EastSlot1,vehicleVarName EastSlot2,vehicleVarName EastSlot3,vehicleVarName EastSlot4,vehicleVarName EastSlot5,vehicleVarName EastSlot6,vehicleVarName EastSlot7,vehicleVarName EastSlot8,vehicleVarName EastSlot9,vehicleVarName EastSlot10,vehicleVarName EastSlot11,vehicleVarName EastSlot12,vehicleVarName EastSlot13,vehicleVarName EastSlot14,vehicleVarName EastSlot15,vehicleVarName EastSlot16,vehicleVarName EastSlot17,vehicleVarName EastSlot18,vehicleVarName EastSlot19,vehicleVarName EastSlot20]

/* MySQL Support */
//#define MYSQL 1

/* Load Screen (OA/CO) */
#ifndef VANILLA
	//#define WF_LOADSCREEN "ca\Missions_e\MPScenarios\MPE_MountainWarfare.Takistan\loading_mpwarfare_co.paa"
	#define WF_LOADSCREEN __EVAL(["ca\Missions_e\campaign\missions\CE7B_PhoenixOp.Takistan\img\loading08_phoenixop_co.paa","ca\Missions_e\campaign\missions\CE7A_FinishingTouch.Takistan\img\loading08_finishingtouch_co.paa","ca\Missions_e\campaign\missions\CE6_EyeOfTheHurricane.Zargabad\img\loading07_co.paa","ca\Missions_e\campaign\missions\CE5B_FromHell.Takistan\img\loading06_fromhell_co.paa","ca\Missions_e\campaign\missions\CE5A_Sandstorm.Takistan\img\loading06_sandstorm_co.paa","ca\Missions_e\campaign\missions\CE4_OpenSeason.Takistan\img\loading05_co.paa","ca\Missions_e\campaign\missions\CE3_ColtanBlues.Takistan\img\loading04_co.paa","ca\Missions_e\campaign\missions\CE2_Pathfinder.Takistan\img\loading03_co.paa","ca\Missions_e\campaign\missions\CE1_GoodMorningTStan.Takistan\img\loading02_goodmorning_co.paa","ca\Missions_e\campaign\missions\CE0_Backstab.Zargabad\img\loading01_co.paa","ca\Missions_e\scenarios\SPE1_Jackal.Takistan\loading_jackal_co.paa","ca\Missions_e\scenarios\SPE1_Vehicles_US.Takistan\loading_showus_co.paa","ca\Missions_e\scenarios\SPE1_Vehicles_TKG.Zargabad\loading_showgue_co.paa","ca\Missions_e\scenarios\SPE1_Vehicles_TKA.Zargabad\loading_showtk_co.paa","ca\Missions_e\scenarios\SPE1_Vehicles_Civilian.Zargabad\loading_showciv_co.paa","ca\Missions_e\scenarios\SPE1_Vehicles_Allies.Takistan\loading_shownato_co.paa","ca\Missions_e\scenarios\SPE1_SteelPanthers.Takistan\loading_steelpanthers_co.paa","ca\Missions_e\scenarios\SPE1_OneShotOneKill.Takistan\loading_oneshotonekill_co.paa","ca\Missions_e\scenarios\SPE1_Littlebird.Takistan\loading_littlebird_co.paa","ca\Missions_e\scenarios\SPE1_LaserShow.Takistan\loading_lasershow_co.paa","ca\Missions_e\scenarios\SPE1_HikeInTheHills.Takistan\loading_hikeinthehills_co.paa","ca\Missions_e\scenarios\SPE1_DeathFromAbove.Takistan\loading_deathfromabove_co.paa","ca\Missions_e\scenarios\SPE1_Benchmark1.Takistan\loading_benchmark_co.paa","ca\Missions_e\MPScenarios\MPE1_Dogfighters.Takistan\loading_mpdogfight_co.paa","ca\Missions_e\MPScenarios\MPE_MountainWarfare.Takistan\loading_mpwarfare_co.paa","ca\Missions_e\MPScenarios\MPE_SectorControl.Zargabad\img\loading_mpsectorcontrol_co.paa"] select round random 25)
#endif


