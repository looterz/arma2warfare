using ArmA2.Script.Compile.Collections;
using ArmA2.Script.Compile.Commands.Common;
using ArmA2.Script.Compile.Commands.SQF;

namespace ArmA2.Script.Compile.Commands.FSM
{
    internal class FsmProperty : INamedItem
    {
        internal bool IsValid { get; private set; }
        internal string Name { get; private set; }
        internal CmdBase Value { get; private set; }

        internal FsmClass Parent;

        internal T GetValue<T>() where T : CmdBase
        {
            if (Value is T)
                return (T) Value;

            return null;
        }
        
        internal FsmProperty(CmdGroup node)
        {
            IsValid = false;

            var varName = node.Commands.Get<CmdVariable>(0);
            var opSet = node.Commands.Get<CmdOperatorSet>(1);
            var value = node.Commands.Get<CmdBase>(2);

            if (varName == null || opSet == null || value == null)
                return;

            Name = varName.Text;
            Value = value;
            IsValid = true;
        }

        public override string ToString()
        {
            return Parent + " // " + Name + " = " + Value;
        }

        public string GetName()
        {
            return Name;
        }
    }
}