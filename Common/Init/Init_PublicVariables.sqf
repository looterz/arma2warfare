_l		= ["RequestVehicleLock"];
_l = _l + ["RequestCommanderVote"];
_l = _l + ["RequestStructure"];
_l = _l + ["RequestDefense"];
_l = _l + ["RequestChangeScore"];
_l = _l + ["RequestMHQRepair"];
_l = _l + ["RequestSpecial"];
_l = _l + ["RequestTeamUpdate"];

serverCommandPV = _l;

_l =      ["AllCampsCaptured"];
_l = _l + ["AwardBounty"];
_l = _l + ["CampCaptured"];
_l = _l + ["ChangeScore"];
_l = _l + ["CommanderVote"];
_l = _l + ["DisplayICBM"];
_l = _l + ["EndGame"];
_l = _l + ["ISIS_AddAction"];
_l = _l + ["LocalizeMessage"];
_l = _l + ["SetHQStatus"];
_l = _l + ["SetTask"];
_l = _l + ["SetVehicleLock"];
_l = _l + ["TownCaptured"];
_l = _l + ["TownCapturedPublic"];
_l = _l + ["VoteForCommander"];

clientCommandPV = _l;

clientCommandsSent = 0;
publicVariablesSent = 0;

for [{_count = Count serverCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {Call Compile Format["%1 = 0",serverCommandPV Select _count];};
for [{_count = Count clientCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {Call Compile Format["%1 = 0",clientCommandPV Select _count];};

for [{_count = Count clientCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {Call Compile Format["CMD%1 = %2",clientCommandPV Select _count,_count];};
for [{_count = Count serverCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {Call Compile Format["CMD%1 = %2",serverCommandPV Select _count,_count];};

for [{_count = Count clientCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {Call Compile Format["CLTFNC%1 = Compile PreprocessFile ""Client\PVFunctions\%1.sqf""",clientCommandPV Select _count,_count];};
for [{_count = Count serverCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {Call Compile Format["SRVFNC%1 = Compile PreprocessFile ""Server\PVFunctions\%1.sqf""",serverCommandPV Select _count,_count];};

clientCommandPVTimeLeft = [];
for [{_count = Count clientCommandPV - 1},{_count >= 0},{_count = _count - 1}] do {clientCommandPVTimeLeft = clientCommandPVTimeLeft + [0];};