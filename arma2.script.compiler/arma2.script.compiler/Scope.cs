using System.Collections.Generic;

namespace ArmA2.Script
{
    public class Scope
    {
        public int Start = -1, End = -1;
        public string OpenCh;   // символ открывающий скоп
        public string EndCh;   // символ закрывающий скоп

        public string Text;

        public int Length
        {
            get { return (Start != -1 && End != -1) ? End - Start : -1; }
        }

        public string ScopeText
        {
            get { return (End != -1) ? Text.Substring(Start, End - Start + 1) : Text.Substring(Start); }
        }
    }
}