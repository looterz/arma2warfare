using System.Reflection.Emit;

namespace jsc.Languages.SQF.ScriptBuilder
{
    public class OperationHandlers
    {
        public OpCodeHandler[] Handlers;

        public OperationHandlers()
        {
            Handlers = new OpCodeHandler[0xFFFF];
        }

        public OpCodeHandler this[params OpCode[] i]
        {
            set
            {
                foreach (OpCode c in i)
                    this[c] = value;
            }
        }

        public OpCodeHandler this[OpCode i]
        {
            get
            {
                return this[i.Value];
            }
            set
            {
                this[i.Value] = value;
            }
        }

        public OpCodeHandler this[short i]
        {
            get
            {
                return Handlers[i & 0x0000ffff];
            }
            set
            {
                Handlers[i & 0x0000ffff] = value;
            }
        }
    }
}