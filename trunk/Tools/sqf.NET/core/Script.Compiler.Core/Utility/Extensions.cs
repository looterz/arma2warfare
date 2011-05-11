using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Xml;
using System.Xml.Serialization;
using ScriptCoreLib;
using ScriptCoreLib.CSharp.Extensions;

namespace Script.Compiler.Core.Utility
{
	public static class Extensions
	{
		public static bool IsInstanceConstructor(this MethodBase e)
		{
			return e.IsConstructor && !e.IsStatic;
		}

        public static ushort[] StructAsUInt16Array(this object data)
        {
            // http://www.vsj.co.uk/articles/display.asp?id=501

            var size = Marshal.SizeOf(data);
            var buf = Marshal.AllocHGlobal(size);


            Marshal.StructureToPtr(data, buf, false);

            var a = new ushort[size / sizeof(ushort)];

            unsafe
            {
                var p = (ushort*)buf;
                for (int i = 0; i < a.Length; i++)
                {
                    a[i] = *p;
                    p++;
                }
            }

            Marshal.FreeHGlobal(buf);

            return a;
        }

		public static uint[] StructAsUInt32Array(this object data)
		{
			// http://www.vsj.co.uk/articles/display.asp?id=501

			var size = Marshal.SizeOf(data);
			var buf = Marshal.AllocHGlobal(size);


			Marshal.StructureToPtr(data, buf, false);

			var a = new uint[size / sizeof(int)];

			unsafe
			{
				var p = (uint*)buf;
				for (int i = 0; i < a.Length; i++)
				{
					a[i] = *p;
					p++;
				}
			}

			Marshal.FreeHGlobal(buf);

			return a;
		}

        public static float[] StructAsFloatArray(this object data)
        {
            // http://www.vsj.co.uk/articles/display.asp?id=501

            var size = Marshal.SizeOf(data);
            var buf = Marshal.AllocHGlobal(size);


            Marshal.StructureToPtr(data, buf, false);

            var a = new float[size / sizeof(float)];

            unsafe
            {
                var p = (float*)buf;
                for (int i = 0; i < a.Length; i++)
                {
                    a[i] = *p;
                    p++;
                }
            }

            Marshal.FreeHGlobal(buf);

            return a;
        }

		public static int[] StructAsInt32Array(this object data)
		{
			// http://www.vsj.co.uk/articles/display.asp?id=501

			var size = Marshal.SizeOf(data);
			var buf = Marshal.AllocHGlobal(size);


			Marshal.StructureToPtr(data, buf, false);

			var a = new int[size / sizeof(int)];

			unsafe
			{
				int* p = (int*)buf;
				for (int i = 0; i < a.Length; i++)
				{
					a[i] = *p;
					p++;
				}
			}

			Marshal.FreeHGlobal(buf);

			return a;
		}

		public static MethodInfo[] GetInstanceMethods(this Type z)
		{
			if (z == null)
				return null;

			return z.GetMethods(BindingFlags.DeclaredOnly | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Public);
		}

		public static bool IsToString(this MethodInfo e)
		{
			return e.Name == "ToString" && e.GetParameters().Length == 0;
		}


		public static bool IsDelegate(this Type z)
		{
            if (z == null)
                return false;

			return z.BaseType == typeof(MulticastDelegate);
		}

		public static T[] GetCustomAttributes<T>(this MemberInfo e)
			where T : System.Attribute
		{
			return (T[])Attribute.GetCustomAttributes(e, typeof(T), false);
		}

		public static T[] GetCustomAttributes<T>(this MemberInfo e, bool inherit)
			where T : System.Attribute
		{
			return (T[])Attribute.GetCustomAttributes(e, typeof(T), inherit);
		}

		public static T[] GetCustomAttributes<T>(this Assembly e)
			where T : System.Attribute
		{
			// "Could not load type

			return (T[])Attribute.GetCustomAttributes(e, typeof(T), false);
		}

		public static Dictionary<string, object> GetProperties(this object e, BindingFlags f)
		{
			return (
				from p in e.GetType().GetProperties(f)
				let name = p.Name
				let value = p.GetValue(e, null)
				select new { name, value }
			).ToDictionary(i => i.name, i => i.value);
		}

		public static Dictionary<string, object> GetProperties(this object e)
		{
			return (
				from p in e.GetType().GetProperties()
				let name = p.Name
				let value = p.GetValue(e, null)
				select new { name, value }
			).ToDictionary(i => i.name, i => i.value);
		}

	

		public static string GetResourceFileContent(this string name)
		{
			return new StreamReader(Assembly.GetExecutingAssembly().GetManifestResourceStream(name)).ReadToEnd();
		}

		public static string ReplaceSpace(this string e, params string[] u)
		{
			foreach (var v in u)
			{
				e = e.ReplaceSpace(v);
			}

			return e;
		}

		public static string ReplaceSpace(this string e, string u)
		{
			return e.Replace(u + " ", u);
		}

		public static string SerializeToXML(this object e)
		{
			if (e == null)
				return "";

			var s = new XmlSerializer(e.GetType());
			var w = new StringWriter();
			var z =
				XmlWriter.Create(
					w,
					new XmlWriterSettings
					{

						Indent = true,
						OmitXmlDeclaration = true

					}
				);


			s.Serialize(z, e);

			return w.ToString();
		}

		public static StreamWriter CreateFile(this DirectoryInfo dir, string filename)
		{
			FileInfo f = new FileInfo(dir.FullName + "/" + filename);

			if (f.Exists)
				f.Delete();

			StreamWriter x = new StreamWriter(new FileStream(f.FullName, FileMode.Create));


			return x;
		}


		public static ConstructorInfo GetConstructor(this Type e, params Type[] args)
		{
			return e.GetConstructor(args);
		}
	}
}
