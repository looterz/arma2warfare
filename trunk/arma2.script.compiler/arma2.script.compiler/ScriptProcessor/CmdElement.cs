using System.Collections.Generic;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdElement
    {
        public List<CmdElement> Elements = new List<CmdElement>();

        public override string ToString()
        {
            string txt = "";
            Elements.ForEach(m => txt = txt + m);
            return txt;
        }
    }

    public class CmdOperator : CmdElement
    {
        public string Text;
        public override string ToString()
        {
            return Text;
        }
    }

    public class CmdString : CmdElement
    {
        public string Quote;
        public string Text;
        public override string ToString()
        {
            return Quote + Text + Quote;
        }
    }

    public class CmdSeparator : CmdElement
    {
        public string Text;
        public override string ToString()
        {
            return Text;
        }
    }

    public class CmdScope : CmdElement
    {
        public string OpenCh;

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