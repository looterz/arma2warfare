using System;
using System.Diagnostics;
using System.Reflection;
using System.Reflection.Emit;
using ScriptCoreLib;

namespace jsc.Languages.SQF.ScriptBuilder
{
    public partial class SqfMethodBodyWriter
    {
        #region Методы класса

        public void Emit(ILBlock.Prestatement p)
        {
            if (Handlers[p.Instruction.OpCode.Value] == null)
            {
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

            _writer.WriteIdent();
            try
            {
                OpCodeHandler(p);
                _writer.WriteLine(";");
            }
            catch (SkipThisPrestatementException)
            {
                _writer.WriteLine();
            }
        }

        public void EmitScope(ILBlock.PrestatementBlock s, bool canCollapse)
        {
            EmitScope(s, canCollapse, null);
        }

        public void EmitScope(ILBlock.PrestatementBlock s, bool canCollapse,
                              Predicate<ILBlock.Prestatement> predicate)
        {
            _writer.WriteBeginScope();
            EmitPrestatementBlock(s, predicate);
            _writer.WriteEndScope();
        }

        public void EmitPrestatementBlock(ILBlock.PrestatementBlock s)
        {
            EmitPrestatementBlock(s, null);
        }

        public void EmitPrestatementBlock(ILBlock.PrestatementBlock s, Predicate<ILBlock.Prestatement> predicate)
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
                        _writer.WriteIdent();
                        _writer.WriteLine("try");

                        ILBlock.PrestatementBlock b = p.Block.Prestatements;

                        bool leave =
                            OpCodeExtensions.IsOpCodeLeave(b.Last)
                            && b.Last.TargetInstruction == b.OwnerBlock.NextNonClauseBlock.First;

                        EmitScope(b.ExtractBlock(b.First, leave ? b.Last.Prev : b.Last), false);

                        continue;
                    }

                    if (p.Block.IsHandlerBlock)
                    {
                        _writer.WriteIdent();

                        ILBlock.PrestatementBlock b = p.Block.Prestatements;

                        bool pop = b.First == OpCodes.Pop &&
                                    (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Clause);
                        bool leave =
                            b.Last == OpCodes.Endfinally
                            ||
                            (OpCodeExtensions.IsOpCodeLeave(b.Last) &&
                             b.Last.TargetInstruction == b.OwnerBlock.NextNonClauseBlock.First);

                        b = b.ExtractBlock(pop ? b.First.Next : b.First, leave ? b.Last.Prev : b.Last);

                        b.RemoveNopOpcodes();

                        if (b.PrestatementCommands.Count == 0)
                        {
                            if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Finally)
                            {
                                _writer.WriteLine("finally ");
                            }
                            else if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Clause)
                            {
                                _writer.Write("catch (");
                                _writer.Write(")");
                            }
                            else
                            {
                                Debugger.Break();
                            }

                            _writer.Write("{ }");
                            _writer.WriteLine();
                        }
                        else
                        {
                            if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Finally)
                            {
                                _writer.WriteLine("finally");
                            }
                            else if (p.Block.Clause.Flags == ExceptionHandlingClauseOptions.Clause)
                            {
                                _writer.Write("catch (");
                                _writer.Write(")");
                                _writer.WriteLine();
                            }
                            else
                            {
                                Debugger.Break();
                            }

                            EmitScope(b, false);
                        }

                        continue;
                    }
                }

                #endregion

                #region if

                ILIfElseConstruct iif = p.Instruction.InlineIfElseConstruct;

                if (iif != null)
                {
                    _writer.WriteLine();
                    _writer.WriteIdent();
                    _writer.Write("if");
                    _writer.WriteSpace();

                    if (iif.Branch.IsAnyOpCodeOf(OpCodes.Bge, OpCodes.Bge_S))
                    {
                        #region F# FailInit check :)

                        #region only false block

                        if (iif.BodyTrueFirst == null)
                        {
                            _writer.Write("(");
                            OpCodeHandler(p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                            _writer.Write(" < ");
                            OpCodeHandler(p, iif.Branch, iif.Branch.StackBeforeStrict[1]);
                            _writer.Write(")");
                            _writer.WriteLine();

                            EmitScope(p.Owner.ExtractBlock(iif.BodyFalseFirst, iif.BodyFalseLast), true);

                            _writer.WriteLine();
                            continue;
                        }

                        #endregion

                        _writer.Write("(");
                        OpCodeHandler(p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                        _writer.Write(" > ");
                        OpCodeHandler(p, iif.Branch, iif.Branch.StackBeforeStrict[1]);
                        _writer.Write(")");

                        #endregion
                    }
                    else if (iif.Branch.IsAnyOpCodeOf(OpCodes.Brfalse_S, OpCodes.Brfalse))
                    {
                        _writer.Write("(");
                        OpCodeHandler(p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                        _writer.Write(")");
                    }
                    else if (iif.Branch.IsAnyOpCodeOf(OpCodes.Brtrue_S, OpCodes.Brtrue))
                    {
                        // fix 2.03.2006
                        _writer.Write("(");
                        _writer.Write("!");

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
                            OpCodeHandler(p, iif.Branch, expression);
                        }

                        else
                        {
                            _writer.Write("(");
                            OpCodeHandler(p, iif.Branch, expression);

                            _writer.Write(")");
                        }

                        _writer.Write(")");
                        //_writer.Write("(!(");
                        //OpCodeHandler(p, iif.Branch, iif.Branch.StackBeforeStrict[0]);
                        //_writer.Write("))");
                    }
                    else
                    {
                        Task.Error("if block not detected correctly, opcode was " + iif.Branch.OpCode.Name);
                        Task.Fail(null);
                    }

                    _writer.WriteLine();

                    //_writer.WriteCommentLine(iif.Branch.ToString());

                    EmitScope(p.Owner.ExtractBlock(iif.BodyTrueFirst, iif.BodyTrueLast), true);

                    if (iif.HasElseClause)
                    {
                        _writer.WriteIdent();
                        _writer.WriteLine("else");

                        EmitScope(p.Owner.ExtractBlock(iif.BodyFalseFirst, iif.BodyFalseLast), true);
                    }

                    _writer.WriteLine();

                    continue;
                }

                #endregion

                #region loop

                ILLoopConstruct loop = p.Instruction.InlineLoopConstruct;

                if (loop != null)
                {
                    if (loop.IsBreak(p.Instruction))
                    {
                        _writer.WriteIdent();
                        _writer.WriteLine("break;");
                        continue;
                    }

                    if (loop.IsContinue(p.Instruction))
                    {
                        _writer.WriteIdent();
                        _writer.WriteLine("continue;");
                        continue;
                    }

                    _writer.WriteIdent();
                    _writer.Write("while");
                    _writer.WriteSpace();
                    _writer.Write("(");

                    ILBlock.PrestatementBlock block;

                    block = p.Owner.ExtractBlock(loop.CFirst, loop.CLast);
                    block.IsCompound = true;

                    if (block.LastPrestatement.Instruction.OpCode.FlowControl == FlowControl.Branch)
                    {
                        _writer.Write("true");
                    }
                    else
                    {
                        OpCodeHandlerArgument(block.LastPrestatement);
                    }

                    _writer.Write(")");
                    _writer.WriteLine();

                    EmitScope(p.Owner.ExtractBlock(loop.BodyFirst, loop.BodyLast), true);

                    continue;
                }

                #endregion

                #region opt-out

                if (p.Instruction != null)
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
                        WriteForStatement(p);
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

                Emit(p);
            }
        }

        private void WriteForStatement(ILBlock.Prestatement p)
        {
            _writer.WriteLine();
            _writer.WriteIdent();
            _writer.Write("for (");

            OpCodeHandler(p);

            _writer.Write("; ");

            ILLoopConstruct loop = p.Next.Instruction.InlineLoopConstruct;

            ILBlock.PrestatementBlock block = p.Owner.ExtractBlock(loop.CFirst, loop.CLast);

            block.IsCompound = true;

            if (block.LastPrestatement.Instruction.OpCode.FlowControl == FlowControl.Branch)
            {
                _writer.Write("true");
            }
            else
            {
                OpCodeHandler(block.LastPrestatement, block.LastPrestatement.Instruction,
                              block.LastPrestatement.Instruction.StackBeforeStrict[0]);
            }

            _writer.Write("; ");

            ILBlock.PrestatementBlock wblock = p.Owner.ExtractBlock(loop.BodyFirst, loop.BodyLast);

            OpCodeHandler(wblock.LastPrestatement);

            _writer.WriteLine(")");

            _writer.WriteBeginScope();

            EmitPrestatementBlock(wblock,
                                  delegate(ILBlock.Prestatement xxp)
                                  {
                                      return xxp == wblock.LastPrestatement;
                                  }
                );
            _writer.WriteEndScope();

            _writer.WriteLine();
        }

        public void EmitBody(MethodBase i, bool defineSelf)
        {
            if (i.IsAbstract)
            {
                _writer.Write("throw new Error('abstract method');");

                return;
            }

            var ilBlock = new ILBlock(i);
            if (ilBlock.Instructrions == null)
                return;


            ScriptAttribute a = ScriptAttribute.OfProvider(i);

            bool noexeptions = (a != null && a.NoExeptions);

            if (noexeptions)
            {
                _writer.WriteIdent();
                _writer.WriteLine("try");
                _writer.WriteBeginScope();
            }

            ILBlock.PrestatementBlock b = ilBlock.Prestatements;

            if (b.PrestatementCommands.Count > 0)
            {
                ILInstruction instruction = b.PrestatementCommands[0].Instruction;

                // the IL is not calling base.ctor() ? :)

                bool ctor = i.IsInstanceConstructor();
                bool ctorObjbase = ctor && instruction == OpCodes.Call &&
                                   instruction.TargetConstructor.DeclaringType == typeof (object);

                EmitPrestatementBlock(b.ExtractBlock(ctorObjbase ? instruction.Next : b.First, b.Last));
            }

            if (noexeptions)
            {
                _writer.WriteEndScope();
                _writer.WriteIdent();
                _writer.WriteLine("catch (_ne) {}");
            }
        }

        private void DeclareFieldDefaultValue(FieldInfo zf)
        {
            if (zf.FieldType == typeof (int))
            {
                _writer.Write("0");
            }
            else if (zf.FieldType == typeof (long))
            {
                _writer.Write("0");
            }
            else if (zf.FieldType == typeof (bool))
            {
                _writer.Write("false");
            }
            else if (zf.FieldType == typeof (string))
            {
                _writer.Write("null");
            }
            else if (zf.FieldType.IsEnum)
            {
                _writer.Write("0");
            }
            else if (zf.FieldType is object)
            {
                _writer.Write("null");
            }
        }

        #endregion
    }
}