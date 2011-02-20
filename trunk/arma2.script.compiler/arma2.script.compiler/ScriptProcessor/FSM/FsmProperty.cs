﻿using System;
using ArmA2.Script.ScriptProcessor.Commands;

namespace ArmA2.Script.ScriptProcessor
{
    public class FsmProperty : INamedItem
    {
        public bool IsValid { get; private set; }
        public string Name { get; private set; }
        public CmdBase Value { get; private set; }

        public FsmClass Parent;

        public T GetValue<T>() where T : CmdBase
        {
            if (Value is T)
                return (T) Value;

            return null;
        }
        
        public FsmProperty(CmdElement node)
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