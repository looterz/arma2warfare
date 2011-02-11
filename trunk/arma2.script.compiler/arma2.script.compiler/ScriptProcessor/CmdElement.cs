using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public enum CmdScopeType
    {
        Unknown,
        Scope,
        Array,
        Expression
    }

    public class CmdElementCollection : List<CmdBase>
    {
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
        private readonly CmdElementCollection _items = new CmdElementCollection();

        public void ChildAdd(CmdBase child)
        {
            child.Parent = this;
            _items.Add(child);
        }

        public List<CmdBase> GetItems()
        {
            return _items;
        }

        public void CmdAdd(string cmdName)
        {
            if (cmdName.Length != 0)
            {
                if (Processor.IsCommand(cmdName))
                    ChildAdd(new CmdCommand { Text = cmdName });
                else if (Processor.IsOperator(cmdName))
                    ChildAdd(new CmdOperator { Text = cmdName });
                else
                    ChildAdd(new CmdVariable { Text = cmdName });
            }
        }

        public void SeparatorAdd(string separatorName)
        {
            if (separatorName.Length != 0)
            {
                if (Processor.IsOperator(separatorName))
                    ChildAdd(new CmdOperator { Text = separatorName });
                else
                    ChildAdd(new CmdSeparator { Text = separatorName });
            }
        }

        public CmdElementCollection Data
        {
            get
            {
                var items = new CmdElementCollection();
                items.AddRange(_items.Where(m => 
                    !(m is CmdSeparator && ((CmdSeparator)m).Text == ";"  ) &&
                    !(m is CmdSeparator && ((CmdSeparator)m).Text == " ") &&
                    !(m.GetType() == typeof(CmdElement) && ((CmdElement)m)._items.Count == 0)
                    ));
                return items;
            }
        }

        public override string ToString()
        {
            return _items.ToString();
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

    public class CmdCommand : CmdText
    {}

    public class CmdVariable : CmdText
    {}

    public class CmdOperator : CmdText
    { }

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

    public class CmdScope : CmdElement
    {
        public string OpenCh;

        public CmdScopeType Type
        {
            get
            {
                switch (OpenCh)
                {
                    case "[":
                        return CmdScopeType.Array;
                    case "{":
                        return CmdScopeType.Scope;
                    case "(":
                        return CmdScopeType.Expression;
                    default:
                        return CmdScopeType.Unknown;
                }               
            }
        }

        public string EndCh
        {
            get
            {
                switch(OpenCh)
                {
                    case "[": return "]";
                    case "{": return "}";
                    case "(": return ")";
                    default:
                        return "";
                }
            }
        }

        public override string ToString()
        {
            return OpenCh + base.ToString() + EndCh;
        }
    }
}