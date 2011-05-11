using System.Reflection;
using Script.Compiler.Core.ScriptModel;
using Script.Compiler.Core.ScriptWriter;

namespace Script.Compiler.Languages.SQF
{
    class SqfConstructor : SqfMethod
    {
        public SqfConstructor(MethodBase method, IScriptClass sqfClass)
            : base(method, sqfClass)
        {
        }

        public override void RenderMethodCode(IScriptWriter writer)
        {
            writer.WriteLine("_this = 'objectBase' createVehicle [0, 0, 0];");
            base.RenderMethodCode(writer);

            writer.WriteLine();
            writer.WriteLine("_this; // return class instance");
        }
    }
}