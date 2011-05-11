
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
		bool OpCodeNewobjOverride(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
		{
			Type declType = i.TargetConstructor.DeclaringType;

			#region custom implementation

		    MethodBase implTypeCtor = ScriptCompiler.GetScriptClass(declType).GetScriptMethod(i.TargetConstructor).Method;

			if (implTypeCtor != null)
			{
				WriteCreateType(p, i, s, implTypeCtor);
				return true;
			}


			#endregion


			return false;
		}



		void OpCodeNewobj(ILBlock.Prestatement p, ILInstruction i, ILFlowStackItem[] s)
		{
			MethodBase m = i.TargetConstructor;

			if (m.DeclaringType == typeof(object))
			{
				_writer.Write("{}");

				return;
			}


			if (ScriptAttribute.IsAnonymousType(m.DeclaringType))
			{
				goto TryDefault;
			}


			if (ScriptAttribute.OfProvider(m.DeclaringType) == null)
			{
			    var scriptMethod = GetImplementation(m.DeclaringType);
                //_writer.Write(" = createVehicleLocal []");
				return;
			}


			if (OpCodeNewobjOverride(p, i, s))
			{
				if (i.TargetConstructor.DeclaringType.IsDelegate())
				{
					var targetIsNotNull = i.StackBeforeStrict[0].SingleStackInstruction != OpCodes.Ldnull;
					var targetMethodIsStatic = i.StackBeforeStrict[1].SingleStackInstruction.TargetMethod.IsStatic;

                    if (targetMethodIsStatic)
						if (targetIsNotNull)
						{
							_writer.Write(".");
							_writer.Write("[TODO: DelegateImplementationProvider.AsExtensionMethod]");
							_writer.Write("()");
						}
				}

				return;
			}

			var mTypeAttribute = ScriptAttribute.Of(m.DeclaringType, true);



			#region missing script attribute
			if (mTypeAttribute == null)
			{
				if (m.DeclaringType.IsArray)
				{
					// when is this hit? arrays are implemented!

					Task.Error("new array not implemented");
					Task.Fail(i);
				}

				using (StringWriter sw = new StringWriter())
				{
					// static? in js?

					if (m.IsStatic)
                        sw.Write("");

                    sw.Write("{0}.{1}", m.DeclaringType.FullName, m.Name);
                    sw.Write("(");
					int pix = 0;
					foreach (ParameterInfo pi in m.GetParameters())
					{
						if (pix++ > 0)
                            sw.Write(", ");

                        sw.Write(pi.ParameterType.FullName);
					}

                    sw.Write(")");

                    Task.Error("Missing Script Attribute? Native constructor was invoked, please implement [{0}]", sw.ToString());
					Task.Fail(i);
				}
				Debugger.Break();
			}
			#endregion

		TryDefault:

			WriteCreateType(p, i, s, m);


		}
	}

}