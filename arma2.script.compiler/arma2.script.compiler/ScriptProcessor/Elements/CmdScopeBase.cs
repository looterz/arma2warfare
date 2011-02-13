using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
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

        public override void Render(ScriptWriter writer)
        {
            var state = writer.Minimized;
            int internalScopes = FlatData.Where(m => m is CmdScopeCode).Count();

            bool newLine = (this.Data.Count > 1 || internalScopes > 0);
            writer.Minimized = writer.Minimized || !newLine;

            if (internalScopes > 0 && this is CmdScopeCode)
                writer.Minimized = false;

            bool addIndent = !writer.Minimized;
            writer.WriteIndent(true, OpenCh);
            if (addIndent) 
                writer.Indent++;

            if (addIndent && FlatData.Count > 0 && !(FlatData[0] is CmdScopeCode))
                writer.WriteIndent(true, "");

            base.Render(writer);

            if (addIndent)
                writer.Indent--;


            //if (!writer.Minimized)
            writer.WriteIndent(true, EndCh);

            //writer.WriteIndent(newLine, EndCh);
            writer.Minimized = state;
        }
    }
}