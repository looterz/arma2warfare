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
                var constr = attribute.Constructor.Resolve();
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
                var baseMethod = GetBaseMethod(method, baseType.Resolve());
                if (baseMethod != null)
                    return baseMethod;
            }

            for(int i=0; i< type.Interfaces.Count; i++)
            {
                var baseMethod = GetBaseMethod(method, type.Interfaces[i].Resolve());
                if (baseMethod != null)
                    return baseMethod;
            }

            return null;
        }

        public static IMethodDeclaration GetBaseMethod(IMethodDeclaration method, ITypeDeclaration baseType)
        {
            var methods =
                baseType.Methods.Cast<IMethodDeclaration>()
                    .Where(m => m.Name == method.Name && 
                                m.Parameters.Count == method.Parameters.Count &&
                                m.ReturnType.Type == method.ReturnType.Type);

            methods = methods
                    .Where(m => m.Parameters.Cast<IParameterDeclaration>().Where((p, id) => p.ParameterType != method.Parameters[id].ParameterType).Count() == 0);

            return methods.FirstOrDefault();
        }
    }
}