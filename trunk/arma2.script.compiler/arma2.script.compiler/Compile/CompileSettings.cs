namespace ArmA2.Script
{
    public class CompileSettings
    {
        #region Поля класса

        internal bool ApplyPrivateVars = true;

        public string FileName = string.Empty;
        public bool FsmContent;
        internal bool HideVars;

        public bool IsTopFile = true;
        internal bool ScriptMinimized;

        public string StringQuote = "'";

        #endregion

        #region Свойства класса

        public bool EnableMinimization
        {
            get
            {
                #if !DISABLEMINIMIZE
                    return ScriptMinimized;
                #else
                    return false;
                #endif
            }
            set
            {
                #if !DISABLEMINIMIZE
                    ScriptMinimized = value;
                #endif            
            }
        }

        #endregion

        #region Методы класса

        internal CompileSettings Clone()
        {
            return (CompileSettings) MemberwiseClone();
        }

        #endregion
    }
}