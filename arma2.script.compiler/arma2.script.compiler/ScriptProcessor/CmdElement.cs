using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdElementCollection: CmdElementCollectionBase<CmdBase>
    {}

    public class CmdElementCollectionBase<T> : List<T> where T : CmdBase
    {
        private int _position = 0;

        public void SetPosition(int position)
        {
            _position = position;
        }

        public CmdElementCollectionBase<T1> Select<T1>() where T1 : CmdBase
        {
            var items = new CmdElementCollectionBase<T1>();

            foreach(T item in this)
            {
                if (item is T1)
                    items.Add(((T1)(object)item));
            }

            return items;
        }

        public T Get<T>(int offset) where T : CmdBase
        {
            int pos = _position + offset;
            if (pos >= 0 && pos < this.Count())
            {
                CmdBase item = this[pos];
                if (item is T) 
                    return (T)item;
            }
            return null;
        }

        public override string ToString()
        {
            string txt = "";
            this.ForEach(m => txt = txt + m);
            return txt;
        }        
    }

    //[DebuggerTypeProxy(typeof(Flatten))]
    public class CmdBase
    {
        public CmdElement Parent { get; set; }        
    }

    public class CmdElement : CmdBase
    {
        public readonly CmdElementCollection Items = new CmdElementCollection();

        public CmdBase ChildAdd(CmdBase child)
        {
            child.Parent = this;
            Items.Add(child);

            return child;
        }

        public CmdText CmdAdd(string cmdName)
        {
            if (cmdName.Length != 0)
            {
                CmdText cmd;
                if (Processor.IsCommand(cmdName))
                    cmd = new CmdCommand { Text = cmdName };
                else if (Processor.IsOperator(cmdName))
                    cmd = new CmdOperator { Text = cmdName };
                else
                    cmd = new CmdVariable { Text = cmdName };

                ChildAdd(cmd);
                return cmd;
            }
            return null;
        }

        public CmdBase SeparatorAdd(string separatorName)
        {
            if (separatorName.Length != 0)
            {
                if (Processor.IsOperator(separatorName))
                    return ChildAdd(new CmdOperator { Text = separatorName });

                return ChildAdd(new CmdSeparator { Text = separatorName });
            }
            return null;
        }

        public CmdElementCollection Data
        {
            get
            {
                var items = new CmdElementCollection();
                items.AddRange(Items.Where(m => 
                    !(m is CmdSeparator) &&
                    !(m.GetType() == typeof(CmdElement) && ((CmdElement)m).Items.Count == 0)
                    ));
                return items;
            }
        }

        public override string ToString()
        {
            return Items.ToString();
        }
    }

    public class CmdText : CmdBase
    {
        public string Text;
        public override string ToString()
        {
            return Text;
        }
    }

    public class CmdCommandBase : CmdText
    {}

    public class CmdCommand : CmdCommandBase
    { }

    public class CmdOperator : CmdCommandBase
    { }

    public class CmdVariable : CmdText
    {}

    public class CmdSeparator : CmdText
    {}

    public class CmdString : CmdText
    {
        public string Quote;
        public override string ToString()
        {
            return Quote + base.ToString() + Quote;
        }
    }

    public class CmdScopeArray : CmdScopeBase
    {
        public CmdScopeArray()
        {
            OpenCh = "[";
            EndCh = "]";
        }
    }

    public class CmdScopeCode : CmdScopeBase
    {
        public CmdScopeCode()
        {
            OpenCh = "{";
            EndCh = "}";
        }
    }

    public class CmdScopeExpression : CmdScopeBase
    {
        public CmdScopeExpression()
        {
            OpenCh = "(";
            EndCh = ")";
        }
    }

    public class CmdScopeBase : CmdElement
    {
        public CmdScopeBase()
        {
            OpenCh = EndCh = string.Empty;
        }

        public static CmdScopeBase CreateNewScope(string openScopeCh)
        {
            switch (openScopeCh)
            {
                case "[":
                    return new CmdScopeArray();
                case "{":
                    return new CmdScopeCode();
                case "(":
                    return new CmdScopeExpression();
                default:
                    {
                        Logger.Log(LogLevel.Warning, "CreateNewScope: Unknown open scope char - '{0}'", openScopeCh);
                        return new CmdScopeBase();
                    }
            } 
        }

        public string OpenCh { get; protected set; }
        public string EndCh { get; protected set; }

        public override string ToString()
        {
            return OpenCh + base.ToString() + EndCh;
        }
    }
}