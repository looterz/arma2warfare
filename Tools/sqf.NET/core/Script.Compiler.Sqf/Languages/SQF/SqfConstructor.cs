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

        public override void RenderMethodBody(IScriptWriter writer)
        {
            if (Method.Name == ".cctor")
            {
                base.RenderMethodBody(writer);
                return;
            }

            writer.Write("if (isNil \"_this\") then ");
            using (writer.Scope("{", "};"))
            {
                writer.WriteLine("_this = 'objectBase' createVehicle [0, 0, 0];");
            }
            base.RenderMethodBody(writer);

            writer.WriteLine();
            writer.WriteLine("_this; // return class instance");
        }
    }
}