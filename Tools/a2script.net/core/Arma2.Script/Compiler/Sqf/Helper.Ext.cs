using System.Collections.Generic;
using System.Linq;
using Arma2.Script.Compiler.Sqf.Attributes;
using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf
{
    public partial class Helper
    {
        public static ICustomAttribute GetInlineAttribute(ICustomAttributeCollection attributeCollection)
        {
            return attributeCollection.Cast<ICustomAttribute>().FirstOrDefault(attribute =>
            {
                var constr = ResolveMethod(attribute.Constructor);
                if (constr == null)
                    return false;

                var type = ((ITypeDeclaration) constr.DeclaringType).Resolve();
                var fullName = type.Namespace + "." + type.Name;

                return fullName == typeof (InlineMethodAttribute).FullName;
            });
        }

        public static ICollection<ICustomAttribute> GetCustomAttributes(IMethodDeclaration method, bool inheritance)
        {
            List<ICustomAttribute> attributes = new List<ICustomAttribute>();
            attributes.AddRange(method.Attributes.Cast<ICustomAttribute>());

            if (inheritance)
            {
                List<ITypeDeclaration> parentTypes = new List<ITypeDeclaration>();
                var type = ((ITypeReference) (method.DeclaringType)).Resolve();
                while (type.BaseType != null)
                {
                    type = type.BaseType.Resolve();
                    parentTypes.Add(type);

                    parentTypes.AddRange(GetInterfaces(type).Cast<ITypeDeclaration>());
                }
            }
            return attributes;
        }

        public static IMethodDeclaration GetBaseMethod(IMethodDeclaration method)
        {
            var type = ((ITypeReference)method.DeclaringType).Resolve();
            var baseType = type.BaseType;
            if (baseType != null)
            {
                var baseMethod = GetMethodBySignature(method, baseType.Resolve());
                if (baseMethod != null)
                    return baseMethod;
            }

            for(int i=0; i< type.Interfaces.Count; i++)
            {
                var baseMethod = GetMethodBySignature(method, type.Interfaces[i].Resolve());
                if (baseMethod != null)
                    return baseMethod;
            }

            return null;
        }

        public static IMethodDeclaration ResolveMethod(IMethodReference methodReference)
        {
            var decl = methodReference.Resolve();
            if (decl != null)
                return decl;

            var methodSignature = (IMethodSignature)methodReference;
            var typeRef = (ITypeReference)methodReference.DeclaringType;
            var typeDef = typeRef.Resolve();

            return Helper.GetMethodBySignature(typeDef, methodReference.Name, methodSignature.Parameters);
        }

        public static bool IsParameterEqual(IParameterDeclarationCollection a, IParameterDeclarationCollection b)
        {
            for(int i=0; i<a.Count; i++)
            {
                var aType1 = a[i].ParameterType as IArrayType;
                var aType2 = b[i].ParameterType as IArrayType;

                var type1 = a[i].ParameterType as ITypeReference;
                var type2 = b[i].ParameterType as ITypeReference;                

                if (aType1 != null && aType2 != null)
                {
                    if (aType1.Dimensions.Count != aType2.Dimensions.Count)
                        return false;

                    type1 = aType1.ElementType as ITypeReference;
                    type2 = aType2.ElementType as ITypeReference;
                }

                if (type1 != null && type2 != null)
                {
                    if ((type1.Namespace == type2.Namespace && type1.Name == type2.Name) == false)
                        return false;

                    continue;
                }

                if (a[i].ParameterType != b[i].ParameterType)
                    return false;    
            }
            return true;
        }

        public static IMethodDeclaration GetMethodBySignature(ITypeDeclaration baseType, string methodName, IParameterDeclarationCollection argumentTypes)
        {
            var methods =
                baseType.Methods.Cast<IMethodDeclaration>()
                    .Where(m => m.Name == methodName &&
                                m.Parameters.Count == argumentTypes.Count);

            methods = methods
                    .Where(m => IsParameterEqual(m.Parameters, argumentTypes));

            return methods.FirstOrDefault();
        }

        public static IMethodDeclaration GetMethodBySignature(IMethodDeclaration method, ITypeDeclaration baseType)
        {
            var methods =
                baseType.Methods.Cast<IMethodDeclaration>()
                    .Where(m => m.Name == method.Name && 
                                m.Parameters.Count == method.Parameters.Count);

            methods = methods
                    .Where(m => m.Parameters.Cast<IParameterDeclaration>().Where((p, id) => p.ParameterType != method.Parameters[id].ParameterType).Count() == 0);

            return methods.FirstOrDefault();
        }
    }
}