class CfgMovesBasic {
	class Default;	// External class reference
	class StandBase;	// External class reference
};

class CfgMovesMaleSdr : CfgMovesBasic {
	class States {
		class AmovPercMstpSlowWrflDnon : StandBase {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPercMstpSlowWrflDnon_AmovPercMevaSrasWrflDl : AmovPercMstpSlowWrflDnon {
			ConnectTo[] = {};
		};
		
		class AmovPercMstpSrasWrflDnon : AmovPercMstpSlowWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPercMstpSrasWrflDnon_AmovPercMevaSrasWrflDr : AmovPercMstpSrasWrflDnon {
			ConnectTo[] = {};
		};
		
		class AmovPercMwlkSrasWrflDf : AmovPercMstpSrasWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMstpSlowWrflDnon : AmovPercMstpSlowWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSlowWrflDf : AmovPknlMstpSlowWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMstpSrasWrflDnon : AmovPknlMstpSlowWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMwlkSrasWrflDf : AmovPknlMstpSrasWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDf : AmovPknlMstpSrasWrflDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDfl : AmovPknlMrunSrasWrflDf {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDl : AmovPknlMrunSrasWrflDfl {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDbl : AmovPknlMrunSrasWrflDfl {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDb : AmovPknlMrunSrasWrflDfl {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDbr : AmovPknlMrunSrasWrflDfl {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDr : AmovPknlMrunSrasWrflDfl {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMrunSrasWrflDfr : AmovPknlMrunSrasWrflDfl {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPercMstpSrasWpstDnon : StandBase {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
		
		class AmovPknlMstpSrasWpstDnon : AmovPercMstpSrasWpstDnon {
			collisionShape = "ca\Anims\Characters\data\Geom\Sdr\Perc_Mrun_Slow_Wrfl.p3d";
		};
	}; 	
};