using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using jsc.Languages.JavaScript;
using jsc.Languages.SQF;
using jsc.Languages.SQF.ScriptBuilder;
using jsc.Script;
using ScriptCoreLib;
using ScriptCoreLib.CSharp.Extensions;
using ScriptCoreLib.Extensions;

namespace jsc.Sqf
{
    public class SqfMethodBodyWriter
    {
        #region Методы класса

        public void Emit(ScriptWriter w, ILBlock.Prestatement p)
        {
            if (IL2ScriptGenerator.Handlers[p.Instruction.OpCode.Value] == null)
            {
                CompilerBase.BreakToDebugger("unknown opcode " + p.Instruction.OpCode.Name + " at " +
                                             p.Instruction.OwnerMethod.Name + " + " +
                                             string.Format("0x{0:x4}", p.Instruction.Offset));

                throw new InvalidOperationException();
            }
            if (p.Instruction == OpCodes.Nop)
            {
                return;
            }

            if (p.Next == null &&
                p.Instruction == OpCodes.Ret)
            {
                try
                {
                    if (p.Instruction.NextInstruction == null)
                    {
                        if (p.Instruction.OwnerMethod.IsInstanceConstructor())
                        {
                            return;
                        }

                        if (p.Instruction.OwnerMethod is MethodInfo)
                        {
                            if ((p.Instruction.OwnerMethod as MethodInfo).ReturnType == typeof (void))
                            {
                                return;
                            }
                        }
                        else
                        {
                            if (p.Instruction.OwnerMethod.IsStatic)
                            {
                                return;
                            }
                        }
                    }
                }
                catch
                {
                    // wtf
                    Debugger.Break();
                }
            }

            if (p.Instruction.IsLoadInstruction)
            {
                // 		p.Instruction.Flow.OwnerBlock.ToConsole()	Expression has been evaluated and has no value	void
                CompilerBase.BreakToDebugger(
                    "a load instruction was selected as prestatement. this is a bug within jsc. " +
                    p.Instruction.Location + " " + p.Instruction);
            }

            w.WriteIdent();
            try
            {
                SqfMethodBodyWriter bodyWriter = new SqfMethodBodyWriter();
                bodyWriter.OpCodeHandler(w, p);

                w.WriteLine(";");
            }
            catch (Languages.SQF.ScriptBuilder.SkipThisPrestatementException)
            {
                w.WriteLine();
            }
        }

        public void EmitScope(ScriptWriter w, ILBlock.PrestatementBlock s, bool canCollapse)
        {
            EmitScope(w, s, canCollapse, null);
        }

        public void EmitScope(ScriptWriter w, ILBlock.PrestatementBlock s, bool canCollapse,
                                     Predicate<ILBlock.Prestatement> predicate)
        {
            w.WriteBeginScope();
            EmitPrestatementBlock(w, s, predicate);
            w.WriteEndScope();
        }

        public void EmitPrestatementBlock(ScriptWriter w, ILBlock.PrestatementBlock s)
        {
            EmitPrestatementBlock(w, s, null);
        }

        public void EmitPrestatementBlock(ScriptWriter w, ILBlock.PrestatementBlock s, Predicate<ILBlock.Prestatement> predicate)
        {
            for (int x = 0; x < s.PrestatementCommands.Count; x++)
            {
                ILBlock.Prestatement p = s.PrestatementCommands[x];

                if (predicate != null)
                {
                    if (predicate(p))
                    {
                        continue;
                    }
                }

                #region try

                if (p.Block != null)
                {
                    if (p.Block.IsTryBlock)
                    {
                        w.WriteIdent();
                        w.WriteLine("try");

                        ILBlock.PrestatementBlock b = p.Block.Prestatements;

                        bool _pop = false;
                        bool leave =
                            OpCodeExtensions.IsOpCodeLeave(b.Last)
                            && b.Last.TargetInstruction == b.OwnerBlock.NextNonClauseBlock.First;

                        EmitScope(w, b.ExtractBlock(_pop ? b.First.Next : b.First, leave ? b.Last.Prev : b.Last), false);

                        continue;
                    }

                    if (p.Block.IsHandlerBlock)
                    {
                        w.WriteIdent();

                        ILBlock.PrestatementBlock b = p.Block.Prestatements;

                        bool _pop = b.First == OpCodes.Pop &&
                                    (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Clause);
                        bool leave =
                            b.Last == OpCodes.Endfinally
                            ||
                            (OpCodeExtensions.IsOpCodeLeave(b.Last) &&
                             b.Last.TargetInstruction == b.OwnerBlock.NextNonClauseBlock.First);

                        b = b.ExtractBlock(_pop ? b.First.Next : b.First, leave ? b.Last.Prev : b.Last);

                        b.RemoveNopOpcodes();

                        if (b.PrestatementCommands.Count == 0)
                        {
                            if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Finally)
                            {
                                w.WriteLine("finally ");
                            }
                            else if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Clause)
                            {
                                w.Write("catch (");
                                w.Helper.DOMWriteCatchParameter();
                                w.Write(")");
                            }
                            else
                            {
                                Debugger.Break();
                            }

                            w.Write("{ }");
                            w.WriteLine();
                        }
                        else
                        {
                            if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Finally)
                            {
                                w.WriteLine("finally");
                            }
                            else if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Clause)
                            {
                                w.Write("catch (");
                                w.Helper.DOMWriteCatchParameter();
                                w.Write(")");
                                w.WriteLine();
                            }
                            else
                            {
                                Debugger.Break();
                            }

                            EmitScope(w, b, false);
                        }

                        continue;
                    }
                }

                #endregion

                #region if

                ILIfElseConstruct iif = p.Instruction.InlineIfElseConstruct;

                if (iif != null)
                {
                    w.WriteLine();
                    w.WriteIdent();
                    w.Write("if");
                    w.WriteSpace();

                    if (iif.Branch.IsAnyOpCodeOf(OpCodes.Bge, OpCodes.Bge_S))
                    {
                        #region F# FailInit check :)

                        #region only false block

                        if (iif.BodyTrueFirst == null)
                        {
                            w.Write("(");
                            IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                            w.Write(" < ");
                            IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, iif.Branch.StackBeforeStrict[1]);
                            w.Write(")");
                            w.WriteLine();

                            EmitScope(w, p.Owner.ExtractBlock(iif.BodyFalseFirst, iif.BodyFalseLast), true);

                            w.WriteLine();
                            continue;
                        }

                        #endregion

                        w.Write("(");
                        IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                        w.Write(" > ");
                        IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, iif.Branch.StackBeforeStrict[1]);
                        w.Write(")");

                        #endregion
                    }
                    else if (iif.Branch.IsAnyOpCodeOf(OpCodes.Brfalse_S, OpCodes.Brfalse))
                    {
                        w.Write("(");
                        IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                        w.Write(")");
                    }
                    else if (iif.Branch.IsAnyOpCodeOf(OpCodes.Brtrue_S, OpCodes.Brtrue))
                    {
                        // fix 2.03.2006
                        w.Write("(");
                        w.Write("!");

                        ILFlowStackItem expression = iif.Branch.StackBeforeStrict[0];

                        bool compact = false;

                        if (expression.StackInstructions.Length == 1)
                        {
                            if (expression.SingleStackInstruction.TargetVariable != null)
                            {
                                compact = true;
                            }
                        }

                        if (compact)
                        {
                            IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, expression);
                        }

                        else
                        {
                            w.Write("(");
                            IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, expression);

                            w.Write(")");
                        }

                        w.Write(")");
                        //w.Write("(!(");
                        //IL2ScriptGenerator.OpCodeHandler(w, p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                        //w.Write("))");
                    }
                    else
                    {
                        Task.Error("if block not detected correctly, opcode was " + iif.Branch.OpCode.Name);
                        Task.Fail(null);
                    }

                    w.WriteLine();

                    //w.WriteCommentLine(iif.Branch.ToString());

                    EmitScope(w, p.Owner.ExtractBlock(iif.BodyTrueFirst, iif.BodyTrueLast), true);

                    if (iif.HasElseClause)
                    {
                        w.WriteIdent();
                        w.WriteLine("else");

                        EmitScope(w, p.Owner.ExtractBlock(iif.BodyFalseFirst, iif.BodyFalseLast), true);
                    }

                    w.WriteLine();

                    continue;
                }

                #endregion

                #region loop

                ILLoopConstruct loop = p.Instruction.InlineLoopConstruct;

                if (loop != null)
                {
                    if (loop.IsBreak(p.Instruction))
                    {
                        w.WriteIdent();
                        w.WriteLine("break;");
                        continue;
                    }

                    if (loop.IsContinue(p.Instruction))
                    {
                        w.WriteIdent();
                        w.WriteLine("continue;");
                        continue;
                    }

                    w.WriteIdent();
                    w.Write("while");
                    w.WriteSpace();
                    w.Write("(");

                    ILBlock.PrestatementBlock block;

                    block = p.Owner.ExtractBlock(loop.CFirst, loop.CLast);
                    block.IsCompound = true;

                    if (block.LastPrestatement.Instruction.OpCode.FlowControl == FlowControl.Branch)
                    {
                        w.Write("true");
                    }
                    else
                    {
                        IL2ScriptGenerator.OpCodeHandlerArgument(w, block.LastPrestatement);
                    }

                    w.Write(")");
                    w.WriteLine();

                    EmitScope(w, p.Owner.ExtractBlock(loop.BodyFirst, loop.BodyLast), true);

                    continue;
                }

                #endregion

                #region opt-out

                if (p != null && p.Instruction != null)
                {
                    try
                    {
                        if (p.Instruction == OpCodes.Nop)
                        {
                            continue;
                        }

                        if (p.Instruction.OpCode == OpCodes.Call)
                        {
                            if (p.Instruction.TargetConstructor != null)
                            {
                                if (p.Instruction.TargetConstructor.DeclaringType == typeof (object))
                                {
                                    continue;
                                }
                            }
                        }

                        if (p.Instruction == OpCodes.Ret)
                        {
                            if (p.Next == null)
                            {
                                if (p.Instruction.StackBeforeStrict.Length == 0)
                                {
                                    continue;
                                }
                            }
                        }
                    }
                    catch
                    {
                        Console.WriteLine("optout failed");
                    }
                }

                #endregion

                #region SupportsForStatements

                /* if (SupportsForStatements)*/
                {
                    if (p.IsValidForStatement)
                    {
                        x += 1;
                        WriteForStatement(w, p);
                        continue;
                    }
                }

                #endregion

                #region newarr

                /* if (SupportsInlineArrayInit) */
                {
                    if (p.IsValidInlineArrayInit)
                    {
                        x += p.InlineArrayInitElementsFound;
                    }
                }

                #endregion

                Emit(w, p);
            }
        }

        private void WriteForStatement(ScriptWriter w, ILBlock.Prestatement p)
        {
            if (!p.IsValidForStatement)
            {
                CompilerBase.BreakToDebugger("not a valid for statement");
            }

            w.WriteLine();

            //p.Instruction.ToConsole(4);

            w.WriteIdent();
            w.Write("for (");

            IL2ScriptGenerator.OpCodeHandler(w, p);

            w.Write("; ");

            ILLoopConstruct loop = p.Next.Instruction.InlineLoopConstruct;

            ILBlock.PrestatementBlock block = p.Owner.ExtractBlock(loop.CFirst, loop.CLast);

            block.IsCompound = true;

            if (block.LastPrestatement.Instruction.OpCode.FlowControl == FlowControl.Branch)
            {
                w.Write("true");
            }
            else
            {
                IL2ScriptGenerator.OpCodeHandler(w, block.LastPrestatement, block.LastPrestatement.Instruction,
                                                 block.LastPrestatement.Instruction.StackBeforeStrict[0]);
            }

            w.Write("; ");

            ILBlock.PrestatementBlock wblock = p.Owner.ExtractBlock(loop.BodyFirst, loop.BodyLast);

            IL2ScriptGenerator.OpCodeHandler(w, wblock.LastPrestatement);

            w.WriteLine(")");

            w.WriteBeginScope();

            EmitPrestatementBlock(w, wblock,
                                  delegate(ILBlock.Prestatement xxp)
                                  {
                                      return xxp == wblock.LastPrestatement;
                                  }
                );
            w.WriteEndScope();

            w.WriteLine();
        }

        public void EmitBody(ScriptWriter w, MethodBase i, bool defineSelf)
        {
            if (i.IsAbstract)
            {
                w.Write("throw new Error('abstract method');");

                return;
            }

            try
            {
                var xb = new ILBlock(i);
                ScriptAttribute a = ScriptAttribute.OfProvider(i);

                if (MethodBodyOptimizer.TryOptimize(w, xb))
                {
                    return;
                }

                CompilerBase.DebugBreak(a);

                bool noexeptions = (a != null && a.NoExeptions);

                if (noexeptions)
                {
                    w.WriteIdent();
                    w.WriteLine("try");
                    w.WriteBeginScope();
                }

                ILBlock.PrestatementBlock b = xb.Prestatements;

                if (b.PrestatementCommands.Count > 0)
                {
                    ILInstruction instruction = b.PrestatementCommands[0].Instruction;

                    // the IL is not calling base.ctor() ? :)

                    bool ctor = i.IsInstanceConstructor();
                    bool ctorObjbase = ctor && instruction == OpCodes.Call &&
                                       instruction.TargetConstructor.DeclaringType == typeof (object);

                    EmitPrestatementBlock(w, b.ExtractBlock(ctorObjbase ? instruction.Next : b.First, b.Last));
                }

                if (noexeptions)
                {
                    w.WriteEndScope();
                    w.WriteIdent();
                    w.WriteLine("catch (_ne) {}");
                }
            }
            catch (Exception exc)
            {
                CompilerBase.BreakToDebugger(
                    "Method: " + i.Name + ", Type: " + i.DeclaringType.FullName + "; " +
                    "emmiting failed : " + exc.Message + " at " + exc.StackTrace
                    );
            }
        }

        public void DeclareStaticConstructors(ScriptWriter w, Type[] types, bool debug)
        {
            foreach (Type z in types)
            {
                if (!z.IsClass)
                {
                    continue;
                }

                ScriptAttribute sa = z.ToScriptAttribute();

                if (sa == null)
                {
                    continue;
                }

                ConstructorInfo[] ci =
                    z.GetConstructors(BindingFlags.Static | BindingFlags.DeclaredOnly | BindingFlags.NonPublic |
                                      BindingFlags.Public);
                foreach (ConstructorInfo zc in ci)
                {
                    ScriptAttribute xsa = ScriptAttribute.Of(z);

                    if (xsa != null && xsa.IsDebugCode && debug)
                    {
                        new ILBlock(zc).ToConsole();
                    }

                    w.Helper.DOMWriteTerminator(
                        delegate
                        {
                            w.Helper.DOMAnonymousMethodCall(zc);
                        }
                        );

                    w.WriteLine();
                    w.WriteLine();
                }
            }
        }

        public void DeclareVirtualMethods(ScriptWriter w, Type owner)
        {
            // find the virtual name or names

            if (ScriptAttribute.Of(owner).HasNoPrototype)
            {
                return;
            }

            //owner.
            Type[] t = owner.GetInterfaces();

            bool b = false;

            Action afterAction = null;

            Action beforeAction = delegate
            {
                w.WriteIdent();
                w.Write("(function (i)");

                w.WriteBeginScope();

                afterAction = delegate
                {
                    w.WriteEndScope();

                    w.WriteIdent();
                    w.Write(")(");
                    w.Helper.WritePrototypeAlias(owner);
                    w.WriteLine(");");
                };
            };

            Action afterOnce =
                delegate
                {
                    if (afterAction == null)
                    {
                        return;
                    }

                    afterAction();

                    afterAction = null;
                };

            Action beforeOnce =
                delegate
                {
                    if (beforeAction == null)
                    {
                        return;
                    }

                    beforeAction();

                    beforeAction = null;
                };

            foreach (Type x in t)
            {
                InterfaceMapping z = owner.GetInterfaceMap(x);

                int ix = 0;

                foreach (MethodInfo zm in z.TargetMethods)
                {
                    beforeOnce();

                    // abstract classes implementing interfaces...
                    if (z.TargetMethods[ix] != null)
                    {
                        w.WriteIdent();

                        w.Write("i");
                        w.Helper.WriteAccessor();
                        w.WriteDecoratedMethodName(z.InterfaceMethods[ix]);

                        w.WriteAssignment();

                        w.Write("i");
                        w.Helper.WriteAccessor();
                        w.WriteDecoratedMethodName(z.TargetMethods[ix]);
                        w.Helper.WriteTerminator();
                        w.WriteLine();
                    }

                    //w.Helper.DOMCopyMember(owner, z.InterfaceMethods[ix], z.TargetMethods[ix]);

                    b = true;

                    ix++;
                }
            }

            afterOnce();

            //if (b)
            //    w.WriteLine();
        }

        public static void OverrideVirtualMember(ScriptWriter w, Type z, MethodInfo m)
        {
            w.WriteIdent();

            ParameterInfo[] p = m.GetParameters();

            var pt = new Type[p.Length];

            for (int i = 0; i < p.Length; i++)
            {
                pt[i] = p[i].ParameterType;
            }

            ParameterModifier pm = p.Length > 0 ? new ParameterModifier(p.Length) : new ParameterModifier();

            if (p.Length > 0)
            {
                for (int i = 0; i < p.Length; i++)
                {
                    pm[i] = true;
                }
            }

            Type _base = z;

            while (true)
            {
                _base = _base.BaseType;

                MethodInfo[] xxx = _base.GetMethods();

                var v = (MethodInfo) w.Session.ResolveMethod(m, _base, null);

                MethodInfo[] zzz = _base.GetMethods(
                    //                m.Name,
                    BindingFlags.ExactBinding
                    | BindingFlags.Instance
                    | BindingFlags.DeclaredOnly
                    | BindingFlags.Public
                    | BindingFlags.NonPublic
                    //,
                    //null,
                    //CallingConventions.HasThis,
                    //pt, new ParameterModifier[] { pm }
                    );

                if (v != null)
                {
                    w.WriteIdent();
                    w.WriteDecorated(z);
                    w.Write(".prototype.");
                    w.WriteDecoratedMethodName(v);
                    w.WriteHint("virtual override");
                    w.Write(" = ");
                    w.WriteDecorated(z);
                    w.Write(".prototype.");
                    w.WriteDecoratedMethodName(m);
                    w.WriteLine(";");

                    //Task.WriteLine("virtual overload [{0}]", v.Name);

                    return;
                }

                if (_base == typeof (object))
                {
                    break;
                }
            }

            if (CompilerBase.IsToStringMethod(m))
            {
                return;
            }

            Task.Error("override is in effect, base class mehtod should be overridden");
            Task.Error("unable to map override to [{0}.{1}]", m.DeclaringType, m.Name);
            Task.Fail(null);
        }

        public static void DeclareMethods(ScriptWriter w, MethodBase[] mi)
        {
            #region methods

            foreach (MethodInfo zm in mi)
            {
                ScriptAttribute zsa = ScriptAttribute.Of(zm);

                //bool _define = true; 

                if (zsa != null)
                {
                    if (zsa.HasNoPrototype)
                    {
                        Debugger.Break();
                        continue;
                    }

                    if (zsa.ExternalTarget != null)
                    {
                        Task.WriteLine("method: {0}", zsa.ExternalTarget);
                        continue;
                    }
                }

                Task.Enabled = zsa != null && zsa.IsDebugCode;

                if (zm.DeclaringType.FullName + "." + zm.Name == "GameOfLife.Game.GameOfLife.CreateUnit")
                {
                    Task.Enabled = Task.Enabled;
                }

                w.WriteCommentLine("{0}.{1}", zm.DeclaringType.FullName, zm.Name);

                if (!zm.IsStatic && zsa != null && zsa.DefineAsStatic)
                {
                    // attach an instance function as static

                    #region DefineAsStatic

                    ParameterInfo[] pi = zm.GetParameters();

                    w.WriteIdent();
                    w.WriteDecoratedMethodName(zm);
                    w.Write(" = function ");
                    w.Write("(");
                    w.WriteSelf();

                    if (pi.Length > 0)
                    {
                        w.Helper.WriteDelimiter();

                        if (zsa != null && zsa.OptimizedCode != null && !zsa.UseCompilerConstants)
                        {
                            w.WriteParameterArray(zm.GetParameters());
                        }
                        else
                        {
                            w.WriteDecoratedParameterArray(pi, zm);
                        }
                    }

                    w.Write(")");

                    if (zsa != null && zsa.OptimizedCode != null)
                    {
                        w.Write(" { ");

                        #region constants

                        string code = DoCompilerConstants(zm, zsa);

                        w.Write(code);

                        #endregion

                        w.WriteLine(" }");
                        w.Helper.WriteTerminator();
                    }
                    else
                    {
                        w.WriteLine();
                        w.WriteBeginScope();
                        EmitBody(w, zm, false);
                        w.EndScopeAndTerminate();
                        w.WriteLine();
                    }

                    #endregion
                }
                else
                {
                    if (w.SemiInlineWrapperMethod(zm, zsa))
                    {
                        // inlined
                    }
                    else
                    {
                        if (zm.IsStatic)
                        {
                            w.WriteIdent();
                            w.Write("function ");
                            w.WriteDecoratedMethodName(zm);
                        }
                        else
                        {
                            ScriptAttribute s = ScriptAttribute.Of(zm.DeclaringType);

                            if (s != null && s.HasNoPrototype)
                            {
                                continue;
                            }

                            w.WriteIdent();
                            w.Helper.WritePrototypeAlias(zm.DeclaringType);

                            w.Helper.WriteAccessor();

                            //w.Write("A_");
                            w.WriteDecoratedMethodName(zm);
                            //w.Write("FN");
                            w.Write(" = function ");
                        }

                        if (zsa != null && zsa.OptimizedCode != null)
                        {
                            w.Write("(");
                            w.WriteParameterArray(zm.GetParameters());
                            w.Write(") { ");

                            #region constants

                            string code = DoCompilerConstants(zm, zsa);

                            w.Write(code);

                            #endregion

                            w.Write(" }");
                            w.Helper.WriteTerminator();
                            w.WriteLine();
                        }
                        else
                        {
                            w.Write("(");
                            w.WriteDecoratedParameterArray(zm.GetParameters(), zm);
                            w.Write(")");

                            w.WriteLine();

                            w.WriteBeginScope();

                            // Although anonymous types are supported by jsc,
                            // they contain compiler generated methods that are not
                            // This means we need to filter those methods here.
                            if (
                                new[] {"GetHashCode", "Equals"}.Contains(zm.Name)
                                && ScriptAttribute.IsAnonymousType(zm.DeclaringType))
                            {
                                w.WriteIdent();
                                w.WriteLine("throw 'Not implemented, " + zm.Name + "';");
                            }
                            else
                            {
                                EmitBody(w, zm, !zm.IsStatic);
                            }

                            w.EndScopeAndTerminate();

                            if (zm.IsVirtual && zm.IsHideBySig)
                            {
                                if ((zm.Attributes & MethodAttributes.VtableLayoutMask) == 0)
                                {
                                    Task.Enabled = true;
                                    OverrideVirtualMember(w, zm.DeclaringType, zm);
                                }
                            }

                            w.WriteLine();
                        }
                    }
                }
            }
            //w.WriteCommentLine("endmethods");

            #endregion
        }

        private static string DoCompilerConstants(MethodInfo zm, ScriptAttribute zsa)
        {
            string code = zsa.OptimizedCode;

            if (zsa.UseCompilerConstants)
            {
                code = CompilerBase.ReplaceWithCompilerConstants(code, zm, ScriptWriter.GetParameterInfoNameField);
            }
            return code;
        }

        public static void DeclareFields(ScriptWriter w, FieldInfo[] fi, Type type)
        {
            #region static fields

            foreach (FieldInfo zf in fi)
            {
                if (zf.IsLiteral)
                {
                    continue;
                }

                if (!zf.IsStatic)
                {
                    continue;
                }

                w.WriteIdent();
                w.Write("var ");

                w.WriteDecoratedMemberInfo(zf);
                w.WriteAssignment();

                DeclareFieldDefaultValue(w, zf);

                w.WriteLine(";");
            }

            #endregion

            foreach (FieldInfo zf in fi)
            {
                if (zf.IsLiteral)
                {
                    continue;
                }

                if (zf.IsStatic)
                {
                    continue;
                }

                ScriptAttribute s = ScriptAttribute.Of(zf.DeclaringType);

                if (s != null && s.HasNoPrototype)
                {
                    continue;
                }

                w.WriteIdent();
                w.Helper.WritePrototypeAlias(type);
                w.Helper.WriteAccessor();
                w.WriteDecoratedMemberInfo(zf);
                w.WriteAssignment();
                DeclareFieldDefaultValue(w, zf);
                w.Helper.WriteTerminator();
                w.WriteLine();
            }

            // whatif hasnoprototype?
            if (type.IsSerializable && !type.GetFields(BindingFlags.NonPublic | BindingFlags.Instance).Any())
            {
                #region type.prototype.meta = {};

                w.Helper.WriteOptionalIdent();
                w.Helper.WritePrototypeAlias(type);

                w.Helper.WriteAccessor();
                w.Write(ScriptAttribute.MetadataMember);
                w.WriteAssignment();
                w.Helper.WriteCreateObject();
                w.Helper.WriteTerminator();
                w.Helper.WriteOptionalNewline();

                #endregion

                #region type.prototype.meta.typename = 'typename';

                w.Helper.WriteOptionalIdent();
                w.Helper.WritePrototypeAlias(type);

                w.Helper.WriteAccessor();
                w.Write(ScriptAttribute.MetadataMember);
                w.Helper.WriteAccessor();
                w.Write(ScriptAttribute.MetadataMemberTypeName);
                w.WriteAssignment();
                w.Write("'" + type.Name + "'");
                w.Helper.WriteTerminator();
                w.Helper.WriteOptionalNewline();

                #endregion

                #region type.prototype.meta.defaultctor = 'defaultctor';

                MethodBase ctor = type.GetConstructor(Type.EmptyTypes);

                if (ctor != null)
                {
                    // metadata support?
                    w.Helper.WriteOptionalIdent();
                    w.Helper.WritePrototypeAlias(type);

                    w.Helper.WriteAccessor();
                    w.Write(ScriptAttribute.MetadataMember);
                    w.Helper.WriteAccessor();
                    w.Write(ScriptAttribute.MetadataMemberDefaultConstructor);
                    w.WriteAssignment();
                    w.WriteDecoratedMemberInfo(ctor, true);
                    w.Helper.WriteTerminator();

                    w.Helper.WriteOptionalNewline();
                }

                #endregion

                // usage?
                // !!! xml serialization

                foreach (FieldInfo zf in fi)
                {
                    if (zf.IsLiteral)
                    {
                        continue;
                    }

                    if (zf.FieldType.IsEnum)
                    {
                        continue;
                    }

                    if (zf.IsStatic)
                    {
                        continue;
                    }

                    // TODO: add primitive type constructors
                    // string, number, boolean

                    if (zf.FieldType.IsArray)
                    {
                        #region type.prototype.meta.field = [];

                        w.Helper.WriteOptionalIdent();
                        w.WriteDecorated(type);
                        w.Helper.WriteAccessor();
                        w.Helper.WritePrototype();
                        w.Helper.WriteAccessor();
                        w.Write(ScriptAttribute.MetadataMember);
                        w.Helper.WriteAccessor();
                        w.WriteDecoratedMemberInfo(zf);
                        w.WriteAssignment();
                        w.Helper.WriteCreateArray();
                        w.Helper.WriteTerminator();
                        w.Helper.WriteOptionalNewline();

                        #endregion

                        continue;
                    }

                    ScriptAttribute sf = ScriptAttribute.Of(zf.FieldType);

                    if (sf != null)
                    {
                        #region type.prototype.meta.field = 'ctor';

                        w.Helper.WriteOptionalIdent();
                        w.WriteDecorated(type);
                        w.Helper.WriteAccessor();
                        w.Helper.WritePrototype();
                        w.Helper.WriteAccessor();
                        w.Write(ScriptAttribute.MetadataMember);
                        w.Helper.WriteAccessor();
                        w.WriteDecoratedMemberInfo(zf);
                        w.WriteAssignment();
                        w.Write("'");
                        w.Write(zf.FieldType.Name);
                        w.Write("'");
                        w.Helper.WriteTerminator();
                        w.Helper.WriteOptionalNewline();

                        #endregion
                    }
                }

                w.Helper.WriteOptionalNewline();
            }
        }

        private static void DeclareFieldDefaultValue(ScriptWriter w, FieldInfo zf)
        {
            if (zf.FieldType == typeof (int))
            {
                w.Write("0");
            }
            else if (zf.FieldType == typeof (long))
            {
                w.Write("0");
            }
            else if (zf.FieldType == typeof (bool))
            {
                w.Write("false");
            }
            else if (zf.FieldType == typeof (string))
            {
                w.Write("null");
            }
            else if (zf.FieldType.IsEnum)
            {
                w.Write("0");
            }
            else if (zf.FieldType is object)
            {
                w.Write("null");
            }
        }

        private static Type[] SortTypes(ScriptWriter w, Type[] e)
        {
            var a = new List<Type>(e);

            while (e.Length > 0)
            {
                //Console.WriteLine("---");;
                var r = new List<Type>();

                foreach (Type v in e)
                {
                    // find my base and align after the base

                    Type b = v.BaseType;

                    if (b == null)
                    {
                        continue;
                    }

                    if (b.IsGenericType)
                    {
                        b = b.GetGenericTypeDefinition()
                            ;
                    }

                    b = w.Session.ResolveImplementation(b) ?? b;

                    int x = a.IndexOf(b);
                    int y = a.IndexOf(v);

                    if (y < x)
                    {
                        //Console.WriteLine("move {0} after {1} at {2}", v, b, x);

                        a.Insert(x + 1, v);
                        a.RemoveAt(y);

                        r.Add(v);
                    }
                }

                e = r.ToArray();
            }

            return a.ToArray();
        }

        private static string UpperFirstLetter(string s)
        {
            return (!string.IsNullOrEmpty(s)) ? char.ToUpper(s[0]) + s.Substring(1, s.Length - 1) : string.Empty;
        }

        private static void WriteInstanceConstructor(ScriptWriter w, Type z, ConstructorInfo zc)
        {
            w.WriteCommentLine(zc.DeclaringType.FullName + zc.Name);

            w.Helper.DefineTypeMemberMethodHeader(z, zc);

            w.WriteBeginScope(false);
            w.WriteDecoratedParameterArray(zc.GetParameters(), zc);

            EmitBody(w, zc, true);
            w.EndScopeAndTerminate();

            // alias
            w.Helper.DefineTypeInheritanceConstructor(z, zc, z.BaseType);
        }

        #endregion
    }
}