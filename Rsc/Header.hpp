/* Header */

//--- Respawn options.
respawn = 3;
respawnDelay = 2;
respawnDialog = false;

//--- Require briefing.html to show up.
onLoadMission = WF_MISSIONNAME;
onLoadMissionTime = false;

//--- ArrowHead loadscreen.
#ifndef VANILLA
	loadScreen = "ca\Missions_e\MPScenarios\MPE_MountainWarfare.Takistan\loading_mpwarfare_co.paa";
#endif

//--- Properties.
class Header {
	gameType = CTI;
	minPlayers = 1;
	maxPlayers = 32;
};