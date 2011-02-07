using System;
using System.IO;
using System.Linq;
using System.Text;
using ArmA2.Script;
using NUnit.Framework;

namespace Obfuscate
{
    [TestFixture]
    public class Tests
    {
        readonly Compiler _obfuscate = new Compiler();

        [Test]
        public void TestTemplates()
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
                Console.WriteLine("Test: {0}", Path.GetFileName(file));
                Console.SetOut(new StringWriter(new StringBuilder()));
                Compiler compiler = new Compiler();
                compiler.FsmContent = (Path.GetExtension(file).ToLower() == ".fsm");
                compiler.FileName = Path.GetFileName(file);

                string content = File.ReadAllText(file);
                string expectedFileName = Path.GetDirectoryName(file) + "\\" + Path.GetFileNameWithoutExtension(file) + ".a" + Path.GetExtension(file);
                string contentExpected = File.ReadAllText(expectedFileName);

                string contentActual = compiler.Compile(content);
                //if (contentActual != contentExpected)
                //    contentActual = contentActual;
                
                Assert.AreEqual(contentExpected, contentActual, string.Format("Test Failed:{0}", Path.GetFileName(file)));


                Console.SetOut(outputBase);
            }

        }


        [Test]
        public void TestRemoveScopeDetect()
        {
            var testText = @"sometext { somevar }";
            var ix1 = _obfuscate.GetScopeNext(testText, 0);
            var ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{ somevar }", testText.Substring(ix1, ix2 - ix1 + 1), "");

            testText = @"sometext { {somevar} }";
            ix1 = _obfuscate.GetScopeNext(testText, 0);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{ {somevar} }", testText.Substring(ix1, ix2 - ix1 + 1), "");

            testText = @"sometext { {somevar1} }  sometext { {somevar2} }";
            ix1 = _obfuscate.GetScopeNext(testText, 0);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{ {somevar1} }", testText.Substring(ix1, ix2 - ix1 + 1), "");

            ix1 = _obfuscate.GetScopeNext(testText, ix2);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1); 
            Assert.AreEqual("{ {somevar2} }", testText.Substring(ix1, ix2 - ix1 + 1), "");

            testText = @"sometext { {somevar1} }{ {somevar2} }";
            ix1 = _obfuscate.GetScopeNext(testText, 0);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{ {somevar1} }", testText.Substring(ix1, ix2 - ix1 + 1), "");

            ix1 = _obfuscate.GetScopeNext(testText, ix2);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{ {somevar2} }", testText.Substring(ix1, ix2 - ix1 + 1), "");


            testText = @"sometext {{somevar1}}{{somevar2}}";
            ix1 = _obfuscate.GetScopeNext(testText, 0);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{{somevar1}}", testText.Substring(ix1, ix2 - ix1 + 1), "");

            ix1 = _obfuscate.GetScopeNext(testText, ix2);
            ix2 = _obfuscate.GetScopeEnd(testText, ix1);
            Assert.AreEqual("{{somevar2}}", testText.Substring(ix1, ix2 - ix1 + 1), "");
        }

        [Test]
        public void TestRemoveStringBreaks()
        {
            var testText = @"_c=""TownCapturePublic: %1 ""  \n   "" asdasd""\n"" asdasdadd""";
            var result = _obfuscate.RemoveStringBreaks(testText);
            Assert.AreEqual(@"_c=""TownCapturePublic: %1  asdasd asdasdadd""", result, "");

            testText = @"""{_lastCoord = [0,0,0]};""\n""""\n""_coord = (_team)""";
            result = _obfuscate.RemoveStringBreaks(testText);
            Assert.AreEqual(@"""{_lastCoord = [0,0,0]};_coord = (_team)""", result, "");

        }

        [Test]
        public void TestRemoveExtraSpaces()
        {
            var testText = @"    var var1   =       ""Hello   world"";    var var2           = ""Hello   world"";";
            var result = _obfuscate.RemoveExtraSpaces(testText);
            Assert.AreEqual(@"var var1=""Hello   world"";var var2=""Hello   world"";", result, "");

            testText = @"    var var1   =       12345;";
            result = _obfuscate.RemoveExtraSpaces(testText);
            Assert.AreEqual(@"var var1=12345;", result, "");
        }

        [Test]
        public void TestRemoveMultiLineComment()
        {
            var testText = @"    var var1 = ""hell/*owor*/ld""; /* old code var /* var1 = ""hellow */orld""   */";
            var result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"var var1 = ""hell/*owor*/ld"";", result, "");

            testText = @"    var var1 = ""hell/*owor*/ld""; /* old code var var1 = ""helloworld"" */ var var2 = ""hell/*owor*/ld"";";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"var var1 = ""hell/*owor*/ld"";  var var2 = ""hell/*owor*/ld"";", result, "");

            testText = @"    var var1 = 12345; /* old code var var1 = ""helloworld"" */";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"var var1 = 12345;", result, "");

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*/";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual(@"", result, "");

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*//* next comment */";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual("", result, "");

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*/ 12345 /* next comment */";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual("12345", result, "");     

            testText = @"/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual(testText, result, "");

            testText = @"
/*%FSM<COMPILE ""F:\ArmA2\FSM Editor Personal Edition\scriptedFSM.cfg, fasttime"">*/
/*%FSM<HEAD>*/
/*
item0[] = {""Init"",0,250,-81.542984,-257.577942,8.457038,-207.578140,0.000000,""Init""};
*//*%FSM</HEAD>*/
class FSM";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual("class FSM", result, "");

            testText = "      init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\"/*%FSM</STATEINIT\"\"\">*/;";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual("init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\";", result, "");

            testText = @"/*  the player's information are stored or retrieved before being updated.*/ TEST";
            result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual("TEST", result, "");
        }

        [Test]
        public void TestRemoveMultiLineComment2()
        {
            var testText = "      init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\"/*%FSM</STATEINIT\"\"\">*/;";
            var result = _obfuscate.RemoveMultiLineComments(testText);
            Assert.AreEqual("init = \"WF_Logic setVariable [\"\"currentTime\"\",_currentTime,true];\";", result, "");
        }

        [Test]
        public void TestRemoveCommentSingleLine()
        {
            var result = _obfuscate.RemoveSingleLineComments("       var mymethod = 12123; // hello world");
            Assert.AreEqual("var mymethod = 12123;", result, "");

            result = _obfuscate.RemoveSingleLineComments("*//*%FSM</HEAD>*/");
            Assert.AreEqual("*/", result, "");

            result = _obfuscate.RemoveSingleLineComments("       var mymethod = 12123; var myText = \"// hello world\";");
            Assert.AreEqual("var mymethod = 12123; var myText = \"// hello world\";", result, "");

            result = _obfuscate.RemoveSingleLineComments("       var mymethod = 12123; var myText = \"// hello world\"; // some my comment");
            Assert.AreEqual("var mymethod = 12123; var myText = \"// hello world\";", result, "");

            result = _obfuscate.RemoveSingleLineComments("//--- Attempt to get the player's team.");
            Assert.AreEqual("", result, "");
        }
    }
}