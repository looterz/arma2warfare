using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Reflection;
using System.Linq;
using ScriptCoreLib;
using ScriptCoreLib.Attributes;

namespace Script.Compiler.Core
{
	/// <summary>
	/// this class is shared among scriptcorelib assemblies 
	/// and provides pre runtime information, to build static
	/// files
	/// </summary>
	public static class SharedHelper
	{
        public static Type[] LoadScriptTypes(ScriptType type, Assembly assemblyLoaded)
        {
            List<Type> types = new List<Type>();

            types.AddRange(ScriptAttribute.FindTypes(assemblyLoaded, type));

            foreach (Assembly xa in SharedHelper.LoadReferencedAssemblies(assemblyLoaded, false))
            {
                ScriptAttribute sa = ScriptAttribute.OfProvider(xa);

                if (sa == null)
                {
                    continue;
                }
                types.AddRange(ScriptAttribute.FindTypes(xa, type));
            }
            return types.ToArray();
        }

		class LoadDependenciesValue
		{
			public Assembly Assembly;
			public Assembly[] Dependencies = new Assembly[] { };

			public class EqualityComparer : IEqualityComparer<LoadDependenciesValue>
			{

				#region IEqualityComparer<LoadDependenciesValue> Members

				public bool Equals(LoadDependenciesValue x, LoadDependenciesValue y)
				{
					return x.Assembly == y.Assembly;
				}

				public int GetHashCode(LoadDependenciesValue obj)
				{
					return obj.Assembly.GetHashCode();
				}

				#endregion
			}

		}

		static IEnumerable<LoadDependenciesValue> LoadDependencies(Assembly context, Assembly a, bool includethis, Action<Assembly> h)
		{
			var r = new LoadDependenciesValue();

			r.Assembly = a;

			Action<Assembly> Add =
				n =>
				{
					r.Dependencies = r.Dependencies.Concat(new[] { n }).ToArray();

					if (h != null)
						h(n);
				};

			var ReferencedAssemblies = a.GetReferencedAssemblies().Select(k => AppDomain.CurrentDomain.Load(k));

			var _as = ScriptAttribute.OfProvider(a);
			if (_as != null)
				if (_as.ScriptLibraries != null)
					ReferencedAssemblies = ReferencedAssemblies.Concat(_as.ScriptLibraries.Select(k => k.Assembly));




			foreach (var x in ReferencedAssemblies)
			{
				if (ScriptAttribute.Of(x) == null)
				{
					// either it is not a script library
					// or it is in regards to context

					var cs = ScriptAttribute.OfProvider(context);

					if (cs != null)
						if (cs.ScriptLibraries != null)
							if (cs.ScriptLibraries.Any(k => k.Assembly == x))
								goto ContinueAdd;

					continue;
				}

			ContinueAdd:
				Add(x);

				foreach (var v in LoadDependencies(context, x, true, Add))
				{
					yield return v;
				}
			}

			if (includethis)
				yield return r;
		}



		public static Assembly[] LoadReferencedAssemblies(Assembly a, bool includethis)
		{
			var r = LoadDependencies(a, a, includethis, null).Distinct(
				new LoadDependenciesValue.EqualityComparer()
			).ToArray().ToDictionary(i => i.Assembly, i => i.Dependencies.Distinct().ToArray());
			var k = r.Keys.OrderByDescending(
				kk =>
				{
	

					// fixme: we should apply namespace filters here
					var any = kk.GetTypes().Any(
						kkk =>
						{
							var sa = ScriptAttribute.OfProvider(kkk);

							if (sa == null)
								return false;

							// if the implements type is in the same assembly
							// we skip this rule!
							if (sa.Implements == null)
								return false;

							return kkk.Assembly != sa.Implements.Assembly;
						}
					);

					return any;
				}
			).ToArray();

			// this is almost in the correct order
			// we need to consider that some assemlies are out of band
			// which mean they are only after the BCLImplementation 
			// assemblies

			return k;


		}

		/// <summary>
		/// returns the names of the modules needed to run a assembly including a
		/// </summary>
		/// <param name="a"></param>
		/// <returns></returns>
		public static string[] ModulesOf(Assembly a)
		{
			return (from e in LoadReferencedAssemblies(a, true)
					select e.ManifestModule.FullyQualifiedName).ToArray();
		}

		public static string[] ModulesOf(Assembly a, ScriptType type)
		{
			return (from e in LoadReferencedAssemblies(a, true)
					let filters = (ScriptTypeFilterAttribute[])e.GetCustomAttributes(typeof(ScriptTypeFilterAttribute), false)
					where filters.Any(k => k.Type == type)
					select e.ManifestModule.FullyQualifiedName).ToArray();
		}

		public static string[] Modules
		{
			get
			{
				return ModulesOf(Assembly.GetCallingAssembly());
			}
		}

		public static string[] LocalModulesOf(Assembly e)
		{
			return
				(from i in ModulesOf(e)
				 let f = new FileInfo(i)
				 select f.Name).Distinct().ToArray();
		}

		public static string[] LocalModulesOf(Assembly e, ScriptType type)
		{
			return
				(from i in ModulesOf(e, type)
				 let f = new FileInfo(i)
				 select f.Name).Distinct().ToArray();
		}


		public static string[] LocalModules
		{
			get
			{
				return LocalModulesOf(Assembly.GetCallingAssembly());

			}
		}
	}
}
