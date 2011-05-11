using System;

namespace ScriptCoreLib.Attributes
{
	[global::System.AttributeUsage(AttributeTargets.Method | AttributeTargets.Constructor , Inherited = false, AllowMultiple = true)]
	public class TypeOfByNameOverrideAttribute : Attribute
	{
		public Type Target;

		public TypeOfByNameOverrideAttribute(Type target)
		{
			this.Target = target;
		}

		public TypeOfByNameOverrideAttribute()
		{

		}
	}
}
