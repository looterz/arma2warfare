using System;
using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.Compile.Lexicon
{
    internal class Dict
    {
        #region Поля класса

        private List<Function> _operators;
        private List<Function> _functions;

        #endregion

        #region Свойства класса

        internal List<Function> Operators
        {
            get
            {
                if (_operators == null)
                {
                    _operators = (new List<Function>(LexOperator.List)).OrderByDescending(m => m.Name).ToList();
                }
                return _operators;
            }
        }

        internal List<Function> Functions
        {
            get
            {
                if (_functions == null)
                {
                    _functions = (new List<Function>(LexCommand.List)).OrderByDescending(m => m.Name).ToList();
                }
                return _functions;
            }
        }

        #endregion

        #region Методы класса

        internal bool IsOperator(string value)
        {
            value = value.ToLower().Trim();
            return Operators.Any(m => m.Name.Equal(value));
        }

        internal bool IsCommand(string value)
        {
            value = value.ToLower().Trim();
            return Functions.Any(m => m.Name.Equals(value, StringComparison.CurrentCultureIgnoreCase));
        }

        internal Function GetFunction(string name)
        {
            name = name.Trim();
            return Functions.FirstOrDefault(m => m.Name.Equal(name));
        }

        private List<string> ReadUniqueItemCollection(string content, string warningMessage)
        {
            IEnumerable<string[]> items =
                content.Split("\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Select(
                    m => m.Split(new[] {":="}, StringSplitOptions.RemoveEmptyEntries));

            IEnumerable<IGrouping<string, string>> groups = items.Select(m => m[0].Trim())
                .Where(m => m.Length > 0)
                .GroupBy(m => m);

            groups.Where(m => m.Count() > 1).ForEach(
                n => Logger.Log(LogLevel.Warning, "{0}: Duplicate '{1}'", warningMessage, n.Key));

            groups.Where(m => m.Key.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Count() > 1)
                .ForEach(n => Logger.Log(LogLevel.Warning, "{0}: Spaces are not allowed '{1}'", warningMessage, n.Key));

            IEnumerable<string> items1 = groups.Select(m => m.Key);

            return items1.Select(m => m.ToLower()).OrderByDescending(m => m.Length)
                .ToList();
        }

        #endregion
    }
}