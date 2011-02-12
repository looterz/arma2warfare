using System;
using System.IO;
using System.Linq;
using System.Text;
using ArmA2.Script;
using ArmA2.Script.ScriptProcessor;
using NUnit.Framework;

namespace ArmA2.Script.UnitTests
{
    [TestFixture]
    public class TestProcessor
    {
        [Test]
        public void TestArrayItems()
        {
            Processor processor = new Processor();
            var byteCode = processor.CompileToByteCode("private['a','b','c','d',if(a>b)then{0}else{1}]");

            var op = (CmdElement)byteCode.Data[0];
            Assert.AreEqual(2, op.Data.Count);

            var array = (CmdScopeArray)op.Data[1];
            Assert.AreEqual(5, array.Data.Count);

            Assert.AreEqual(4, array.Data.Select<CmdString>().Count, "must select 4 string items");
            Assert.AreEqual(1, array.Data.Select<CmdElement>().Count, "must select 1 code element");

        }

        [Test]
        public void TestByteCodePreProcessor()
        {
            Compiler compiler = new Compiler();
            string content = @"
#include ""myfunction.h""
_myobj call compile preprocess _path2file;";

            var result = compiler.Compile(content);
            Assert.AreEqual(result, "#include \"myfunction.h\"\n_myobj call compile preprocess _path2file;");

            Processor processor = new Processor();
            var byteCode = processor.CompileToByteCode(content.Replace("\r\n", "\n").Trim());
            Assert.AreEqual(2, byteCode.Data.Count, "must have two operators");

            content = @"
#define MYFUNC=""myfunction.h"" \
               MYFUNC2
_myobj call compile preprocess _path2file;";

            byteCode = processor.CompileToByteCode(content.Replace("\r\n", "\n").Trim());

            var expected =
                @"
#define MYFUNC=""myfunction.h"" \
               MYFUNC2
_myobj call compile preprocess _path2file;";
            Assert.AreEqual(byteCode.ToString(), expected.Replace("\r\n", "\n").Trim());
            Assert.AreEqual(2, byteCode.Data.Count, "must have two operators");

        }        
        
        [Test]
        public void TestCallFormat()
        {
            Compiler compiler = new Compiler();
            string content = "_myobj call compile format[\" _myobj{0} = 12345;   \", westSide];";

            content = compiler.Compile(content);
            Assert.AreEqual("_myobj call compile format[\" _myobj{0} = 12345;   \",westSide];", content);
        }
        
        [Test]
        public void TestCallCompile()
        {
            Compiler compiler = new Compiler();
            string content = "_myobj call compile \" _myobj1 = 12345;   \"";

            content = compiler.Compile(content);
            Assert.AreEqual("_myobj call compile \"_myobj1=12345;\"", content);

            content = "_myobj spawn compile \" _myobj1 = 12345;   \"";
            content = compiler.Compile(content);
            Assert.AreEqual("_myobj spawn compile \"private['_myobj1'];_myobj1=12345;\"", content);
        }

        [Test]
        public void TestSpawn()
        {
            Compiler compiler = new Compiler();
            string content = "_my1 spawn { _myobj = 12345; }";

            content = compiler.Compile(content);
            Assert.AreEqual("_my1 spawn{private['_myobj'];_myobj=12345}", content);
        }

        [Test]
        public void TestEventHandler()
        {
            Compiler compiler = new Compiler();
            string content = "_myobj addeventhandler['fired',\"_var1 = _this select 0;\"]";

            content = compiler.Compile(content);
            Assert.AreEqual("_myobj addeventhandler['fired',{private['_var1'];_var1=_this select 0;}]", content);
        }

        [Test]
        public void TestGroupSetOp()
        {
            Processor processor = new Processor();
            string content;
            content = "_var1=_var2*_var3";
            var result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);

            var op = (CmdElement) result.Data[0];
            Assert.AreEqual(3, op.Data.Count);


            content = "_var1=((sin _var2)*(cos _var3))";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);
        }


        [Test]
        public void TestSplitExpression()
        {
            Processor processor = new Processor();
            string content;
            content = "_var1=_var2*_var3";
            var result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);

            content = "_var1=_var2 plus (_var3 call LogHigh)";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);

            content = "_myobj addeventhandler['fired',\"_var1 = _this select 0;\"];_myobj2 addeventhandler['fired',\"_var1 = _this select 0;\"]";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(2, result.Data.Count);
        }

        [Test]
        public void TestScopeElements001()
        {
            Processor processor = new Processor();

            string content;
            CmdElement result;
            content = "_myobj addeventhandler['fired',\"_var1 = _this select 0;\"]";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);
            Assert.AreEqual(typeof(CmdElement), result.Data[0].GetType());

            var command = result.Data.Get<CmdElement>(0);
            Assert.AreEqual(3, command.Data.Count);
            Assert.AreEqual(typeof(CmdScopeArray), command.Data[2].GetType());

            var array = command.Data.Get<CmdElement>(2);
            Assert.AreEqual(2, array.Data.Count);
        }

        [Test]
        public void TestScopeElements002()
        {
            Processor processor = new Processor();

            string content;
            CmdElement result;
            content = "_myobj addeventhandler['fired',\"_var1 = _this select 0;\"];_myobj=5";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(2, result.Data.Count);
            Assert.AreEqual(typeof(CmdElement), result.Data[0].GetType());

            var command = result.Data.Get<CmdElement>(0);
            Assert.AreEqual(3, command.Data.Count);
            Assert.AreEqual(typeof(CmdScopeArray), command.Data[2].GetType());

            var array = command.Data.Get<CmdElement>(2);
            Assert.AreEqual(2, array.Data.Count);
        }


        [Test]
        public void TestSplitToCommands()
        {
            CmdElement result;
            Processor processor = new Processor();
            string content;
            content = "{if(WF_DEBUG)then{0}else{1},0,0}";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);
            Assert.AreEqual(typeof(CmdScopeCode), result.Data[0].GetType());

            content = "[if(WF_DEBUG)then{0}else{1},0,0]";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(1, result.Data.Count);
            Assert.AreEqual(typeof(CmdScopeArray), result.Data[0].GetType());


            
            content = "_var1=createVehcile['T71',0,0,0];_var2=createVehcile['T72',0,0,0];_var3=createVehcile['T73',0,0,0]";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
            Assert.AreEqual(3, result.Data.Count);

            content = "{_var1=createVehicle['T72',0,0,0];_var2=createVehcile['T72',0,0,0]} call LogHigh;_var4=12345;";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());

            Assert.AreEqual(2, result.Data.Count);
            var scope1 = (CmdElement) result.Data[0];
            Assert.AreEqual(3, scope1.Data.Count); // {_var1=createVehcile['T72',0,0,0];_var2=createVehcile['T72',0,0,0]} call LogHigh;
            var scope1_1 = (CmdElement)scope1.Data[0];
            Assert.AreEqual(2, scope1_1.Data.Count);  // {_var1=createVehcile['T72',0,0,0];_var2=createVehcile['T72',0,0,0]};

            var scope2 = (CmdElement)result.Data[1];
            Assert.AreEqual(3, scope2.Data.Count);  // _var4=12345;

            content = "{_var1=createVehicle['T72', if(WF_DEBUG)then{0}else{1},0,0];_var2=createVehcile['T72',0,0,0]} call LogHigh;_var4=12345;";
            result = processor.CompileToByteCode(content);
            Assert.AreEqual(content, result.ToString());
        }

        [Test]
        public void TestComplexSplitToCommands()
        {
            var path = Path.Combine(Environment.CurrentDirectory, "..\\..\\tests\\");
            var files = Directory.GetFiles(path).Where(m => Path.GetFileNameWithoutExtension(m).EndsWith(".a") && Path.GetExtension(m) != ".fsm");

            var outputBase = Console.Out;

            foreach(var file in files)
            {
                Logger.Clear();
                string content = File.ReadAllText(file);
                Processor processor = new Processor();

                var cmds = processor.CompileToByteCode(content);
                
                Assert.AreEqual(content, cmds.ToString(), string.Format("{0} - [Failed]", Path.GetFileName(file)));
                Assert.AreEqual(0, Logger.Errors.Count, string.Format("{0} - [Failed]", Path.GetFileName(file)));
                Assert.AreEqual(0, Logger.Warnings.Count, string.Format("{0} - [Failed]", Path.GetFileName(file)));

                Console.SetOut(outputBase);
                Console.WriteLine("{0} - [Done]", Path.GetFileName(file));
            }
        }
    }
}