namespace ArmA2.Script
{
    public class CompilerSettings
    {
        public bool ApplyPrivateVars = true;
        public string FileName = string.Empty;
        public bool FsmContent;
        public bool HideVars;

        public bool IsTopFile = true;
        public bool ScriptMinimized = true;
        public string StringQuote = "'";

        internal CompilerSettings Clone()
        {
            return (CompilerSettings) MemberwiseClone();
        }
    }
}