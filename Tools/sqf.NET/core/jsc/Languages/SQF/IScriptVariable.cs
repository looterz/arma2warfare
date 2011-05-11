namespace jsc.Languages.SQF
{
    public interface IScriptVariable
    {
        string Name { get;  }
        IScriptMethod Method { get;  }
    }
}