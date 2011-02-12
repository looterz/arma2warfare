using System;
using System.IO;
using System.Linq;
using ArmA2.Script;
using NUnit.Framework;

namespace ArmA2.Script.UnitTests
{
    [TestFixture]
    public class TestCompiler
    {
        readonly Compiler _compiler = new Compiler();

        [Test]
        public void TestRegisterPrivate()
        {
            string content;
            string result;
            content = @"spawn { _myVar = 1; }";
            result = _compiler.Compile(content);
            Assert.AreEqual("spawn{private['_myVar'];_myVar=1}", result);
          

            content = @"_fnLocal = { _myVar = 1; }";
            result = _compiler.Compile(content);
            Assert.AreEqual("private['_fnLocal'];_fnLocal={private['_myVar'];_myVar=1}", result);

            content = @"{_myVar = 1;}";
            result = _compiler.Compile(content);
            Assert.AreEqual("private['_myVar'];{_myVar=1}", result);

            content = @"
switch (_respawnCampsMode) do {
	case 1: {
/* Classic Respawn */
		_town = [_deathLoc] Call GetClosestLocation;
    };
};
";
            result = _compiler.Compile(content);
            Assert.AreEqual("private['_town'];switch(_respawnCampsMode)do{case 1:{_town=[_deathLoc]Call GetClosestLocation}};", result);

            //


        } 

        [Test]
        public void TestStringSearch2()
        {
            var expectedData = new[] { "_c", "_u", "_longestlightbuildtime", "Units_Light_", ".sqf", "WFBE_WESTLIGHTUNITS", "LIGHT", "WEST", @"Client\Init\Init_Faction.sqf", "Units_Light_", ".sqf", "WFBE_EASTLIGHTUNITS", "LIGHT", "EAST", @"Client\Init\Init_Faction.sqf", "Units_Light_", ".sqf", "WFBE_GUERLIGHTUNITS", "WFBE_ALLIES", @"Vanilla\Units_Light_CDF.sqf", "WFBE_WESTALLIESLIGHTUNITS", @"Vanilla\Units_Light_INS.sqf", "WFBE_EASTALLIESLIGHTUNITS", "WFBE_WESTALLIESLIGHTUNITS", "WFBE_EASTALLIESLIGHTUNITS", "WFBE_WESTREPAIRTRUCK", "MtvrRepair", "WFBE_WESTSUPPLYTRUCK", "WarfareSupplyTruck_USMC", "WFBE_WESTSALVAGETRUCK", "WarfareSalvageTruck_USMC", "WFBE_WESTAMBULANCES", "HMMWV_Ambulance", "WFBE_EASTREPAIRTRUCK", "KamazRepair", "WFBE_EASTSUPPLYTRUCK", "WarfareSupplyTruck_RU", "WFBE_EASTSALVAGETRUCK", "WarfareSalvageTruck_RU", "WFBE_EASTAMBULANCES", "GAZ_Vodnik_MedEvac", "WFBE_WESTREPAIRTRUCK", "MtvrRepair_DES_EP1", "WFBE_WESTSUPPLYTRUCK", "MtvrSupply_DES_EP1", "WFBE_WESTSALVAGETRUCK", "MtvrSalvage_DES_EP1", "WFBE_WESTAMBULANCES", "HMMWV_Ambulance_DES_EP1", "M1133_MEV_EP1", "WFBE_EASTREPAIRTRUCK", "UralRepair_TK_EP1", "WFBE_EASTSUPPLYTRUCK", "UralSupply_TK_EP1", "WFBE_EASTSALVAGETRUCK", "UralSalvage_TK_EP1", "WFBE_EASTAMBULANCES", "M113Ambul_TK_EP1", "WFBE_WESTREPAIRTRUCK", "MtvrRepair", "MtvrRepair_DES_EP1", "WFBE_WESTSUPPLYTRUCK", "WarfareSupplyTruck_USMC", "MtvrSupply_DES_EP1", "WFBE_WESTSALVAGETRUCK", "WarfareSalvageTruck_USMC", "MtvrSalvage_DES_EP1", "WFBE_WESTAMBULANCES", "HMMWV_Ambulance", "HMMWV_Ambulance_DES_EP1", "M1133_MEV_EP1", "WFBE_EASTREPAIRTRUCK", "KamazRepair", "UralRepair_TK_EP1", "WFBE_EASTSUPPLYTRUCK", "WarfareSupplyTruck_RU", "UralSupply_TK_EP1", "WFBE_EASTSALVAGETRUCK", "WarfareSalvageTruck_RU", "UralSalvage_TK_EP1", "WFBE_EASTAMBULANCES", "GAZ_Vodnik_MedEvac", "M113Ambul_TK_EP1", "WFBE_WESTREPAIRTRUCKS", "MtvrRepair_DES_EP1", "MtvrRepair", "WFBE_WESTSUPPLYTRUCKS", "MtvrSupply_DES_EP1", "WarfareSupplyTruck_USMC", "WFBE_EASTREPAIRTRUCKS", "UralRepair_TK_EP1", "KamazRepair", "WFBE_EASTSUPPLYTRUCKS", "UralSupply_TK_EP1", "WarfareSupplyTruck_RU", "_c", @"Config_LightFactory: '%1' is not defined in the Core files.", "WFBE_EASTLIGHTUNITS", "WFBE_WESTLIGHTUNITS", "WFBE_GUERLIGHTUNITS", "WFBE_LONGESTLIGHTBUILDTIME" };

            string text = @"private['_c','_u','_longestlightbuildtime'];_u=Call Compile preprocessFile(WFBE_V_UnitsRoot+WFBE_V_West_UnitsRootVersion+'Units_Light_'+WFBE_V_West_Faction+'.sqf');['WFBE_WESTLIGHTUNITS',_u,true]Call SetNamespace;if(local player)then{['LIGHT','WEST',_u]Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};_u=Call Compile preprocessFile(WFBE_V_UnitsRoot+WFBE_V_East_UnitsRootVersion+'Units_Light_'+WFBE_V_East_Faction+'.sqf');['WFBE_EASTLIGHTUNITS',_u,true]Call SetNamespace;if(local player)then{['LIGHT','EAST',_u]Call Compile preProcessFile 'Client\Init\Init_Faction.sqf'};_u=Call Compile preprocessFile(WFBE_V_UnitsRoot+WFBE_V_Resistance_UnitsRootVersion+'Units_Light_'+WFBE_V_Resistance_Faction+'.sqf');['WFBE_GUERLIGHTUNITS',_u,true]Call SetNamespace;if(('WFBE_ALLIES' Call GetNamespace)>0)then{_u=Call Compile preprocessFile(WFBE_V_UnitsRoot+'Vanilla\Units_Light_CDF.sqf');['WFBE_WESTALLIESLIGHTUNITS',_u,true]Call SetNamespace;_u=Call Compile preprocessFile(WFBE_V_UnitsRoot+'Vanilla\Units_Light_INS.sqf');['WFBE_EASTALLIESLIGHTUNITS',_u,true]Call SetNamespace}else{['WFBE_WESTALLIESLIGHTUNITS',[],true]Call SetNamespace;['WFBE_EASTALLIESLIGHTUNITS',[],true]Call SetNamespace};if(WF_A2_Vanilla)then{['WFBE_WESTREPAIRTRUCK','MtvrRepair',true]Call SetNamespace;['WFBE_WESTSUPPLYTRUCK','WarfareSupplyTruck_USMC',true]Call SetNamespace;['WFBE_WESTSALVAGETRUCK',['WarfareSalvageTruck_USMC'],true]Call SetNamespace;['WFBE_WESTAMBULANCES',['HMMWV_Ambulance'],true]Call SetNamespace;['WFBE_EASTREPAIRTRUCK','KamazRepair',true]Call SetNamespace;['WFBE_EASTSUPPLYTRUCK','WarfareSupplyTruck_RU',true]Call SetNamespace;['WFBE_EASTSALVAGETRUCK',['WarfareSalvageTruck_RU'],true]Call SetNamespace;['WFBE_EASTAMBULANCES',['GAZ_Vodnik_MedEvac'],true]Call SetNamespace};if(WF_A2_Arrowhead)then{['WFBE_WESTREPAIRTRUCK','MtvrRepair_DES_EP1',true]Call SetNamespace;['WFBE_WESTSUPPLYTRUCK','MtvrSupply_DES_EP1',true]Call SetNamespace;['WFBE_WESTSALVAGETRUCK',['MtvrSalvage_DES_EP1'],true]Call SetNamespace;['WFBE_WESTAMBULANCES',['HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1'],true]Call SetNamespace;['WFBE_EASTREPAIRTRUCK','UralRepair_TK_EP1',true]Call SetNamespace;['WFBE_EASTSUPPLYTRUCK','UralSupply_TK_EP1',true]Call SetNamespace;['WFBE_EASTSALVAGETRUCK',['UralSalvage_TK_EP1'],true]Call SetNamespace;['WFBE_EASTAMBULANCES',['M113Ambul_TK_EP1'],true]Call SetNamespace};if(WF_A2_CombinedOps)then{['WFBE_WESTREPAIRTRUCK',if(WF_Camo)then{'MtvrRepair'}else{'MtvrRepair_DES_EP1'},true]Call SetNamespace;['WFBE_WESTSUPPLYTRUCK',if(WF_Camo)then{'WarfareSupplyTruck_USMC'}else{'MtvrSupply_DES_EP1'},true]Call SetNamespace;['WFBE_WESTSALVAGETRUCK',['WarfareSalvageTruck_USMC','MtvrSalvage_DES_EP1'],true]Call SetNamespace;['WFBE_WESTAMBULANCES',['HMMWV_Ambulance','HMMWV_Ambulance_DES_EP1','M1133_MEV_EP1'],true]Call SetNamespace;['WFBE_EASTREPAIRTRUCK',if(WF_Camo)then{'KamazRepair'}else{'UralRepair_TK_EP1'},true]Call SetNamespace;['WFBE_EASTSUPPLYTRUCK',if(WF_Camo)then{'WarfareSupplyTruck_RU'}else{'UralSupply_TK_EP1'},true]Call SetNamespace;['WFBE_EASTSALVAGETRUCK',['WarfareSalvageTruck_RU','UralSalvage_TK_EP1'],true]Call SetNamespace;['WFBE_EASTAMBULANCES',['GAZ_Vodnik_MedEvac','M113Ambul_TK_EP1'],true]Call SetNamespace};['WFBE_WESTREPAIRTRUCKS',['MtvrRepair_DES_EP1','MtvrRepair'],true]Call SetNamespace;['WFBE_WESTSUPPLYTRUCKS',['MtvrSupply_DES_EP1','WarfareSupplyTruck_USMC'],true]Call SetNamespace;['WFBE_EASTREPAIRTRUCKS',['UralRepair_TK_EP1','KamazRepair'],true]Call SetNamespace;['WFBE_EASTSUPPLYTRUCKS',['UralSupply_TK_EP1','WarfareSupplyTruck_RU'],true]Call SetNamespace;_longestLightBuildTime=0;{_c=_x Call GetNamespace;if!(isNil '_c')then{if((_c select QUERYUNITTIME)>_longestLightBuildTime)then{_longestLightBuildTime=(_c select QUERYUNITTIME)}}else{Format[""Config_LightFactory: '%1' is not defined in the Core files."",_x]call LogError}}forEach(('WFBE_EASTLIGHTUNITS' Call GetNamespace)+('WFBE_WESTLIGHTUNITS' Call GetNamespace)+('WFBE_GUERLIGHTUNITS' Call GetNamespace));['WFBE_LONGESTLIGHTBUILDTIME',_longestLightBuildTime,true]Call SetNamespace;";
            int s1, s2;

            s1 = 0;
            int id = 0;
            while (s1 != -1)
            {
                s1 = _compiler.GetNextStringStart(text, s1);
                if (s1 == -1)
                    break;

                s2 = text.GetEndQuote(s1);
                var actual1 = _compiler.GetNextString(text, s1);
                actual1 = actual1.Substring(1, actual1.Length - 2);
                var actual2 = text.Substring(s1 + 1, (s2 - s1 + 1) - 2);

                Assert.AreEqual(expectedData[id], actual1);
                Assert.AreEqual(expectedData[id], actual2);

                id++;
                if (s2 != -1)
                    s1 = s2 + 1;
            }

            Assert.AreEqual(id, expectedData.Length);
        }

        [Test]
        public void TestStringSearch()
        {
            string text = @"var c= ""var c=0; var c=5""; for(var c=0; c<100; c++)";
            int c1 = _compiler.GetNextStringStart(text, 0);
            int c2 = text.GetEndQuote(c1);

            string actual = text.Substring(c1+1, c2 - c1 - 1);
            Assert.AreEqual("var c=0; var c=5", actual);

            text = @"var c= ""var """"c=0;"" var c=5; 'for(var c=0; c<100; c++)' var c=5;";
            actual = _compiler.GetNextString(text, 0);
            Assert.AreEqual(@"""var """"c=0;""", actual);

            text = @"var c= ""var """"c=0;\"" var c=5; 'for(var c=0; c<100; c++)' var c=5;";
            actual = _compiler.GetNextString(text, 0);
            Assert.AreEqual(@"""var """"c=0;\""", actual);

            text = @"var c= 'var """"c=0;\' var c=5; 'for(var c=0; c<100; c++)' var c=5;";
            actual = _compiler.GetNextString(text, 0);
            Assert.AreEqual(@"'var """"c=0;\'", actual);

            text = @"var c= 'var ''c=0;' var c=5; 'for(var c=0; c<100; c++)' var c=5;";
            actual = _compiler.GetNextString(text, 0);
            Assert.AreEqual(@"'var ''c=0;'", actual);

            c1 = _compiler.GetNextStringStart(text, 0);
            c2 = text.GetEndQuote(c1);

            actual = _compiler.GetNextString(text, c2+1);
            Assert.AreEqual(@"'for(var c=0; c<100; c++)'", actual);

            //--
            text = @"var c= ""var c=0;"""" var c=5""; for(var c=0; c<100; c++)";
            c1 = _compiler.GetNextStringStart(text, 0);
            c2 = text.GetEndQuote(c1);

            actual = text.Substring(c1 + 1, c2 - c1 - 1);
            Assert.AreEqual(@"var c=0;"""" var c=5", actual);

            actual = _compiler.GetNextString(text, 0);
            Assert.AreEqual(@"""var c=0;"""" var c=5""", actual);

            text = @"var c= ""var c=0;' var c=5""; for(var c=0; c<100; c++)";
            c1 = _compiler.GetNextStringStart(text, 0);
            c2 = text.GetEndQuote(c1);

            actual = text.Substring(c1 + 1, c2 - c1 - 1);
            Assert.AreEqual(@"var c=0;' var c=5", actual);

            actual = _compiler.GetNextString(text, 0);
            Assert.AreEqual(@"""var c=0;' var c=5""", actual);
        }

        [Test]
        public void TestComplexFilePatterns()
        {
            GlobalVars.ExcludeLines.Clear();
            GlobalVars.ExcludeLines.Add("PROFILER_BEGIN");
            GlobalVars.ExcludeLines.Add("PROFILER_END");
            GlobalVars.ExcludeLines.Add(@"profiler.sqf");
            GlobalVars.ExcludeLines.Add(@"profiler.h");
            GlobalVars.ExcludeLines.Add(@"!isNil ""initProfiler""");
            GlobalVars.ExcludeLines.Add(@"call Log(Inform|High|Medium|Warning|Error|Trace|Unexpected|Notify)(?:[^\w])");

            var path = Path.Combine(Environment.CurrentDirectory, "..\\..\\tests\\");
            var files = Directory.GetFiles(path).Where(m => !Path.GetFileNameWithoutExtension(m).EndsWith(".a"));

            var outputBase = Console.Out;

            foreach(var file in files)
            {
                //var file = @"c:\Users\Evgeny_Zyuzin\Documents\ArmA 2 Other Profiles\Bomba\missions\arma2.script.compiler\unittest\tests\A01.sqf";
                Logger.Clear();

                //Console.SetOut(new StringWriter(new StringBuilder()));
                Compiler compiler = new Compiler();
                compiler.FsmContent = (Path.GetExtension(file).ToLower() == ".fsm");
                compiler.FileName = Path.GetFileName(file);

                string content = File.ReadAllText(file);
                string expectedFileName = Path.GetDirectoryName(file) + "\\" + Path.GetFileNameWithoutExtension(file) + ".a" + Path.GetExtension(file);
                string contentExpected = File.ReadAllText(expectedFileName);

                string contentActual = compiler.Compile(content);
                if (contentActual != contentExpected)
                    contentActual = contentActual;
                
                Assert.AreEqual(contentExpected, contentActual, string.Format("{0} - [Failed]", Path.GetFileName(file)));
                Assert.AreEqual(0, Logger.Errors.Count, string.Format("{0} - [Failed]", Path.GetFileName(file)));
                Assert.AreEqual(0, Logger.Warnings.Count, string.Format("{0} - [Failed]", Path.GetFileName(file)));

                Console.SetOut(outputBase);
                Console.WriteLine("{0} - [Done]", Path.GetFileName(file));
            }

        }

        [Test]
        public void TestScopeDetectComplex()
        {
            var path = Path.Combine(Environment.CurrentDirectory, "..\\..\\tests\\");
            //Common_SelectCamo.a.sqf 
        }

        [Test]
        public void TestScopeDetect()
        {
            var testText = @"sometext { somevar }";
            var scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{ somevar }", testText.Substring(scope.Start, scope.Length + 1), "");

            testText = @"aaaaa {'somevar'} bbbbb";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{'somevar'}", testText.Substring(scope.Start, scope.Length + 1), "");



            testText = "{ctrlSetText[19007,Format[localize \"STR_WF_CurrentMission\",\"N/A\"]]}";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{ctrlSetText[19007,Format[localize \"STR_WF_CurrentMission\",\"N/A\"]]}", testText.Substring(scope.Start, scope.Length + 1), "");

//            testText = @"{_txt=Format[""DEBUG: \n\n Something might be wrong with the town initialization process... \n\n This could be related to the towns amount set or to the initialization itself, try to rejoin the game if the auto-fix doesn't work...\n\nExtra Info:\ncount towns:%1\ntotalTowns:%2...\n\nThe game will now attempt to fix itself..."",count towns,totalTowns];_txt Call DebugHint;towns = towns - [objNull];if (count towns == totalTowns) then {townInit = true;('DEBUG:\n\nThe towns initialization has been fixed.') Call DebugHint;} else {('DEBUG:\n\nThe towns initialization cannot be fixed.') Call DebugHint;sleep 5; failMission ""END1""};} else {townInit = true};";
            //           var str = _compiler.GetNextString(testText, 0);
            //          Assert.AreEqual("{ somevar }", testText.Substring(scope.Start, scope.Length + 1), "");

            testText = @"sometext { somevar ""asda"" { ""abcde"" } ";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual(@"{ somevar ""asda"" { ""abcde"" } ", testText.Substring(scope.Start, scope.Length + 1), "");

            testText = @"sometext { sometext var { sometext }{ sometext }} sometext { sometext }{ sometext }";
            var scopes = _compiler.GetScopes(testText, 0, testText.Length); 
            int scopeCount = scopes.Count;
            Assert.AreEqual(3, scopeCount, "incorrect calculate internal scope count");

            testText = @"sometext { sometext var { sometext }{ sometext }} sometext (sometext)[sometext]";
            scopeCount = _compiler.GetScopes(testText, 0, testText.Length).Count();
            Assert.AreEqual(1, scopeCount, "incorrect calculate internal scope count");

            testText = @"sometext ""som{0}var""";
            scopeCount = _compiler.GetScopes(testText, 0, testText.Length).Count();
            Assert.AreEqual(0, scopeCount, "incorrect calculate internal scope count");

            testText = @"sometext ""som{0}var"" sometext ""111"" sometext { abc } sometext ""som{0}var"" sometext ""111"" sometext ";
            scopeCount = _compiler.GetScopes(testText, 0, testText.Length).Count();
            Assert.AreEqual(1, scopeCount, "incorrect calculate internal scope count");

            testText = @"sometext { ""som}v{ar}"" } sometext";
            scopeCount = _compiler.GetScopes(testText, 0, testText.Length).Count();
            Assert.AreEqual(1, scopeCount, "incorrect calculate internal scope count");

            testText = @"sometext { {somevar} }";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{ {somevar} }", testText.Substring(scope.Start, scope.Length + 1), "");

            testText = @"sometext { {somevar1} }  sometext { {somevar2} }";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{ {somevar1} }", testText.Substring(scope.Start, scope.Length + 1), "");

            scope = _compiler.GetScopeNext(testText, scope.End);
            Assert.AreEqual("{ {somevar2} }", testText.Substring(scope.Start, scope.Length + 1), "");

            testText = @"sometext { {somevar1} }{ {somevar2} }";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{ {somevar1} }", testText.Substring(scope.Start, scope.Length + 1), "");

            scope = _compiler.GetScopeNext(testText, scope.End);
            Assert.AreEqual("{ {somevar2} }", testText.Substring(scope.Start, scope.Length + 1), "");


            testText = @"sometext {{somevar1}}{{somevar2}}";
            scope = _compiler.GetScopeNext(testText, 0);
            Assert.AreEqual("{{somevar1}}", testText.Substring(scope.Start, scope.Length + 1), "");

            scope = _compiler.GetScopeNext(testText, scope.End);
            Assert.AreEqual("{{somevar2}}", testText.Substring(scope.Start, scope.Length + 1), "");
        }

        [Test]
        public void TestRemoveStringBreaks()
        {
            var testText = @"_c=""TownCapturePublic: %1 ""  \n   "" asdasd""\n"" asdasdadd""";
            var result = _compiler.RemoveStringBreaks(testText);
            Assert.AreEqual(@"_c=""TownCapturePublic: %1  asdasd asdasdadd""", result, "");

            testText = @"""{_lastCoord = [0,0,0]};""\n""""\n""_coord = (_team)""";
            result = _compiler.RemoveStringBreaks(testText);
            Assert.AreEqual(@"""{_lastCoord = [0,0,0]};_coord = (_team)""", result, "");

        }

        [Test]
        public void TestRemoveExtraSpaces()
        {
            var testText = @"    var var1   =       ""Hello   world"";    var var2           = ""Hello   world"";";
            var result = _compiler.RemoveExtraSpaces(testText);
            Assert.AreEqual(@"var var1=""Hello   world"";var var2=""Hello   world"";", result, "");

            testText = @"    var var1   =       12345;";
            result = _compiler.RemoveExtraSpaces(testText);
            Assert.AreEqual(@"var var1=12345;", result, "");
        }

        [Test]
        public void TestRemoveMultiLineComment()
        {
            var testText = @"    var var1 = ""hell/*owor*/ld""; /* old code var /* var1 = ""hellow */orld""   */";
            var result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"var var1 = ""hell/*owor*/ld"";", result, "");

            testText = @"*//*%FSM</HEAD>*/";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"*/", result, "");

            testText = @"    var var1 = ""hell/*owor*/ld""; /* old code var var1 = ""helloworld"" */ var var2 = ""hell/*owor*/ld"";";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"var var1 = ""hell/*owor*/ld"";  var var2 = ""hell/*owor*/ld"";", result, "");

            testText = @"    var var1 = 12345; /* old code var var1 = ""helloworld"" */";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"var var1 = 12345;", result, "");

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*/";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"", result, "");

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*//* next comment */";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("", result, "");

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*/ 12345 /* next comment */";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("12345", result, "");     

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("", result, "");

            testText = @"*/%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(testText, result, "");

            testText = @"
/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*/
/*%FSM<HEAD>*/
/*
item0[] = {""Init"",0,250,-81.542984,-257.577942,8.457038,-207.578140,0.000000,""Init""};
*//*%FSM</HEAD>*/
class FSM";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("class FSM", result, "");

            testText = "      init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\"/*%FSM</STATEINIT\"\"\">*/;";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\";", result, "");

            testText = @"/*  the player's information are stored or retrieved before being updated.*/ TEST";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("TEST", result, "");
        }

        [Test]
        public void TestRemoveMultiLineComment2()
        {
            var testText = "      init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\"/*%FSM</STATEINIT\"\"\">*/;";
            var result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual("init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\";", result, "");

            Logger.Clear();
            testText = @"/* This file handle the client's UAV broadcast, a client send info to the others. */var c=0;";
            result = _compiler.RemoveMultiLineComments(testText);
            Assert.AreEqual(0, Logger.Errors.Count, "");
            Assert.AreEqual("var c=0;", result, "");

        }

        [Test]
        public void TestRemoveCommentSingleLine()
        {
            var result = _compiler.RemoveSingleLineComments("       var mymethod = 12123; // hello world");
            Assert.AreEqual("var mymethod = 12123;", result, "");

            result = _compiler.RemoveSingleLineComments("*//*%FSM</HEAD>*//");
            Assert.AreEqual("*//*%FSM</HEAD>*//", result, "");

            result = _compiler.RemoveSingleLineComments("       var mymethod = 12123; var myText = \"// hello world\";");
            Assert.AreEqual("var mymethod = 12123; var myText = \"// hello world\";", result, "");

            result = _compiler.RemoveSingleLineComments("       var mymethod = 12123; var myText = \"// hello world\"; // some my comment");
            Assert.AreEqual("var mymethod = 12123; var myText = \"// hello world\";", result, "");

            result = _compiler.RemoveSingleLineComments("//--- Attempt to get the player's team.");
            Assert.AreEqual("", result, "");
        }
    }
}