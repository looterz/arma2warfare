using System.Reflection.Emit;

namespace jsc
{
    public static class OpCodeExtensions
    {
        public static bool IsOpCodeLeave(this OpCode e)
        {
            return e == OpCodes.Leave
                   || e == OpCodes.Leave_S;
        }
    }
}