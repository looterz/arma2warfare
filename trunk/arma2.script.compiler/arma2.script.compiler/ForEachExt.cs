using System.Collections.Generic;

namespace System.Linq
{
    public static class ForEachExt
    {
        public static IEnumerable<T> ForEach<T>(this IEnumerable<T> enumeration, Action<T> action)
        {
            foreach (var item in enumeration)
            {
                action(item);
            }
            return enumeration;
        }
    }
}