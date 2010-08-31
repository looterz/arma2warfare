//--- Synchronize unit on the fly.
private["_group"];
_group = _this;

//--- Only execute this server sided!
if (isServer) then
{
      [nil,nil,"per",rEXECVM,(BIS_AIS_path + "data\scripts\" + "IS.sqf"),_group] call RE;
      [nil,nil,"per",rEXECVM,(BIS_FA_Path+BIS_PATH_SQF+"FA.sqf"),_group,nil,true] call RE;
};