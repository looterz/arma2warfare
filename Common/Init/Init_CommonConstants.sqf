//--- DO NOT CHANGE!
EASTID = 128;
WESTID = 256;
RESISTANCEID = 512;
CMDPARAMETERBIT0 = 1024;
CMDPARAMETERBIT1 = 2048;
//--- DO NOT CHANGE!
CMD0PARAMETERS = 0;
CMD1PARAMETERS = CMDPARAMETERBIT0;
CMD2PARAMETERS = CMDPARAMETERBIT1;
CMD3PARAMETERS = CMDPARAMETERBIT0 + CMDPARAMETERBIT1;

/* IMPORTANT: New Getter/Setter, variable are stored into missionNamespace, the true/false variable define whether we shall override an existing variable or not */
//--- How long a vehicle last empty before being sweeped.
['WFBE_ABANDONVEHICLETIMER',1200,false] Call SetNamespace;
//--- AI Commander will move the base after this laps of time if all conditions are met.
['WFBE_AICOMMANDERMOVEINTERVAL',3600,true] Call SetNamespace;
//--- Global AI Skill.
['WFBE_AISKILL',1,true] Call SetNamespace;
//--- Announcers (Radio).
if (WF_A2_Vanilla) then {
	['WFBE_ANNOUNCERSWEST',['WFHQ_EN0','WFHQ_EN1','WFHQ_EN2'],true] Call SetNamespace;
	['WFBE_ANNOUNCERSEAST',['WFHQ_RU0','WFHQ_RU1','WFHQ_RU2'],true] Call SetNamespace;
};
if (WF_A2_Arrowhead) then {
	['WFBE_ANNOUNCERSWEST',['WFHQ_EN0_EP1','WFHQ_EN1_EP1','WFHQ_EN2_EP1','WFHQ_EN3_EP1','WFHQ_EN4_EP1','WFHQ_EN5_EP1'],true] Call SetNamespace;
	['WFBE_ANNOUNCERSEAST',['WFHQ_TK0_EP1','WFHQ_TK1_EP1','WFHQ_TK2_EP1','WFHQ_TK3_EP1','WFHQ_TK4_EP1'],true] Call SetNamespace;
};
if (WF_A2_CombinedOps) then {
	['WFBE_ANNOUNCERSWEST',['WFHQ_EN0_EP1','WFHQ_EN1_EP1','WFHQ_EN2_EP1','WFHQ_EN3_EP1','WFHQ_EN4_EP1','WFHQ_EN5_EP1'],true] Call SetNamespace;
	['WFBE_ANNOUNCERSEAST',['WFHQ_RU0','WFHQ_RU1','WFHQ_RU2'],true] Call SetNamespace;
};
//--- Build area (Radius/Height).
['WFBE_AREAHQDEPLOYED',[110,25],true] Call SetNamespace;
['WFBE_AREAHQUNDEPLOYED',[50,15],true] Call SetNamespace;
['WFBE_AREAREPAIRTRUCK',[45,10],true] Call SetNamespace;
//--- Anti Air Radar Z offset detection.
['WFBE_ANTIAIRRADARDETECTION',100,true] Call SetNamespace;
//--- Artillery Range.
['WFBE_ARTILLERYMAXRANGE',3,false] Call SetNamespace;
//--- Balanced units.
['WFBE_BALANCEDUNITS',['T72_TK_EP1','M6_EP1','T55_TK_EP1','ZSU_TK_EP1','An2_TK_EP1','L39_TK_EP1','UH1H_TK_EP1','Mi24_D_TK_EP1','Mi24_P','Mi24_V','Ka52','Ka52Black','MH6J_EP1','F35B'],true] Call SetNamespace;
//--- Base Area Limits.
['WFBE_BASEAREARANGE',250,true] Call SetNamespace;
['WFBE_BASEAREAMAX',2,false] Call SetNamespace;
//--- Base Patrols.
if (WF_A2_Vanilla) then {
	['WFBE_WESTBASEPATROLS_0',['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier','USMC_Soldier_AR','USMC_Soldier_GL','USMC_Soldier_MG'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_1',['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier','USMC_Soldier_MG','USMC_Soldier_LAT','USMC_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_2',['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier','USMC_Soldier_AT','USMC_Soldier_AA','USMC_SoldierS_Sniper'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_3',['USMC_Soldier_SL','USMC_Soldier','USMC_Soldier_AR','USMC_Soldier_HAT','USMC_Soldier_LAT','USMC_Soldier_GL'],true] Call SetNamespace;
	
	['WFBE_EASTBASEPATROLS_0',['RU_Soldier_SL','RU_Soldier','RU_Soldier','RU_Soldier_AR','RU_Soldier_GL','RU_Soldier_MG'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_1',['RU_Soldier_SL','RU_Soldier','RU_Soldier','RU_Soldier_MG','RU_Soldier_LAT','RU_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_2',['RU_Soldier_SL','RU_Soldier','RU_Soldier','RU_Soldier_AT','RU_Soldier_AA','RU_Soldier_Marksman'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_3',['RU_Soldier_SL','RU_Soldier','RU_Soldier_AR','RU_Soldier_HAT','RU_Soldier_LAT','RU_Soldier_GL'],true] Call SetNamespace;
};
if (WF_A2_Arrowhead) then {
	['WFBE_WESTBASEPATROLS_0',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_AR_EP1','US_Soldier_GL_EP1','US_Soldier_MG_EP1'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_1',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_MG_EP1','US_Soldier_LAT_EP1','US_Soldier_Medic_EP1'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_2',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_AT_EP1','US_Soldier_AA_EP1','US_Soldier_Sniper_EP1'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_3',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_AR_EP1','US_Soldier_HAT_EP1','US_Soldier_LAT_EP1','US_Soldier_GL_EP1'],true] Call SetNamespace;
	
	['WFBE_EASTBASEPATROLS_0',['TK_Soldier_SL_EP1','TK_Soldier_EP1','TK_Soldier_EP1','TK_Soldier_AR_EP1','TK_Soldier_GL_EP1','TK_Soldier_MG_EP1'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_1',['TK_Soldier_SL_EP1','TK_Soldier_EP1','TK_Soldier_EP1','TK_Soldier_MG_EP1','TK_Soldier_LAT_EP1','TK_Soldier_Medic_EP1'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_2',['TK_Soldier_SL_EP1','TK_Soldier_EP1','TK_Soldier_EP1','TK_Soldier_AT_EP1','TK_Soldier_AA_EP1','TK_Soldier_Spotter_EP1'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_3',['TK_Soldier_SL_EP1','TK_Soldier_EP1','TK_Soldier_AR_EP1','TK_Soldier_HAT_EP1','TK_Soldier_LAT_EP1','TK_Soldier_GL_EP1'],true] Call SetNamespace;
};
if (WF_A2_CombinedOps) then {
	['WFBE_WESTBASEPATROLS_0',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_AR_EP1','US_Soldier_GL_EP1','US_Soldier_MG_EP1'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_1',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_MG_EP1','US_Soldier_LAT_EP1','US_Soldier_Medic_EP1'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_2',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_AT_EP1','US_Soldier_AA_EP1','US_Soldier_Sniper_EP1'],true] Call SetNamespace;
	['WFBE_WESTBASEPATROLS_3',['US_Soldier_SL_EP1','US_Soldier_EP1','US_Soldier_AR_EP1','US_Soldier_HAT_EP1','US_Soldier_LAT_EP1','US_Soldier_GL_EP1'],true] Call SetNamespace;
	
	['WFBE_EASTBASEPATROLS_0',['RU_Soldier_SL','RU_Soldier','RU_Soldier','RU_Soldier_AR','RU_Soldier_GL','RU_Soldier_MG'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_1',['RU_Soldier_SL','RU_Soldier','RU_Soldier','RU_Soldier_MG','RU_Soldier_LAT','RU_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_2',['RU_Soldier_SL','RU_Soldier','RU_Soldier','RU_Soldier_AT','RU_Soldier_AA','RU_Soldier_Marksman'],true] Call SetNamespace;
	['WFBE_EASTBASEPATROLS_3',['RU_Soldier_SL','RU_Soldier','RU_Soldier_AR','RU_Soldier_HAT','RU_Soldier_LAT','RU_Soldier_GL'],true] Call SetNamespace;
};
//--- Bounty Coefficient Modifier (Blood money).
['WFBE_BOUNTYMODIFIER',0.25,true] Call SetNamespace;
//--- Building Limits.
['WFBE_BUILDINGMAXBARRACKS',3,false] Call SetNamespace;
['WFBE_BUILDINGMAXLIGHT',3,false] Call SetNamespace;
['WFBE_BUILDINGMAXCOMMANDCENTER',3,false] Call SetNamespace;
['WFBE_BUILDINGMAXHEAVY',3,false] Call SetNamespace;
['WFBE_BUILDINGMAXAIRCRAFT',3,false] Call SetNamespace;
['WFBE_BUILDINGMAXSERVICEPOINT',6,false] Call SetNamespace;
//--- Bounty received by player whenever he capture a camp.
['WFBE_CAMPCAPTUREBOUNTY',100,true] Call SetNamespace;
//--- Command Center Range.
['WFBE_COMMANDCENTERRANGE',50000,true] Call SetNamespace;
//--- Commander bounties.
['WFBE_COMMANDERBUILDSCORE',1,true] Call SetNamespace;
['WFBE_COMMANDERTOWNCAPTURECOEF',30,true] Call SetNamespace;
['WFBE_COMMANDERTOWNCAPTURESCORE',1,true] Call SetNamespace;
['WFBE_COMMANDERUPGRADESCORE',1,true] Call SetNamespace;
//--- Counter Measures.
['WFBE_COUNTERMEASUREPLANES',64,true] Call SetNamespace;
['WFBE_COUNTERMEASURECHOPPERS',32,true] Call SetNamespace;
//--- Crew Cost.
['WFBE_CREWCOST',120,true] Call SetNamespace;
//--- Within 250 meters, units on defense mode will board defenses.
['WFBE_DEFENSEMANRANGE',250,false] Call SetNamespace;
//--- Supply Trucks (Clients) delivery range.
['WFBE_DELIVERYRANGE',30,true] Call SetNamespace;
//--- Patrolling Range Ratio.
['WFBE_DETECTIONTOPATROLRANGERATIO',0.4,true] Call SetNamespace;
//--- Fast Time skip time rate.
['WFBE_FASTTIMERATE',0.00666,true] Call SetNamespace;
//--- Fast Travel.
['WFBE_FASTTRAVELMAXRANGE',3500,true] Call SetNamespace;
['WFBE_FASTTRAVELRANGE',175,true] Call SetNamespace;
['WFBE_FASTTRAVELTIMECOEF',1,true] Call SetNamespace;
//--- Fire mission interval.
['WFBE_FIREMISSIONTIMEOUT0',300,true] Call SetNamespace;
['WFBE_FIREMISSIONTIMEOUT1',250,true] Call SetNamespace;
['WFBE_FIREMISSIONTIMEOUT2',200,true] Call SetNamespace;
['WFBE_FIREMISSIONTIMEOUT3',150,true] Call SetNamespace;
//--- Coef per supply delivery.
['WFBE_FUNDSPERSUPPLYPOINT',2,true] Call SetNamespace;
//--- Distance above which units are able to perform an HALO jump.
['WFBE_HALOJUMPHEIGHT',200,true] Call SetNamespace;
//--- HQ Deploy / Mobilize Price.
['WFBE_HQDEPLOYPRICE',100,false] Call SetNamespace;
//--- Income System (1:Full, 2:Half (Half -> 120 SV Town = 60$ / 60SV))
['WFBE_INCOMESYSTEM',1,false] Call SetNamespace;
//--- Time that a marker remain on a dead unit.
['WFBE_MARKERDEADDELAY',60,true] Call SetNamespace;
//--- Maximum AI's that will be able to man defense in baracks area.
['WFBE_MAXAIDEFENSE',30,true] Call SetNamespace;
//---  Maximum spread area of artillery support.
['WFBE_MAXARTILLERYAREA',300,true] Call SetNamespace;
//--- Maximum rate of a camp's capture affecting a town.
['WFBE_MAXCAMPCAPTURERATE',5,true] Call SetNamespace;
//--- Maximum Client Group size.
['WFBE_MAXGROUPSIZE',14,false] Call SetNamespace;
['WFBE_MAXGROUPSIZEAI',10,false] Call SetNamespace;
//--- Skill (Soldier), have more units than the others.
['WFBE_MAXGZBONUSSKILL',6,true] Call SetNamespace;
//--- Maximum amount of supply truck per side (AI).
['WFBE_MAXAISUPPLYTRUCKS',5,true] Call SetNamespace;
//--- Maximum Clutter Distance (Grass).
['WFBE_MAXCLUTTERDISTANCE',50,false] Call SetNamespace;
//--- Maximum Supply per trucks.
['WFBE_MAXSUPPLYTRUCKSSV0',5,true] Call SetNamespace;
['WFBE_MAXSUPPLYTRUCKSSV1',7,true] Call SetNamespace;
['WFBE_MAXSUPPLYTRUCKSSV2',10,true] Call SetNamespace;
//--- Maximum Client Side View Distance.
['WFBE_MAXVIEWDISTANCE',4000,false] Call SetNamespace;
//--- HQ Building Range.
['WFBE_MHQBUILDINGRANGE',120,true] Call SetNamespace;
//--- HQ Repair Price.
['WFBE_MHQREPAIRPRICE',25000,true] Call SetNamespace;
//--- Town Occupation SV floor.
['WFBE_OCCUPATIONTEAM1',20,true] Call SetNamespace;
['WFBE_OCCUPATIONTEAM2',40,true] Call SetNamespace;
['WFBE_OCCUPATIONTEAM3',60,true] Call SetNamespace;
['WFBE_OCCUPATIONTEAM4',80,true] Call SetNamespace;
['WFBE_OCCUPATIONTEAM5',100,true] Call SetNamespace;
['WFBE_OCCUPATIONTEAM6',120,true] Call SetNamespace;
//--- Maximum seconds off the map limits.
['WFBE_OFFMAPMAXTIME',30,true] Call SetNamespace;
//--- Unit Patrol Radius.
['WFBE_PATROLRANGE',400,true] Call SetNamespace;
//--- Purchase Unit Range.
['WFBE_PURCHASEUNITSRANGE',150,true] Call SetNamespace;
['WFBE_PURCHASEUNITSRANGEAIR',50,true] Call SetNamespace;
//--- Purchase Gear Range.
['WFBE_PURCHASEGEARRANGE',150,true] Call SetNamespace;
//--- Repair truck repair range.
['WFBE_REPAIRTRUCKRANGE',40,true] Call SetNamespace;
//--- Resistance 'part' (faction) to be used.
if (WF_A2_CombinedOps) then {['WFBE_RESISTANCEFACTION',1,false] Call SetNamespace};
//--- Resistance Inactive period before being removed (town).
['WFBE_RESISTANCEINACTIVETIME',400,true] Call SetNamespace;
//--- Respawn Delay (Players/AI).
['WFBE_RESPAWNDELAY',30,false] Call SetNamespace;
//--- How far a player need to be from a town to spawn at camps.
['WFBE_RESPAWNRANGE',550,false] Call SetNamespace;
['WFBE_RESPAWNMINRANGE',50,true] Call SetNamespace;
//--- How far a player need to be from a mobile respawn in order to spawn on it.
['WFBE_RESPAWNMOBILERANGE0',250,true] Call SetNamespace;
['WFBE_RESPAWNMOBILERANGE1',350,true] Call SetNamespace;
['WFBE_RESPAWNMOBILERANGE2',500,true] Call SetNamespace;
//--- Score Gained per town assist.
['WFBE_SCOREASSISTCAPTURETOWN',5,true] Call SetNamespace;
//--- Points Gained per camp captire.
['WFBE_SCORECAPTURECAMP',1,true] Call SetNamespace;
//--- Score Gained per town capture.
['WFBE_SCORECAPTURETOWN',10,true] Call SetNamespace;
//--- Points Received per Supply delivery.
['WFBE_SCOREPERSUPPLYPOINT',2,true] Call SetNamespace;
//--- Service points action range.
['WFBE_SERVICEPOINTRANGE',50,true] Call SetNamespace;
//--- Sides need at last xkm of distance between them.
['WFBE_SIDESTARTINGDISTANCE',5000,false] Call SetNamespace;
//--- Starting Locations Mode: 0 = WN|ES; 1 = WS|EN; 2 = Random;
['WFBE_STARTINGLOCATIONMODE',2,false] Call SetNamespace;
//--- Supply System (0: Trucks, 1: Automatic with time).
['WFBE_SUPPLYSYSTEM',0,false] Call SetNamespace;
//--- If SUPPLYSYSTEM == 1 then, we increase of SUPPLYSYSTEMINCREASE each SUPPLYSYSTEMINCREASETIME.
['WFBE_SUPPLYSYSTEMINCREASE0',1,true] Call SetNamespace;
['WFBE_SUPPLYSYSTEMINCREASE1',2,true] Call SetNamespace;
['WFBE_SUPPLYSYSTEMINCREASE2',3,true] Call SetNamespace;
['WFBE_SUPPLYSYSTEMINCREASETIME',60,true] Call SetNamespace;
//--- Action range for repair/rearm/refuel.
['WFBE_SUPPORTRANGE',70,true] Call SetNamespace;
//--- Price of Support (Base), note that Rearm, Refuel and Repair are using Ratio.
['WFBE_SUPPORTHEALPRICE',125,true] Call SetNamespace;
['WFBE_SUPPORTREARMPRICE',14,true] Call SetNamespace;
['WFBE_SUPPORTREFUELPRICE',16,true] Call SetNamespace;
['WFBE_SUPPORTREPAIRPRICE',2,true] Call SetNamespace;
//--- Amount of time required to be able to use an action from the support menu again.
['WFBE_SUPPORTHEALTIME',50,true] Call SetNamespace;
['WFBE_SUPPORTREARMTIME',60,true] Call SetNamespace;
['WFBE_SUPPORTREFUELTIME',40,true] Call SetNamespace;
['WFBE_SUPPORTREPAIRTIME',80,true] Call SetNamespace;
//--- Money to be deducted from a teamkiller.
['WFBE_TEAMKILLPENALTY',500,true] Call SetNamespace;
//--- Bounty received by player whenever he get an assist in a town.
['WFBE_TOWNASSISTCAPTUREBOUNTY',175,true] Call SetNamespace;
['WFBE_TOWNMISSIONASSISTCAPTUREBOUNTY',350,true] Call SetNamespace;
//--- Restrict use of build menu if the player is near a town.
['WFBE_TOWNBUILDPROTECTIONRANGE',450,false] Call SetNamespace;
//--- Range Coefficient whenever a player get an assist in a town.
['WFBE_TOWNCAPTUREASSISTRANGEMODIFIER',0.6,true] Call SetNamespace;
//--- Bounty received by player whenever he capture a town.
['WFBE_TOWNCAPTUREBOUNTY',400,true] Call SetNamespace;
['WFBE_TOWNMISSIONCAPTUREBOUNTY',800,true] Call SetNamespace;
//--- Town Depot capture range.
['WFBE_TOWNCAPTURERANGE',40,true] Call SetNamespace;
//--- Town Capture rate.
['WFBE_TOWNCAPTURERATE',1,true] Call SetNamespace;
//--- Town Purchase range.
['WFBE_TOWNPURCHASERANGE',30,true] Call SetNamespace;
//--- Town occupation Difficulty (1: Light, 2: Medium, 3: Hard, 4: Insane, 5: Auto).
['WFBE_TOWNOCCUPATIONDIFFICULTY',1,false] Call SetNamespace;
//--- East or West Inactive period before being removed (town).
['WFBE_TOWNOCCUPATIONINACTIVETIME',400,true] Call SetNamespace;
//--- Town resistance Difficulty (1: Light, 2: Medium, 3: Hard, 4: Insane).
['WFBE_TOWNRESISTANCEDIFFICULTY',1,false] Call SetNamespace;
//--- Town starting mode (0: Resistance, 1: 50% blu, 50% red, 2: Nearby Towns.
['WFBE_TOWNSTARTINGMODE',0,false] Call SetNamespace;
//--- Distance between each defensive waypoints.
['WFBE_TOWNUNITSDEFENSEDISTANCE',30,true] Call SetNamespace;
//--- Distance between each patrolling waypoints.
['WFBE_TOWNUNITSPATROLDISTANCE',360,true] Call SetNamespace;
//--- Unit will spawn within this range.
['WFBE_TOWNUNITSPAWNRANGE',75,true] Call SetNamespace;
//--- Sweeping delay.
['WFBE_UNITREMOVEDLAY',300,false] Call SetNamespace;
//--- Victory Condition (0: Annihilation, 1: Assassination, 2: Supremacy).
['WFBE_VICTORYCONDITION',2,false] Call SetNamespace;
//--- Commander vote time.

if (WF_DEBUG) then { 
	['WFBE_VOTETIME',10,true] Call SetNamespace;
} else 
{ 	['WFBE_VOTETIME',60,true] Call SetNamespace; };


//--- Weather Transition period, need to be < server weather sleep (Jip Sync on next forecast).
['WFBE_WEATHERTRANSITION',400,true] Call SetNamespace;
//--- Proper worlds (Radio town localization).
['WFBE_WORLDWHITELISTOA',["Zargabad","Takistan"],true] Call SetNamespace;
['WFBE_WORLDWHITELISTVA',["chernarus","utes"],true] Call SetNamespace;

//--- Resistance Island Patrol System.
['WFBE_RESPATROLINTERVAL',1200,true] Call SetNamespace;
['WFBE_RESPATROLMAX',6,false] Call SetNamespace;
_resType = 'WFBE_RESISTANCEFACTION' Call GetNamespace;
if (isNil '_resType') then {_resType = -1};
if (WF_A2_Vanilla || _resType == 0) then {
	['WFBE_RESPATROLTYPE10',['GUE_Soldier_1','GUE_Soldier_MG','GUE_Soldier_Sniper','GUE_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE11',['GUE_Soldier_CO','GUE_Soldier_AR','GUE_Soldier_3','GUE_Soldier_AT','GUE_Soldier_2'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE12',['Offroad_DSHKM_Gue','Offroad_SPG9_Gue'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE20',['BRDM2_GUE','BRDM2_GUE'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE21',['V3S_GUE','GUE_Soldier_CO','GUE_Soldier_AT','GUE_Soldier_MG','GUE_Soldier_AT'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE22',['BMP2_GUE','GUE_Soldier_AA','GUE_Soldier_AA','GUE_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE30',['BMP2_GUE','BMP2_GUE'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE31',['T72_GUE','T72_GUE'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE32',['GUE_Soldier_Sniper','GUE_Soldier_Scout','GUE_Soldier_Sniper'],true] Call SetNamespace;
};
if (WF_A2_Arrowhead || _resType == 1) then {
	['WFBE_RESPATROLTYPE10',['TK_GUE_Soldier_EP1','TK_GUE_Soldier_MG_EP1','TK_GUE_Soldier_Sniper_EP1','TK_GUE_Bonesetter_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE11',['TK_GUE_Warlord_EP1','TK_GUE_Soldier_AR_EP1','TK_GUE_Soldier_3_EP1','TK_GUE_Soldier_AT_EP1','TK_GUE_Soldier_4_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE12',['Offroad_DSHKM_TK_GUE_EP1','Offroad_SPG9_TK_GUE_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE20',['BTR40_MG_TK_GUE_EP1','Ural_ZU23_TK_GUE_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE21',['V3S_TK_GUE_EP1','TK_GUE_Warlord_EP1','TK_GUE_Soldier_AT_EP1','TK_GUE_Soldier_MG_EP1','TK_GUE_Soldier_HAT_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE22',['BTR40_MG_TK_GUE_EP1','TK_GUE_Soldier_AA_EP1','TK_GUE_Soldier_AA_EP1','TK_GUE_Bonesetter_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE30',['T34_TK_GUE_EP1','T34_TK_GUE_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE31',['T55_TK_GUE_EP1','T55_TK_GUE_EP1'],true] Call SetNamespace;
	['WFBE_RESPATROLTYPE32',['TK_GUE_Soldier_Sniper_EP1','TK_GUE_Soldier_5_EP1','TK_GUE_Soldier_Sniper_EP1'],true] Call SetNamespace;
};

//--- Resistance Strikers.
['WFBE_RESSTRIKERINTERVAL',1800,true] Call SetNamespace;
['WFBE_RESSTRIKERMAX',3,false] Call SetNamespace;
if (WF_A2_Vanilla || _resType == 0) then {
	['WFBE_RESSTRIKERTYPE10',['GUE_Soldier_Sab','GUE_Soldier_Scout','GUE_Soldier_Sniper'],true] Call SetNamespace;
	['WFBE_RESSTRIKERTYPE11',['GUE_Soldier_CO','GUE_Soldier_AR','GUE_Soldier_3','GUE_Soldier_AT','GUE_Soldier_2'],true] Call SetNamespace;
	['WFBE_RESSTRIKERTYPE12',['GUE_Soldier_CO','GUE_Soldier_AA','GUE_Soldier_AA','GUE_Soldier_3'],true] Call SetNamespace;
	['WFBE_RESSTRIKERTYPE13',['GUE_Soldier_CO','GUE_Soldier_MG','GUE_Soldier_Medic','GUE_Soldier_AT','GUE_Soldier_AT'],true] Call SetNamespace;
};
if (WF_A2_Arrowhead || _resType == 1) then {
	['WFBE_RESSTRIKERTYPE10',['TK_GUE_Soldier_EP1','TK_GUE_Soldier_5_EP1','TK_GUE_Soldier_Sniper_EP1'],true] Call SetNamespace;
	['WFBE_RESSTRIKERTYPE11',['TK_GUE_Warlord_EP1','TK_GUE_Soldier_AR_EP1','TK_GUE_Soldier_3_EP1','TK_GUE_Soldier_AT_EP1','TK_GUE_Soldier_4_EP1'],true] Call SetNamespace;
	['WFBE_RESSTRIKERTYPE12',['TK_GUE_Warlord_EP1','TK_GUE_Soldier_AA_EP1','TK_GUE_Soldier_AA_EP1','TK_GUE_Soldier_3_EP1'],true] Call SetNamespace;
	['WFBE_RESSTRIKERTYPE13',['TK_GUE_Warlord_EP1','TK_GUE_Soldier_MG_EP1','TK_GUE_Bonesetter_EP1','TK_GUE_Soldier_AT_EP1','TK_GUE_Soldier_AT_EP1'],true] Call SetNamespace;
};

//--- UPGRADE SYSTEM:
//--- Important: If you add any other upgrades, add them at the end.
['WFBE_UPGRADELABELS',
 [localize 'strwfbarracks',localize 'strwflightfactory',localize 'strwfheavyfactory',localize 'strwfaircraftfactory',localize 'STR_WF_Paratroop',
 localize 'str_dn_uav',localize 'STR_WF_Supply',localize 'STR_WF_RespawnRange',localize 'STR_WF_Airlift',localize 'STR_WF_Countermeasures',
 localize 'STR_WF_ArtilleryUpgrade',localize 'STR_WF_ICBM',localize 'STR_WF_FastTravel',localize 'STR_WF_Gear',localize 'STR_WF_Ammo','EASA'],
 true
] Call SetNamespace;
//--- Amount of upgrade levels.
['WFBE_UPGRADELEVELS',[3,3,3,3,3,1,2,2,1,1,3,1,1,3,1,1],true] Call SetNamespace;
//--- [upgrade index, upgrade level].
['WFBE_UPGRADEDEPENDENCIES',[[],[],[],[],[3,1],[3,2],[],[1,2],[],[3,1],[2,1],[3,3],[],[],[13,3],[3,3]],true] Call SetNamespace;
//--- Special condition.
['WFBE_UPGRADECONDITION',[true,true,true,true,true,true,true,true,true,counterMeasures,arty,icbm,fastTravel,true,true,paramEASA],true] Call SetNamespace;
//--- [Supply,Money].
['WFBE_UPGRADEPRICESLEVEL1',[[300,750],[700,1850],[1900,4000],[3600,8800],[3200,7400],[2500,5600],[1800,6200],[500,1800],[950,2450],[3400,8200],[1200,2950],[50000,80000],[1350,3550],[250,500],[750,2250],[4400,12500]],true] Call SetNamespace;
['WFBE_UPGRADEPRICESLEVEL2',[[400,1150],[800,2450],[2100,4750],[4600,9900],[3800,8700],[],[3600,12400],[700,2400],[],[],[1800,4400],[],[],[650,2550],[],[]],true] Call SetNamespace;
['WFBE_UPGRADEPRICESLEVEL3',[[500,1620],[1000,3900],[2400,6050],[5500,10750],[4400,9800],[],[],[],[],[],[3000,7500],[],[],[1400,4250],[],[]],true] Call SetNamespace;
//--- Time required per upgrade.
['WFBE_UPGRADETIMESLEVEL1',[160,210,320,420,340,260,310,175,195,320,220,850,260,180,170,420],true] Call SetNamespace;
['WFBE_UPGRADETIMESLEVEL2',[220,250,340,455,370,0,420,220,0,0,260,0,0,260,0,0],true] Call SetNamespace;
['WFBE_UPGRADETIMESLEVEL3',[240,290,360,495,390,0,0,0,0,0,320,0,0,340,0,0],true] Call SetNamespace;
//--- AI COMMANDER priority, we use the upgrade index (0: Barracks, 4: Paratroops...).
['WFBE_UPGRADEAIORDER',[0,13,1,6,2,12,3,7,10,3,8,4,5,9,11,14,15],true] Call SetNamespace;

//--- SPECIAL.
['WFBE_PARADELAY',1200,true] Call SetNamespace;
if (WF_A2_Vanilla) then {
	['WFBE_WESTPARACARGO','C130J',true] Call SetNamespace;
	['WFBE_EASTPARACARGO','Mi17_Ins',true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL1',['RU_Soldier_SL','RU_Soldier_LAT','RU_Soldier','RU_Soldier2','RU_Soldier_AR','RU_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL2',['RU_Soldier_SL','RU_Soldier_AT','RU_Soldier_AT','RU_Soldier_AT','RU_Soldier_AA','RU_Soldier_MG','RU_Soldier_Medic','RU_Soldier_Marksman','RUS_Soldier_Marksman'],true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL3',['MVD_Soldier_TL','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_AA','RU_Soldier_AA','MVD_Soldier_MG','RUS_Commander','MVD_Soldier_Sniper','RUS_Soldier_Marksman'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL1',['USMC_Soldier_SL','USMC_Soldier_LAT','USMC_Soldier','USMC_Soldier2','USMC_Soldier_AR','USMC_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL2',['USMC_Soldier_SL','USMC_Soldier_AT','USMC_Soldier_AT','USMC_Soldier_AT','USMC_Soldier_AA','USMC_Soldier_MG','USMC_Soldier_Medic','USMC_SoldierS_Spotter','USMC_SoldierS_Sniper'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL3',['FR_Assault_R','USMC_Soldier_HAT','USMC_Soldier_HAT','USMC_Soldier_HAT','USMC_Soldier_HAT','USMC_Soldier_AA','USMC_Soldier_AA','FR_AR','FR_AC','USMC_Soldier_Medic','FR_Marksman','USMC_Soldier_AT','USMC_SoldierS_Sniper'],true] Call SetNamespace;
};
if (WF_A2_Arrowhead) then {
	['WFBE_WESTPARACARGO','C130J_US_EP1',true] Call SetNamespace;
	['WFBE_EASTPARACARGO','Mi17_TK_EP1',true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL1',['TK_Soldier_SL_EP1','TK_Soldier_LAT_EP1','TK_Soldier_EP1','TK_Soldier_LAT_EP1','TK_Soldier_AR_EP1','TK_Soldier_Medic_EP1'],true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL2',['TK_Soldier_SL_EP1','TK_Soldier_AT_EP1','TK_Soldier_AT_EP1','TK_Soldier_AT_EP1','TK_Soldier_AA_EP1','TK_Soldier_MG_EP1','TK_Soldier_Medic_EP1','TK_Soldier_Sniper_EP1','TK_Soldier_Spotter_EP1'],true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL3',['TK_Special_Forces_TL_EP1','TK_Soldier_HAT_EP1','TK_Soldier_HAT_EP1','TK_Soldier_HAT_EP1','TK_Soldier_HAT_EP1','TK_Soldier_HAT_EP1','TK_Soldier_AA_EP1','TK_Soldier_AA_EP1','TK_Special_Forces_MG_EP1','TK_Special_Forces_EP1','TK_Special_Forces_EP1','TK_Special_Forces_EP1'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL1',['US_Soldier_SL_EP1','US_Soldier_LAT_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_AR_EP1','US_Soldier_Medic_EP1'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL2',['US_Soldier_SL_EP1','US_Soldier_AT_EP1','US_Soldier_AT_EP1','US_Soldier_AT_EP1','US_Soldier_AA_EP1','US_Soldier_MG_EP1','US_Soldier_Medic_EP1','US_Soldier_Spotter_EP1','US_Soldier_Sniper_EP1'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL3',['US_Delta_Force_TL_EP1','US_Soldier_HAT_EP1','US_Soldier_HAT_EP1','US_Soldier_HAT_EP1','US_Soldier_HAT_EP1','US_Soldier_AA_EP1','US_Soldier_AA_EP1','US_Delta_Force_AR_EP1','US_Delta_Force_Assault_EP1','US_Soldier_Medic_EP1','US_Delta_Force_M14_EP1','US_Soldier_AT_EP1','US_Soldier_Marksman_EP1'],true] Call SetNamespace;
};
if (WF_A2_CombinedOps) then {
	['WFBE_WESTPARACARGO','C130J_US_EP1',true] Call SetNamespace;
	['WFBE_EASTPARACARGO','Mi17_Ins',true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL1',['RU_Soldier_SL','RU_Soldier_LAT','RU_Soldier','RU_Soldier2','RU_Soldier_AR','RU_Soldier_Medic'],true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL2',['RU_Soldier_SL','RU_Soldier_AT','RU_Soldier_AT','RU_Soldier_AT','RU_Soldier_AA','RU_Soldier_MG','RU_Soldier_Medic','RU_Soldier_Marksman','RUS_Soldier_Marksman'],true] Call SetNamespace;
	['WFBE_EASTPARACHUTELEVEL3',['MVD_Soldier_TL','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_HAT','RU_Soldier_AA','RU_Soldier_AA','MVD_Soldier_MG','RUS_Commander','MVD_Soldier_Sniper','RUS_Soldier_Marksman'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL1',['US_Soldier_SL_EP1','US_Soldier_LAT_EP1','US_Soldier_EP1','US_Soldier_EP1','US_Soldier_AR_EP1','US_Soldier_Medic_EP1'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL2',['US_Soldier_SL_EP1','US_Soldier_AT_EP1','US_Soldier_AT_EP1','US_Soldier_AT_EP1','US_Soldier_AA_EP1','US_Soldier_MG_EP1','US_Soldier_Medic_EP1','US_Soldier_Spotter_EP1','US_Soldier_Sniper_EP1'],true] Call SetNamespace;
	['WFBE_WESTPARACHUTELEVEL3',['US_Delta_Force_TL_EP1','US_Soldier_HAT_EP1','US_Soldier_HAT_EP1','US_Soldier_HAT_EP1','US_Soldier_HAT_EP1','US_Soldier_AA_EP1','US_Soldier_AA_EP1','US_Delta_Force_AR_EP1','US_Delta_Force_Assault_EP1','US_Soldier_Medic_EP1','US_Delta_Force_M14_EP1','US_Soldier_AT_EP1','US_Soldier_Marksman_EP1'],true] Call SetNamespace;
};