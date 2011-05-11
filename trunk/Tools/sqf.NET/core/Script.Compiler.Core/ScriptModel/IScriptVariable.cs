namespace Script.Compiler.Core.ScriptModel
{
    public interface IScriptVariable
    {
        string Name { get;  }
        IScriptMethod Method { get;  }
    }
}