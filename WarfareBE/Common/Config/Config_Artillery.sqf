_maxRange = 'WFBE_ARTILLERYMAXRANGE' Call GetNamespace;

if (WF_A2_Vanilla) then {
	if (side player == west) then {
		artilleryDescs = ['M119','M252','MLRS'];
		artilleryNames = [['M119'],['M252'],['MLRS']];
		artilleryWeapons = ['M119','M252','MLRS'];
		artilleryAmmos = ['ARTY_Sh_105_HE','ARTY_Sh_81_HE','R_MLRS'];
		artilleryMagazines = ['ARTY_30Rnd_105mmHE_M119','ARTY_8Rnd_81mmHE_M252','12Rnd_MLRS'];
		artilleryMinRanges = [1000,500,1200];
		artilleryMaxRanges = [2333*_maxRange,1833*_maxRange,3000*_maxRange];
		artilleryReloadTimes = [7,4,2];
		artilleryBurst = [10,4,6];
		artilleryVelocities = [1100,890,1050];
		artilleryDispersions = [50,60,40];
	} else {
		artilleryDescs = ['D30','2B14','GRAD'];
		artilleryNames = [['D30_RU'],['2b14_82mm'],['GRAD_RU']];
		artilleryWeapons = ['D30','2B14','GRAD'];
		artilleryAmmos = ['ARTY_Sh_122_HE','ARTY_Sh_82_HE','R_GRAD'];
		artilleryMagazines = ['ARTY_30Rnd_122mmHE_D30','ARTY_8Rnd_82mmHE_2B14','40Rnd_GRAD'];
		artilleryMinRanges = [1000,500,800];
		artilleryMaxRanges = [2333*_maxRange,1833*_maxRange,3000*_maxRange];
		artilleryReloadTimes = [7,4,2];
		artilleryBurst = [10,4,10];
		artilleryVelocites = [1100,890,1050];
		artilleryDispersions = [50,60,40];
	};
};

if (WF_A2_Arrowhead || WF_A2_CombinedOps) then {
	if (side player == west) then {
		artilleryDescs = ['M119','M252','MLRS','Stryker MC'];
		artilleryNames = [['M119_US_EP1'],['M252_US_EP1'],['MLRS','MLRS_DES_EP1'],['M1129_MC_EP1']];
		artilleryWeapons = ['M119','M252','MLRS','M120'];
		artilleryAmmos = ['ARTY_Sh_105_HE','ARTY_Sh_81_HE','R_MLRS','120mmHE_M120'];
		artilleryMagazines = ['ARTY_30Rnd_105mmHE_M119','ARTY_8Rnd_81mmHE_M252','12Rnd_MLRS','24Rnd_120mmHE_M120_02'];
		artilleryMinRanges = [1000,500,1200,550];
		artilleryMaxRanges = [2333*_maxRange,1833*_maxRange,3000*_maxRange,2150*_maxRange];
		artilleryReloadTimes = [7,4,2,4];
		artilleryBurst = [10,4,6,6];
		artilleryVelocities = [1100,890,1050,920];
		artilleryDispersions = [50,60,40,55];
	} else {
		artilleryDescs = ['D30','2B14','GRAD'];
		artilleryNames = [['D30_TK_EP1'],['2b14_82mm_TK_EP1'],['GRAD_RU','GRAD_TK_EP1']];
		artilleryWeapons = ['D30','2B14','GRAD'];
		artilleryAmmos = ['ARTY_Sh_122_HE','ARTY_Sh_82_HE','R_GRAD'];
		artilleryMagazines = ['ARTY_30Rnd_122mmHE_D30','ARTY_8Rnd_82mmHE_2B14','40Rnd_GRAD'];
		artilleryMinRanges = [1000,500,800];
		artilleryMaxRanges = [2333*_maxRange,1833*_maxRange,3000*_maxRange];
		artilleryReloadTimes = [7,4,2];
		artilleryBurst = [10,4,10];
		artilleryVelocites = [1100,890,1050];
		artilleryDispersions = [50,60,40];
	};
};

diag_log '[WFBE (INIT)] Config_Artillery: Initialization - [Done]';