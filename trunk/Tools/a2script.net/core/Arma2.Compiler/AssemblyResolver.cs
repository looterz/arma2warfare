using System.Reflection;
using Reflector.CodeModel;

namespace SqfCompiler
{
    public class AssemblyResolver : IAssemblyResolver
    {
        private IAssemblyManager _assemblyManager;

        public AssemblyResolver(IAssemblyManager appManager)
        {
            _assemblyManager = appManager;
        }

        public IAssembly Resolve(IAssemblyReference value, string localPath)
        {
            Assembly assembly = Assembly.Load(value.ToString());
            return _assemblyManager.LoadFile(assembly.Location);
        }
    }
}