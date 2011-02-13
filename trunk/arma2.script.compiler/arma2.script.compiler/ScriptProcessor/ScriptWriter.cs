using System.IO;

namespace ArmA2.Script.ScriptProcessor
{
    public class ScriptWriter : StreamWriter
    {
        private int _indent = 0;

        public int Indent { get { return _indent; } set { _indent = (value >= 0) ? value : 0; } }
        public bool Minimized = false;

        public void WriteIndent(bool allowIdent, string content, params object[] args)
        {
            if (args.Length > 0)
                content = string.Format(content, args);

            if (!GlobalSettings.AllowMinimize && !Minimized && allowIdent)
            {
                base.WriteLine();
                var indent = Indent;
                while (indent-- > 0)
                    base.Write("    ");
            }
            base.Write(content);
        }

        public ScriptWriter(Stream stream) : base(stream)
        {}
    }
}