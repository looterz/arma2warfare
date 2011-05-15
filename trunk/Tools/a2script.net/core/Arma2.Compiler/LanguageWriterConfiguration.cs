using System.Collections.Generic;
using Reflector.CodeModel;

namespace SqfCompiler
{
    class LanguageWriterConfiguration : ILanguageWriterConfiguration
    {
        private IVisibilityConfiguration _visibilityConfiguration;
        private Dictionary<string, string> _config = new Dictionary<string, string>();

        public LanguageWriterConfiguration(IVisibilityConfiguration visibilityConfiguration)
        {
            _visibilityConfiguration = visibilityConfiguration;
        }

        public IVisibilityConfiguration Visibility
        {
            get { return _visibilityConfiguration; }
        }

        public string this[string name]
        {
            get { return _config.ContainsKey(name) ? _config[name] : null; }
            set
            {
                if (_config.ContainsKey(name) == false)
                    _config.Add(name, value);
                else
                {
                    _config[name] = value;
                }
            }
        }
    }
}