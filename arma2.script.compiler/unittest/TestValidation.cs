using ArmA2.Script.ScriptProcessor;
using NUnit.Framework;

namespace ArmA2.Script.UnitTests
{
    [TestFixture]
    public class TestValidation
    {
        [Test]
        public void ForEachValidation()
        {
            Processor processor = new Processor();
            string content;
            content = "_var1=0; {} forEach _m;";
            var code = processor.CompileToByteCode(content);
            var validate = processor.Validate(code);

            content = "_var1=0; forEach _m;";
            code = processor.CompileToByteCode(content);
            validate = processor.Validate(code);
        }
    }
}