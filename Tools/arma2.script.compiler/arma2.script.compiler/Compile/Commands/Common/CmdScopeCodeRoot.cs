﻿using System.Linq;
using ArmA2.Script.Compile.Collections;
using ArmA2.Script.Compile.Commands.SQF;
using ArmA2.Script.Compile.Exceptions;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdScopeCodeRoot : CmdScopeBase
    {
        private readonly Parser _parser;

        internal CmdScopeCodeRoot(Parser p)
        {
            _parser = p;
            OpenCh = "";
            EndCh = "";
        }

        internal override Parser Parser
        {
            get { return _parser ?? base.Parser; }
        }

        protected override void CompileInternal(Compiler compiler)
        {
            var op = NextElement(-1);
            bool topPrivateScope = (Parent == null || TopPrivateScope);
            if (op is CmdOperatorSet && NextElement(1) == null)
            {
                var varName = NextElement<CmdVariable>(-2);
                topPrivateScope = topPrivateScope | (varName != null && !varName.IsLocal);    // декларируем скоп как глобальный, если назначается глобальная функция
            }
            //applyPrivate = applyPrivate | (op is CmdCommand && ((CmdCommand)op).Text.Equal("spawn"));

            TopPrivateScope = topPrivateScope;

            base.CompileInternal(compiler);
        }

        protected override void CompilePrivateVar(Compiler compiler)
        {
            var op = NextElement(-1);
            var varName = NextElement<CmdVariable>(-2);
            bool considerParent = (varName != null && varName.IsLocal);
            considerParent = considerParent | (op is CmdCommand && ((CmdCommand)op).Text.Equal("spawn"));
            considerParent = considerParent | (op is CmdCommand && ((CmdCommand)op).Text.Equal("call"));

            var unused = PrivateVars.Where(localVar => !LocalVars.IsDeclared(localVar));

            if (unused.Count() > 0)
            {
                string list = "Unused, but declared as private: ";
                int i = 0;
                unused.ForEach(m => list = list + ((i++ == 0) ? "" : ",") + string.Format("'{0}'", m));

                list = list + "\nAt Scope: " + ShortTerm + "\n";
                var warn = new CompileException(CompileCode.PrivateVarUnused, list);
                warn.WriteToLog();
            }

            if ((TopPrivateScope || considerParent) && compiler.Settings.UpdatePrivateVars)
                ApplyPrivateVar(considerParent, compiler);

            base.CompilePrivateVar(compiler);
        }

        internal void ApplyPrivateVar(bool considerParent, Compiler compiler)
        {
            UniqueVarList considerLocals = new UniqueVarList(Parser.Compiler);
            if (considerParent)
            {
                var parentScope = this.ParentScope;
                while (parentScope != null)
                {
                    if (parentScope.HasLocalVars)
                    {
                        parentScope.LocalVars.ForEach(var => considerLocals.VarAdd(var));
                    }

                    if (parentScope.TopPrivateScope)
                        break;
                    parentScope = parentScope.ParentScope;
                }
            }

            var undeclared = LocalVars.Where(localVar => !PrivateVars.IsDeclared(localVar) && !considerLocals.IsDeclared(localVar));

            if (undeclared.Count() > 0)
            {
                string list = "Not declared as private: ";
                int i = 0;
                undeclared.ForEach(m => list = list + ((i++ == 0) ? "" : ",") + string.Format("'{0}'", m));

                list = list + "\nAt Scope: " + ShortTerm + "\n";
                var warn = new CompileException(CompileCode.PrivateVarUndeclared, list);
                warn.WriteToLog();
            }

            var privateCmds = Items.Select<CmdGroup>().Where(m => m.Items.Get<CmdPrivate>(0) != null);
            privateCmds.ForEach(m =>
            {
                var sep = m.NextItem(1);
                if (sep is CmdSeparator && ((CmdSeparator)sep).Text == ";")
                    sep.Parent.Items.Remove(sep);

                m.Parent.Items.Remove(m);
            });


            var localVars = LocalVars.Where(localVar => PrivateVars.IsDeclared(localVar) || !considerLocals.IsDeclared(localVar));
            if (localVars.Count() > 0)
            {
                CmdGroup privateCmd = new CmdGroup { Parent = this };
                Items.Insert(0, privateCmd);

                privateCmd.CmdAdd("private");

                var array = (CmdScopeArray)privateCmd.ChildAdd(new CmdScopeArray());
                privateCmd.SeparatorAdd(";");

                var reg = localVars.OrderBy(m => m).ToList();

                for (int i = 0; i < reg.Count; i++)
                {
                    array.ChildAdd(new CmdString { Text = reg[i], Quote = compiler.Settings.StringQuote });
                    if (i + 1 != LocalVars.Count)
                        array.SeparatorAdd(",");
                }
            }

            PrivateVars.Clear();
            LocalVars.ForEach(m => PrivateVars.VarAdd(m));
        }
    }
}