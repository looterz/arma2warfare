using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using Script.Compiler.Core.Attributes;

namespace ScriptCoreLib.CSharp.Extensions
{
	public static class ScriptAttributeExtensions
	{
		public static ScriptAttribute ToScriptAttribute(this ICustomAttributeProvider p)
		{
			return ScriptAttribute.OfProvider(p);
		}

		public static ScriptAttribute ToScriptAttributeOrDefault(this ICustomAttributeProvider p)
		{
			return ScriptAttribute.OfProvider(p) ?? new ScriptAttribute();
		}
	}
}
