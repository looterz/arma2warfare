using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using Reflector.CodeModel;
using System.Linq;

namespace Arma2.Script.Compiler.Sqf
{
    public partial class Helper
	{
		private Helper()
		{
		}

        private static Dictionary<object, string> _entityNames = new Dictionary<object, string>();

        private static string GetIndexedName(int index)
        {
            const int count = 'z' - 'a';
            string name = "";
            while (true)
            {
                int id = index / count;
                int r = index - (id * count);

                name = string.Format("{0}", (char)('a' + r)) + name;
                if (id == 0)
                    break;
            }
            return name;
        }

        public static string GetGlobalUniqueName(string name)
        {
            string name1 = name;
            int id = 0;
            while (_entityNames.Values.Any(m => m.Equals(name1, StringComparison.CurrentCultureIgnoreCase)))
            {
                name1 = name + GetIndexedName(id++).ToUpper();
            }
            return name1;
        }

        private static string GetLocalTypeName(ITypeReference value)
		{
			if (value != null)
			{
                if (value.GenericType != null)
                    return GetLocalTypeName(value.GenericType);

			    ITypeCollection genericParameters = value.GenericArguments;
                if (genericParameters.Count > 0)
				{
					using (StringWriter writer = new StringWriter(CultureInfo.InvariantCulture))
					{
                        writer.Write("Of");
						for (int i = 0; i < genericParameters.Count; i++)
						{
							IType genericParameter = genericParameters[i];
							if (genericParameter != null)
							{
								writer.Write(genericParameter.ToString());
							}
						}
						return value.Name + writer.ToString();
					}
				}

                

				return value.Name;
			}

			throw new NotSupportedException();
		}

		public static string GetTypeName(ITypeReference value)
		{
		    string typeName;
			if (value != null)
			{
                if (_entityNames.ContainsKey(value))
                    return _entityNames[value];

				ITypeReference declaringType = value.Owner as ITypeReference;
                if (declaringType != null)
                {
                    typeName = GetTypeName(declaringType) + "_" + Helper.GetLocalTypeName(value);
                }
                else
                {
                    typeName = Helper.GetLocalTypeName(value);
                    typeName = typeName.Replace("_", "");
                    while (typeName.Length < 2)
                    {
                        typeName = "C" + typeName;
                    }

                    typeName = char.ToUpper(typeName[0]) + typeName.Substring(1);

                    if (value.Namespace.Length != 0)
                    {
                        string ns = value.Namespace.Replace(".", "");
                        typeName = ns + "_" + typeName;
                    }
                }

			    typeName = Helper.GetGlobalUniqueName(typeName);
                _entityNames.Add(value, typeName);

			    return typeName;
			}

			throw new NotSupportedException();
		}

		public static string GetResolutionScope(ITypeReference value)
		{
			IModule module = value.Owner as IModule;
			if (module != null)
			{
				return value.Namespace;
			}

			ITypeDeclaration declaringType = value.Owner as ITypeDeclaration;
			if (declaringType != null)
			{
				return Helper.GetResolutionScope(declaringType) + "+" + Helper.GetTypeName(declaringType);
			}

			throw new NotSupportedException();
		}

		public static bool IsValueType(ITypeReference value)
		{
			if (value != null)
			{
				ITypeDeclaration typeDeclaration = value.Resolve();
				if (typeDeclaration == null)
				{
					return false;
				}

				// TODO
				ITypeReference baseType = typeDeclaration.BaseType;
				return ((baseType != null) && ((baseType.Name == "ValueType") || (baseType.Name == "Enum")) && (baseType.Namespace == "System"));
			}

			return false;
		}

		public static bool IsDelegate(ITypeReference value)
		{
			if (value != null)
			{
				// TODO
				if ((value.Name == "MulticastDelegate") && (value.Namespace == "System"))
				{
					return false;
				}

				ITypeDeclaration typeDeclaration = value.Resolve();
				if (typeDeclaration == null)
				{
					return false;
				}

				ITypeReference baseType = typeDeclaration.BaseType;
				return ((baseType != null) && (baseType.Namespace == "System") && ((baseType.Name == "MulticastDelegate") || (baseType.Name == "Delegate")) && (baseType.Namespace == "System"));
			}

			return false;
		}

		public static bool IsEnumeration(ITypeReference value)
		{
			if (value != null)
			{
				ITypeDeclaration typeDeclaration = value.Resolve();
				if (typeDeclaration == null)
				{
					return false;
				}

				// TODO
				ITypeReference baseType = typeDeclaration.BaseType;
				return ((baseType != null) && (baseType.Name == "Enum") && (baseType.Namespace == "System"));
			}

			return false;
		}

		public static IAssemblyReference GetAssemblyReference(IType value)
		{
			ITypeReference typeReference = value as ITypeReference;
			if (typeReference != null)
			{
				ITypeReference declaringType = typeReference.Owner as ITypeReference;
				if (declaringType != null)
				{
					return GetAssemblyReference(declaringType);
				}

				IModuleReference moduleReference = typeReference.Owner as IModuleReference;
				if (moduleReference != null)
				{
					IModule module = moduleReference.Resolve();
					return module.Assembly;
				}

				IAssemblyReference assemblyReference = typeReference.Owner as IAssemblyReference;
				if (assemblyReference != null)
				{
					return assemblyReference;
				}
			}

			throw new NotSupportedException();
		}

		public static bool IsVisible(IType value, IVisibilityConfiguration visibility)
		{
			ITypeReference typeReference = value as ITypeReference;
			if (typeReference != null)
			{
				ITypeReference declaringType = typeReference.Owner as ITypeReference;
				if (declaringType != null)
				{
					if (!Helper.IsVisible(declaringType, visibility))
					{
						return false;
					}
				}

				ITypeDeclaration typeDeclaration = typeReference.Resolve();
				if (typeDeclaration == null)
				{
					return true;
				}

				switch (typeDeclaration.Visibility)
				{
					case TypeVisibility.Public:
					case TypeVisibility.NestedPublic:
						return visibility.Public;

					case TypeVisibility.Private:
					case TypeVisibility.NestedPrivate:
						return visibility.Private;

					case TypeVisibility.NestedFamilyOrAssembly:
						return visibility.FamilyOrAssembly;

					case TypeVisibility.NestedFamily:
						return visibility.Family;

					case TypeVisibility.NestedFamilyAndAssembly:
						return visibility.FamilyAndAssembly;

					case TypeVisibility.NestedAssembly:
						return visibility.Assembly;

					default:
						throw new NotImplementedException();
				}
			}

			throw new NotSupportedException();
		}

		public static IMethodDeclaration GetMethod(ITypeDeclaration value, string methodName)
		{
			IMethodDeclarationCollection methods = value.Methods;
			for (int i = 0; i < methods.Count; i++)
			{
				if (methodName == methods[i].Name)
				{
					return methods[i];
				}
			}

			return null;
		}
 
		public static ICollection GetInterfaces(ITypeDeclaration value)
		{
			ArrayList list = new ArrayList(value.Interfaces);

			if (value.BaseType != null)
			{
				ITypeDeclaration baseType = value.BaseType.Resolve();
				foreach (ITypeReference interfaceReference in baseType.Interfaces)
				{
					if (list.Contains(interfaceReference))
					{
						list.Remove(interfaceReference);
					}
				}
			}

			foreach (ITypeReference interfaceReference in value.Interfaces)
			{
				ITypeDeclaration interfaceDeclaration = interfaceReference.Resolve();
				foreach (ITypeReference interfaceBaseReference in interfaceDeclaration.Interfaces)
				{
					if (list.Contains(interfaceBaseReference))
					{
						list.Remove(interfaceBaseReference);
					}
				}
			}

			ITypeReference[] array = new ITypeReference[list.Count];
			list.CopyTo (array, 0);
			return array;
		}

		public static ICollection GetInterfaces(ITypeDeclaration value, IVisibilityConfiguration visibility)
		{
			ArrayList list = new ArrayList(0);

			foreach (ITypeReference typeReference in GetInterfaces(value))
			{
				if (Helper.IsVisible(typeReference, visibility))
				{
					list.Add(typeReference);
				}
			}
			
			list.Sort();	
			return list;
		}

		public static ICollection GetFields(ITypeDeclaration value, IVisibilityConfiguration visibility)
		{
			IFieldDeclarationCollection fields = value.Fields;
			if (fields.Count > 0)
			{
				ArrayList list = new ArrayList(0);

				foreach (IFieldDeclaration fieldDeclaration in fields)
				{
					if ((visibility == null) || (Helper.IsVisible(fieldDeclaration, visibility)))
					{
						list.Add(fieldDeclaration);
					}
				}

				list.Sort();
				return list;
			}

			return new IFieldDeclaration[0];
		}

		public static ICollection GetMethods(ITypeDeclaration value, IVisibilityConfiguration visibility)
		{
			IMethodDeclarationCollection methods = value.Methods;
			if (methods.Count > 0)
			{
				ArrayList list = new ArrayList(0);
				
				foreach (IMethodDeclaration methodDeclaration in methods)
				{
					if ((visibility == null) || (Helper.IsVisible(methodDeclaration, visibility)))
					{
						list.Add(methodDeclaration);
					}
				}

				foreach (IPropertyDeclaration propertyDeclaration in value.Properties)
				{
					if (propertyDeclaration.SetMethod != null)
					{
						list.Remove(propertyDeclaration.SetMethod.Resolve());
					}

					if (propertyDeclaration.GetMethod != null)
					{
						list.Remove(propertyDeclaration.GetMethod.Resolve());
					}
				}

				foreach (IEventDeclaration eventDeclaration in value.Events)
				{
					if (eventDeclaration.AddMethod != null)
					{
						list.Remove(eventDeclaration.AddMethod.Resolve());
					}

					if (eventDeclaration.RemoveMethod != null)
					{
						list.Remove(eventDeclaration.RemoveMethod.Resolve());
					}

					if (eventDeclaration.InvokeMethod != null)
					{
						list.Remove(eventDeclaration.InvokeMethod.Resolve());
					}
				}

				list.Sort();
				return list;
			}

			return new IMethodDeclaration[0];
		}
		
		public static ICollection GetProperties(ITypeDeclaration value, IVisibilityConfiguration visibility)
		{
			IPropertyDeclarationCollection properties = value.Properties;
			if (properties.Count > 0)
			{
				ArrayList list = new ArrayList(0);

				foreach (IPropertyDeclaration propertyDeclaration in properties)
				{
					if ((visibility == null) || (Helper.IsVisible(propertyDeclaration, visibility)))
					{
						list.Add(propertyDeclaration);
					}
				}

				list.Sort();
				return list;
			}

			return new IPropertyDeclaration[0];
		}

		public static ICollection GetEvents(ITypeDeclaration value, IVisibilityConfiguration visibility)
		{
			IEventDeclarationCollection events = value.Events;
			if (events.Count > 0)
			{
				ArrayList list = new ArrayList(0);
				
				foreach (IEventDeclaration eventDeclaration in events)
				{
					if ((visibility == null) || (Helper.IsVisible(eventDeclaration, visibility)))
					{
						list.Add(eventDeclaration);
					}
				}

				list.Sort();
				return list;
			}

			return new IEventDeclaration[0];
		}

		public static ICollection GetNestedTypes(ITypeDeclaration value, IVisibilityConfiguration visibility)
		{
			ITypeDeclarationCollection nestedTypes = value.NestedTypes;
			if (nestedTypes.Count > 0)
			{
				ArrayList list = new ArrayList(0);

				foreach (ITypeDeclaration nestedType in nestedTypes)
				{
					if (Helper.IsVisible(nestedType, visibility))
					{
						list.Add(nestedType);
					}
				}

				list.Sort();
				return list;
			}

			return new ITypeDeclaration[0];
		}

		public static string GetFieldName(IFieldReference value)
		{
		    var fieldInfo = value.Resolve();
            if (fieldInfo.Static)
            {
                if (_entityNames.ContainsKey(fieldInfo))
                    return _entityNames[fieldInfo];

                string fieldName = Helper.GetTypeName(value.DeclaringType as ITypeReference) + "_" + fieldInfo.Name;
                fieldName = GetGlobalUniqueName(fieldName);
                _entityNames[fieldInfo] = fieldName;

                return fieldName;
            }

		    return value.Name;
		}

		public static bool IsVisible(IFieldReference value, IVisibilityConfiguration visibility)
		{
			if (Helper.IsVisible(value.DeclaringType, visibility))
			{
				IFieldDeclaration fieldDeclaration = value.Resolve();
				if (fieldDeclaration == null)
				{
					return true;
				}

				switch (fieldDeclaration.Visibility)
				{
					case FieldVisibility.Public:
						return visibility.Public;

					case FieldVisibility.Assembly:
						return visibility.Assembly;

					case FieldVisibility.FamilyOrAssembly:
						return visibility.FamilyOrAssembly;

					case FieldVisibility.Family:
						return visibility.Family;

					case FieldVisibility.Private:
						return visibility.Private;

					case FieldVisibility.FamilyAndAssembly:
						return visibility.FamilyAndAssembly;

					case FieldVisibility.PrivateScope:
						return visibility.Private;
				}

				throw new NotSupportedException();
			}

			return false;
		}

        public static bool IsConstructor(IMethodReference value)
        {
            return ((value.Name == ".ctor") || (value.Name == ".cctor"));
        }

		public static string GetMethodName(IMethodReference value)
		{
            if (value.GenericMethod != null)
                return GetMethodName(value.GenericMethod);

            if (_entityNames.ContainsKey(value))
                return _entityNames[value];

            string methodName = value.Name;

            if (IsConstructor(value))
            {
                methodName = "Create";
            }

		    ITypeCollection genericArguments = value.GenericArguments;
			if (genericArguments.Count > 0)
			{
				using (StringWriter writer = new StringWriter(CultureInfo.InvariantCulture))
				{
                    writer.Write("Of");

					for (int i = 0; i < genericArguments.Count; i++)
					{
						IType genericArgument = genericArguments[i];
						if (genericArgument != null)
						{
							writer.Write(genericArgument.ToString());
						}
					}

                    methodName = methodName + writer.ToString();
				}
			}

            methodName = methodName.Replace("_", "");
            while (methodName.Length < 2)
            {
                methodName = "M" + methodName;
            }

            methodName = char.ToUpper(methodName[0]) + methodName.Substring(1); 

            ITypeReference typeReference = value.DeclaringType as ITypeReference;
            if (typeReference != null)
            {
                methodName = GetTypeName(typeReference) + methodName;
            }
            
            methodName = GetGlobalUniqueName(methodName);
            _entityNames.Add(value, methodName);
            return methodName;
		}

		public static string GetNameWithParameterList(IMethodReference value)
		{
			using (StringWriter writer = new StringWriter(CultureInfo.InvariantCulture))
			{
				writer.Write(Helper.GetMethodName(value));
				writer.Write("(");

				IParameterDeclarationCollection parameters = value.Parameters;
				for (int i = 0; i < parameters.Count; i++)
				{
					if (i != 0)
					{
						writer.Write(", ");
					}

					writer.Write(parameters[i].ParameterType.ToString());
				}

				if (value.CallingConvention == MethodCallingConvention.VariableArguments)
				{
					if (value.Parameters.Count > 0)
					{
						writer.Write(", ");
					}

					writer.Write("...");
				}

				writer.Write(")");

				if ((value.Name != ".ctor") && (value.Name != ".cctor"))
				{
					writer.Write(" : ");
					writer.Write(value.ReturnType.Type.ToString());
				}

				return writer.ToString();
			}
		}

		public static string GetNameWithDeclaringType(IMethodReference value)
		{
			ITypeReference typeReference = value.DeclaringType as ITypeReference;
			if (typeReference != null)
			{
				return Helper.GetTypeName(typeReference) + "." + Helper.GetNameWithParameterList(value);
			}

			IArrayType arrayType = value.DeclaringType as IArrayType;
			if (arrayType != null)
			{
				return arrayType.ToString() + "." + Helper.GetNameWithParameterList(value);
			}

			throw new NotSupportedException();
		}

		public static bool IsVisible(IMethodReference value, IVisibilityConfiguration visibility)
		{
			if (Helper.IsVisible(value.DeclaringType, visibility))
			{
				IMethodDeclaration methodDeclaration = value.Resolve();
				switch (methodDeclaration.Visibility)
				{
					case MethodVisibility.Public:
						return visibility.Public;

					case MethodVisibility.Assembly:
						return visibility.Assembly;

					case MethodVisibility.FamilyOrAssembly:
						return visibility.FamilyOrAssembly;

					case MethodVisibility.Family:
						return visibility.Family;

					case MethodVisibility.Private:
					case MethodVisibility.PrivateScope:
						return visibility.Private;

					case MethodVisibility.FamilyAndAssembly:
						return visibility.FamilyAndAssembly;
				}

				throw new NotSupportedException();
			}

			return false;
		}

		public static string GetTypeName(IPropertyReference value)
		{
			IParameterDeclarationCollection parameters = value.Parameters;
			if (parameters.Count > 0)
			{
				using (StringWriter writer = new StringWriter(CultureInfo.InvariantCulture))
				{
					for (int i = 0; i < parameters.Count; i++)
					{
						if (i != 0)
						{
							writer.Write(", ");
						}

						writer.Write(parameters[i].ParameterType.ToString());
					}

					return value.Name + "[" + writer.ToString() + "] : " + value.PropertyType.ToString();
				}
			}

			return value.Name + " : " + value.PropertyType.ToString();
		}

		public static string GetNameWithDeclaringType(IPropertyReference value)
		{
			return Helper.GetTypeName(value.DeclaringType as ITypeReference) + "." + Helper.GetTypeName(value);
		}

		public static MethodVisibility GetVisibility(IPropertyReference value)
		{
			MethodVisibility visibility = MethodVisibility.Public;
			
			IPropertyDeclaration propertyDeclaration = value.Resolve();
			if (propertyDeclaration != null)
			{
				IMethodReference setMethodReference = propertyDeclaration.SetMethod;
				IMethodDeclaration setMethod = (setMethodReference == null) ? null : setMethodReference.Resolve();
	
				IMethodReference getMethodReference = propertyDeclaration.GetMethod;
				IMethodDeclaration getMethod = (getMethodReference == null) ? null : getMethodReference.Resolve();

				if ((setMethod != null) && (getMethod != null))
				{
					if (getMethod.Visibility == setMethod.Visibility)
					{
						visibility = getMethod.Visibility;
					}
				}
				else if (setMethod != null)
				{
					visibility = setMethod.Visibility;
				}
				else if (getMethod != null)
				{
					visibility = getMethod.Visibility;
				}
			}

			return visibility;
		}

		public static bool IsVisible(IPropertyReference value, IVisibilityConfiguration visibility)
		{
			if (Helper.IsVisible(value.DeclaringType, visibility))
			{
				switch (Helper.GetVisibility(value))
				{
					case MethodVisibility.Public:
						return visibility.Public;

					case MethodVisibility.Assembly:
						return visibility.Assembly;

					case MethodVisibility.FamilyOrAssembly:
						return visibility.FamilyOrAssembly;

					case MethodVisibility.Family:
						return visibility.Family;

					case MethodVisibility.Private:
					case MethodVisibility.PrivateScope:
						return visibility.Private;

					case MethodVisibility.FamilyAndAssembly:
						return visibility.FamilyAndAssembly;
				}

				throw new NotSupportedException();
			}

			return false;
		}

		public static string GetTypeName(IEventReference value)
		{
			return value.Name;
		}

		public static string GetNameWithDeclaringType(IEventReference value)
		{
            return Helper.GetTypeName(value.DeclaringType as ITypeReference) + "." + Helper.GetTypeName(value);
		}

		public static IMethodDeclaration GetAddMethod(IEventReference value)
		{
			IEventDeclaration eventDeclaration = value.Resolve();
			if (eventDeclaration.AddMethod != null)
			{
				return eventDeclaration.AddMethod.Resolve ();
			}

			return null;
		}

		public static IMethodDeclaration GetRemoveMethod(IEventReference value)
		{
			IEventDeclaration eventDeclaration = value.Resolve();
			if (eventDeclaration.RemoveMethod != null)
			{
				return eventDeclaration.RemoveMethod.Resolve();
			}

			return null;
		}

		public static IMethodDeclaration GetInvokeMethod(IEventReference value)
		{
			IEventDeclaration eventDeclaration = value.Resolve();
			if (eventDeclaration.InvokeMethod != null)
			{
				return eventDeclaration.InvokeMethod.Resolve ();
			}

			return null;
		}

		public static MethodVisibility GetVisibility(IEventReference value)
		{
			IMethodDeclaration addMethod = Helper.GetAddMethod(value);
			IMethodDeclaration removeMethod = Helper.GetRemoveMethod(value);
			IMethodDeclaration invokeMethod = Helper.GetInvokeMethod(value);

			if ((addMethod != null) && (removeMethod != null) && (invokeMethod != null))
			{
				if ((addMethod.Visibility == removeMethod.Visibility) && (addMethod.Visibility == invokeMethod.Visibility))
				{
					return addMethod.Visibility;
				}
			}
			else if ((addMethod != null) && (removeMethod != null))
			{
				if (addMethod.Visibility == removeMethod.Visibility)
				{
					return addMethod.Visibility;
				}
			}
			else if ((addMethod != null) && (invokeMethod != null))
			{
				if (addMethod.Visibility == invokeMethod.Visibility)
				{
					return addMethod.Visibility;
				}
			}
			else if ((removeMethod != null) && (invokeMethod != null))
			{
				if (removeMethod.Visibility == invokeMethod.Visibility)
				{
					return removeMethod.Visibility;
				}
			}
			else if (addMethod != null)
			{
				return addMethod.Visibility;
			}
			else if (removeMethod != null)
			{
				return removeMethod.Visibility;
			}
			else if (invokeMethod != null)
			{
				return invokeMethod.Visibility;
			}

			return MethodVisibility.Public;
		}

		public static bool IsVisible(IEventReference value, IVisibilityConfiguration visibility)
		{
			if (Helper.IsVisible(value.DeclaringType, visibility))
			{
				switch (Helper.GetVisibility(value))
				{
					case MethodVisibility.Public :
						return visibility.Public;

					case MethodVisibility.Assembly :
						return visibility.Assembly;

					case MethodVisibility.FamilyOrAssembly :
						return visibility.FamilyOrAssembly;

					case MethodVisibility.Family :
						return visibility.Family;

					case MethodVisibility.Private:
					case MethodVisibility.PrivateScope:
						return visibility.Private;

					case MethodVisibility.FamilyAndAssembly :
						return visibility.FamilyAndAssembly;
				}

				throw new NotSupportedException();
			}

			return false;
		}

		public static bool IsStatic(IEventReference value)
		{
			bool isStatic = false;

			if (Helper.GetAddMethod(value) != null)
			{
				isStatic |= Helper.GetAddMethod(value).Static;
			}

			if (Helper.GetRemoveMethod(value) != null)
			{
				isStatic |= Helper.GetRemoveMethod(value).Static;
			}

			if (Helper.GetInvokeMethod(value) != null)
			{
				isStatic |= Helper.GetInvokeMethod(value).Static;
			}

			return isStatic;
		}

		public static bool IsBaseMethod(IMethodReference value, IMethodReference baseMethod)
		{
			if (value.Name != baseMethod.Name)
			{
				return false;
			}

			if (value.GenericMethod != null)
			{
				value = value.GenericMethod;
			}

			if (baseMethod.GenericMethod != null)
			{
				baseMethod = baseMethod.GenericMethod;
			}

			if (!value.ReturnType.Type.Equals(baseMethod.ReturnType.Type))
			{
				return false;
			}

			if ((value.HasThis != baseMethod.HasThis) && (value.ExplicitThis != baseMethod.ExplicitThis) && (value.CallingConvention != baseMethod.CallingConvention))
			{
				return false;
			}

			if (value.Parameters.Count != baseMethod.Parameters.Count)
			{
				return false;
			}

			for (int i = 0; i < value.Parameters.Count; i++)
			{
				if (!value.Parameters[i].ParameterType.Equals(baseMethod.Parameters[i].ParameterType))
				{
					return false;
				}
			}

			if (value.GenericArguments.Count != baseMethod.GenericArguments.Count)
			{
				return false;
			}

			IMethodDeclaration methodDeclaration = value.Resolve();
			IMethodDeclaration baseMethodDeclaration = baseMethod.Resolve();
			if ((methodDeclaration == null) || (baseMethodDeclaration == null))
			{
				return false;
			}

			if ((!methodDeclaration.Virtual) || (!baseMethodDeclaration.Virtual))
			{
				return false;
			}

			if (!Helper.IsBaseType(methodDeclaration.DeclaringType, baseMethodDeclaration.DeclaringType))
			{
				return false;
			}

			return true;
		}

        public static bool IsLogicExpression(IExpression expression)
        {
            if (expression is IBinaryExpression)
            {
                switch (((IBinaryExpression)expression).Operator)
                {
                    case BinaryOperator.ValueInequality:
                    case BinaryOperator.IdentityInequality:
                    case BinaryOperator.ValueEquality:
                    case BinaryOperator.IdentityEquality:
                    case BinaryOperator.BooleanOr:
                    case BinaryOperator.BooleanAnd:
                    case BinaryOperator.LessThan:
                    case BinaryOperator.LessThanOrEqual:
                    case BinaryOperator.GreaterThan:
                    case BinaryOperator.GreaterThanOrEqual:
                        return true;
                }
            }
            return false;
        }

        public static bool IsEqual(IType type, Type netType)
        {
            ITypeReference typeReference = type as ITypeReference;
            if (typeReference == null)
                return false;

            ITypeDeclaration typeDeclaration = typeReference.Resolve();
            if (typeDeclaration == null)
                return false;

            string fullName = typeDeclaration.Namespace + "." + typeDeclaration.Name;

            return fullName == netType.FullName;
        }

        public static bool IsBaseType(IType type, IType baseType)
		{
			ITypeReference typeReference = type as ITypeReference;
			ITypeReference baseTypeReference = baseType as ITypeReference;
			if ((typeReference != null) && (baseTypeReference != null))
			{
				ITypeDeclaration typeDeclaration = typeReference.Resolve();
				if (typeDeclaration != null)
				{
					if ((typeDeclaration.BaseType != null) && (typeDeclaration.BaseType.Equals(baseType)))
					{
						return true;
					}

					foreach (ITypeReference interfaceType in typeDeclaration.Interfaces)
					{
						if (interfaceType.Equals(baseType))
						{
							return true;
						}
					}

					if ((typeDeclaration.BaseType != null) && (IsBaseType(typeDeclaration.BaseType, baseType)))
					{
						return true;
					}

					foreach (ITypeReference interfaceType in typeDeclaration.Interfaces)
					{
						if (IsBaseType(interfaceType, baseType))
						{
							return true;
						}
					}
				}
			}

			return false;
		}
	}
}
