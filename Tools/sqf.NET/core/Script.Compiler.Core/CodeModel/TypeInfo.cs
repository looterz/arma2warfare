using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using Script.Compiler.Core.Attributes;
using ScriptCoreLib;

namespace jsc.CodeModel
{
	public class TypeInfo
	{
		public Type Value;
		public Type ResolvedValue;

		public TypeInfo(Type e)
		{
			Value = e;

			ReferencedBaseTypes = GetReferencedBaseTypes(e).ToArray();

		}

		public readonly Type[] ReferencedBaseTypes;
		public Type[] ResolvedBaseTypes;

		static IEnumerable<Type> GetReferencedBaseTypes(Type e)
		{
			if (e.BaseType != null)
				yield return e.BaseType;

			foreach (var i in e.GetInterfaces())
			{
				yield return i;

				foreach (var j in GetReferencedBaseTypes(i))
				{
					yield return j;
				}
			}
		}

		public bool IsCompilerGenerated
		{
			get
			{
				return ScriptAttribute.IsCompilerGenerated(Value);
			}
		}

		public bool IsScript
		{
			get
			{
				return ScriptAttribute.Of(Value) != null;
			}
		}

		public Func<TypeInfo, string> TargetFileNameHandler;

		public string TargetFileName
		{
			get
			{

				return TargetFileNameHandler(this);
			}
		}

		public string AssamblyFileName
		{
			get
			{
				return new FileInfo(Value.Assembly.Location).Name;
			}
		}

		public override string ToString()
		{
			return this.Value.ToString();
		}
	}
}
