using jsc;

namespace Script.Compiler.Languages.SQF.ScriptBuilder
{
    public delegate void OpCodeHandler(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s);
}