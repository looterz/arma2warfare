﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using Script.Compiler;
using Script.Compiler.Core;
using Script.Compiler.Core.Attributes;
using Script.Compiler.Core.ExtensionMethods;
using Script.Compiler.Core.Utility;
using ScriptCoreLib;

namespace jsc.Loader
{
	public static class LoaderStrategy
	{
		public static IEnumerable<Assembly> LoadReferencedAssemblies(Assembly Context, ScriptType[] filter, params ScriptAttribute[] UpperContextScript)
		{
			// if an assembly is not being picked up
			// then maybe you forgot to include the namespace for translation?

			var ContextObfuscation = Context.GetCustomAttributes<ObfuscationAttribute>().FirstOrDefault();
			var ContextScript = Context.GetCustomAttributes<ScriptAttribute>().FirstOrDefault();
			var ContextScriptTypeFilter = Context.GetCustomAttributes<ScriptTypeFilterAttribute>();

			if (ContextScript == null)
			{
				// this might not be a script assembly at all

				if (ContextObfuscation == null)
				{
					if (UpperContextScript.Any(k => k.ScriptLibraries != null && k.ScriptLibraries.Any(kk => kk.Assembly == Context)))
					{
						// an upper context said this library shall be treated like IsScriptLibrary 
					}
					else yield break;
				}
				else
				{
					if (ContextObfuscation.Feature != "script")
						yield break;

					// yay this context is a script assembly
				}
			}
			else
			{
				if (ContextScriptTypeFilter.Length > 0)
				{
				}
				else
				{
					// this was suppoesed to be a script library
					// yet it doesn't tell us which namespaces belong to which
					// target language

					if (ContextScript.IsScriptLibrary || 
						(ContextObfuscation != null && ContextObfuscation.Feature == "script"))
					{
						// lets assume all types are for all languages then
					}
					else
					{
						// does the upper context have anything to declare?

						if (UpperContextScript.Any(k => k.ScriptLibraries.Any(kk => kk.Assembly == Context)))
						{
							// an upper context said this library shall be treated like IsScriptLibrary 
						}
						else yield break;
					}
				}
			}
 
		
			if (ContextScriptTypeFilter.Length > 0)
			{
				// it seems the current context knows which namespace
				// is to be translated to which language

				// lets check to see if we are trying to translate 
				// an irrelevant assembly 

				if (filter.Any(k => ContextScriptTypeFilter.Any(kk => kk.Type == k)))
				{
					// we are good...
				}
				else yield break;
			}

			yield return Context;


			var References = Context.GetReferencedAssemblies();

			if (ContextScript != null)
				if (ContextScript.ScriptLibraries != null)
					References = References.Concat(ContextScript.ScriptLibraries.Select(k => k.Assembly.GetName())).Distinct().ToArray();

			foreach (var r in References)
			{
				foreach (var k in LoadReferencedAssemblies(
						Assembly.Load(r), 
						filter, 
						ContextScript == null ? UpperContextScript :
						UpperContextScript.Concat(new [] {ContextScript}).ToArray()
					)
				)
				{
					yield return k;
				}
			}

			yield break;
		}
	}
}