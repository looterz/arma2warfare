using System;

namespace jsc.Languages.SQF
{
    public class ScopeScriptWriter : IDisposable
    {
        private ScriptWriter _writer;
        private string _openCh, _closeCh;
        
        public ScopeScriptWriter(ScriptWriter writer, string openCh, string closeCh)
        {
            _openCh = openCh;
            _closeCh = closeCh;

            _writer = writer;
            if (!string.IsNullOrEmpty(_openCh))
            {
                _writer.WriteLine(_openCh);
            }
            _writer.Ident++;

        }

        public void Dispose()
        {
            _writer.Ident--;
            if (!string.IsNullOrEmpty(_closeCh))
            {
                _writer.WriteLine(_closeCh);
            }
        }
    }
}