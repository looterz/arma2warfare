using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Script.Compiler.Core.Attributes;
using ScriptCoreLib;

namespace Script.Compiler.Core
{
    /// <summary>
    /// this class is shared among scriptcorelib assemblies 
    /// and provides pre runtime information, to build static
    /// files
    /// </summary>
    public static class SharedHelper
    {
        #region Методы класса

        public static Type[] LoadScriptTypes(ScriptType type, Assembly assemblyLoaded)
        {
            var types = new List<Type>();

            types.AddRange(ScriptAttribute.FindTypes(assemblyLoaded, type));

            foreach (Assembly xa in LoadReferencedAssemblies(assemblyLoaded, false))
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

        private static IEnumerable<LoadDependenciesValue> LoadDependencies(Assembly context, Assembly a, bool includethis, Action<Assembly> h)
        {
            var r = new LoadDependenciesValue();

            r.Assembly = a;

            Action<Assembly> Add =
                n =>
                {
                    r.Dependencies = r.Dependencies.Concat(new[] {n}).ToArray();

                    if (h != null)
                    {
                        h(n);
                    }
                };

            IEnumerable<Assembly> ReferencedAssemblies = a.GetReferencedAssemblies().Select(k => AppDomain.CurrentDomain.Load(k));

            ScriptAttribute _as = ScriptAttribute.OfProvider(a);
            if (_as != null)
            {
                if (_as.ScriptLibraries != null)
                {
                    ReferencedAssemblies = ReferencedAssemblies.Concat(_as.ScriptLibraries.Select(k => k.Assembly));
                }
            }

            foreach (Assembly x in ReferencedAssemblies)
            {
                if (ScriptAttribute.Of(x) == null)
                {
                    // either it is not a script library
                    // or it is in regards to context

                    ScriptAttribute cs = ScriptAttribute.OfProvider(context);

                    if (cs != null)
                    {
                        if (cs.ScriptLibraries != null)
                        {
                            if (cs.ScriptLibraries.Any(k => k.Assembly == x))
                            {
                                goto ContinueAdd;
                            }
                        }
                    }

                    continue;
                }

                ContinueAdd:
                Add(x);

                foreach (LoadDependenciesValue v in LoadDependencies(context, x, true, Add))
                {
                    yield return v;
                }
            }

            if (includethis)
            {
                yield return r;
            }
        }

        public static Assembly[] LoadReferencedAssemblies(Assembly a, bool includethis)
        {
            Dictionary<Assembly, Assembly[]> r = LoadDependencies(a, a, includethis, null).Distinct(
                new LoadDependenciesValue.EqualityComparer()
                ).ToArray().ToDictionary(i => i.Assembly, i => i.Dependencies.Distinct().ToArray());
            Assembly[] k = r.Keys.OrderByDescending(
                kk =>
                {
                    // fixme: we should apply namespace filters here
                    bool any = kk.GetTypes().Any(
                        kkk =>
                        {
                            ScriptAttribute sa = ScriptAttribute.OfProvider(kkk);

                            if (sa == null)
                            {
                                return false;
                            }

                            // if the implements type is in the same assembly
                            // we skip this rule!
                            if (sa.Implements == null)
                            {
                                return false;
                            }

                            return kkk.Assembly != sa.Implements.Assembly;
                        }
                        );

                    return any;
                }
                ).ToArray();

            return k;
        }

        #endregion

        #region Nested type: LoadDependenciesValue

        private class LoadDependenciesValue
        {
            #region Поля класса

            public Assembly Assembly;
            public Assembly[] Dependencies = new Assembly[] {};

            #endregion

            #region Nested type: EqualityComparer

            public class EqualityComparer : IEqualityComparer<LoadDependenciesValue>
            {
                #region Интерфейсы класса

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

                #endregion
            }

            #endregion
        }

        #endregion
    }
}