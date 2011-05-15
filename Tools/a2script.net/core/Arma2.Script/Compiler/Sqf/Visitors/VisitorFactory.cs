using System;
using System.Linq;
using Arma2.Script.Compiler.Sqf;
using Reflector.CodeModel;
using Reflector.CodeModel.Memory;

namespace Arma2.Script.Compiler.Sqf.Visitors
{
    public static class VisitorFactory
    {
        private static IVisitor[] Visitors { get; set; }
        public static IVisitor BaseVisitor { get; private set; }

        static VisitorFactory()
        {
            var visitors =
                System.Reflection.Assembly.GetExecutingAssembly()
                    .GetTypes().Where(type => type.GetInterface(typeof (IVisitor).FullName) != null)
                    .Select(type => (IVisitor)type.GetConstructor(new Type[0]).Invoke(new object[0])).ToArray();

            BaseVisitor = visitors.First(visitor => visitor.GetAdaptingType() == null);
            Visitors = visitors.Where(visitor => visitor.GetAdaptingType() != null).ToArray();
        }

        public static IVisitor[] GetVisitor()
        {
            return Visitors;
        }

        public static IVisitor[] GetVisitor(IType type)
        {
            if (type == null)
                return new IVisitor[0];

            return Visitors.Where(visitor => Helper.IsEqual(type, visitor.GetAdaptingType())).ToArray();
        }
    }
}