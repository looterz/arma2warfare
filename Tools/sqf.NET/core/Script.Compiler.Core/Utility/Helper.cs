using System;
using System.Linq;

namespace Script.Compiler.Core.Utility
{
    public sealed class Helper
    {
        public static bool InArray<T>(T u, params T[] e)
        {
            return e.Contains(u);
        }

        internal static void Invoke(Action action)
        {
            if (action != null) action.Invoke();
        }

        internal static bool Invoke<T>(Predicate<T> p, T i)
        {
            if (p != null)
                return p(i);

            return false;
        }
    }
}
