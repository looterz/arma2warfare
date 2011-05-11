using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.CompilerServices;
using ScriptCoreLib;
using ScriptCoreLib.CSharp.Extensions;

namespace jsc.Languages.SQF.ScriptBuilder
{
    public partial class SqfMethodBodyWriter
    {
        #region Поля класса

        private readonly OperationHandlers _handlers;
        private readonly ScriptWriter _writer;

        #endregion

        #region Свойства класса

        public IScriptCompiler ScriptCompiler { get; private set; }

        public OperationHandlers Handlers
        {
            get { return _handlers; }
        }

        #endregion

        #region Конструкторы класса

        public SqfMethodBodyWriter(IScriptCompiler compiler, ScriptWriter writer)
        {
            _writer = writer;
            ScriptCompiler = compiler;

            _handlers = new OperationHandlers();
            CreateInstructionHandlers();
        }

        public IScriptMethod GetImplementation(Type type, MethodBase methodBase)
        {
            IScriptClass scriptClass = GetImplementation(type);
            return scriptClass.GetScriptMethod(methodBase);
        }

        public IScriptClass GetImplementation(Type type)
        {
            return ScriptCompiler.GetScriptClass(type);
        }

        #endregion

        #region Методы класса

        private void OpCodeHandlerLogic(ILBlock.Prestatement p, ILInstruction i, ILBlock.InlineLogic logic)
        {
            if (logic.hint == ILBlockInlineLogicSpecialType.AndOperator)
            {
                if (logic.IsNegative)
                {
                    _writer.Write("!");
                }

                _writer.Write("(");

                OpCodeHandlerLogic(p, i, logic.lhs);

                _writer.WriteSpace();
                _writer.Write("&&");
                _writer.WriteSpace();

                OpCodeHandlerLogic(p, i, logic.rhs);

                _writer.Write(")");

                return;
            }

            if (logic.hint == ILBlockInlineLogicSpecialType.OrOperator)
            {
                if (logic.IsNegative)
                {
                    _writer.Write("!");
                }

                _writer.Write("(");
                OpCodeHandlerLogic(p, i, logic.lhs);

                _writer.WriteSpace();
                _writer.Write("||");
                _writer.WriteSpace();

                OpCodeHandlerLogic(p, i, logic.rhs);

                _writer.Write(")");

                return;
            }

            if (logic.hint == ILBlockInlineLogicSpecialType.Value)
            {
                if (logic.IsNegative)
                {
                    _writer.Write("!");
                }

                OpCodeHandler(p, logic.value.SingleStackInstruction, null);

                return;
            }

            if (logic.hint == ILBlockInlineLogicSpecialType.IfClause)
            {
                _writer.Write("(");

                if (logic.IsNegative)
                {
                    _writer.Write("!");
                }

                _writer.Write("(");

                if (logic.IfClause.Branch == OpCodes.Brtrue_S
                    || logic.IfClause.Branch == OpCodes.Brfalse_S)
                {
                    OpCodeHandler(p, logic.IfClause.Branch, logic.IfClause.Branch.StackBeforeStrict[0]);
                }
                else
                {
                    OpCodeHandler(p, logic.IfClause.Branch, null);
                }

                _writer.Write(")");

                _writer.WriteSpace();
                _writer.Write("?");
                _writer.WriteSpace();

                ILBlock.PrestatementBlock block;

                block = p.Owner.ExtractBlock(
                    /*logic.IsNegative ? logic.IfClause.FFirst :*/ logic.IfClause.BodyFalseFirst,
                                                                   /*logic.IsNegative ? logic.IfClause.FLast :*/
                                                                   logic.IfClause.BodyFalseLast
                    );

                // todo: explicit boolean

                OpCodeHandler(block.PrestatementCommands[block.PrestatementCommands.Count - 1],
                              block.PrestatementCommands[block.PrestatementCommands.Count - 1].Instruction,
                              null
                    );

                _writer.WriteSpace();
                _writer.Write(":");
                _writer.WriteSpace();

                block = p.Owner.ExtractBlock(
                    /*!logic.IsNegative ?*/ logic.IfClause.BodyTrueFirst /*: logic.IfClause.TFirst*/,
                                            /*!logic.IsNegative ?*/ logic.IfClause.BodyTrueLast
                    /*: logic.IfClause.TLast*/
                    );

                OpCodeHandler(block.PrestatementCommands[block.PrestatementCommands.Count - 1],
                              block.PrestatementCommands[block.PrestatementCommands.Count - 1].Instruction,
                              null
                    );

                _writer.Write(")");

                return;
            }

            Debugger.Break();
        }

        public void OpCodeHandlerArgument(ILBlock.Prestatement p)
        {
            OpCodeHandlerArgument(p, p.Instruction, p.Instruction.StackBeforeStrict[0]);
        }

        private void OpCodeHandlerArgument(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem s)
        {
            if (s.StackInstructions.Length == 1)
            {
                OpCodeHandler(p, s.SingleStackInstruction, null);
            }
            else
            {
                OpCodeHandlerLogic(p, i, s.InlineLogic(p.Owner.MemoryBy(s)));
            }
        }

        public void OpCodeHandler(ILBlock.Prestatement p)
        {
            Handlers[p.Instruction.OpCode.Value](p, p.Instruction, p.Instruction.StackBeforeStrict);
        }

        /// <summary>
        /// resolves operand (stackitem) -or- if s is null, resolves raw opcode
        /// </summary>
        /// <param name="w"></param>
        /// <param name="p"></param>
        /// <param name="i"></param>
        /// <param name="s"></param>
        public void OpCodeHandler(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem s)
        {
            if (s == null)
            {
                if (i == null)
                {
                    _writer.Write("0 /* null instruction*/");

                    return;
                }

                // if debugger breaks, opcode is missing
                if (Handlers[i] == null)
                {
                    Task.Error("opcode unsupported - {0}", i);
                    Task.Fail(i);
                }
                else
                {
                    Handlers[i](p, i, i.StackBeforeStrict);
                }
            }
            else
            {
                OpCodeHandlerArgument(p, i, s);
            }
        }

        private void OpCodeCallOverride(ILBlock.Prestatement prestatement,
                                        ILInstruction ilInstruction, ILFlowStackItem[] stackItems, IScriptMethod smethod)
        {
            MethodBase m = smethod.Method;

            ScriptAttribute sq = ScriptAttribute.OfProvider(m);
            ScriptAttribute sqt = ScriptAttribute.OfProvider(m.DeclaringType);

            if (sqt == null && ScriptAttribute.IsAnonymousType(m.DeclaringType))
            {
                sqt = new ScriptAttribute();
            }

            // definition not found
            if (sqt == null && !m.DeclaringType.IsInterface)
            {
                using (var sw = new StringWriter())
                {
                    if (m.IsStatic)
                    {
                        sw.Write("");
                    }

                    sw.Write("{0}.{1}",
                             (m.DeclaringType.IsGenericType
                                  ? m.DeclaringType.GetGenericTypeDefinition()
                                  : m.DeclaringType).FullName, m.Name);

                    sw.Write("(");
                    int pix = 0;
                    foreach (ParameterInfo pi in m.GetParameters())
                    {
                        if (pix++ > 0)
                        {
                            sw.Write(", ");
                        }

                        sw.Write(pi.ParameterType.FullName);
                    }

                    sw.Write(")");

                    //Task.Fail(ilInstruction);

                    return;
                }
            }

            if (!m.IsStatic && sq != null && sq.DefineAsStatic)
            {
                IScriptMethod scriptMethod = ScriptCompiler.GetScriptClass(m.DeclaringType).GetScriptMethod(m);
                _writer.Write(scriptMethod.Name);

                _writer.Write("(");
                OpCodeHandler(prestatement, ilInstruction, stackItems[0]);
                if (stackItems.Length > 1)
                {
                    _writer.WriteDelimiter();
                    WriteParameters(prestatement, ilInstruction, stackItems, 1, m);
                }
                _writer.Write(")");
            }
            else
            {
                if (m.IsStatic)
                {
                    IScriptMethod scriptMethod = GetImplementation(m.DeclaringType, m);
                    _writer.Write(scriptMethod.Name, scriptMethod);
                }
                else
                {
                    // target
                    if (m.GetParameters().Length > 0)
                    {
                        _writer.Write("[");
                        OpCodeHandler(prestatement, ilInstruction, stackItems[0]);
                        _writer.Write(", [");
                        WriteParameters(prestatement, ilInstruction, stackItems, m.IsStatic ? 0 : 1, m);
                        _writer.Write("]]");
                    }
                    else
                    {
                        OpCodeHandler(prestatement, ilInstruction, stackItems[0]);
                    }

                    _writer.WriteSpace();
                    _writer.Write("call ");

                    // method);
                    if (sqt != null && (sqt.ExternalTarget != null || sqt.HasNoPrototype))
                    {
                        _writer.Write(m.Name);
                    }
                    else
                    {
                        if (sq != null && sq.ExternalTarget != null)
                        {
                            _writer.Write(sq.ExternalTarget);
                        }
                        else
                        {
                            IScriptMethod scriptMethod =
                                ScriptCompiler.GetScriptClass(m.DeclaringType).GetScriptMethod(m);
                            _writer.Write(scriptMethod.Name);
                        }
                    }
                }

            }
        }

        public void WriteParameters(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s, int offset,
                                    MethodBase m)
        {
            ParameterInfo[] pi = m == null ? null : m.GetParameters();

            for (int si = offset; si < s.Length; si++)
            {
                if (si > offset)
                {
                    _writer.WriteDelimiter();
                }

                if (pi != null && OpCodeEmitStringEnum(s[si], pi[si - offset].ParameterType))
                {
                    continue;
                }

                OpCodeHandler(p, i, s[si]);
            }
        }

        private void OpCodeCall(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            MethodBase mm = i.ReferencedMethod;

            if (mm.DeclaringType == typeof (RuntimeHelpers))
            {
                if (mm.Name == "InitializeArray")
                {
                    throw new SkipThisPrestatementException();
                }
            }

            #region fetch method

            MethodBase m = i.TargetMethod ?? (MethodBase) i.TargetConstructor;

            if (m == null)
            {
                Debugger.Break();
            }

            #endregion

            if (m.DeclaringType.IsValueType)
            {
                if (m is ConstructorInfo)
                {
                    // fix this call as it shall be a call to new at the moment

                    OpCodeHandler(p, i, s[0]);

                    _writer.WriteAssignment();

                    var s2 = new ILFlowStackItem[s.Length - 1];

                    Array.Copy(s, 1, s2, 0, s2.Length);

                    WriteCreateType(p, i, s2, m);
                    return;
                    // 
                }
            }

            if (mm.DeclaringType.ToScriptAttributeOrDefault().HasNoPrototype)
            {
                // we are calling a native method

                DefaultMemberAttribute defaultMemberAttribute =
                    mm.DeclaringType.GetCustomAttributes<DefaultMemberAttribute>().FirstOrDefault();

                if (defaultMemberAttribute != null)
                {
                    foreach (PropertyInfo defaultMember in
                        mm.DeclaringType.GetProperties(BindingFlags.NonPublic | BindingFlags.Public |
                                                       BindingFlags.Instance).Where(
                                                           k => k.Name == defaultMemberAttribute.MemberName)
                        )
                    {
                        if (defaultMember != null)
                        {
                            MethodInfo getter = defaultMember.GetGetMethod();
                            if (getter == mm)
                            {
                                if (getter.ToScriptAttributeOrDefault().DefineAsStatic)
                                {
                                    // bail
                                }
                                else
                                {
                                    OpCodeHandler(p, i, s[0]);
                                    _writer.Write("[");
                                    OpCodeHandler(p, i, s[1]);
                                    _writer.Write("]");
                                    return;
                                }
                            }

                            MethodInfo setter = defaultMember.GetSetMethod();

                            if (setter == mm)
                            {
                                if (setter.ToScriptAttributeOrDefault().DefineAsStatic)
                                {
                                    // bail
                                }
                                else
                                {
                                    OpCodeHandler(p, i, s[0]);
                                    _writer.Write("[");
                                    OpCodeHandler(p, i, s[1]);
                                    _writer.Write("]");

                                    _writer.WriteSpace();
                                    _writer.Write("=");
                                    _writer.WriteSpace();

                                    OpCodeHandler(p, i, s[2]);
                                    return;
                                }
                            }
                        }
                    }
                }
            }

            #region toString

            if (m.Name == "ToString")
            {
                _writer.Write("\"\"");  // just return empty string
                return;
            }

            #endregion

            OpCodeCallOverride(p, i, s, GetImplementation(m.DeclaringType, m));
        }

        private void OpCode_ldstr(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            /*var @break = i.TargetLiteral == "jsc.break";

            if (@break)
                Debugger.Break();*/

            _writer.WriteLiteral(i.TargetLiteral);
        }

        private void OpCode_ldc(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i == OpCodes.Ldc_R4)
            {
                _writer.Write(i.OpParamAsFloat);
                return;
            }

            if (i == OpCodes.Ldc_I8)
            {
                _writer.Write((long) i.TargetLong);
                return;
            }

            if (i == OpCodes.Ldc_R8)
            {
                _writer.Write(i.OpParamAsDouble);
                return;
            }

            int? n = i.TargetInteger;

            if (n == null)
            {
                Task.Error("ldc not resolved");
                Debugger.Break();
            }

            _writer.Write(n.Value);
        }

        private void OpCode_br(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i.TargetFlow.Branch == OpCodes.Ret)
            {
                OpCodeRet(p, i.TargetFlow.Branch, i.TargetFlow.Branch.StackBeforeStrict);
            }
            else
            {
                Task.Error("logic failure");
                Task.Fail(i);
            }
        }

        private void OpCodeLeave(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            ILBlock b = i.Flow.OwnerBlock;

            if (b.Clause == null)
            {
                b = b.Parent;
            }

            if (b.Clause == null)
            {
                Debugger.Break();
            }

            if (b.Clause.Flags == ExceptionHandlingClauseOptions.Clause)
            {
                if (b.NextNonClauseBlock == null)
                {
                    Debugger.Break();
                }

                ILBlock.Prestatement tx = i.IndirectReturnPrestatement;

                if (tx != null)
                {
                    // redirect

                    OpCodeHandler(tx);

                    return;
                }

                if (b.NextNonClauseBlock.First == i.TargetInstruction)
                {
                    _writer.Write("/* leave */");
                    return;
                }
            }

            if (b.Clause.Flags == ExceptionHandlingClauseOptions.Finally)
            {
                ILBlock.Prestatement tx = i.IndirectReturnPrestatement;

                if (tx != null)
                {
                    // redirect

                    OpCodeHandler(tx);

                    return;
                }
            }

            // this needs to be fixed!
            throw new NotSupportedException("current OpCodes.Leave cannot be understood at " + i.Location);
        }

        private void OpCodeRet(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (s.Length == 0)
            {
                // nothing return;
            }
            else
            {
                OpCodeHandler(p, i, s[0]);
            }
        }

        private void OpCodeLDFLD(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i == OpCodes.Ldfld || i == OpCodes.Ldflda)
            {
                OpCodeHandler(p, i, s[0]);
            }

            if (i == OpCodes.Ldsfld)
            {
                object[] o = i.TargetField.DeclaringType.GetCustomAttributes(typeof (ScriptAttribute), true);

                if (o.Length == 1)
                {
                    var sa = o[0] as ScriptAttribute;

                    if (sa.ExternalTarget != null)
                    {
                        Debugger.Break();

                        _writer.Write(sa.ExternalTarget);

                        goto skip;
                    }
                }

                o = i.TargetField.GetCustomAttributes(typeof (ScriptAttribute), true);

                if (o.Length == 1)
                {
                    var sa = o[0] as ScriptAttribute;

                    if (sa.ExternalTarget != null)
                    {
                        _writer.Write(sa.ExternalTarget);

                        return;
                    }
                }
            }

            skip:
            OpCodeDecorateField(p, i, s);
        }

        private void OpCodeDecorateField(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i.TargetField == null)
            {
                _writer.Write("/* bad field */");
                return;
            }

            FieldInfo targetField = i.TargetField;
            Type targetFieldType = targetField.DeclaringType;
            IScriptClass targetImplementation = GetImplementation(targetFieldType);

            IFieldVariable field = targetImplementation.Fields.First(m => m.FieldInfo.Name == targetField.Name);

            _writer.Write(field.Name);
        }

        private void OpCodeStfld(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i == OpCodes.Stfld)
            {
                OpCodeHandler(p, i, s[0]);
            }

            if (i == OpCodes.Stsfld)
            {
                object[] o = i.TargetField.DeclaringType.GetCustomAttributes(typeof (ScriptAttribute), true);

                if (o.Length == 1)
                {
                    var sa = o[0] as ScriptAttribute;

                    if (sa.ExternalTarget != null)
                    {
                        Debugger.Break();

                        _writer.Write(sa.ExternalTarget);

                        goto skip;
                    }
                }
            }

            skip:

            OpCodeDecorateField(p, i, s);

            _writer.WriteSpace();
            _writer.Write("=");
            _writer.WriteSpace();

            if (OpCodeEmitStringEnum(s[s.Length - 1], i.TargetField.FieldType))
            {
                return;
            }

            OpCodeHandler(p, i, s[s.Length - 1]);
        }

        internal bool OpCodeEmitStringEnum(ILFlowStackItem s, Type type)
        {
            if (type != null && type.IsEnum)
            {
                ScriptAttribute enumA = ScriptAttribute.Of(type);

                if (enumA != null && enumA.IsStringEnum)
                {
                    int? enumVal = s.SingleStackInstruction.TargetInteger;

                    if (enumVal != null)
                    {
                        string name = Enum.GetName(type, enumVal.Value);

                        ScriptAttribute ma = ScriptAttribute.OfTypeMember(type, name);

                        if (ma != null)
                        {
                            if (ma.ExternalTarget != null)
                            {
                                _writer.WriteLiteral(ma.ExternalTarget);

                                return true;
                            }
                        }

                        _writer.WriteLiteral(name);

                        return true;
                    }
                }
            }

            return false;
        }

        private void OpCodeLdelem(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);
            _writer.Write("[");
            OpCodeHandler(p, i, s[1]);
            _writer.Write("]");
        }

        private void OpCodeStelem(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);
            _writer.Write("[");
            OpCodeHandler(p, i, s[1]);
            _writer.Write("]");
            _writer.WriteSpace();
            _writer.Write("=");
            _writer.WriteSpace();

            OpCodeHandler(p, i, s[2]);
        }

        private void OpCodeStobj(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);

            _writer.Write("=");

            OpCodeHandler(p, i, s[1]);
        }

        private void OpCodeLdobj(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);
        }

        private void OpCodeLdlen(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);
            _writer.Write(".length");
        }

        private void OpCode_ldnull(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            _writer.Write("null");
        }

        private void OpCodeLdvirtftn(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeLDFTN(p, i, s);
        }

        private void OpCodeLDTOKEN(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            _writer.Write("LDTOKEN:");

            _writer.Write("new ");

            //_writer.Helper.WriteWrappedConstructor(
            //    _writer.Session.ResolveImplementation(
            //        typeof (RuntimeTypeHandle)
            //        ).GetConstructor(new[] {typeof (IntPtr)})
            //    );

            //_writer.Write("(");

            //_writer.Helper.WritePrototypeAlias(
            //    _writer.Session.ResolveImplementation(i.TargetType) ?? i.TargetType
            //    );

            _writer.Write(")");
        }

        private void OpCodeLDFTN(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            IScriptMethod method = GetImplementation(i.TargetMethod.DeclaringType, i.TargetMethod);

            _writer.Write(method.Name);
        }

        private void OpCodeINITOBJ(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            // we can only initobj a variable. we cannot init a generic type parameter
            if (i.Prev.TargetVariable == null)
            {
                throw new SkipThisPrestatementException();
            }

            //Script.CompilerBase.WriteVisualStudioMessage(jsc.Script.CompilerBase.MessageType.warning, 1001, "init missing: " + i.Method.DeclaringType.FullName + "." + i.Method.Name);

            //_writer.WriteDecorated(i.OwnerMethod, i.Prev.TargetVariable);

            var var = i.Prev.TargetVariable;
            ScriptCompiler.GetScriptClass(i.OwnerMethod.DeclaringType)
                .GetScriptMethod(i.OwnerMethod).Locals.Where(m => m is ILocalVariable).First(m => ((ILocalVariable)m).LocalVariable.LocalIndex == var.LocalIndex);

            _writer.WriteSpace();
            _writer.Write("=");
            _writer.WriteSpace();

            if (i.TargetType.IsGenericParameter)
            {
                _writer.Write("void(0)");
            }
            else
            {
                ConstructorInfo ctor = i.TargetType.GetConstructor(new Type[0]);

                if (ctor == null)
                {
                    throw new Exception("valuetype ctor not found " + i.TargetType);
                }

                WriteCreateType(p, i, new ILFlowStackItem[0], ctor);
            }

            //Task.Error("default(T) not supported yet");
            //Task.Fail(i);
        }

        private void WriteCreateType(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s, MethodBase m)
        {
            _writer.Write("[WriteCreateType]");

            IScriptMethod method = GetImplementation(m.DeclaringType, m);

            ScriptAttribute sa =
                ScriptAttribute.IsAnonymousType(m.DeclaringType)
                    ? new ScriptAttribute()
                    : ScriptAttribute.Of(m.DeclaringType, true);

            if (sa == null)
            {
                throw new Exception("ctor not found or no script attribute for type " +
                                             m.DeclaringType.FullName + " at " + i.Location);
                return;
            }

            if (sa.HasNoPrototype)
            {
                if (sa.GetConstructorAlias() != null)
                {
                    IScriptMethod scriptMethod = ScriptCompiler.ResolveMethod(m, m.DeclaringType, sa.GetConstructorAlias());
                    OpCodeCallOverride(p, i, s, scriptMethod);
                    return;
                }

                if (sa.ExternalTarget == null)
                {
                    Task.Error("You tried to instance a class which seems to be marked as native.");

                    Task.Error("type has no callable constructor: [{0}] {1}", m.DeclaringType.FullName, m.ToString());
                    Task.Fail(i);
                }
                else
                {
                    //_writer.Helper.DOMCreateType(sa.ExternalTarget, p, i, s);
                }
            }
            else
            {
                //_writer.Helper.DOMCreateAndInvokeConstructor(
                //    m.DeclaringType,
                //    m, p, i, s);
            }
        }

        private void OpCodeNewArr(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            #region inline newarr

            if (p.IsValidInlineArrayInit)
            {
                _writer.WriteLine("[");
                _writer.Ident++;

                ILFlowStackItem[] stack = p.InlineArrayInitElements;

                for (int si = 0; si < stack.Length; si++)
                {
                    if (si > 0)
                    {
                        _writer.Write(",");
                        _writer.WriteLine();
                    }

                    _writer.WriteIdent();

                    if (stack[si] == null)
                    {
                        if (!i.TargetType.IsValueType)
                        {
                            _writer.Write("null");
                        }
                        else
                        {
                            // http://stackoverFlow.com/questions/325426/c-programmatic-equivalent-of-defaulttype

                            if (i.TargetType.IsEnum)
                            {
                                _writer.Write("" + Activator.CreateInstance(Enum.GetUnderlyingType(i.TargetType)));
                            }
                            else
                            {
                                _writer.Write("" + Activator.CreateInstance(i.TargetType));
                            }
                        }
                    }
                    else
                    {
                        OpCodeHandler(p, i, stack[si]);
                    }
                }

                _writer.WriteLine();

                _writer.Ident--;
                _writer.WriteIdent();
                _writer.Write("]");
            }
                #endregion

            else
            {
                if (i.NextInstruction == OpCodes.Dup &&
                    i.NextInstruction.NextInstruction == OpCodes.Ldtoken &&
                    i.NextInstruction.NextInstruction.NextInstruction == OpCodes.Call)
                {
                    var length = (int) i.StackBeforeStrict.First().SingleStackInstruction.TargetInteger;
                    Type Type = i.TargetType;

                    // Conversion To IEnumrable

                    if (Type == typeof (int))
                    {
                        int[] Values = i.NextInstruction.NextInstruction.TargetField.GetValue(null).StructAsInt32Array();

                        _writer.Write("[");
                        for (int j = 0; j < Values.Length; j++)
                        {
                            if (j > 0)
                            {
                                _writer.Write(", ");
                            }

                            _writer.Write(Values[j].ToString());
                        }
                        _writer.Write("]");
                    }
                    else if (Type == typeof (uint))
                    {
                        uint[] values =
                            i.NextInstruction.NextInstruction.TargetField.GetValue(null).StructAsUInt32Array();

                        _writer.Write("[");
                        for (int j = 0; j < values.Length; j++)
                        {
                            if (j > 0)
                            {
                                _writer.Write(", ");
                            }

                            _writer.Write(values[j].ToString());
                        }
                        _writer.Write("]");
                    }
                    else if (Type == typeof (ushort))
                    {
                        ushort[] Values =
                            i.NextInstruction.NextInstruction.TargetField.GetValue(null).StructAsUInt16Array();

                        _writer.Write("[");
                        for (int j = 0; j < Values.Length; j++)
                        {
                            if (j > 0)
                            {
                                _writer.Write(", ");
                            }

                            _writer.Write(Values[j].ToString());
                        }
                        _writer.Write("]");
                    }
                    else if (Type == typeof (float))
                    {
                        float[] values =
                            i.NextInstruction.NextInstruction.TargetField.GetValue(null).StructAsFloatArray();

                        _writer.Write("[");
                        for (int j = 0; j < values.Length; j++)
                        {
                            if (j > 0)
                            {
                                _writer.Write(", ");
                            }

                            _writer.Write(values[j]);
                        }
                        _writer.Write("]");
                    }
                    else if (Type == typeof (double))
                    {
                        float[] values =
                            i.NextInstruction.NextInstruction.TargetField.GetValue(null).StructAsFloatArray();

                        _writer.Write("[");
                        for (int j = 0; j < values.Length; j++)
                        {
                            if (j > 0)
                            {
                                _writer.Write(", ");
                            }

                            _writer.Write(values[j]);
                        }
                        _writer.Write("]");
                    }
                    else
                    {
                        throw new NotImplementedException(Type.Name);
                    }
                }
                else
                {
                    // Write("[]");
                    // this fix is for javascript too

                    if (i.StackBeforeStrict[0].SingleStackInstruction == OpCodes.Ldc_I4_0)
                    {
                        _writer.Write("[]");
                    }
                    else
                    {
                        _writer.Write("new Array(");
                        OpCodeHandler(p, i, i.StackBeforeStrict[0]);
                        _writer.Write(")");
                    }
                }
            }
        }

        private void OpCodeRethrow(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            _writer.Write("rethrow ");
        }

        private void OpCodeThrow(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (s.Length == 1)
            {
                _writer.Write("throw ");

                OpCodeHandler(p, i, s[0]);
            }
            else
            {
                Debugger.Break();
            }
        }

        private void OpCodeDup(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (s.Length != 1)
            {
                Debugger.Break();
            }

            OpCodeHandler(p, i, s[0]);
        }

        private void OpCodePop(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);
        }

        private void OpCodeConv(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeHandler(p, i, s[0]);
        }

        private void OpCodeEndFinally(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            Debugger.Break();
        }

        private void OpCodeCastclass(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            // runtime check?

            OpCodeHandler(p, i, s[0]);
        }

        private void OpCodeBox(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (s.Length != 1)
            {
                Debugger.Break();
            }

            Type t = i.TargetType;

            if (t == typeof (bool))
            {
                _writer.Write("new Boolean");
                _writer.Write("(");
                OpCodeHandler(p, i, s[0]);
                _writer.Write(")");

                return;
            }

            if (t == typeof (int))
            {
                _writer.Write("new Number");
                _writer.Write("(");
                OpCodeHandler(p, i, s[0]);
                _writer.Write(")");

                return;
            }

            if (t == null)
            {
                _writer.Write("/* null box */ ");
                OpCodeHandler(p, i, s[0]);

                return;
            }

            // _writer.Write("/* box[{0}] */ ", t.UnderlyingSystemType);

            OpCodeHandler(p, i, s[0]);
        }

        private void OpCodeDoNothing(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            //_writer.Write("/* {0} */", i.ToString());

            if (s.Length == 0)
            {
                return;
            }

            OpCodeHandler(p, i, s[0]);
        }

        /// <summary>
        /// defines "lhs op rhs"
        /// </summary>
        /// <param name="w"></param>
        /// <param name="p"></param>
        /// <param name="i"></param>
        /// <param name="lhs"></param>
        /// <param name="op"></param>
        /// <param name="rhs"></param>
        private void OpCodeOperatorHandler(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem lhs, string op,
                                           ILFlowStackItem rhs)
        {
            OpCodeHandler(p, i, lhs);

            _writer.WriteSpace();
            _writer.Write(op);
            _writer.WriteSpace();

            OpCodeHandler(p, i, rhs);
        }

        private void OpCodeBneUn(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeOperatorHandler(p, i, s[0], "!=", s[1]);
        }

        private void OpCodeBeq(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeOperatorHandler(p, i, s[0], "==", s[1]);
        }

        private void OpCodeBgt(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeOperatorHandler(p, i, s[0], ">", s[1]);
        }

        private void OpCodeBlt(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeOperatorHandler(p, i, s[0], "<", s[1]);
        }

        private void OpCodeBle(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeOperatorHandler(p, i, s[0], "<=", s[1]);
        }

        private void OpCodeBge(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            OpCodeOperatorHandler(p, i, s[0], ">=", s[1]);
        }

        private void OpCodeLogicOperators(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            // catch prefix operators

            if (i.IsInlinePrefixOperator(OpCodes.Add))
            {
                _writer.Write("++");
                OpCodeHandler(p, i, s[0]);
                return;
            }

            if (i.IsInlinePrefixOperator(OpCodes.Sub))
            {
                _writer.Write("--");
                OpCodeHandler(p, i, s[0]);
                return;
            }

            if (i == OpCodes.Not)
            {
                _writer.Write("~");

                OpCodeHandler(p, i, s[0]);

                return;
            }

            if (i == OpCodes.Ceq)
            {
                if (s[1].SingleStackInstruction == OpCodes.Ldc_I4_0)
                {
                    _writer.Write("!");
                    OpCodeHandler(p, i, s[0]);
                    return;
                }
            }

            if (i == OpCodes.Neg)
            {
                _writer.Write("(-");
                OpCodeHandler(p, i, s[0]);
                _writer.Write(")");
                return;
            }

            if (s[0].SingleStackInstruction.OpCode == OpCodes.Isinst)
            {
                if (i.OpCode == OpCodes.Cgt_Un)
                {
                    if (s[1].SingleStackInstruction.OpCode == OpCodes.Ldnull)
                    {
                        WriteOperatorIs(p, i, s[0]);
                        return;
                    }
                }
            }

            _writer.Write("(");

            OpCodeHandler(p, i, s[0]);

            _writer.WriteSpace();

            if (i.IsAnyOpCodeOf(OpCodes.Div, OpCodes.Div_Un))
            {
                _writer.Write("/");
            }

            if (i == OpCodes.Sub || i == OpCodes.Sub_Ovf)
            {
                _writer.Write("-");
            }

            if (i == OpCodes.Add || i == OpCodes.Add_Ovf || i == OpCodes.Add_Ovf_Un)
            {
                _writer.Write("+");
            }

            if (i == OpCodes.Mul)
            {
                _writer.Write("*");
            }
            if (i == OpCodes.And)
            {
                _writer.Write("&");
            }
            if (i == OpCodes.Or)
            {
                _writer.Write("|");
            }
            if (i == OpCodes.Xor)
            {
                _writer.Write("^");
            }
            if (i == OpCodes.Shl)
            {
                _writer.Write("<<");
            }
            if (i == OpCodes.Shr)
            {
                _writer.Write(">>");
            }
            if (i == OpCodes.Shr_Un)
            {
                _writer.Write(">>");
            }
            if (i == OpCodes.Cgt)
            {
                _writer.Write(">");
            }
            if (i == OpCodes.Cgt_Un)
            {
                _writer.Write(">");
            }
            if (i == OpCodes.Ceq)
            {
                _writer.Write("==");
            }
            if (i == OpCodes.Clt)
            {
                _writer.Write("<");
            }
            if (i == OpCodes.Clt_Un)
            {
                _writer.Write("<");
            }

            if (i.IsAnyOpCodeOf(OpCodes.Rem, OpCodes.Rem_Un))
            {
                _writer.Write("%");
            }

            _writer.WriteSpace();

            if (s[0].SingleStackInstruction.TargetField != null)
            {
                if (OpCodeEmitStringEnum(s[1], s[0].SingleStackInstruction.TargetField.FieldType))
                {
                    _writer.Write(")");
                    return;
                }
            }

            #region uint fixup

            if (s[1].SingleStackInstruction.TargetInteger != null)
            {
                // if we are going to AND an uint, the second operator should also be presented
                if (
                    (s[0].SingleStackInstruction.TargetField != null &&
                     s[0].SingleStackInstruction.TargetField.FieldType == typeof (uint)) ||
                    (s[0].SingleStackInstruction.TargetParameter != null &&
                     s[0].SingleStackInstruction.TargetParameter.ParameterType == typeof (uint))
                    )
                {
                    _writer.Write((uint) s[1].SingleStackInstruction.TargetInteger);

                    _writer.Write(")");
                    return;
                }
            }

            #endregion

            OpCodeHandler(p, i, s[1]);

            _writer.Write(")");
        }

        private void OpCodeLDARG(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i.OwnerMethod.IsStatic)
            {
                var variable = ScriptCompiler.GetVariable(i.OwnerMethod, i.TargetParameter);
                _writer.Write(variable.Name);
            }
            else
            {
                if (i == OpCodes.Ldarg_0)
                {
                    _writer.WriteSelf();
                }
                else
                {
                    var variable = ScriptCompiler.GetVariable(i.OwnerMethod, i.TargetParameter);
                    _writer.Write(variable.Name);
                }
            }
        }

        private void OpCodeLDLOC(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (p.Owner.IsCompound)
            {
                ILBlock.Prestatement sp = p.Owner.SourcePrestatement(p, i);

                if (sp != null)
                {
                    OpCodeHandlerArgument(sp);
                    return;
                }
            }

            var variable = ScriptCompiler.GetVariable(i.OwnerMethod, i.TargetVariable);
            _writer.Write(variable.Name);

            // -- operator?

            if (i.IsInlinePostSub)
            {
                _writer.Write("--");
            }
            if (i.IsInlinePostAdd)
            {
                _writer.Write("++");
            }
        }

        private void OpCodeSTLOC(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            var variable = ScriptCompiler.GetVariable(i.OwnerMethod, i.TargetVariable);
            _writer.Write(variable.Name);

            if (i.IsInlinePrefixOperatorStatement(OpCodes.Add))
            {
                _writer.Write("++");
                return;
            }

            if (i.IsInlinePrefixOperatorStatement(OpCodes.Sub))
            {
                _writer.Write("--");
                return;
            }

            _writer.WriteSpace();
            _writer.Write("=");
            _writer.WriteSpace();

            if (i.IsFirstInFlow && i.Flow.OwnerBlock.IsHandlerBlock)
            {
                _writer.Write("__exc");
            }
            else
            {
                if (OpCodeEmitStringEnum(s[0], i.TargetVariable.LocalType))
                {
                    return;
                }

                OpCodeHandler(p, i, s[0]);
            }
        }

        private void OpCodeSTARG(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
        {
            if (i.TargetParameter == null)
            {
                Debugger.Break();
            }

            var variable = ScriptCompiler.GetVariable(i.OwnerMethod, i.TargetParameter);
            _writer.Write(variable.Name);

            _writer.WriteSpace();
            _writer.Write("=");
            _writer.WriteSpace();

            OpCodeHandler(p, i, s[0]);
        }

        #endregion
    }
}