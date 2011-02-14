using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdScopeBase : CmdElement
    {
        private List<string> _privateVars = null;

        public bool HasLocalVars
        {
            get { return (_privateVars != null && _privateVars.Count != 0); }
        }

        public List<string> LocalVars
        {
            get
            {
                if (Parent == null || this is CmdScopeFunction)
                {
                    if (_privateVars == null)
                        _privateVars = new List<string>();

                    return _privateVars;
                }

                return Scope.LocalVars;
            }
        }

        public CmdScopeBase()
        {
            OpenCh = EndCh = string.Empty;
        }

        public string OpenCh { get; protected set; }
        public string EndCh { get; protected set; }

        public override void Render(ScriptWriter writer)
        {
            var state = writer.Minimized;
            int internalScopes = FlatData.Where(m => m is CmdScopeCode).Count();

            bool newLine = (this.Commands.Count > 1 || internalScopes > 0);
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