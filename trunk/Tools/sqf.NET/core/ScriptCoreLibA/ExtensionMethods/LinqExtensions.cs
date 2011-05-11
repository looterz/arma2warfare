using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using ScriptCoreLib;
using ScriptCoreLib.CSharp.Extensions;

namespace System.Linq
{
	public static class LinqExtensions
	{
		public static void ForEach<T>(this IEnumerable<T> source, Action<T, int> f)
		{
			int c = 0;
			foreach (var k in source)
			{
				f(k, c);
				c++;
			}
		}

        public static void ForEach<T>(this IEnumerable<T> source, Action<T> f)
		{
			foreach (var k in source)
			{
				f(k);
			}
		}
	}
}
