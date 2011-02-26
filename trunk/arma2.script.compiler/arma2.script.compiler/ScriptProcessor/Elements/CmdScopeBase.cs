using System.Collections.Generic;
using System.Linq;
using ArmA2.Script.Compile;
using ArmA2.Script.Compile.Collections;
using ArmA2.Script.Compile.Exceptions;

namespace ArmA2.Script.ScriptProcessor
{
    internal class CmdScopeBase : CmdGroup
    {
        private UniqueVarList _localVars = null;
        private UniqueVarList _privateVars = null;

        internal bool TopPrivateScope { get; set; }

        internal Dictionary<string, object> CompileProperties = new Dictionary<string, object>();

        internal bool HasLocalVars
        {
            get { return (_localVars != null && _localVars.Count != 0); }
        }

        internal bool IsDeclaredInOuterScope(string varName)
        {
            if (LocalVars.IsDeclared(varName))
                return true;

            return (ParentScope != null && !TopPrivateScope) ? ParentScope.IsDeclaredInOuterScope(varName) : false;
        }

        internal UniqueVarList PrivateVars
        {
            get
            {
                if (_privateVars == null)
                    _privateVars = new UniqueVarList(Processor.Compiler);

                return _privateVars;
            }
        }

        internal UniqueVarList LocalVars
        {
            get
            {
                if (_localVars == null)
                    _localVars = new UniqueVarList(Processor.Compiler);

                return _localVars;
            }
        }

        internal CmdScopeBase()
        {
            OpenCh = EndCh = string.Empty;
        }

        public string OpenCh { get; protected set; }
        public string EndCh { get; protected set; }

        protected override void CompileInternal(Compiler compiler)
        {
            base.CompileInternal(compiler);
            CompilePrivateVar(compiler);
        }

        protected virtual void CompilePrivateVar(Compiler compiler)
        {
            if (CompileProperties.ContainsKey("UseUndeclaredVars"))
            {
                UniqueVarList useUndeclaredVars = (UniqueVarList)CompileProperties["UseUndeclaredVars"];

                if (useUndeclaredVars.Count() > 0)
                {
                    string list = "Variables used, but not have assigned: ";
                    int i = 0;
                    useUndeclaredVars.ForEach(m => list = list + ((i++ == 0) ? "" : ",") + string.Format("'{0}'", m));

                    list = list + "\nAt Scope: " + ShortTerm + "\n";
                    var warn = new CompileException(CompileCode.UsedNotAssigned, list);
                    warn.WriteToLog();
                }
            }

            if (this.ParentScope != null)
            {
                var undeclared = LocalVars.Where(localVar => !PrivateVars.IsDeclared(localVar));
                undeclared.ForEach(n => this.ParentScope.LocalVars.VarAdd(n));
            }
        }

        public override void Render(ScriptWriter writer)
        {
            var state = writer.Minimized;
            int internalScopes = FlatData.Where(m => m is CmdScopeCode).Count();

            bool newLine = (this.Commands.Count > 1 || internalScopes > 0);
            writer.Minimized = writer.Minimized || !newLine;

            if (internalScopes > 0 && this is CmdScopeCode)
                writer.Minimized = false;

            bool addIndent = !writer.Minimized;
            if (this is CmdScopeCodeRoot && this.Parent == null)
                addIndent = false;

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