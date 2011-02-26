using ArmA2.Script.Compile;
using ArmA2.Script.ScriptProcessor;
using NUnit.Framework;

namespace ArmA2.Script.UnitTests
{
    [TestFixture]
    public class TestValidation
    {
        [Test]
        public void LocalVariables()
        {
            string content = @"
Private [""_vehicle"",""_amount"",""_vehicle""];
_vehicle = _this select 0;

if (isNull _vehicle) exitWith {};
waitUntil {commonInitComplete};
sleep 2;
_amount = if (_vehicle isKindOf ""Plane"") then {'WFBE_COUNTERMEASUREPLANES' Call GetNamespace} else {'WFBE_COUNTERMEASURECHOPPERS' Call GetNamespace}
_vehicle setVariable [""FlareCount"", _amount, _vehicle];
_vehicle setVariable [""FlareActive"", false];

";

            Compiler c = new Compiler();
            string result = c.Compile(content);

        }

        [Test, Ignore]
        public void ForEachValidation()
        {
            Parser parser = new Parser();
            string content;
            content = "_var1=0; {} forEach _m;";
            var code = parser.CompileToByteCode(content);
            //var validate = Parser.Validate(code);

            content = "_var1=0; forEach _m;";
            code = parser.CompileToByteCode(content);
            //validate = Parser.Validate(code);
        }
    }
}