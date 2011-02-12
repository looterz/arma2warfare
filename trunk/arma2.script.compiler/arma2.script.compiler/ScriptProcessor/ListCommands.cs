using System.IO;

namespace ArmA2.Script.ScriptProcessor
{
    public partial class Processor
    {
        public static Function[] CommandData = new Function[]
            {
                new Function { Name="#include",                      OnCompile = null,	OnExecute = null },
                new Function { Name="#define",                       OnCompile = null,	OnExecute = null },
                new Function { Name="#ifdef",                        OnCompile = null,	OnExecute = null },
                new Function { Name="#ifndef",                       OnCompile = null,	OnExecute = null },
                new Function { Name="#endif",                        OnCompile = null,	OnExecute = null },
                new Function { Name="#else",                         OnCompile = null,	OnExecute = null },

                new Function { Name="abs",                           OnCompile = null,	OnExecute = null },
                new Function { Name="accTime",                       OnCompile = null,	OnExecute = null },
                new Function { Name="acos",                          OnCompile = null,	OnExecute = null },
                new Function { Name="action",                        OnCompile = null,	OnExecute = null },
                new Function { Name="actionKeys",                    OnCompile = null,	OnExecute = null },
                new Function { Name="actionKeysImages",              OnCompile = null,	OnExecute = null },
                new Function { Name="actionKeysNames",               OnCompile = null,	OnExecute = null },
                new Function { Name="actionKeysNamesArray",          OnCompile = null,	OnExecute = null },
                new Function { Name="activateAddons",                OnCompile = null,	OnExecute = null },
                new Function { Name="activateKey",                   OnCompile = null,	OnExecute = null },
                new Function { Name="addAction",                     OnCompile = null,	OnExecute = null },
                new Function { Name="addBackpack",                   OnCompile = null,	OnExecute = null },
                new Function { Name="addBackpackCargo",              OnCompile = null,	OnExecute = null },
                new Function { Name="addCamShake",                   OnCompile = null,	OnExecute = null },
                new Function { Name="addEditorObject",               OnCompile = null,	OnExecute = null },
                new Function { Name="addEventHandler",               OnCompile = EventHandler,	OnExecute = null },
                new Function { Name="addGroupIcon",                  OnCompile = null,	OnExecute = null },
                new Function { Name="addLiveStats",                  OnCompile = null,	OnExecute = null },
                new Function { Name="addMagazine",                   OnCompile = null,	OnExecute = null },
                new Function { Name="addMagazineCargo",              OnCompile = null,	OnExecute = null },
                new Function { Name="addMagazineCargoGlobal",        OnCompile = null,	OnExecute = null },
                new Function { Name="addMagazinePool",               OnCompile = null,	OnExecute = null },
                new Function { Name="addMagazineTurret",             OnCompile = null,	OnExecute = null },
                new Function { Name="addMenu",                       OnCompile = null,	OnExecute = null },
                new Function { Name="addMenuItem",                   OnCompile = null,	OnExecute = null },
                new Function { Name="addMPEventHandler",             OnCompile = EventHandler,	OnExecute = null },
                new Function { Name="addPublicVariableEventHandler", OnCompile = PVEventHandler,	OnExecute = null },
                new Function { Name="addRating",                     OnCompile = null,	OnExecute = null },
                new Function { Name="addResources",                  OnCompile = null,	OnExecute = null },
                new Function { Name="addScore",                      OnCompile = null,	OnExecute = null },
                new Function { Name="addSwitchableUnit",             OnCompile = null,	OnExecute = null },
                new Function { Name="addTeamMember",                 OnCompile = null,	OnExecute = null },
                new Function { Name="addVehicle",                    OnCompile = null,	OnExecute = null },
                new Function { Name="addWaypoint",                   OnCompile = null,	OnExecute = null },
                new Function { Name="addWeapon",                     OnCompile = null,	OnExecute = null },
                new Function { Name="addWeaponCargo",                OnCompile = null,	OnExecute = null },
                new Function { Name="addWeaponCargoGlobal",          OnCompile = null,	OnExecute = null },
                new Function { Name="addWeaponPool",                 OnCompile = null,	OnExecute = null },
                new Function { Name="agent",                         OnCompile = null,	OnExecute = null },
                new Function { Name="agents",                        OnCompile = null,	OnExecute = null },
                new Function { Name="aimedAtTarget",                 OnCompile = null,	OnExecute = null },
                new Function { Name="airportSide",                   OnCompile = null,	OnExecute = null },
                new Function { Name="AISFinishHeal",                 OnCompile = null,	OnExecute = null },
                new Function { Name="alive",                         OnCompile = null,	OnExecute = null },
                new Function { Name="allDead",                       OnCompile = null,	OnExecute = null },
                new Function { Name="allGroups",                     OnCompile = null,	OnExecute = null },
                new Function { Name="allMissionObjects",             OnCompile = null,	OnExecute = null },
                new Function { Name="allow3DMode",                   OnCompile = null,	OnExecute = null },
                new Function { Name="allowDamage",                   OnCompile = null,	OnExecute = null },
                new Function { Name="allowDammage",                  OnCompile = null,	OnExecute = null },
                new Function { Name="allowFileOperations",           OnCompile = null,	OnExecute = null },
                new Function { Name="allowFleeing",                  OnCompile = null,	OnExecute = null },
                new Function { Name="allowGetIn",                    OnCompile = null,	OnExecute = null },
                new Function { Name="allUnits",                      OnCompile = null,	OnExecute = null },
                new Function { Name="ammo",                          OnCompile = null,	OnExecute = null },
                new Function { Name="and",                           OnCompile = null,	OnExecute = null },
                new Function { Name="animate",                       OnCompile = null,	OnExecute = null },
                new Function { Name="animationPhase",                OnCompile = null,	OnExecute = null },
                new Function { Name="animationState",                OnCompile = null,	OnExecute = null },
                new Function { Name="armoryPoints",                  OnCompile = null,	OnExecute = null },
                new Function { Name="asin",                          OnCompile = null,	OnExecute = null },
                new Function { Name="assert",                        OnCompile = null,	OnExecute = null },
                new Function { Name="assignAsCargo",                 OnCompile = null,	OnExecute = null },
                new Function { Name="assignAsCommander",             OnCompile = null,	OnExecute = null },
                new Function { Name="assignAsDriver",                OnCompile = null,	OnExecute = null },
                new Function { Name="assignAsGunner",                OnCompile = null,	OnExecute = null },
                new Function { Name="assignedCargo",                 OnCompile = null,	OnExecute = null },
                new Function { Name="assignedCommander",             OnCompile = null,	OnExecute = null },
                new Function { Name="assignedDriver",                OnCompile = null,	OnExecute = null },
                new Function { Name="assignedGunner",                OnCompile = null,	OnExecute = null },
                new Function { Name="assignedTarget",                OnCompile = null,	OnExecute = null },
                new Function { Name="assignedVehicle",               OnCompile = null,	OnExecute = null },
                new Function { Name="assignedVehicleRole",           OnCompile = null,	OnExecute = null },
                new Function { Name="assignTeam",                    OnCompile = null,	OnExecute = null },
                new Function { Name="assignToAirport",               OnCompile = null,	OnExecute = null },
                new Function { Name="atan",                          OnCompile = null,	OnExecute = null },
                new Function { Name="atan2",                         OnCompile = null,	OnExecute = null },
                new Function { Name="atg",                           OnCompile = null,	OnExecute = null },
                new Function { Name="attachedObject",                OnCompile = null,	OnExecute = null },
                new Function { Name="attachObject",                  OnCompile = null,	OnExecute = null },
                new Function { Name="attachTo",                      OnCompile = null,	OnExecute = null },
                new Function { Name="attackEnabled",                 OnCompile = null,	OnExecute = null },
                new Function { Name="backpackSpaceFor",              OnCompile = null,	OnExecute = null },
                new Function { Name="behaviour",                     OnCompile = null,	OnExecute = null },
                new Function { Name="benchmark",                     OnCompile = null,	OnExecute = null },
                new Function { Name="boundingBox",                   OnCompile = null,	OnExecute = null },
                new Function { Name="boundingCenter",                OnCompile = null,	OnExecute = null },
                new Function { Name="breakOut",                      OnCompile = null,	OnExecute = null },
                new Function { Name="breakTo",                       OnCompile = null,	OnExecute = null },
                new Function { Name="buildingExit",                  OnCompile = null,	OnExecute = null },
                new Function { Name="buildingPos",                   OnCompile = null,	OnExecute = null },
                new Function { Name="buttonAction",                  OnCompile = null,	OnExecute = null },
                new Function { Name="buttonSetAction",               OnCompile = null,	OnExecute = null },
                new Function { Name="cadetMode",                     OnCompile = null,	OnExecute = null },
                new Function { Name="call",                          OnCompile = null,	OnExecute = null },
                new Function { Name="camCommand",                    OnCompile = null,	OnExecute = null },
                new Function { Name="camCommit",                     OnCompile = null,	OnExecute = null },
                new Function { Name="camCommitPrepared",             OnCompile = null,	OnExecute = null },
                new Function { Name="camCommitted",                  OnCompile = null,	OnExecute = null },
                new Function { Name="camConstuctionSetParams",       OnCompile = null,	OnExecute = null },
                new Function { Name="camCreate",                     OnCompile = null,	OnExecute = null },
                new Function { Name="camDestroy",                    OnCompile = null,	OnExecute = null },
                new Function { Name="cameraEffect",                  OnCompile = null,	OnExecute = null },
                new Function { Name="cameraEffectEnableHUD",         OnCompile = null,	OnExecute = null },
                new Function { Name="cameraInterest",                OnCompile = null,	OnExecute = null },
                new Function { Name="cameraOn",                      OnCompile = null,	OnExecute = null },
                new Function { Name="cameraView",                    OnCompile = null,	OnExecute = null },
                new Function { Name="campaignConfigFile",            OnCompile = null,	OnExecute = null },
                new Function { Name="camPreload",                    OnCompile = null,	OnExecute = null },
                new Function { Name="camPreloaded",                  OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareBank",                OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareDir",                 OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareDive",                OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareFocus",               OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareFov",                 OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareFovRange",            OnCompile = null,	OnExecute = null },
                new Function { Name="camPreparePos",                 OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareRelPos",              OnCompile = null,	OnExecute = null },
                new Function { Name="camPrepareTarget",              OnCompile = null,	OnExecute = null },
                new Function { Name="camSetBank",                    OnCompile = null,	OnExecute = null },
                new Function { Name="camSetDir",                     OnCompile = null,	OnExecute = null },
                new Function { Name="camSetDive",                    OnCompile = null,	OnExecute = null },
                new Function { Name="camSetFocus",                   OnCompile = null,	OnExecute = null },
                new Function { Name="camSetFov",                     OnCompile = null,	OnExecute = null },
                new Function { Name="camSetFovRange",                OnCompile = null,	OnExecute = null },
                new Function { Name="camSetPos",                     OnCompile = null,	OnExecute = null },
                new Function { Name="camSetRelPos",                  OnCompile = null,	OnExecute = null },
                new Function { Name="camSetTarget",                  OnCompile = null,	OnExecute = null },
                new Function { Name="camTarget",                     OnCompile = null,	OnExecute = null },
                new Function { Name="camUseNVG",                     OnCompile = null,	OnExecute = null },
                new Function { Name="canFire",                       OnCompile = null,	OnExecute = null },
                new Function { Name="canMove",                       OnCompile = null,	OnExecute = null },
                new Function { Name="canStand",                      OnCompile = null,	OnExecute = null },
                new Function { Name="canUnloadInCombat",             OnCompile = null,	OnExecute = null },
                new Function { Name="captive",                       OnCompile = null,	OnExecute = null },
                new Function { Name="captiveNum",                    OnCompile = null,	OnExecute = null },
                new Function { Name="case",                          OnCompile = null,	OnExecute = null },
                new Function { Name="catch",                         OnCompile = null,	OnExecute = null },
                new Function { Name="ceil",                          OnCompile = null,	OnExecute = null },
                new Function { Name="cheatsEnabled",                 OnCompile = null,	OnExecute = null },
                new Function { Name="checkAIFeature",                OnCompile = null,	OnExecute = null },
                new Function { Name="civilian",                      OnCompile = null,	OnExecute = null },
                new Function { Name="clearBackpackCargoGlobal",      OnCompile = null,	OnExecute = null },
                new Function { Name="clearGroupIcons",               OnCompile = null,	OnExecute = null },
                new Function { Name="clearMagazineCargo",            OnCompile = null,	OnExecute = null },
                new Function { Name="clearMagazineCargoGlobal",      OnCompile = null,	OnExecute = null },
                new Function { Name="clearMagazinePool",             OnCompile = null,	OnExecute = null },
                new Function { Name="clearOverlay",                  OnCompile = null,	OnExecute = null },
                new Function { Name="clearRadio",                    OnCompile = null,	OnExecute = null },
                new Function { Name="clearVehicleInit",              OnCompile = null,	OnExecute = null },
                new Function { Name="clearWeaponCargo",              OnCompile = null,	OnExecute = null },
                new Function { Name="clearWeaponCargoGlobal",        OnCompile = null,	OnExecute = null },
                new Function { Name="clearWeaponPool",               OnCompile = null,	OnExecute = null },
                new Function { Name="closeDialog",                   OnCompile = null,	OnExecute = null },
                new Function { Name="closeDisplay",                  OnCompile = null,	OnExecute = null },
                new Function { Name="closeOverlay",                  OnCompile = null,	OnExecute = null },
                new Function { Name="collapseObjectTree",            OnCompile = null,	OnExecute = null },
                new Function { Name="combatMode",                    OnCompile = null,	OnExecute = null },
                new Function { Name="commandChat",                   OnCompile = null,	OnExecute = null },
                new Function { Name="commander",                     OnCompile = null,	OnExecute = null },
                new Function { Name="commandFire",                   OnCompile = null,	OnExecute = null },
                new Function { Name="commandFollow",                 OnCompile = null,	OnExecute = null },
                new Function { Name="commandFSM",                    OnCompile = null,	OnExecute = null },
                new Function { Name="commandGetOut",                 OnCompile = null,	OnExecute = null },
                new Function { Name="commandingMenu",                OnCompile = null,	OnExecute = null },
                new Function { Name="commandMove",                   OnCompile = null,	OnExecute = null },
                new Function { Name="commandRadio",                  OnCompile = null,	OnExecute = null },
                new Function { Name="commandStop",                   OnCompile = null,	OnExecute = null },
                new Function { Name="commandTarget",                 OnCompile = null,	OnExecute = null },
                new Function { Name="commandWatch",                  OnCompile = null,	OnExecute = null },
                new Function { Name="comment",                       OnCompile = null,	OnExecute = null },
                new Function { Name="commitOverlay",                 OnCompile = null,	OnExecute = null },
                new Function { Name="compile",                       OnCompile = CompileCommand,	OnExecute = null },
                new Function { Name="completedFSM",                  OnCompile = null,	OnExecute = null },
                new Function { Name="composeText",                   OnCompile = null,	OnExecute = null },
                new Function { Name="configFile",                    OnCompile = null,	OnExecute = null },
                new Function { Name="configName",                    OnCompile = null,	OnExecute = null },
                new Function { Name="controlNull",                   OnCompile = null,	OnExecute = null },
                new Function { Name="copyFromClipboard",             OnCompile = null,	OnExecute = null },
                new Function { Name="copyToClipboard",               OnCompile = null,	OnExecute = null },
                new Function { Name="copyWaypoints",                 OnCompile = null,	OnExecute = null },
                new Function { Name="cos",                           OnCompile = null,	OnExecute = null },
                new Function { Name="count",                         OnCompile = null,	OnExecute = null },
                new Function { Name="countEnemy",                    OnCompile = null,	OnExecute = null },
                new Function { Name="countFriendly",                 OnCompile = null,	OnExecute = null },
                new Function { Name="countSide",                     OnCompile = null,	OnExecute = null },
                new Function { Name="countType",                     OnCompile = null,	OnExecute = null },
                new Function { Name="countUnknown",                  OnCompile = null,	OnExecute = null },
                new Function { Name="createAgent",                   OnCompile = null,	OnExecute = null },
                new Function { Name="createCenter",                  OnCompile = null,	OnExecute = null },
                new Function { Name="createDialog",                  OnCompile = null,	OnExecute = null },
                new Function { Name="createDiaryLink",               OnCompile = null,	OnExecute = null },
                new Function { Name="createDiaryRecord",             OnCompile = null,	OnExecute = null },
                new Function { Name="createDiarySubject",            OnCompile = null,	OnExecute = null },
                new Function { Name="createDisplay",                 OnCompile = null,	OnExecute = null },
                new Function { Name="createGearDialog",              OnCompile = null,	OnExecute = null },
                new Function { Name="createGroup",                   OnCompile = null,	OnExecute = null },
                new Function { Name="createGuardedPoint",            OnCompile = null,	OnExecute = null },
                new Function { Name="createLocation",                OnCompile = null,	OnExecute = null },
                new Function { Name="createMarker",                  OnCompile = null,	OnExecute = null },
                new Function { Name="createMarkerLocal",             OnCompile = null,	OnExecute = null },
                new Function { Name="createMenu",                    OnCompile = null,	OnExecute = null },
                new Function { Name="createMine",                    OnCompile = null,	OnExecute = null },
                new Function { Name="createMissionDisplay",          OnCompile = null,	OnExecute = null },
                new Function { Name="createSimpleTask",              OnCompile = null,	OnExecute = null },
                new Function { Name="createSoundSource",             OnCompile = null,	OnExecute = null },
                new Function { Name="createTarget",                  OnCompile = null,	OnExecute = null },
                new Function { Name="createTask",                    OnCompile = null,	OnExecute = null },
                new Function { Name="createTeam",                    OnCompile = null,	OnExecute = null },
                new Function { Name="createTrigger",                 OnCompile = null,	OnExecute = null },
                new Function { Name="createUnit",                    OnCompile = null,	OnExecute = null },
                new Function { Name="createVehicle",                 OnCompile = null,	OnExecute = null },
                new Function { Name="createVehicleLocal",            OnCompile = null,	OnExecute = null },
                new Function { Name="crew",                          OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlActivate",                  OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlAddEventHandler",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlAutoScrollDelay",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlAutoScrollRewind",          OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlAutoScrollSpeed",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlCommit",                    OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlCommitted",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlEnable",                    OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlEnabled",                   OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlFade",                      OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapAnimAdd",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapAnimClear",              OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapAnimCommit",             OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapAnimDone",               OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapCursor",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapMouseOver",              OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapScale",                  OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapScreenToWorld",          OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlMapWorldToScreen",          OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlParent",                    OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlPosition",                  OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlRemoveAllEventHandlers",    OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlRemoveEventHandler",        OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlScale",                     OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetActiveColor",            OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetAutoScrollDelay",        OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetAutoScrollRewind",       OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetAutoScrollSpeed",        OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetBackgroundColor",        OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetEventHandler",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFade",                   OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFocus",                  OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFont",                   OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH1",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH1B",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH2",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH2B",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH3",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH3B",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH4",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH4B",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH5",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH5B",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH6",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontH6B",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeight",             OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeightH1",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeightH2",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeightH3",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeightH4",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeightH5",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontHeightH6",           OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontP",                  OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetFontPB",                 OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetForegroundColor",        OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetPosition",               OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetScale",                  OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetStructuredText",         OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetText",                   OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetTextColor",              OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetTooltip",                OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetTooltipColorBox",        OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetTooltipColorShade",      OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlSetTooltipColorText",       OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlShow",                      OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlShown",                     OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlText",                      OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlType",                      OnCompile = null,	OnExecute = null },
                new Function { Name="ctrlVisible",                   OnCompile = null,	OnExecute = null },
                new Function { Name="currentCommand",                OnCompile = null,	OnExecute = null },
                new Function { Name="currentMagazine",               OnCompile = null,	OnExecute = null },
                new Function { Name="currentMuzzle",                 OnCompile = null,	OnExecute = null },
                new Function { Name="currentTask",                   OnCompile = null,	OnExecute = null },
                new Function { Name="currentTasks",                  OnCompile = null,	OnExecute = null },
                new Function { Name="currentVisionMode",             OnCompile = null,	OnExecute = null },
                new Function { Name="currentWaypoint",               OnCompile = null,	OnExecute = null },
                new Function { Name="currentWeapon",                 OnCompile = null,	OnExecute = null },
                new Function { Name="currentWeaponMode",             OnCompile = null,	OnExecute = null },
                new Function { Name="currentZeroing",                OnCompile = null,	OnExecute = null },
                new Function { Name="cursorTarget",                  OnCompile = null,	OnExecute = null },
                new Function { Name="cutFadeOut",                    OnCompile = null,	OnExecute = null },
                new Function { Name="cutObj",                        OnCompile = null,	OnExecute = null },
                new Function { Name="cutRsc",                        OnCompile = null,	OnExecute = null },
                new Function { Name="cutText",                       OnCompile = null,	OnExecute = null },
                new Function { Name="damage",                        OnCompile = null,	OnExecute = null },
                new Function { Name="date",                          OnCompile = null,	OnExecute = null },
                new Function { Name="dateToNumber",                  OnCompile = null,	OnExecute = null },
                new Function { Name="daytime",                       OnCompile = null,	OnExecute = null },
                new Function { Name="debugLog",                      OnCompile = null,	OnExecute = null },
                new Function { Name="default",                       OnCompile = null,	OnExecute = null },
                new Function { Name="deg",                           OnCompile = null,	OnExecute = null },
                new Function { Name="deleteCenter",                  OnCompile = null,	OnExecute = null },
                new Function { Name="deleteCollection",              OnCompile = null,	OnExecute = null },
                new Function { Name="deleteEditorObject",            OnCompile = null,	OnExecute = null },
                new Function { Name="deleteGroup",                   OnCompile = null,	OnExecute = null },
                new Function { Name="deleteIdentity",                OnCompile = null,	OnExecute = null },
                new Function { Name="deleteLocation",                OnCompile = null,	OnExecute = null },
                new Function { Name="deleteMarker",                  OnCompile = null,	OnExecute = null },
                new Function { Name="deleteMarkerLocal",             OnCompile = null,	OnExecute = null },
                new Function { Name="deleteResources",               OnCompile = null,	OnExecute = null },
                new Function { Name="deleteStatus",                  OnCompile = null,	OnExecute = null },
                new Function { Name="deleteTarget",                  OnCompile = null,	OnExecute = null },
                new Function { Name="deleteTeam",                    OnCompile = null,	OnExecute = null },
                new Function { Name="deleteVehicle",                 OnCompile = null,	OnExecute = null },
                new Function { Name="deleteWaypoint",                OnCompile = null,	OnExecute = null },
                new Function { Name="detach",                        OnCompile = null,	OnExecute = null },
                new Function { Name="diag_fps",                      OnCompile = null,	OnExecute = null },
                new Function { Name="diag_fpsmin",                   OnCompile = null,	OnExecute = null },
                new Function { Name="diag_frameno",                  OnCompile = null,	OnExecute = null },
                new Function { Name="diag_log",                      OnCompile = null,	OnExecute = null },
                new Function { Name="diag_tickTime",                 OnCompile = null,	OnExecute = null },
                new Function { Name="dialog",                        OnCompile = null,	OnExecute = null },
                new Function { Name="diarySubjectExists",            OnCompile = null,	OnExecute = null },
                new Function { Name="difficultyEnabled",             OnCompile = null,	OnExecute = null },
                new Function { Name="direction",                     OnCompile = null,	OnExecute = null },
                new Function { Name="directSay",                     OnCompile = null,	OnExecute = null },
                new Function { Name="disableAI",                     OnCompile = null,	OnExecute = null },
                new Function { Name="disableConversation",           OnCompile = null,	OnExecute = null },
                new Function { Name="disableSerialization",          OnCompile = null,	OnExecute = null },
                new Function { Name="disableTIEquipment",            OnCompile = null,	OnExecute = null },
                new Function { Name="disableUserInput",              OnCompile = null,	OnExecute = null },
                new Function { Name="displayAddEventHandler",        OnCompile = null,	OnExecute = null },
                new Function { Name="displayCtrl",                   OnCompile = null,	OnExecute = null },
                new Function { Name="displayNull",                   OnCompile = null,	OnExecute = null },
                new Function { Name="displayRemoveAllEventHandlers", OnCompile = null,	OnExecute = null },
                new Function { Name="displayRemoveEventHandler",     OnCompile = null,	OnExecute = null },
                new Function { Name="displaySetEventHandler",        OnCompile = null,	OnExecute = null },
                new Function { Name="dissolveTeam",                  OnCompile = null,	OnExecute = null },
                new Function { Name="distance",                      OnCompile = null,	OnExecute = null },
                new Function { Name="distributionRegion",            OnCompile = null,	OnExecute = null },
                new Function { Name="do",                            OnCompile = null,	OnExecute = null },
                new Function { Name="doFire",                        OnCompile = null,	OnExecute = null },
                new Function { Name="doFollow",                      OnCompile = null,	OnExecute = null },
                new Function { Name="doFSM",                         OnCompile = null,	OnExecute = null },
                new Function { Name="doGetOut",                      OnCompile = null,	OnExecute = null },
                new Function { Name="doMove",                        OnCompile = null,	OnExecute = null },
                new Function { Name="doStop",                        OnCompile = null,	OnExecute = null },
                new Function { Name="doTarget",                      OnCompile = null,	OnExecute = null },
                new Function { Name="doWatch",                       OnCompile = null,	OnExecute = null },
                new Function { Name="drawArrow",                     OnCompile = null,	OnExecute = null },
                new Function { Name="drawEllipse",                   OnCompile = null,	OnExecute = null },
                new Function { Name="drawIcon",                      OnCompile = null,	OnExecute = null },
                new Function { Name="drawLine",                      OnCompile = null,	OnExecute = null },
                new Function { Name="drawLink",                      OnCompile = null,	OnExecute = null },
                new Function { Name="drawLocation",                  OnCompile = null,	OnExecute = null },
                new Function { Name="drawRectangle",                 OnCompile = null,	OnExecute = null },
                new Function { Name="driver",                        OnCompile = null,	OnExecute = null },
                new Function { Name="drop",                          OnCompile = null,	OnExecute = null },
                new Function { Name="east",                          OnCompile = null,	OnExecute = null },
                new Function { Name="echo",                          OnCompile = null,	OnExecute = null },
                new Function { Name="editObject",                    OnCompile = null,	OnExecute = null },
                new Function { Name="editorSetEventHandler",         OnCompile = null,	OnExecute = null },
                new Function { Name="effectiveCommander",            OnCompile = null,	OnExecute = null },
                new Function { Name="else",                          OnCompile = null,	OnExecute = null },
                new Function { Name="emptyPositions",                OnCompile = null,	OnExecute = null },
                new Function { Name="enableAI",                      OnCompile = null,	OnExecute = null },
                new Function { Name="enableAIFeature",               OnCompile = null,	OnExecute = null },
                new Function { Name="enableAttack",                  OnCompile = null,	OnExecute = null },
                new Function { Name="enableCamShake",                OnCompile = null,	OnExecute = null },
                new Function { Name="enableEndDialog",               OnCompile = null,	OnExecute = null },
                new Function { Name="enableEngineArtillery",         OnCompile = null,	OnExecute = null },
                new Function { Name="enableEnvironment",             OnCompile = null,	OnExecute = null },
                new Function { Name="enableGunLights",               OnCompile = null,	OnExecute = null },
                new Function { Name="enableIRLasers",                OnCompile = null,	OnExecute = null },
                new Function { Name="enableRadio",                   OnCompile = null,	OnExecute = null },
                new Function { Name="enableReload",                  OnCompile = null,	OnExecute = null },
                new Function { Name="enableSaving",                  OnCompile = null,	OnExecute = null },
                new Function { Name="enableSentences",               OnCompile = null,	OnExecute = null },
                new Function { Name="enableSimulation",              OnCompile = null,	OnExecute = null },
                new Function { Name="enableTeamSwitch",              OnCompile = null,	OnExecute = null },
                new Function { Name="endLoadingScreen",              OnCompile = null,	OnExecute = null },
                new Function { Name="endMission",                    OnCompile = null,	OnExecute = null },
                new Function { Name="enemy",                         OnCompile = null,	OnExecute = null },
                new Function { Name="engineOn",                      OnCompile = null,	OnExecute = null },
                new Function { Name="estimatedEndServerTime",        OnCompile = null,	OnExecute = null },
                new Function { Name="estimatedTimeLeft",             OnCompile = null,	OnExecute = null },
                new Function { Name="evalObjectArgument",            OnCompile = null,	OnExecute = null },
                new Function { Name="exec",                          OnCompile = null,	OnExecute = null },
                new Function { Name="execEditorScript",              OnCompile = null,	OnExecute = null },
                new Function { Name="execFSM",                       OnCompile = null,	OnExecute = null },
                new Function { Name="execVM",                        OnCompile = null,	OnExecute = null },
                new Function { Name="exit",                          OnCompile = null,	OnExecute = null },
                new Function { Name="exitWith",                      OnCompile = null,	OnExecute = null },
                new Function { Name="exp",                           OnCompile = null,	OnExecute = null },
                new Function { Name="expectedDestination",           OnCompile = null,	OnExecute = null },
                new Function { Name="exportLandscapeXYZ",            OnCompile = null,	OnExecute = null },
                new Function { Name="faction",                       OnCompile = null,	OnExecute = null },
                new Function { Name="fadeMusic",                     OnCompile = null,	OnExecute = null },
                new Function { Name="fadeRadio",                     OnCompile = null,	OnExecute = null },
                new Function { Name="fadeSound",                     OnCompile = null,	OnExecute = null },
                new Function { Name="fadeSpeech",                    OnCompile = null,	OnExecute = null },
                new Function { Name="failMission",                   OnCompile = null,	OnExecute = null },
                new Function { Name="false",                         OnCompile = null,	OnExecute = null },
                new Function { Name="fillWeaponsFromPool",           OnCompile = null,	OnExecute = null },
                new Function { Name="find",                          OnCompile = null,	OnExecute = null },
                new Function { Name="findCover",                     OnCompile = null,	OnExecute = null },
                new Function { Name="findDisplay",                   OnCompile = null,	OnExecute = null },
                new Function { Name="findEditorObject",              OnCompile = null,	OnExecute = null },
                new Function { Name="findEmptyPosition",             OnCompile = null,	OnExecute = null },
                new Function { Name="findEmptyPositionReady",        OnCompile = null,	OnExecute = null },
                new Function { Name="findNearestEnemy",              OnCompile = null,	OnExecute = null },
                new Function { Name="finishMissionInit",             OnCompile = null,	OnExecute = null },
                new Function { Name="finite",                        OnCompile = null,	OnExecute = null },
                new Function { Name="fire",                          OnCompile = null,	OnExecute = null },
                new Function { Name="fireAtTarget",                  OnCompile = null,	OnExecute = null },
                new Function { Name="flag",                          OnCompile = null,	OnExecute = null },
                new Function { Name="flagOwner",                     OnCompile = null,	OnExecute = null },
                new Function { Name="fleeing",                       OnCompile = null,	OnExecute = null },
                new Function { Name="floor",                         OnCompile = null,	OnExecute = null },
                new Function { Name="flyInHeight",                   OnCompile = null,	OnExecute = null },
                new Function { Name="fog",                           OnCompile = null,	OnExecute = null },
                new Function { Name="fogForecast",                   OnCompile = null,	OnExecute = null },
                new Function { Name="for",                           OnCompile = null,	OnExecute = null },
                new Function { Name="forceEnd",                      OnCompile = null,	OnExecute = null },
                new Function { Name="forceMap",                      OnCompile = null,	OnExecute = null },
                new Function { Name="forceSpeed",                    OnCompile = null,	OnExecute = null },
                new Function { Name="forceWalk",                     OnCompile = null,	OnExecute = null },
                new Function { Name="forEach",                       OnCompile = null,	OnExecute = null },
                new Function { Name="forEachMember",                 OnCompile = null,	OnExecute = null },
                new Function { Name="forEachMemberAgent",            OnCompile = null,	OnExecute = null },
                new Function { Name="forEachMemberTeam",             OnCompile = null,	OnExecute = null },
                new Function { Name="format",                        OnCompile = null,	OnExecute = null },
                new Function { Name="formation",                     OnCompile = null,	OnExecute = null },
                new Function { Name="formationDirection",            OnCompile = null,	OnExecute = null },
                new Function { Name="formationLeader",               OnCompile = null,	OnExecute = null },
                new Function { Name="formationMembers",              OnCompile = null,	OnExecute = null },
                new Function { Name="formationPosition",             OnCompile = null,	OnExecute = null },
                new Function { Name="formationTask",                 OnCompile = null,	OnExecute = null },
                new Function { Name="formatText",                    OnCompile = null,	OnExecute = null },
                new Function { Name="formLeader",                    OnCompile = null,	OnExecute = null },
                new Function { Name="friendly",                      OnCompile = null,	OnExecute = null },
                new Function { Name="from",                          OnCompile = null,	OnExecute = null },
                new Function { Name="fromEditor",                    OnCompile = null,	OnExecute = null },
                new Function { Name="fuel",                          OnCompile = null,	OnExecute = null },
                new Function { Name="gearSlotData",                  OnCompile = null,	OnExecute = null },
                new Function { Name="getArray",                      OnCompile = null,	OnExecute = null },
                new Function { Name="getBackpackCargo",              OnCompile = null,	OnExecute = null },
                new Function { Name="getDammage",                    OnCompile = null,	OnExecute = null },
                new Function { Name="getDir",                        OnCompile = null,	OnExecute = null },
                new Function { Name="getEditorCamera",               OnCompile = null,	OnExecute = null },
                new Function { Name="getEditorMode",                 OnCompile = null,	OnExecute = null },
                new Function { Name="getEditorObjectScope",          OnCompile = null,	OnExecute = null },
                new Function { Name="getElevationOffset",            OnCompile = null,	OnExecute = null },
                new Function { Name="getFriend",                     OnCompile = null,	OnExecute = null },
                new Function { Name="getFSMVariable",                OnCompile = null,	OnExecute = null },
                new Function { Name="getGroupIcon",                  OnCompile = null,	OnExecute = null },
                new Function { Name="getGroupIconParams",            OnCompile = null,	OnExecute = null },
                new Function { Name="getGroupIcons",                 OnCompile = null,	OnExecute = null },
                new Function { Name="getHideFrom",                   OnCompile = null,	OnExecute = null },
                new Function { Name="getMagazineCargo",              OnCompile = null,	OnExecute = null },
                new Function { Name="getMarkerColor",                OnCompile = null,	OnExecute = null },
                new Function { Name="getMarkerPos",                  OnCompile = null,	OnExecute = null },
                new Function { Name="getMarkerSize",                 OnCompile = null,	OnExecute = null },
                new Function { Name="getMarkerType",                 OnCompile = null,	OnExecute = null },
                new Function { Name="getNumber",                     OnCompile = null,	OnExecute = null },
                new Function { Name="getObjectArgument",             OnCompile = null,	OnExecute = null },
                new Function { Name="getObjectChildren",             OnCompile = null,	OnExecute = null },
                new Function { Name="getObjectProxy",                OnCompile = null,	OnExecute = null },
                new Function { Name="getPlayerUID",                  OnCompile = null,	OnExecute = null },
                new Function { Name="getPos",                        OnCompile = null,	OnExecute = null },
                new Function { Name="getPosASL",                     OnCompile = null,	OnExecute = null },
                new Function { Name="getPosATL",                     OnCompile = null,	OnExecute = null },
                new Function { Name="getResolution",                 OnCompile = null,	OnExecute = null },
                new Function { Name="getSpeed",                      OnCompile = null,	OnExecute = null },
                new Function { Name="getTerrainHeightASL",           OnCompile = null,	OnExecute = null },
                new Function { Name="getText",                       OnCompile = null,	OnExecute = null },
                new Function { Name="getVariable",                   OnCompile = null,	OnExecute = null },
                new Function { Name="getWeaponCargo",                OnCompile = null,	OnExecute = null },
                new Function { Name="getWPPos",                      OnCompile = null,	OnExecute = null },
                new Function { Name="glanceAt",                      OnCompile = null,	OnExecute = null },
                new Function { Name="globalChat",                    OnCompile = null,	OnExecute = null },
                new Function { Name="globalRadio",                   OnCompile = null,	OnExecute = null },
                new Function { Name="goto",                          OnCompile = null,	OnExecute = null },
                new Function { Name="group",                         OnCompile = null,	OnExecute = null },
                new Function { Name="groupChat",                     OnCompile = null,	OnExecute = null },
                new Function { Name="groupIconSelectable",           OnCompile = null,	OnExecute = null },
                new Function { Name="groupIconsVisible",             OnCompile = null,	OnExecute = null },
                new Function { Name="groupRadio",                    OnCompile = null,	OnExecute = null },
                new Function { Name="groupSelectedUnits",            OnCompile = null,	OnExecute = null },
                new Function { Name="groupSelectUnit",               OnCompile = null,	OnExecute = null },
                new Function { Name="grpNull",                       OnCompile = null,	OnExecute = null },
                new Function { Name="gunner",                        OnCompile = null,	OnExecute = null },
                new Function { Name="halt",                          OnCompile = null,	OnExecute = null },
                new Function { Name="handsHit",                      OnCompile = null,	OnExecute = null },
                new Function { Name="hasWeapon",                     OnCompile = null,	OnExecute = null },
                new Function { Name="hcAllGroups",                   OnCompile = null,	OnExecute = null },
                new Function { Name="hcGroupParams",                 OnCompile = null,	OnExecute = null },
                new Function { Name="hcLeader",                      OnCompile = null,	OnExecute = null },
                new Function { Name="hcRemoveAllGroups",             OnCompile = null,	OnExecute = null },
                new Function { Name="hcRemoveGroup",                 OnCompile = null,	OnExecute = null },
                new Function { Name="hcSelected",                    OnCompile = null,	OnExecute = null },
                new Function { Name="hcSelectGroup",                 OnCompile = null,	OnExecute = null },
                new Function { Name="hcSetGroup",                    OnCompile = null,	OnExecute = null },
                new Function { Name="hcShowBar",                     OnCompile = null,	OnExecute = null },
                new Function { Name="hcShownBar",                    OnCompile = null,	OnExecute = null },
                new Function { Name="hideBehindScripted",            OnCompile = null,	OnExecute = null },
                new Function { Name="hideBody",                      OnCompile = null,	OnExecute = null },
                new Function { Name="hideObject",                    OnCompile = null,	OnExecute = null },
                new Function { Name="hierarchyObjectsCount",         OnCompile = null,	OnExecute = null },
                new Function { Name="hint",                          OnCompile = null,	OnExecute = null },
                new Function { Name="hintC",                         OnCompile = null,	OnExecute = null },
                new Function { Name="hintCadet",                     OnCompile = null,	OnExecute = null },
                new Function { Name="hintSilent",                    OnCompile = null,	OnExecute = null },
                new Function { Name="hostMission",                   OnCompile = null,	OnExecute = null },
                new Function { Name="htmlLoad",                      OnCompile = null,	OnExecute = null },
                new Function { Name="if",                            OnCompile = null,	OnExecute = null },
                new Function { Name="image",                         OnCompile = null,	OnExecute = null },
                new Function { Name="importAllGroups",               OnCompile = null,	OnExecute = null },
                new Function { Name="importance",                    OnCompile = null,	OnExecute = null },
                new Function { Name="in",                            OnCompile = null,	OnExecute = null },
                new Function { Name="inflame",                       OnCompile = null,	OnExecute = null },
                new Function { Name="inflamed",                      OnCompile = null,	OnExecute = null },
                new Function { Name="inGameUISetEventHandler",       OnCompile = null,	OnExecute = null },
                new Function { Name="inheritsFrom",                  OnCompile = null,	OnExecute = null },
                new Function { Name="initAmbientLife",               OnCompile = null,	OnExecute = null },
                new Function { Name="inputAction",                   OnCompile = null,	OnExecute = null },
                new Function { Name="insertEditorObject",            OnCompile = null,	OnExecute = null },
                new Function { Name="intersect",                     OnCompile = null,	OnExecute = null },
                new Function { Name="isAgent",                       OnCompile = null,	OnExecute = null },
                new Function { Name="isArray",                       OnCompile = null,	OnExecute = null },
                new Function { Name="isAutoHoverOn",                 OnCompile = null,	OnExecute = null },
                new Function { Name="isClass",                       OnCompile = null,	OnExecute = null },
                new Function { Name="isDedicated",                   OnCompile = null,	OnExecute = null },
                new Function { Name="isEngineOn",                    OnCompile = null,	OnExecute = null },
                new Function { Name="isFlatEmpty",                   OnCompile = null,	OnExecute = null },
                new Function { Name="isForcedWalk",                  OnCompile = null,	OnExecute = null },
                new Function { Name="isFormationLeader",             OnCompile = null,	OnExecute = null },
                new Function { Name="isHidden",                      OnCompile = null,	OnExecute = null },
                new Function { Name="isHideBehindScripted",          OnCompile = null,	OnExecute = null },
                new Function { Name="isKeyActive",                   OnCompile = null,	OnExecute = null },
                new Function { Name="isKindOf",                      OnCompile = null,	OnExecute = null },
                new Function { Name="isManualFire",                  OnCompile = null,	OnExecute = null },
                new Function { Name="isMarkedForCollection",         OnCompile = null,	OnExecute = null },
                new Function { Name="isMultiplayer",                 OnCompile = null,	OnExecute = null },
                new Function { Name="isNil",                         OnCompile = null,	OnExecute = null },
                new Function { Name="isNull",                        OnCompile = null,	OnExecute = null },
                new Function { Name="isNumber",                      OnCompile = null,	OnExecute = null },
                new Function { Name="isOnRoad",                      OnCompile = null,	OnExecute = null },
                new Function { Name="isPlayer",                      OnCompile = null,	OnExecute = null },
                new Function { Name="isRealTime",                    OnCompile = null,	OnExecute = null },
                new Function { Name="isServer",                      OnCompile = null,	OnExecute = null },
                new Function { Name="isShowing3DIcons",              OnCompile = null,	OnExecute = null },
                new Function { Name="isText",                        OnCompile = null,	OnExecute = null },
                new Function { Name="isWalking",                     OnCompile = null,	OnExecute = null },
                new Function { Name="items",                         OnCompile = null,	OnExecute = null },
                new Function { Name="join",                          OnCompile = null,	OnExecute = null },
                new Function { Name="joinAs",                        OnCompile = null,	OnExecute = null },
                new Function { Name="joinAsSilent",                  OnCompile = null,	OnExecute = null },
                new Function { Name="joinSilent",                    OnCompile = null,	OnExecute = null },
                new Function { Name="kbAddDatabase",                 OnCompile = null,	OnExecute = null },
                new Function { Name="kbAddDatabaseTargets",          OnCompile = null,	OnExecute = null },
                new Function { Name="kbAddTopic",                    OnCompile = null,	OnExecute = null },
                new Function { Name="kbHasTopic",                    OnCompile = null,	OnExecute = null },
                new Function { Name="kbReact",                       OnCompile = null,	OnExecute = null },
                new Function { Name="kbRemoveTopic",                 OnCompile = null,	OnExecute = null },
                new Function { Name="kbTell",                        OnCompile = null,	OnExecute = null },
                new Function { Name="kbWasSaid",                     OnCompile = null,	OnExecute = null },
                new Function { Name="keyImage",                      OnCompile = null,	OnExecute = null },
                new Function { Name="keyName",                       OnCompile = null,	OnExecute = null },
                new Function { Name="knowsAbout",                    OnCompile = null,	OnExecute = null },
                new Function { Name="land",                          OnCompile = null,	OnExecute = null },
                new Function { Name="landAt",                        OnCompile = null,	OnExecute = null },
                new Function { Name="landResult",                    OnCompile = null,	OnExecute = null },
                new Function { Name="laserTarget",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lbAdd",                         OnCompile = null,	OnExecute = null },
                new Function { Name="lbClear",                       OnCompile = null,	OnExecute = null },
                new Function { Name="lbColor",                       OnCompile = null,	OnExecute = null },
                new Function { Name="lbCurSel",                      OnCompile = null,	OnExecute = null },
                new Function { Name="lbData",                        OnCompile = null,	OnExecute = null },
                new Function { Name="lbDelete",                      OnCompile = null,	OnExecute = null },
                new Function { Name="lbIsSelected",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lbPicture",                     OnCompile = null,	OnExecute = null },
                new Function { Name="lbSelection",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lbSetColor",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lbSetCurSel",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lbSetData",                     OnCompile = null,	OnExecute = null },
                new Function { Name="lbSetPicture",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lbSetSelected",                 OnCompile = null,	OnExecute = null },
                new Function { Name="lbSetValue",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lbSize",                        OnCompile = null,	OnExecute = null },
                new Function { Name="lbSort",                        OnCompile = null,	OnExecute = null },
                new Function { Name="lbSortByValue",                 OnCompile = null,	OnExecute = null },
                new Function { Name="lbText",                        OnCompile = null,	OnExecute = null },
                new Function { Name="lbValue",                       OnCompile = null,	OnExecute = null },
                new Function { Name="leader",                        OnCompile = null,	OnExecute = null },
                new Function { Name="leaveVehicle",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lifeState",                     OnCompile = null,	OnExecute = null },
                new Function { Name="lightAttachObject",             OnCompile = null,	OnExecute = null },
                new Function { Name="lightDetachObject",             OnCompile = null,	OnExecute = null },
                new Function { Name="lightIsOn",                     OnCompile = null,	OnExecute = null },
                new Function { Name="limitSpeed",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lineBreak",                     OnCompile = null,	OnExecute = null },
                new Function { Name="list",                          OnCompile = null,	OnExecute = null },
                new Function { Name="listObjects",                   OnCompile = null,	OnExecute = null },
                new Function { Name="ln",                            OnCompile = null,	OnExecute = null },
                new Function { Name="lnbAddArray",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lnbAddColumn",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lnbAddRow",                     OnCompile = null,	OnExecute = null },
                new Function { Name="lnbClear",                      OnCompile = null,	OnExecute = null },
                new Function { Name="lnbColor",                      OnCompile = null,	OnExecute = null },
                new Function { Name="lnbCurSelRow",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lnbData",                       OnCompile = null,	OnExecute = null },
                new Function { Name="lnbDeleteColumn",               OnCompile = null,	OnExecute = null },
                new Function { Name="lnbDeleteRow",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lnbGetColumnsPosition",         OnCompile = null,	OnExecute = null },
                new Function { Name="lnbPicture",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSetColor",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lnbsetColumnsPos",              OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSetCurSelRow",               OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSetData",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSetPicture",                 OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSetText",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSetValue",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lnbSize",                       OnCompile = null,	OnExecute = null },
                new Function { Name="lnbText",                       OnCompile = null,	OnExecute = null },
                new Function { Name="lnbValue",                      OnCompile = null,	OnExecute = null },
                new Function { Name="loadFile",                      OnCompile = null,	OnExecute = null },
                new Function { Name="loadGame",                      OnCompile = null,	OnExecute = null },
                new Function { Name="loadIdentity",                  OnCompile = null,	OnExecute = null },
                new Function { Name="loadOverlay",                   OnCompile = null,	OnExecute = null },
                new Function { Name="loadStatus",                    OnCompile = null,	OnExecute = null },
                new Function { Name="local",                         OnCompile = null,	OnExecute = null },
                new Function { Name="localize",                      OnCompile = null,	OnExecute = null },
                new Function { Name="locationNull",                  OnCompile = null,	OnExecute = null },
                new Function { Name="locationPosition",              OnCompile = null,	OnExecute = null },
                new Function { Name="lock",                          OnCompile = null,	OnExecute = null },
                new Function { Name="lockCargo",                     OnCompile = null,	OnExecute = null },
                new Function { Name="lockDriver",                    OnCompile = null,	OnExecute = null },
                new Function { Name="locked",                        OnCompile = null,	OnExecute = null },
                new Function { Name="lockedCargo",                   OnCompile = null,	OnExecute = null },
                new Function { Name="lockedDriver",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lockedTurret",                  OnCompile = null,	OnExecute = null },
                new Function { Name="lockTurret",                    OnCompile = null,	OnExecute = null },
                new Function { Name="lockWP",                        OnCompile = null,	OnExecute = null },
                new Function { Name="log",                           OnCompile = null,	OnExecute = null },
                new Function { Name="lookAt",                        OnCompile = null,	OnExecute = null },
                new Function { Name="lookAtPos",                     OnCompile = null,	OnExecute = null },
                new Function { Name="magazines",                     OnCompile = null,	OnExecute = null },
                new Function { Name="magazinesTurret",               OnCompile = null,	OnExecute = null },
                new Function { Name="mapAnimAdd",                    OnCompile = null,	OnExecute = null },
                new Function { Name="mapAnimClear",                  OnCompile = null,	OnExecute = null },
                new Function { Name="mapAnimCommit",                 OnCompile = null,	OnExecute = null },
                new Function { Name="mapAnimDone",                   OnCompile = null,	OnExecute = null },
                new Function { Name="mapCenterOnCamera",             OnCompile = null,	OnExecute = null },
                new Function { Name="mapGridPosition",               OnCompile = null,	OnExecute = null },
                new Function { Name="markerAlpha",                   OnCompile = null,	OnExecute = null },
                new Function { Name="markerBrush",                   OnCompile = null,	OnExecute = null },
                new Function { Name="markerColor",                   OnCompile = null,	OnExecute = null },
                new Function { Name="markerDir",                     OnCompile = null,	OnExecute = null },
                new Function { Name="markerPos",                     OnCompile = null,	OnExecute = null },
                new Function { Name="markerShape",                   OnCompile = null,	OnExecute = null },
                new Function { Name="markerSize",                    OnCompile = null,	OnExecute = null },
                new Function { Name="markerText",                    OnCompile = null,	OnExecute = null },
                new Function { Name="markerType",                    OnCompile = null,	OnExecute = null },
                new Function { Name="max",                           OnCompile = null,	OnExecute = null },
                new Function { Name="members",                       OnCompile = null,	OnExecute = null },
                new Function { Name="min",                           OnCompile = null,	OnExecute = null },
                new Function { Name="missionConfigFile",             OnCompile = null,	OnExecute = null },
                new Function { Name="missionName",                   OnCompile = null,	OnExecute = null },
                new Function { Name="missionNamespace",              OnCompile = null,	OnExecute = null },
                new Function { Name="missionStart",                  OnCompile = null,	OnExecute = null },
                new Function { Name="mod",                           OnCompile = null,	OnExecute = null },
                new Function { Name="modelToWorld",                  OnCompile = null,	OnExecute = null },
                new Function { Name="morale",                        OnCompile = null,	OnExecute = null },
                new Function { Name="move",                          OnCompile = null,	OnExecute = null },
                new Function { Name="moveInCargo",                   OnCompile = null,	OnExecute = null },
                new Function { Name="moveInCommander",               OnCompile = null,	OnExecute = null },
                new Function { Name="moveInDriver",                  OnCompile = null,	OnExecute = null },
                new Function { Name="moveInGunner",                  OnCompile = null,	OnExecute = null },
                new Function { Name="moveInTurret",                  OnCompile = null,	OnExecute = null },
                new Function { Name="moveObjectToEnd",               OnCompile = null,	OnExecute = null },
                new Function { Name="moveOut",                       OnCompile = null,	OnExecute = null },
                new Function { Name="moveTarget",                    OnCompile = null,	OnExecute = null },
                new Function { Name="moveTime",                      OnCompile = null,	OnExecute = null },
                new Function { Name="moveTo",                        OnCompile = null,	OnExecute = null },
                new Function { Name="moveToCompleted",               OnCompile = null,	OnExecute = null },
                new Function { Name="moveToFailed",                  OnCompile = null,	OnExecute = null },
                new Function { Name="musicVolume",                   OnCompile = null,	OnExecute = null },
                new Function { Name="name",                          OnCompile = null,	OnExecute = null },
                new Function { Name="nearEntities",                  OnCompile = null,	OnExecute = null },
                new Function { Name="nearestBuilding",               OnCompile = null,	OnExecute = null },
                new Function { Name="nearestLocation",               OnCompile = null,	OnExecute = null },
                new Function { Name="nearestLocations",              OnCompile = null,	OnExecute = null },
                new Function { Name="nearestLocationWithDubbing",    OnCompile = null,	OnExecute = null },
                new Function { Name="nearestObject",                 OnCompile = null,	OnExecute = null },
                new Function { Name="nearestObjects",                OnCompile = null,	OnExecute = null },
                new Function { Name="nearObjects",                   OnCompile = null,	OnExecute = null },
                new Function { Name="nearObjectsReady",              OnCompile = null,	OnExecute = null },
                new Function { Name="nearRoads",                     OnCompile = null,	OnExecute = null },
                new Function { Name="nearTargets",                   OnCompile = null,	OnExecute = null },
                new Function { Name="needReload",                    OnCompile = null,	OnExecute = null },
                new Function { Name="newOverlay",                    OnCompile = null,	OnExecute = null },
                new Function { Name="nextMenuItemIndex",             OnCompile = null,	OnExecute = null },
                new Function { Name="nextWeatherChange",             OnCompile = null,	OnExecute = null },
                new Function { Name="nil",                           OnCompile = null,	OnExecute = null },
                new Function { Name="nMenuItems",                    OnCompile = null,	OnExecute = null },
                new Function { Name="not",                           OnCompile = null,	OnExecute = null },
                new Function { Name="NumberToDate",                  OnCompile = null,	OnExecute = null },
                new Function { Name="object",                        OnCompile = null,	OnExecute = null },
                new Function { Name="objNull",                       OnCompile = null,	OnExecute = null },
                new Function { Name="objStatus",                     OnCompile = null,	OnExecute = null },
                new Function { Name="onBriefingGear",                OnCompile = null,	OnExecute = null },
                new Function { Name="onBriefingGroup",               OnCompile = null,	OnExecute = null },
                new Function { Name="onBriefingNotes",               OnCompile = null,	OnExecute = null },
                new Function { Name="onBriefingPlan",                OnCompile = null,	OnExecute = null },
                new Function { Name="onBriefingTeamSwitch",          OnCompile = null,	OnExecute = null },
                new Function { Name="onCommandModeChanged",          OnCompile = null,	OnExecute = null },
                new Function { Name="onDoubleClick",                 OnCompile = null,	OnExecute = null },
                new Function { Name="onGroupIconClick",              OnCompile = null,	OnExecute = null },
                new Function { Name="onGroupIconOverEnter",          OnCompile = null,	OnExecute = null },
                new Function { Name="onGroupIconOverLeave",          OnCompile = null,	OnExecute = null },
                new Function { Name="onHCGroupSelectionChanged",     OnCompile = null,	OnExecute = null },
                new Function { Name="onMapSingleClick",              OnCompile = null,	OnExecute = null },
                new Function { Name="onPlayerConnected",             OnCompile = null,	OnExecute = null },
                new Function { Name="onPlayerDisconnected",          OnCompile = null,	OnExecute = null },
                new Function { Name="onPreloadFinished",             OnCompile = null,	OnExecute = null },
                new Function { Name="onPreloadStarted",              OnCompile = null,	OnExecute = null },
                new Function { Name="onShowNewObject",               OnCompile = null,	OnExecute = null },
                new Function { Name="onTeamSwitch",                  OnCompile = null,	OnExecute = null },
                new Function { Name="openDSInterface",               OnCompile = null,	OnExecute = null },
                new Function { Name="openMap",                       OnCompile = null,	OnExecute = null },
                new Function { Name="or",                            OnCompile = null,	OnExecute = null },
                new Function { Name="orderGetIn",                    OnCompile = null,	OnExecute = null },
                new Function { Name="overcast",                      OnCompile = null,	OnExecute = null },
                new Function { Name="overcastForecast",              OnCompile = null,	OnExecute = null },
                new Function { Name="owner",                         OnCompile = null,	OnExecute = null },
                new Function { Name="parseNumber",                   OnCompile = null,	OnExecute = null },
                new Function { Name="parseText",                     OnCompile = null,	OnExecute = null },
                new Function { Name="parsingNamespace",              OnCompile = null,	OnExecute = null },
                new Function { Name="pi",                            OnCompile = null,	OnExecute = null },
                new Function { Name="pickWeaponPool",                OnCompile = null,	OnExecute = null },
                new Function { Name="playableUnits",                 OnCompile = null,	OnExecute = null },
                new Function { Name="playAction",                    OnCompile = null,	OnExecute = null },
                new Function { Name="playActionNow",                 OnCompile = null,	OnExecute = null },
                new Function { Name="player",                        OnCompile = null,	OnExecute = null },
                new Function { Name="playerRespawnTime",             OnCompile = null,	OnExecute = null },
                new Function { Name="playerSide",                    OnCompile = null,	OnExecute = null },
                new Function { Name="playersNumber",                 OnCompile = null,	OnExecute = null },
                new Function { Name="playGesture",                   OnCompile = null,	OnExecute = null },
                new Function { Name="playMission",                   OnCompile = null,	OnExecute = null },
                new Function { Name="playMove",                      OnCompile = null,	OnExecute = null },
                new Function { Name="playMoveNow",                   OnCompile = null,	OnExecute = null },
                new Function { Name="playMusic",                     OnCompile = null,	OnExecute = null },
                new Function { Name="playScriptedMission",           OnCompile = null,	OnExecute = null },
                new Function { Name="playSound",                     OnCompile = null,	OnExecute = null },
                new Function { Name="position",                      OnCompile = null,	OnExecute = null },
                new Function { Name="posScreenToWorld",              OnCompile = null,	OnExecute = null },
                new Function { Name="positionCameraToWorld",         OnCompile = null,	OnExecute = null },
                new Function { Name="posWorldToScreen",              OnCompile = null,	OnExecute = null },
                new Function { Name="ppEffectAdjust",                OnCompile = null,	OnExecute = null },
                new Function { Name="ppEffectCommit",                OnCompile = null,	OnExecute = null },
                new Function { Name="ppEffectCommitted",             OnCompile = null,	OnExecute = null },
                new Function { Name="ppEffectCreate",                OnCompile = null,	OnExecute = null },
                new Function { Name="ppEffectDestroy",               OnCompile = null,	OnExecute = null },
                new Function { Name="ppEffectEnable",                OnCompile = null,	OnExecute = null },
                new Function { Name="precision",                     OnCompile = null,	OnExecute = null },
                new Function { Name="preloadCamera",                 OnCompile = null,	OnExecute = null },
                new Function { Name="preloadObject",                 OnCompile = null,	OnExecute = null },
                new Function { Name="preloadSound",                  OnCompile = null,	OnExecute = null },
                new Function { Name="preloadTitleObj",               OnCompile = null,	OnExecute = null },
                new Function { Name="preloadTitleRsc",               OnCompile = null,	OnExecute = null },
                new Function { Name="preprocessFile",                OnCompile = null,	OnExecute = null },
                new Function { Name="preprocessFileLineNumbers",     OnCompile = null,	OnExecute = null },
                new Function { Name="primaryWeapon",                 OnCompile = null,	OnExecute = null },
                new Function { Name="priority",                      OnCompile = null,	OnExecute = null },
                new Function { Name="private",                       OnCompile = null,	OnExecute = null },
                new Function { Name="processDiaryLink",              OnCompile = null,	OnExecute = null },
                new Function { Name="processInitCommands",           OnCompile = null,	OnExecute = null },
                new Function { Name="progressLoadingScreen",         OnCompile = null,	OnExecute = null },
                new Function { Name="progressPosition",              OnCompile = null,	OnExecute = null },
                new Function { Name="progressSetPosition",           OnCompile = null,	OnExecute = null },
                new Function { Name="publicVariable",                OnCompile = null,	OnExecute = null },
                new Function { Name="putWeaponPool",                 OnCompile = null,	OnExecute = null },
                new Function { Name="queryMagazinePool",             OnCompile = null,	OnExecute = null },
                new Function { Name="queryWeaponPool",               OnCompile = null,	OnExecute = null },
                new Function { Name="rad",                           OnCompile = null,	OnExecute = null },
                new Function { Name="radioVolume",                   OnCompile = null,	OnExecute = null },
                new Function { Name="rain",                          OnCompile = null,	OnExecute = null },
                new Function { Name="random",                        OnCompile = null,	OnExecute = null },
                new Function { Name="rank",                          OnCompile = null,	OnExecute = null },
                new Function { Name="rankId",                        OnCompile = null,	OnExecute = null },
                new Function { Name="rating",                        OnCompile = null,	OnExecute = null },
                new Function { Name="rectangular",                   OnCompile = null,	OnExecute = null },
                new Function { Name="registeredTasks",               OnCompile = null,	OnExecute = null },
                new Function { Name="registerTask",                  OnCompile = null,	OnExecute = null },
                new Function { Name="reload",                        OnCompile = null,	OnExecute = null },
                new Function { Name="reloadEnabled",                 OnCompile = null,	OnExecute = null },
                new Function { Name="remoteControl",                 OnCompile = null,	OnExecute = null },
                new Function { Name="removeAction",                  OnCompile = null,	OnExecute = null },
                new Function { Name="removeAllEventHandlers",        OnCompile = null,	OnExecute = null },
                new Function { Name="removeAllItems",                OnCompile = null,	OnExecute = null },
                new Function { Name="removeAllMPEventHandlers",      OnCompile = null,	OnExecute = null },
                new Function { Name="removeAllWeapons",              OnCompile = null,	OnExecute = null },
                new Function { Name="removeBackpack",                OnCompile = null,	OnExecute = null },
                new Function { Name="removeDrawIcon",                OnCompile = null,	OnExecute = null },
                new Function { Name="removeDrawLinks",               OnCompile = null,	OnExecute = null },
                new Function { Name="removeEventHandler",            OnCompile = null,	OnExecute = null },
                new Function { Name="removeGroupIcon",               OnCompile = null,	OnExecute = null },
                new Function { Name="removeMagazine",                OnCompile = null,	OnExecute = null },
                new Function { Name="removeMagazines",               OnCompile = null,	OnExecute = null },
                new Function { Name="removeMagazinesTurret",         OnCompile = null,	OnExecute = null },
                new Function { Name="removeMagazineTurret",          OnCompile = null,	OnExecute = null },
                new Function { Name="removeMenuItem",                OnCompile = null,	OnExecute = null },
                new Function { Name="removeMPEventHandler",          OnCompile = null,	OnExecute = null },
                new Function { Name="removeSimpleTask",              OnCompile = null,	OnExecute = null },
                new Function { Name="removeSwitchableUnit",          OnCompile = null,	OnExecute = null },
                new Function { Name="removeTeamMember",              OnCompile = null,	OnExecute = null },
                new Function { Name="removeWeapon",                  OnCompile = null,	OnExecute = null },
                new Function { Name="requiredVersion",               OnCompile = null,	OnExecute = null },
                new Function { Name="resetCamShake",                 OnCompile = null,	OnExecute = null },
                new Function { Name="resistance",                    OnCompile = null,	OnExecute = null },
                new Function { Name="resize",                        OnCompile = null,	OnExecute = null },
                new Function { Name="resources",                     OnCompile = null,	OnExecute = null },
                new Function { Name="respawnVehicle",                OnCompile = null,	OnExecute = null },
                new Function { Name="restartEditorCamera",           OnCompile = null,	OnExecute = null },
                new Function { Name="reveal",                        OnCompile = null,	OnExecute = null },
                new Function { Name="reversedMouseY",                OnCompile = null,	OnExecute = null },
                new Function { Name="roadsConnectedTo",              OnCompile = null,	OnExecute = null },
                new Function { Name="round",                         OnCompile = null,	OnExecute = null },
                new Function { Name="runInitScript",                 OnCompile = null,	OnExecute = null },
                new Function { Name="safeZoneH",                     OnCompile = null,	OnExecute = null },
                new Function { Name="safeZoneW",                     OnCompile = null,	OnExecute = null },
                new Function { Name="safeZoneWAbs",                  OnCompile = null,	OnExecute = null },
                new Function { Name="safeZoneX",                     OnCompile = null,	OnExecute = null },
                new Function { Name="safeZoneXAbs",                  OnCompile = null,	OnExecute = null },
                new Function { Name="safeZoneY",                     OnCompile = null,	OnExecute = null },
                new Function { Name="saveGame",                      OnCompile = null,	OnExecute = null },
                new Function { Name="saveIdentity",                  OnCompile = null,	OnExecute = null },
                new Function { Name="saveOverlay",                   OnCompile = null,	OnExecute = null },
                new Function { Name="saveStatus",                    OnCompile = null,	OnExecute = null },
                new Function { Name="saveVar",                       OnCompile = null,	OnExecute = null },
                new Function { Name="savingEnabled",                 OnCompile = null,	OnExecute = null },
                new Function { Name="say",                           OnCompile = null,	OnExecute = null },
                new Function { Name="say2D",                         OnCompile = null,	OnExecute = null },
                new Function { Name="say3D",                         OnCompile = null,	OnExecute = null },
                new Function { Name="scopeName",                     OnCompile = null,	OnExecute = null },
                new Function { Name="score",                         OnCompile = null,	OnExecute = null },
                new Function { Name="scoreSide",                     OnCompile = null,	OnExecute = null },
                new Function { Name="screenToWorld",                 OnCompile = null,	OnExecute = null },
                new Function { Name="scriptDone",                    OnCompile = null,	OnExecute = null },
                new Function { Name="scriptName",                    OnCompile = null,	OnExecute = null },
                new Function { Name="scudState",                     OnCompile = null,	OnExecute = null },
                new Function { Name="secondaryWeapon",               OnCompile = null,	OnExecute = null },
                new Function { Name="select",                        OnCompile = null,	OnExecute = null },
                new Function { Name="selectBestPlaces",              OnCompile = null,	OnExecute = null },
                new Function { Name="selectDiarySubject",            OnCompile = null,	OnExecute = null },
                new Function { Name="selectedEditorObjects",         OnCompile = null,	OnExecute = null },
                new Function { Name="selectEditorObject",            OnCompile = null,	OnExecute = null },
                new Function { Name="selectionPosition",             OnCompile = null,	OnExecute = null },
                new Function { Name="selectLeader",                  OnCompile = null,	OnExecute = null },
                new Function { Name="selectNoPlayer",                OnCompile = null,	OnExecute = null },
                new Function { Name="selectPlayer",                  OnCompile = null,	OnExecute = null },
                new Function { Name="selectWeapon",                  OnCompile = null,	OnExecute = null },
                new Function { Name="sendSimpleCommand",             OnCompile = null,	OnExecute = null },
                new Function { Name="sendTask",                      OnCompile = null,	OnExecute = null },
                new Function { Name="sendTaskResult",                OnCompile = null,	OnExecute = null },
                new Function { Name="sendUDPMessage",                OnCompile = null,	OnExecute = null },
                new Function { Name="serverCommand",                 OnCompile = null,	OnExecute = null },
                new Function { Name="serverCommandAvailable",        OnCompile = null,	OnExecute = null },
                new Function { Name="serverTime",                    OnCompile = null,	OnExecute = null },
                new Function { Name="set",                           OnCompile = null,	OnExecute = null },
                new Function { Name="setAccTime",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setAirportSide",                OnCompile = null,	OnExecute = null },
                new Function { Name="setAmmoCargo",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setAperture",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setArmoryPoints",               OnCompile = null,	OnExecute = null },
                new Function { Name="setAttributes",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setBehaviour",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setCameraEffect",               OnCompile = null,	OnExecute = null },
                new Function { Name="setCameraInterest",             OnCompile = null,	OnExecute = null },
                new Function { Name="setCamShakeDefParams",          OnCompile = null,	OnExecute = null },
                new Function { Name="setCamShakeParams",             OnCompile = null,	OnExecute = null },
                new Function { Name="setCamUseTi",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setCaptive",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setCombatMode",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setCurrentTask",                OnCompile = null,	OnExecute = null },
                new Function { Name="setCurrentWaypoint",            OnCompile = null,	OnExecute = null },
                new Function { Name="setDamage",                     OnCompile = null,	OnExecute = null },
                new Function { Name="setDammage",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setDate",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setDestination",                OnCompile = null,	OnExecute = null },
                new Function { Name="setDir",                        OnCompile = null,	OnExecute = null },
                new Function { Name="setDirection",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setDrawIcon",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setDropInterval",               OnCompile = null,	OnExecute = null },
                new Function { Name="setEditorMode",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setEditorObjectScope",          OnCompile = null,	OnExecute = null },
                new Function { Name="setEffectCondition",            OnCompile = null,	OnExecute = null },
                new Function { Name="setFace",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setFaceAnimation",              OnCompile = null,	OnExecute = null },
                new Function { Name="setFlagOwner",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setFlagSide",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setFlagTexture",                OnCompile = null,	OnExecute = null },
                new Function { Name="setFog",                        OnCompile = null,	OnExecute = null },
                new Function { Name="setFormation",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setFormationTask",              OnCompile = null,	OnExecute = null },
                new Function { Name="setFormDir",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setFriend",                     OnCompile = null,	OnExecute = null },
                new Function { Name="setFromEditor",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setFSMVariable",                OnCompile = null,	OnExecute = null },
                new Function { Name="setFuel",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setFuelCargo",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setGroupIcon",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setGroupIconParams",            OnCompile = null,	OnExecute = null },
                new Function { Name="setGroupIconsSelectable",       OnCompile = null,	OnExecute = null },
                new Function { Name="setGroupIconsVisible",          OnCompile = null,	OnExecute = null },
                new Function { Name="setGroupId",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setHit",                        OnCompile = null,	OnExecute = null },
                new Function { Name="setHideBehind",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setIdentity",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setImportance",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setLeader",                     OnCompile = null,	OnExecute = null },
                new Function { Name="setLightAmbient",               OnCompile = null,	OnExecute = null },
                new Function { Name="setLightBrightness",            OnCompile = null,	OnExecute = null },
                new Function { Name="setLightColor",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerAlpha",                OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerAlphaLocal",           OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerBrush",                OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerBrushLocal",           OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerColor",                OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerColorLocal",           OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerDir",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerDirLocal",             OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerPos",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerPosLocal",             OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerShape",                OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerShapeLocal",           OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerSize",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerSizeLocal",            OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerText",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerTextLocal",            OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerType",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setMarkerTypeLocal",            OnCompile = null,	OnExecute = null },
                new Function { Name="setMimic",                      OnCompile = null,	OnExecute = null },
                new Function { Name="setMousePosition",              OnCompile = null,	OnExecute = null },
                new Function { Name="setMusicEffect",                OnCompile = null,	OnExecute = null },
                new Function { Name="setName",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setObjectArguments",            OnCompile = null,	OnExecute = null },
                new Function { Name="setObjectProxy",                OnCompile = null,	OnExecute = null },
                new Function { Name="setObjectTexture",              OnCompile = null,	OnExecute = null },
                new Function { Name="setOvercast",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setParticleCircle",             OnCompile = null,	OnExecute = null },
                new Function { Name="setParticleParams",             OnCompile = null,	OnExecute = null },
                new Function { Name="setParticleRandom",             OnCompile = null,	OnExecute = null },
                new Function { Name="setPlayable",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setPlayerRespawnTime",          OnCompile = null,	OnExecute = null },
                new Function { Name="setPos",                        OnCompile = null,	OnExecute = null },
                new Function { Name="setPosASL",                     OnCompile = null,	OnExecute = null },
                new Function { Name="setPosASL2",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setPosATL",                     OnCompile = null,	OnExecute = null },
                new Function { Name="setPosition",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setRadioMsg",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setRain",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setRank",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setRectangular",                OnCompile = null,	OnExecute = null },
                new Function { Name="setRepairCargo",                OnCompile = null,	OnExecute = null },
                new Function { Name="setSide",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setSimpleTaskDescription",      OnCompile = null,	OnExecute = null },
                new Function { Name="setSimpleTaskDestination",      OnCompile = null,	OnExecute = null },
                new Function { Name="setSimpleTaskTarget",           OnCompile = null,	OnExecute = null },
                new Function { Name="setSize",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setSoundEffect",                OnCompile = null,	OnExecute = null },
                new Function { Name="setSpeedMode",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setTargetAge",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setTaskResult",                 OnCompile = null,	OnExecute = null },
                new Function { Name="setTaskState",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setTerrainGrid",                OnCompile = null,	OnExecute = null },
                new Function { Name="setText",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setTitleEffect",                OnCompile = null,	OnExecute = null },
                new Function { Name="setTriggerActivation",          OnCompile = null,	OnExecute = null },
                new Function { Name="setTriggerArea",                OnCompile = null,	OnExecute = null },
                new Function { Name="setTriggerStatements",          OnCompile = null,	OnExecute = null },
                new Function { Name="setTriggerText",                OnCompile = null,	OnExecute = null },
                new Function { Name="setTriggerTimeout",             OnCompile = null,	OnExecute = null },
                new Function { Name="setTriggerType",                OnCompile = null,	OnExecute = null },
                new Function { Name="setType",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setUnconscious",                OnCompile = null,	OnExecute = null },
                new Function { Name="setUnitAbility",                OnCompile = null,	OnExecute = null },
                new Function { Name="setUnitPos",                    OnCompile = null,	OnExecute = null },
                new Function { Name="setUnitPosWeak",                OnCompile = null,	OnExecute = null },
                new Function { Name="setUnitRank",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setVariable",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setVectorDir",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setVectorDirAndUp",             OnCompile = null,	OnExecute = null },
                new Function { Name="setVectorUp",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleAmmo",                OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleArmor",               OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleId",                  OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleInit",                OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleLock",                OnCompile = null,	OnExecute = null },
                new Function { Name="setVehiclePosition",            OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleTiPars",              OnCompile = null,	OnExecute = null },
                new Function { Name="setVehicleVarName",             OnCompile = null,	OnExecute = null },
                new Function { Name="setVelocity",                   OnCompile = null,	OnExecute = null },
                new Function { Name="setVelocityTransformation",     OnCompile = null,	OnExecute = null },
                new Function { Name="setViewDistance",               OnCompile = null,	OnExecute = null },
                new Function { Name="setVisibleIfTreeCollapsed",     OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointBehaviour",          OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointCombatMode",         OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointCompletionRadius",   OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointDescription",        OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointFormation",          OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointHousePosition",      OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointPosition",           OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointScript",             OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointSpeed",              OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointStatements",         OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointTimeout",            OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointType",               OnCompile = null,	OnExecute = null },
                new Function { Name="setWaypointVisible",            OnCompile = null,	OnExecute = null },
                new Function { Name="setWind",                       OnCompile = null,	OnExecute = null },
                new Function { Name="setWPPos",                      OnCompile = null,	OnExecute = null },
                new Function { Name="show3DIcons",                   OnCompile = null,	OnExecute = null },
                new Function { Name="showCinemaBorder",              OnCompile = null,	OnExecute = null },
                new Function { Name="showCommandingMenu",            OnCompile = null,	OnExecute = null },
                new Function { Name="showCompass",                   OnCompile = null,	OnExecute = null },
                new Function { Name="showGPS",                       OnCompile = null,	OnExecute = null },
                new Function { Name="showHUD",                       OnCompile = null,	OnExecute = null },
                new Function { Name="showLegend",                    OnCompile = null,	OnExecute = null },
                new Function { Name="showMap",                       OnCompile = null,	OnExecute = null },
                new Function { Name="shownCompass",                  OnCompile = null,	OnExecute = null },
                new Function { Name="showNewEditorObject",           OnCompile = null,	OnExecute = null },
                new Function { Name="shownGPS",                      OnCompile = null,	OnExecute = null },
                new Function { Name="shownMap",                      OnCompile = null,	OnExecute = null },
                new Function { Name="shownPad",                      OnCompile = null,	OnExecute = null },
                new Function { Name="shownRadio",                    OnCompile = null,	OnExecute = null },
                new Function { Name="shownWarrant",                  OnCompile = null,	OnExecute = null },
                new Function { Name="shownWatch",                    OnCompile = null,	OnExecute = null },
                new Function { Name="showPad",                       OnCompile = null,	OnExecute = null },
                new Function { Name="showRadio",                     OnCompile = null,	OnExecute = null },
                new Function { Name="showSubtitles",                 OnCompile = null,	OnExecute = null },
                new Function { Name="showWarrant",                   OnCompile = null,	OnExecute = null },
                new Function { Name="showWatch",                     OnCompile = null,	OnExecute = null },
                new Function { Name="showWaypoint",                  OnCompile = null,	OnExecute = null },
                new Function { Name="side",                          OnCompile = null,	OnExecute = null },
                new Function { Name="sideChat",                      OnCompile = null,	OnExecute = null },
                new Function { Name="sideEnemy",                     OnCompile = null,	OnExecute = null },
                new Function { Name="sideFriendly",                  OnCompile = null,	OnExecute = null },
                new Function { Name="sideLogic",                     OnCompile = null,	OnExecute = null },
                new Function { Name="sideRadio",                     OnCompile = null,	OnExecute = null },
                new Function { Name="sideUnknown",                   OnCompile = null,	OnExecute = null },
                new Function { Name="simpleTasks",                   OnCompile = null,	OnExecute = null },
                new Function { Name="simulationEnabled",             OnCompile = null,	OnExecute = null },
                new Function { Name="sin",                           OnCompile = null,	OnExecute = null },
                new Function { Name="size",                          OnCompile = null,	OnExecute = null },
                new Function { Name="sizeOf",                        OnCompile = null,	OnExecute = null },
                new Function { Name="skill",                         OnCompile = null,	OnExecute = null },
                new Function { Name="skipTime",                      OnCompile = null,	OnExecute = null },
                new Function { Name="sleep",                         OnCompile = null,	OnExecute = null },
                new Function { Name="sliderPosition",                OnCompile = null,	OnExecute = null },
                new Function { Name="sliderRange",                   OnCompile = null,	OnExecute = null },
                new Function { Name="sliderSetPosition",             OnCompile = null,	OnExecute = null },
                new Function { Name="sliderSetRange",                OnCompile = null,	OnExecute = null },
                new Function { Name="sliderSetSpeed",                OnCompile = null,	OnExecute = null },
                new Function { Name="sliderSpeed",                   OnCompile = null,	OnExecute = null },
                new Function { Name="someAmmo",                      OnCompile = null,	OnExecute = null },
                new Function { Name="soundVolume",                   OnCompile = null,	OnExecute = null },
                new Function { Name="spawn",                         OnCompile = null,	OnExecute = null },
                new Function { Name="speed",                         OnCompile = null,	OnExecute = null },
                new Function { Name="speedMode",                     OnCompile = null,	OnExecute = null },
                new Function { Name="sqrt",                          OnCompile = null,	OnExecute = null },
                new Function { Name="startLoadingScreen",            OnCompile = null,	OnExecute = null },
                new Function { Name="step",                          OnCompile = null,	OnExecute = null },
                new Function { Name="stop",                          OnCompile = null,	OnExecute = null },
                new Function { Name="stopped",                       OnCompile = null,	OnExecute = null },
                new Function { Name="str",                           OnCompile = null,	OnExecute = null },
                new Function { Name="supportInfo",                   OnCompile = null,	OnExecute = null },
                new Function { Name="suppressFor",                   OnCompile = null,	OnExecute = null },
                new Function { Name="surfaceIsWater",                OnCompile = null,	OnExecute = null },
                new Function { Name="surfaceType",                   OnCompile = null,	OnExecute = null },
                new Function { Name="switch",                        OnCompile = null,	OnExecute = null },
                new Function { Name="switchableUnits",               OnCompile = null,	OnExecute = null },
                new Function { Name="switchAction",                  OnCompile = null,	OnExecute = null },
                new Function { Name="switchCamera",                  OnCompile = null,	OnExecute = null },
                new Function { Name="switchGesture",                 OnCompile = null,	OnExecute = null },
                new Function { Name="switchLight",                   OnCompile = null,	OnExecute = null },
                new Function { Name="switchMove",                    OnCompile = null,	OnExecute = null },
                new Function { Name="synchronizedObjects",           OnCompile = null,	OnExecute = null },
                new Function { Name="synchronizeObjectsAdd",         OnCompile = null,	OnExecute = null },
                new Function { Name="synchronizeObjectsRemove",      OnCompile = null,	OnExecute = null },
                new Function { Name="synchronizeWaypoint",           OnCompile = null,	OnExecute = null },
                new Function { Name="tan",                           OnCompile = null,	OnExecute = null },
                new Function { Name="targetsAggregate",              OnCompile = null,	OnExecute = null },
                new Function { Name="targetsQuery",                  OnCompile = null,	OnExecute = null },
                new Function { Name="taskChildren",                  OnCompile = null,	OnExecute = null },
                new Function { Name="taskCompleted",                 OnCompile = null,	OnExecute = null },
                new Function { Name="taskDescription",               OnCompile = null,	OnExecute = null },
                new Function { Name="taskDestination",               OnCompile = null,	OnExecute = null },
                new Function { Name="taskHint",                      OnCompile = null,	OnExecute = null },
                new Function { Name="taskNull",                      OnCompile = null,	OnExecute = null },
                new Function { Name="taskParent",                    OnCompile = null,	OnExecute = null },
                new Function { Name="taskResult",                    OnCompile = null,	OnExecute = null },
                new Function { Name="taskState",                     OnCompile = null,	OnExecute = null },
                new Function { Name="teamMember",                    OnCompile = null,	OnExecute = null },
                new Function { Name="teamMemberNull",                OnCompile = null,	OnExecute = null },
                new Function { Name="teamName",                      OnCompile = null,	OnExecute = null },
                new Function { Name="teams",                         OnCompile = null,	OnExecute = null },
                new Function { Name="teamSwitch",                    OnCompile = null,	OnExecute = null },
                new Function { Name="teamSwitchEnabled",             OnCompile = null,	OnExecute = null },
                new Function { Name="teamType",                      OnCompile = null,	OnExecute = null },
                new Function { Name="terminate",                     OnCompile = null,	OnExecute = null },
                new Function { Name="text",                          OnCompile = null,	OnExecute = null },
                new Function { Name="textLog",                       OnCompile = null,	OnExecute = null },
                new Function { Name="textLogFormat",                 OnCompile = null,	OnExecute = null },
                new Function { Name="tg",                            OnCompile = null,	OnExecute = null },
                new Function { Name="then",                          OnCompile = null,	OnExecute = null },
                new Function { Name="throw",                         OnCompile = null,	OnExecute = null },
                new Function { Name="time",                          OnCompile = null,	OnExecute = null },
                new Function { Name="titleCut",                      OnCompile = null,	OnExecute = null },
                new Function { Name="titleFadeOut",                  OnCompile = null,	OnExecute = null },
                new Function { Name="titleObj",                      OnCompile = null,	OnExecute = null },
                new Function { Name="titleRsc",                      OnCompile = null,	OnExecute = null },
                new Function { Name="titleText",                     OnCompile = null,	OnExecute = null },
                new Function { Name="to",                            OnCompile = null,	OnExecute = null },
                new Function { Name="toArray",                       OnCompile = null,	OnExecute = null },
                new Function { Name="toLower",                       OnCompile = null,	OnExecute = null },
                new Function { Name="toString",                      OnCompile = null,	OnExecute = null },
                new Function { Name="toUpper",                       OnCompile = null,	OnExecute = null },
                new Function { Name="triggerActivated",              OnCompile = null,	OnExecute = null },
                new Function { Name="triggerActivation",             OnCompile = null,	OnExecute = null },
                new Function { Name="triggerArea",                   OnCompile = null,	OnExecute = null },
                new Function { Name="triggerAttachedVehicle",        OnCompile = null,	OnExecute = null },
                new Function { Name="triggerAttachObject",           OnCompile = null,	OnExecute = null },
                new Function { Name="triggerAttachVehicle",          OnCompile = null,	OnExecute = null },
                new Function { Name="triggerStatements",             OnCompile = null,	OnExecute = null },
                new Function { Name="triggerText",                   OnCompile = null,	OnExecute = null },
                new Function { Name="triggerTimeout",                OnCompile = null,	OnExecute = null },
                new Function { Name="triggerType",                   OnCompile = null,	OnExecute = null },
                new Function { Name="true",                          OnCompile = null,	OnExecute = null },
                new Function { Name="try",                           OnCompile = null,	OnExecute = null },
                new Function { Name="turretUnit",                    OnCompile = null,	OnExecute = null },
                new Function { Name="type",                          OnCompile = null,	OnExecute = null },
                new Function { Name="typeName",                      OnCompile = null,	OnExecute = null },
                new Function { Name="typeOf",                        OnCompile = null,	OnExecute = null },
                new Function { Name="uiNamespace",                   OnCompile = null,	OnExecute = null },
                new Function { Name="uisleep",                       OnCompile = null,	OnExecute = null },
                new Function { Name="unassignTeam",                  OnCompile = null,	OnExecute = null },
                new Function { Name="unassignVehicle",               OnCompile = null,	OnExecute = null },
                new Function { Name="unitBackpack",                  OnCompile = null,	OnExecute = null },
                new Function { Name="unitPos",                       OnCompile = null,	OnExecute = null },
                new Function { Name="unitReady",                     OnCompile = null,	OnExecute = null },
                new Function { Name="unitsBelowHeight",              OnCompile = null,	OnExecute = null },
                new Function { Name="units",                         OnCompile = null,	OnExecute = null },
                new Function { Name="unlockAchievement",             OnCompile = null,	OnExecute = null },
                new Function { Name="unregisterTask",                OnCompile = null,	OnExecute = null },
                new Function { Name="updateDrawIcon",                OnCompile = null,	OnExecute = null },
                new Function { Name="updateMenuItem",                OnCompile = null,	OnExecute = null },
                new Function { Name="updateObjectTree",              OnCompile = null,	OnExecute = null },
                new Function { Name="useAudioTimeForMoves",          OnCompile = null,	OnExecute = null },
                new Function { Name="vectorDir",                     OnCompile = null,	OnExecute = null },
                new Function { Name="vectorUp",                      OnCompile = null,	OnExecute = null },
                new Function { Name="vehicle",                       OnCompile = null,	OnExecute = null },
                new Function { Name="vehicleChat",                   OnCompile = null,	OnExecute = null },
                new Function { Name="vehicleRadio",                  OnCompile = null,	OnExecute = null },
                new Function { Name="vehicles",                      OnCompile = null,	OnExecute = null },
                new Function { Name="vehicleVarName",                OnCompile = null,	OnExecute = null },
                new Function { Name="velocity",                      OnCompile = null,	OnExecute = null },
                new Function { Name="verifySignature",               OnCompile = null,	OnExecute = null },
                new Function { Name="viewDistance",                  OnCompile = null,	OnExecute = null },
                new Function { Name="visibleMap",                    OnCompile = null,	OnExecute = null },
                new Function { Name="waitUntil",                     OnCompile = null,	OnExecute = null },
                new Function { Name="waypointAttachedObject",        OnCompile = null,	OnExecute = null },
                new Function { Name="waypointAttachedVehicle",       OnCompile = null,	OnExecute = null },
                new Function { Name="waypointAttachObject",          OnCompile = null,	OnExecute = null },
                new Function { Name="waypointAttachVehicle",         OnCompile = null,	OnExecute = null },
                new Function { Name="waypointBehaviour",             OnCompile = null,	OnExecute = null },
                new Function { Name="waypointCombatMode",            OnCompile = null,	OnExecute = null },
                new Function { Name="waypointCompletionRadius",      OnCompile = null,	OnExecute = null },
                new Function { Name="waypointDescription",           OnCompile = null,	OnExecute = null },
                new Function { Name="waypointFormation",             OnCompile = null,	OnExecute = null },
                new Function { Name="waypointHousePosition",         OnCompile = null,	OnExecute = null },
                new Function { Name="waypointPosition",              OnCompile = null,	OnExecute = null },
                new Function { Name="waypoints",                     OnCompile = null,	OnExecute = null },
                new Function { Name="waypointScript",                OnCompile = null,	OnExecute = null },
                new Function { Name="waypointShow",                  OnCompile = null,	OnExecute = null },
                new Function { Name="waypointSpeed",                 OnCompile = null,	OnExecute = null },
                new Function { Name="waypointStatements",            OnCompile = null,	OnExecute = null },
                new Function { Name="waypointTimeout",               OnCompile = null,	OnExecute = null },
                new Function { Name="waypointType",                  OnCompile = null,	OnExecute = null },
                new Function { Name="waypointVisible",               OnCompile = null,	OnExecute = null },
                new Function { Name="weaponDirection",               OnCompile = null,	OnExecute = null },
                new Function { Name="weapons",                       OnCompile = null,	OnExecute = null },
                new Function { Name="weaponsTurret",                 OnCompile = null,	OnExecute = null },
                new Function { Name="west",                          OnCompile = null,	OnExecute = null },
                new Function { Name="WFSideText",                    OnCompile = null,	OnExecute = null },
                new Function { Name="while",                         OnCompile = null,	OnExecute = null },
                new Function { Name="wind",                          OnCompile = null,	OnExecute = null },
                new Function { Name="with",                          OnCompile = null,	OnExecute = null },
                new Function { Name="worldName",                     OnCompile = null,	OnExecute = null },
                new Function { Name="worldToModel",                  OnCompile = null,	OnExecute = null },
                new Function { Name="worldToScreen",                 OnCompile = null,	OnExecute = null },
            };


        private const string _commandList = @"
abs                     :=a
accTime
acos                    :=a
action                  :=a,b
actionKeys
actionKeysImages
actionKeysNames
actionKeysNamesArray
activateAddons
activateKey
addAction
addBackpack
addBackpackCargo
addCamShake
addEditorObject
addEventHandler
addGroupIcon
addLiveStats
addMagazine
addMagazineCargo
addMagazineCargoGlobal
addMagazinePool
addMagazineTurret
addMenu
addMenuItem
addMPEventHandler
addPublicVariableEventHandler
addRating
addResources
addScore
addSwitchableUnit
addTeamMember
addVehicle
addWaypoint
addWeapon
addWeaponCargo
addWeaponCargoGlobal
addWeaponPool
agent
agents
aimedAtTarget
airportSide
AISFinishHeal
alive                   :=a
allDead
allGroups
allMissionObjects
allow3DMode
allowDamage
allowDammage
allowFileOperations
allowFleeing
allowGetIn
allUnits
ammo
and                     :=a,b
animate
animationPhase
animationState
armoryPoints
asin:=1
assert
assignAsCargo
assignAsCommander
assignAsDriver
assignAsGunner
assignedCargo
assignedCommander
assignedDriver
assignedGunner
assignedTarget
assignedVehicle
assignedVehicleRole
assignTeam
assignToAirport
atan                    :=a
atan2                   :=a
atg                     :=a
attachedObject
attachObject
attachTo
attackEnabled

backpackSpaceFor
behaviour
benchmark
boundingBox
boundingCenter
breakOut
breakTo
buildingExit
buildingPos
buttonAction
buttonSetAction

cadetMode
call                    :=a,b
camCommand
camCommit
camCommitPrepared
camCommitted
camConstuctionSetParams
camCreate
camDestroy
cameraEffect
cameraEffectEnableHUD
cameraInterest
cameraOn
cameraView
campaignConfigFile
camPreload
camPreloaded
camPrepareBank
camPrepareDir
camPrepareDive
camPrepareFocus
camPrepareFov
camPrepareFovRange
camPreparePos
camPrepareRelPos
camPrepareTarget
camSetBank
camSetDir
camSetDive
camSetFocus
camSetFov
camSetFovRange
camSetPos
camSetRelPos
camSetTarget
camTarget
camUseNVG
canFire
canMove
canStand
canUnloadInCombat
captive
captiveNum
case                        :=a
catch
ceil                        :=a
cheatsEnabled
checkAIFeature
civilian
clearBackpackCargoGlobal
clearGroupIcons
clearMagazineCargo
clearMagazineCargoGlobal
clearMagazinePool
clearOverlay
clearRadio
clearVehicleInit
clearWeaponCargo
clearWeaponCargoGlobal
clearWeaponPool
closeDialog
closeDisplay
closeOverlay
collapseObjectTree
combatMode
commandChat
commander
commandFire
commandFollow
commandFSM
commandGetOut
commandingMenu
commandMove
commandRadio
commandStop
commandTarget
commandWatch
comment
commitOverlay
compile                     :=a
completedFSM
composeText
configFile
configName
controlNull
copyFromClipboard
copyToClipboard
copyWaypoints
cos                         :=a
count                       :=a
countEnemy
countFriendly
countSide
countType
countUnknown
createAgent
createCenter
createDialog
createDiaryLink
createDiaryRecord
createDiarySubject
createDisplay
createGearDialog
createGroup
createGuardedPoint
createLocation
createMarker
createMarkerLocal
createMenu
createMine
createMissionDisplay
createSimpleTask
createSoundSource
createTarget
createTask
createTeam
createTrigger
createUnit
createVehicle
createVehicleLocal
crew                        :=a
ctrlActivate
ctrlAddEventHandler
ctrlAutoScrollDelay
ctrlAutoScrollRewind
ctrlAutoScrollSpeed
ctrlCommit
ctrlCommitted
ctrlEnable
ctrlEnabled
ctrlFade
ctrlMapAnimAdd
ctrlMapAnimClear
ctrlMapAnimCommit
ctrlMapAnimDone
ctrlMapCursor
ctrlMapMouseOver
ctrlMapScale
ctrlMapScreenToWorld
ctrlMapWorldToScreen
ctrlParent
ctrlPosition
ctrlRemoveAllEventHandlers
ctrlRemoveEventHandler
ctrlScale
ctrlSetActiveColor
ctrlSetAutoScrollDelay
ctrlSetAutoScrollRewind
ctrlSetAutoScrollSpeed
ctrlSetBackgroundColor
ctrlSetEventHandler
ctrlSetFade
ctrlSetFocus
ctrlSetFont
ctrlSetFontH1
ctrlSetFontH1B
ctrlSetFontH2
ctrlSetFontH2B
ctrlSetFontH3
ctrlSetFontH3B
ctrlSetFontH4
ctrlSetFontH4B
ctrlSetFontH5
ctrlSetFontH5B
ctrlSetFontH6
ctrlSetFontH6B
ctrlSetFontHeight
ctrlSetFontHeightH1
ctrlSetFontHeightH2
ctrlSetFontHeightH3
ctrlSetFontHeightH4
ctrlSetFontHeightH5
ctrlSetFontHeightH6
ctrlSetFontP
ctrlSetFontPB
ctrlSetForegroundColor
ctrlSetPosition
ctrlSetScale
ctrlSetStructuredText
ctrlSetText
ctrlSetTextColor
ctrlSetTooltip
ctrlSetTooltipColorBox
ctrlSetTooltipColorShade
ctrlSetTooltipColorText
ctrlShow
ctrlShown
ctrlText
ctrlType
ctrlVisible
currentCommand
currentMagazine
currentMuzzle
currentTask
currentTasks
currentVisionMode
currentWaypoint
currentWeapon
currentWeaponMode
currentZeroing
cursorTarget
cutFadeOut
cutObj
cutRsc
cutText

damage
date
dateToNumber
daytime
debugLog
default
deg
deleteCenter
deleteCollection
deleteEditorObject
deleteGroup
deleteIdentity
deleteLocation
deleteMarker
deleteMarkerLocal
deleteResources
deleteStatus
deleteTarget
deleteTeam
deleteVehicle
deleteWaypoint
detach
diag_fps
diag_fpsmin
diag_frameno
diag_log                    :=a
diag_tickTime
dialog
diarySubjectExists
difficultyEnabled
direction
directSay
disableAI
disableConversation
disableSerialization
disableTIEquipment
disableUserInput
displayAddEventHandler
displayCtrl
displayNull
displayRemoveAllEventHandlers
displayRemoveEventHandler
displaySetEventHandler
dissolveTeam
distance
distributionRegion
do
doFire
doFollow
doFSM
doGetOut
doMove
doStop
doTarget
doWatch
drawArrow
drawEllipse
drawIcon
drawLine
drawLink
drawLocation
drawRectangle
driver
drop

east
echo
editObject
editorSetEventHandler
effectiveCommander
else
emptyPositions
enableAI
enableAIFeature
enableAttack
enableCamShake
enableEndDialog
enableEngineArtillery
enableEnvironment
enableGunLights
enableIRLasers
enableRadio
enableReload
enableSaving
enableSentences
enableSimulation
enableTeamSwitch
endLoadingScreen
endMission
enemy
engineOn
estimatedEndServerTime
estimatedTimeLeft

evalObjectArgument
exec                        :=a,b
execEditorScript
execFSM
execVM                      :=a,b
exit
exitWith
exp                         :=a
expectedDestination
exportLandscapeXYZ

faction
fadeMusic
fadeRadio
fadeSound
fadeSpeech
failMission
false
fillWeaponsFromPool
find
findCover
findDisplay
findEditorObject
findEmptyPosition
findEmptyPositionReady
findNearestEnemy
finishMissionInit
finite
fire
fireAtTarget
flag
flagOwner
fleeing
floor
flyInHeight
fog
fogForecast
for                         :=a
forceEnd
forceMap
forceSpeed
forceWalk
forEach                     :=a
forEachMember
forEachMemberAgent
forEachMemberTeam
format                      :=a
formation
formationDirection
formationLeader
formationMembers
formationPosition
formationTask
formatText
formLeader
friendly
from
fromEditor
fuel

gearSlotData
getArray
getBackpackCargo
getDammage
getDir
getEditorCamera
getEditorMode
getEditorObjectScope
getElevationOffset
getFriend
getFSMVariable
getGroupIcon
getGroupIconParams
getGroupIcons
getHideFrom
getMagazineCargo
getMarkerColor
getMarkerPos
getMarkerSize
getMarkerType
getNumber
getObjectArgument
getObjectChildren
getObjectProxy
getPlayerUID
getPos                     :=a
getPosASL
getPosATL
getResolution
getSpeed
getTerrainHeightASL
getText
getVariable
getWeaponCargo
getWPPos
glanceAt
globalChat
globalRadio
goto                        :=a
group
groupChat
groupIconSelectable
groupIconsVisible
groupRadio
groupSelectedUnits
groupSelectUnit
grpNull
gunner                     :=a

halt
handsHit
hasWeapon
hcAllGroups
hcGroupParams
hcLeader
hcRemoveAllGroups
hcRemoveGroup
hcSelected
hcSelectGroup
hcSetGroup
hcShowBar
hcShownBar
hideBehindScripted
hideBody
hideObject
hierarchyObjectsCount
hint
hintC
hintCadet
hintSilent
hostMission
htmlLoad

if                      :=a
image
importAllGroups
importance
in                      :=a,b
inflame
inflamed
inGameUISetEventHandler
inheritsFrom
initAmbientLife
inputAction
insertEditorObject
intersect
isAgent
isArray                 :=a
isAutoHoverOn           :=a
isClass                 :=a
isDedicated
isEngineOn
isFlatEmpty
isForcedWalk
isFormationLeader
isHidden
isHideBehindScripted
isKeyActive
isKindOf                :=a
isManualFire
isMarkedForCollection
isMultiplayer
isNil                   :=a
isNull                  :=a
isNumber
isOnRoad
isPlayer
isRealTime
isServer
isShowing3DIcons
isText                  :=a
isWalking
items

join
joinAs
joinAsSilent
joinSilent

kbAddDatabase
kbAddDatabaseTargets
kbAddTopic
kbHasTopic
kbReact
kbRemoveTopic
kbTell
kbWasSaid
keyImage
keyName
knowsAbout

land
landAt
landResult
laserTarget
lbAdd
lbClear
lbColor
lbCurSel
lbData
lbDelete
lbIsSelected
lbPicture
lbSelection
lbSetColor
lbSetCurSel
lbSetData
lbSetPicture
lbSetSelected
lbSetValue
lbSize
lbSort
lbSortByValue
lbText
lbValue
leader                  :=a
leaveVehicle
lifeState
lightAttachObject
lightDetachObject
lightIsOn
limitSpeed
lineBreak
list
listObjects
ln                      :=a
lnbAddArray
lnbAddColumn
lnbAddRow
lnbClear
lnbColor
lnbCurSelRow
lnbData
lnbDeleteColumn
lnbDeleteRow
lnbGetColumnsPosition
lnbPicture
lnbSetColor
lnbsetColumnsPos
lnbSetCurSelRow
lnbSetData
lnbSetPicture
lnbSetText
lnbSetValue
lnbSize
lnbText
lnbValue
loadFile
loadGame
loadIdentity
loadOverlay
loadStatus
local
localize
locationNull
locationPosition
lock
lockCargo
lockDriver
locked
lockedCargo
lockedDriver
lockedTurret
lockTurret
lockWP
log
lookAt
lookAtPos

magazines
magazinesTurret
mapAnimAdd
mapAnimClear
mapAnimCommit
mapAnimDone
mapCenterOnCamera
mapGridPosition
markerAlpha
markerBrush
markerColor
markerDir
markerPos
markerShape
markerSize
markerText
markerType
max
members
min
missionConfigFile
missionName
missionNamespace
missionStart
mod
modelToWorld
morale
move
moveInCargo
moveInCommander
moveInDriver
moveInGunner
moveInTurret
moveObjectToEnd
moveOut
moveTarget
moveTime
moveTo
moveToCompleted
moveToFailed
musicVolume

name
nearEntities
nearestBuilding
nearestLocation
nearestLocations
nearestLocationWithDubbing
nearestObject
nearestObjects
nearObjects
nearObjectsReady
nearRoads
nearTargets
needReload
newOverlay
nextMenuItemIndex
nextWeatherChange
nil
nMenuItems
not
NumberToDate

object
objNull
objStatus
onBriefingGear
onBriefingGroup
onBriefingNotes
onBriefingPlan
onBriefingTeamSwitch
onCommandModeChanged
onDoubleClick
onGroupIconClick
onGroupIconOverEnter
onGroupIconOverLeave
onHCGroupSelectionChanged
onMapSingleClick
onPlayerConnected
onPlayerDisconnected
onPreloadFinished
onPreloadStarted
onShowNewObject
onTeamSwitch
openDSInterface
openMap
or
orderGetIn
overcast
overcastForecast
owner

parseNumber
parseText
parsingNamespace
pi
pickWeaponPool
playableUnits
playAction
playActionNow
player
playerRespawnTime
playerSide
playersNumber
playGesture
playMission
playMove
playMoveNow
playMusic
playScriptedMission
playSound
position
posScreenToWorld
positionCameraToWorld
posWorldToScreen
ppEffectAdjust
ppEffectCommit
ppEffectCommitted
ppEffectCreate
ppEffectDestroy
ppEffectEnable
precision
preloadCamera
preloadObject
preloadSound
preloadTitleObj
preloadTitleRsc
preprocessFile
preprocessFileLineNumbers
primaryWeapon
priority
private
processDiaryLink
processInitCommands
progressLoadingScreen
progressPosition
progressSetPosition
publicVariable
putWeaponPool

queryMagazinePool
queryWeaponPool

rad
radioVolume
rain
random
rank
rankId
rating
rectangular
registeredTasks
registerTask
reload
reloadEnabled
remoteControl
removeAction
removeAllEventHandlers
removeAllItems
removeAllMPEventHandlers
removeAllWeapons
removeBackpack
removeDrawIcon
removeDrawLinks
removeEventHandler
removeGroupIcon
removeMagazine
removeMagazines
removeMagazinesTurret
removeMagazineTurret
removeMenuItem
removeMPEventHandler
removeSimpleTask
removeSwitchableUnit
removeTeamMember
removeWeapon
requiredVersion
resetCamShake
resistance
resize
resources
respawnVehicle
restartEditorCamera
reveal
reversedMouseY
roadsConnectedTo
round
runInitScript

safeZoneH
safeZoneW
safeZoneWAbs
safeZoneX
safeZoneXAbs
safeZoneY
saveGame
saveIdentity
saveOverlay
saveStatus
saveVar
savingEnabled
say
say2D
say3D
scopeName
score
scoreSide
screenToWorld
scriptDone
scriptName
scudState
secondaryWeapon
select
selectBestPlaces
selectDiarySubject
selectedEditorObjects
selectEditorObject
selectionPosition
selectLeader
selectNoPlayer
selectPlayer
selectWeapon
sendSimpleCommand
sendTask
sendTaskResult
sendUDPMessage
serverCommand
serverCommandAvailable
serverTime
set
setAccTime
setAirportSide
setAmmoCargo
setAperture
setArmoryPoints
setAttributes
setBehaviour
setCameraEffect
setCameraInterest
setCamShakeDefParams
setCamShakeParams
setCamUseTi
setCaptive
setCombatMode
setCurrentTask
setCurrentWaypoint
setDamage
setDammage
setDate
setDestination
setDir
setDirection
setDrawIcon
setDropInterval
setEditorMode
setEditorObjectScope
setEffectCondition
setFace
setFaceAnimation
setFlagOwner
setFlagSide
setFlagTexture
setFog
setFormation
setFormationTask
setFormDir
setFriend
setFromEditor
setFSMVariable
setFuel
setFuelCargo
setGroupIcon
setGroupIconParams
setGroupIconsSelectable
setGroupIconsVisible
setGroupId
setHit
setHideBehind
setIdentity
setImportance
setLeader
setLightAmbient
setLightBrightness
setLightColor
setMarkerAlpha
setMarkerAlphaLocal
setMarkerBrush
setMarkerBrushLocal
setMarkerColor
setMarkerColorLocal
setMarkerDir
setMarkerDirLocal
setMarkerPos
setMarkerPosLocal
setMarkerShape
setMarkerShapeLocal
setMarkerSize
setMarkerSizeLocal
setMarkerText
setMarkerTextLocal
setMarkerType
setMarkerTypeLocal
setMimic
setMousePosition
setMusicEffect
setName
setObjectArguments
setObjectProxy
setObjectTexture
setOvercast
setParticleCircle
setParticleParams
setParticleRandom
setPlayable
setPlayerRespawnTime
setPos
setPosASL
setPosASL2
setPosATL
setPosition
setRadioMsg
setRain
setRank
setRectangular
setRepairCargo
setSide
setSimpleTaskDescription
setSimpleTaskDestination
setSimpleTaskTarget
setSize
setSoundEffect
setSpeedMode
setTargetAge
setTaskResult
setTaskState
setTerrainGrid
setText
setTitleEffect
setTriggerActivation
setTriggerArea
setTriggerStatements
setTriggerText
setTriggerTimeout
setTriggerType
setType
setUnconscious
setUnitAbility
setUnitPos
setUnitPosWeak
setUnitRank
setVariable
setVectorDir
setVectorDirAndUp
setVectorUp
setVehicleAmmo
setVehicleArmor
setVehicleId
setVehicleInit
setVehicleLock
setVehiclePosition
setVehicleTiPars
setVehicleVarName
setVelocity
setVelocityTransformation
setViewDistance
setVisibleIfTreeCollapsed
setWaypointBehaviour
setWaypointCombatMode
setWaypointCompletionRadius
setWaypointDescription
setWaypointFormation
setWaypointHousePosition
setWaypointPosition
setWaypointScript
setWaypointSpeed
setWaypointStatements
setWaypointTimeout
setWaypointType
setWaypointVisible
setWind
setWPPos
show3DIcons
showCinemaBorder
showCommandingMenu
showCompass
showGPS
showHUD
showLegend
showMap
shownCompass
showNewEditorObject
shownGPS
shownMap
shownPad
shownRadio
shownWarrant
shownWatch
showPad
showRadio
showSubtitles
showWarrant
showWatch
showWaypoint
side
sideChat
sideEnemy
sideFriendly
sideLogic
sideRadio
sideUnknown
simpleTasks
simulationEnabled
sin
size
sizeOf
skill
skipTime
sleep
sliderPosition
sliderRange
sliderSetPosition
sliderSetRange
sliderSetSpeed
sliderSpeed
someAmmo
soundVolume
spawn
speed
speedMode
sqrt
startLoadingScreen
step
stop
stopped
str
supportInfo
suppressFor
surfaceIsWater
surfaceType
switch
switchableUnits
switchAction
switchCamera
switchGesture
switchLight
switchMove
synchronizedObjects
synchronizeObjectsAdd
synchronizeObjectsRemove
synchronizeWaypoint

tan
targetsAggregate
targetsQuery
taskChildren
taskCompleted
taskDescription
taskDestination
taskHint
taskNull
taskParent
taskResult
taskState
teamMember
teamMemberNull
teamName
teams
teamSwitch
teamSwitchEnabled
teamType
terminate
text
textLog
textLogFormat
tg
then
throw
time
titleCut
titleFadeOut
titleObj
titleRsc
titleText
to
toArray
toLower
toString
toUpper
triggerActivated
triggerActivation
triggerArea
triggerAttachedVehicle
triggerAttachObject
triggerAttachVehicle
triggerStatements
triggerText
triggerTimeout
triggerType
true
try
turretUnit
type
typeName
typeOf

uiNamespace
uisleep
unassignTeam
unassignVehicle
unitBackpack
unitPos
unitReady
unitsBelowHeight
units
unlockAchievement
unregisterTask
updateDrawIcon
updateMenuItem
updateObjectTree
useAudioTimeForMoves

vectorDir
vectorUp
vehicle
vehicleChat
vehicleRadio
vehicles
vehicleVarName
velocity
verifySignature
viewDistance
visibleMap

waitUntil
waypointAttachedObject
waypointAttachedVehicle
waypointAttachObject
waypointAttachVehicle
waypointBehaviour
waypointCombatMode
waypointCompletionRadius
waypointDescription
waypointFormation
waypointHousePosition
waypointPosition
waypoints
waypointScript
waypointShow
waypointSpeed
waypointStatements
waypointTimeout
waypointType
waypointVisible
weaponDirection
weapons
weaponsTurret
west
WFSideText
while
wind
with
worldName
worldToModel
worldToScreen
";
    }
}