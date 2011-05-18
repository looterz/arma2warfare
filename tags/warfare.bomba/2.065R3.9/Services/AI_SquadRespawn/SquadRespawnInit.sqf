waitUntil {commonInitComplete};

WBE_AISQUAD_RESPAWN = [];
WBE_AISQUAD_RESPAWN_QUEUE = [];

SquadRespawnProc = Compile preprocessFile "Services\AI_SquadRespawn\SquadRespawnProc.sqf";
SquadRespawnWork = Compile preprocessFile "Services\AI_SquadRespawn\SquadRespawnWork.sqf";

AISquadRespawn = Compile preprocessFile "Services\AI_SquadRespawn\AISquadRespawn.sqf";

[SquadRespawnProc, 10];