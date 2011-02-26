namespace ArmA2.Script
{
    public class CompilerSettings
    {
        private bool _scriptMinimize;

        public bool ApplyPrivateVars = true;
        public string FileName = string.Empty;
        public bool FsmContent;
        public bool HideVars;

        public bool IsTopFile = true;
        public bool ScriptMinimized
        {
            get { return _scriptMinimize; }
            set { _scriptMinimize = value; }
        }
        public string StringQuote = "'";

        internal CompilerSettings Clone()
        {
            return (CompilerSettings) MemberwiseClone();
        }
    }
}