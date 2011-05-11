
using System;

using System.IO;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Reflection;
using System.Diagnostics;
using System.Linq;
using System.Reflection.Emit;
using jsc;
using ScriptCoreLib;

namespace Script.Compiler.Languages.SQF.ScriptBuilder
{
    partial class SqfMethodBodyWriter
	{
		void WriteOperatorIs(ILBlock.Prestatement prestatement, ILInstruction instruction, ILFlowStackItem stackItem)
		{
			var stackInstruction = stackItem.SingleStackInstruction;
			var flowStackItem = stackInstruction.StackBeforeStrict.Single();

			_writer.Write("(");
			OpCodeHandler(prestatement, stackInstruction, flowStackItem);

			_writer.WriteSpace();
			_writer.Write("instanceof");
			_writer.WriteSpace();

			//_writer.WriteDecoratedType(GetImplementation(stackInstruction.TargetType), false);
            _writer.Write(GetImplementation(stackInstruction.TargetType).Name);
			_writer.Write(")");
		}

		void WriteOperatorAs(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem s)
		{
			Action<Action> Write =
				expression =>
				{
					_writer.Write("(");

					if (i.TargetType == typeof(string))
					{
						_writer.Write("typeof");
						_writer.WriteSpace();
						expression();
						_writer.WriteSpace();
						_writer.Write("==");
						_writer.WriteSpace();
						_writer.Write("typeof");
						_writer.WriteSpace();
						_writer.WriteLiteral("");

					}
					else
					{
						expression();
						_writer.WriteSpace();
						_writer.Write("instanceof");
						_writer.WriteSpace();
                        _writer.Write(GetImplementation(i.TargetType).Name);
					}

					_writer.WriteSpace();
					_writer.Write("?");
					_writer.WriteSpace();

					// this should be a variable

					expression();


					_writer.WriteSpace();
					_writer.Write(":");
					_writer.WriteSpace();

					_writer.Write("null");

					_writer.Write(")");
				};

			if (s.SingleStackInstruction.IsLoadLocal)
			{
				Write(
					delegate
					{
						OpCodeHandler(p, i, s);
					}
				);

			}
			else
			{
				#region as operator for nonlocal variable

				// uniqe variable
				var f = "c$" + i.Offset;

				_writer.Write("( function () { ");

				_writer.Write("var ");
				_writer.Write(f);
				_writer.WriteAssignment();
				OpCodeHandler(p, i, s);
				_writer.Write("; ");

				_writer.Write("return ");

				Write(
					delegate
					{
						_writer.Write(f);
					}
				);
				_writer.Write(";");

				_writer.Write(" } )()");

				#endregion
			}
		}

        void OpCodeIsInst(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
		{
			WriteOperatorAs(p, i, s[0]);
		}
	}

}