using ArmA2.Script.Compile;
using ArmA2.Script.Compile.TextWriters;

namespace ArmA2.Script.ScriptProcessor
{
    internal interface IScriptRenderer
    {
        void Render(ScriptWriter writer);
    }
}