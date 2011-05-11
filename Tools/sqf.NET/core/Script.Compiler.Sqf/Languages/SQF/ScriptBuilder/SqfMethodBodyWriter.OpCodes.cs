using System.Reflection.Emit;
using jsc;

namespace Script.Compiler.Languages.SQF.ScriptBuilder
{
    using ilbp = ILBlock.Prestatement;
    using ili = ILInstruction;
    using ilfsi = ILFlowStackItem;


    partial class SqfMethodBodyWriter
    {
        private void CreateInstructionHandlers()
        {
            Handlers[OpCodes.Ret] = new OpCodeHandler(OpCodeRet);
            Handlers[OpCodes.Leave_S, OpCodes.Leave] = new OpCodeHandler(OpCodeLeave);

            Handlers[OpCodes.Br_S,
                     OpCodes.Br] = new OpCodeHandler(OpCode_br);

            Handlers[OpCodes.Ldarg_0,
                     OpCodes.Ldarg_1,
                     OpCodes.Ldarg_2,
                     OpCodes.Ldarg_3,
                     OpCodes.Ldarg,
                     OpCodes.Ldarg_S,
                     OpCodes.Ldarga_S,
                     OpCodes.Ldarga] = new OpCodeHandler(OpCodeLDARG);


            Handlers[OpCodes.Starg_S] = new OpCodeHandler(OpCodeSTARG);

            Handlers[OpCodes.Ldloc_0,
                     OpCodes.Ldloc_1,
                     OpCodes.Ldloc_2,
                     OpCodes.Ldloc_3,
                     OpCodes.Ldloc_S,
                     OpCodes.Ldloca,
                     OpCodes.Ldloca_S,
                     OpCodes.Ldloc] = new OpCodeHandler(OpCodeLDLOC);


            Handlers[OpCodes.Stloc_0,
                     OpCodes.Stloc_1,
                     OpCodes.Stloc_2,
                     OpCodes.Stloc_3,
                     OpCodes.Stloc_S,
                     OpCodes.Stloc] = new OpCodeHandler(OpCodeSTLOC);

            Handlers[
                     OpCodes.Sub,
                     OpCodes.Sub_Ovf,
                     OpCodes.Add,
                     OpCodes.Add_Ovf,
                     OpCodes.Add_Ovf_Un,
                     OpCodes.Div,
                     OpCodes.Div_Un,
                     OpCodes.Mul,
                     OpCodes.Rem,
                     OpCodes.Rem_Un,
                     OpCodes.And,
                     OpCodes.Or,
                     OpCodes.Xor,
                     OpCodes.Not,
                     OpCodes.Shl,
                     OpCodes.Shr,
                     OpCodes.Shr_Un,
                     OpCodes.Neg,
                     OpCodes.Ceq,
                     OpCodes.Cgt,
                     OpCodes.Cgt_Un,
                     OpCodes.Clt,
                     OpCodes.Clt_Un
                     ] = new OpCodeHandler(OpCodeLogicOperators);


            Handlers[OpCodes.Ldc_I4,
                     OpCodes.Ldc_I4_S,
                     OpCodes.Ldc_I4_0,
                     OpCodes.Ldc_I4_1,
                     OpCodes.Ldc_I4_2,
                     OpCodes.Ldc_I4_3,
                     OpCodes.Ldc_I4_4,
                     OpCodes.Ldc_I4_5,
                     OpCodes.Ldc_I4_6,
                     OpCodes.Ldc_I4_7,
                     OpCodes.Ldc_I4_8,
                     OpCodes.Ldc_R4,
                     OpCodes.Ldc_R8,
                     OpCodes.Ldc_I8,
                     OpCodes.Ldc_I4_M1] = new OpCodeHandler(OpCode_ldc);

            Handlers[OpCodes.Ldstr] = new OpCodeHandler(OpCode_ldstr);

            Handlers[OpCodes.Call] = new OpCodeHandler(OpCodeCall);
            Handlers[OpCodes.Callvirt] = new OpCodeHandler(OpCodeCall);


            Handlers[OpCodes.Beq_S] = new OpCodeHandler(OpCodeBeq);
            Handlers[OpCodes.Bgt_S] = new OpCodeHandler(OpCodeBgt);
            Handlers[OpCodes.Blt_S] = new OpCodeHandler(OpCodeBlt);
            Handlers[OpCodes.Ble_S] = new OpCodeHandler(OpCodeBle);
            Handlers[OpCodes.Bge_S] = new OpCodeHandler(OpCodeBge);
            Handlers[OpCodes.Bne_Un_S] = new OpCodeHandler(OpCodeBneUn);

            // fixme: leace_S my leave function

            Handlers[OpCodes.Box] = new OpCodeHandler(OpCodeBox);
            Handlers[OpCodes.Castclass] = new OpCodeHandler(OpCodeCastclass);
            Handlers[OpCodes.Endfinally] = new OpCodeHandler(OpCodeEndFinally);

            Handlers[
                OpCodes.Conv_R8,
                OpCodes.Conv_R_Un,
                OpCodes.Conv_I4,
                OpCodes.Conv_I2,
                OpCodes.Conv_Ovf_I4,
                OpCodes.Conv_Ovf_I4_Un,
                OpCodes.Conv_I8,
                OpCodes.Conv_U8,
                OpCodes.Conv_R4,
                OpCodes.Conv_U4,
                OpCodes.Conv_U2,
                OpCodes.Conv_U,
                OpCodes.Conv_U1,
                OpCodes.Conv_Ovf_I
                    ] = new OpCodeHandler(OpCodeConv);

            Handlers[
                     OpCodes.Unbox_Any,



                     OpCodes.Nop,
                     OpCodes.Constrained] = new OpCodeHandler(OpCodeDoNothing);

            Handlers[OpCodes.Throw] = new OpCodeHandler(OpCodeThrow);
            Handlers[OpCodes.Rethrow] = new OpCodeHandler(OpCodeRethrow);
            Handlers[OpCodes.Isinst] = new OpCodeHandler(OpCodeIsInst);
            Handlers[OpCodes.Dup] = new OpCodeHandler(OpCodeDup);
            Handlers[OpCodes.Pop] = new OpCodeHandler(OpCodePop);
            Handlers[OpCodes.Newarr] = new OpCodeHandler(OpCodeNewArr);
            Handlers[OpCodes.Newobj] = new OpCodeHandler(OpCodeNewobj);
            Handlers[OpCodes.Initobj] = new OpCodeHandler(OpCodeINITOBJ);

            Handlers[OpCodes.Ldlen] = new OpCodeHandler(OpCodeLdlen);
            Handlers[OpCodes.Ldnull] = new OpCodeHandler(OpCode_ldnull);
            Handlers[OpCodes.Ldftn] = new OpCodeHandler(OpCodeLDFTN);
            Handlers[OpCodes.Ldvirtftn] = OpCodeLdvirtftn;
            Handlers[OpCodes.Ldtoken] = OpCodeLDTOKEN;

            Handlers[OpCodes.Stelem,
                     OpCodes.Stelem_Ref,
                     OpCodes.Stelem_I1,
                     OpCodes.Stelem_I4,
                     OpCodes.Stelem_R8,
                     OpCodes.Stelem_I2] = OpCodeStelem;

            Handlers[OpCodes.Stobj] = OpCodeStobj;

            Handlers[OpCodes.Ldobj] = OpCodeLdobj;


            Handlers[OpCodes.Ldelem_Ref,
                OpCodes.Ldelem_U1,
                OpCodes.Ldelem_U2,
                OpCodes.Ldelem_U4,
                OpCodes.Ldelem_I1,
                OpCodes.Ldelem_I4,
                OpCodes.Ldelem_R8,
                OpCodes.Ldelema,
                OpCodes.Ldelem
                     ] = new OpCodeHandler(OpCodeLdelem);

            Handlers[OpCodes.Stfld,
                     OpCodes.Stsfld] = new OpCodeHandler(OpCodeStfld);

            Handlers[OpCodes.Ldfld,
                     OpCodes.Ldflda,
                     OpCodes.Ldsfld] = new OpCodeHandler(OpCodeLDFLD);
        }

    }

}