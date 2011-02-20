using System;
using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public partial class Processor
    {
        private List<Function> _functions;

        private static List<string> _operators; 
        public static List<string> Operators
        {
            get
            {
                if (_operators == null)
                {
                    _operators = ReadUniqueItemCollection(_operatorList, "Operator");
                }
                return _operators;
            }
        }

        public List<Function> Functions
        {
            get
            {
                if (_functions == null)
                {
                    _functions = new List<Function>(CommandData);
                }
                return _functions;
            }
        }

        public static bool IsOperator(string value)
        {
            value = value.ToLower().Trim();
            return Operators.Any(m => m == value);
        }

        public bool IsCommand(string value)
        {
            value = value.ToLower().Trim();
            return Functions.Any(m => m.Name.Equals(value, StringComparison.CurrentCultureIgnoreCase));
        }

        public Function GetFunction(string name)
        {
            name = name.Trim();
            return Functions.FirstOrDefault(m => m.Name.Equal(name));
        }

        private static List<string> ReadUniqueItemCollection(string content, string warningMessage)
        {
            var items = content.Split("\n".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Select(m => m.Split(new[] { ":=" }, StringSplitOptions.RemoveEmptyEntries));

            var groups = items.Select(m => m[0].Trim())
                .Where(m => m.Length > 0)
                .GroupBy(m => m);

            groups.Where(m => m.Count() > 1).ForEach(n => Logger.Log(LogLevel.Warning, "{0}: Duplicate '{1}'", warningMessage, n.Key));

            groups.Where(m => m.Key.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).Count() > 1).ForEach(n =>
                                                                                                                         {
                                                                                                                             Logger.Log(LogLevel.Warning, "{0}: Spaces are not allowed '{1}'", warningMessage, n.Key);
                                                                                                                         });

            var items1 = groups.Select(m => m.Key);

            int max = items1.Max(m => m.Length);

            //using (StreamWriter output = new StreamWriter(string.Format("c:\\{0}.txt", warningMessage)))
            //{
            //    items1.ForEach(m =>
            //    {
            //        int nspace = (max - m.Length);
            //        string tab = " ";
            //        while (nspace-- > 0)
            //            tab = tab + " ";

            //        output.WriteLine("new Function {{ Name=\"{0}\",{1}OnCompile = null,\tOnExecute = null }},", m, tab);
            //    });
            //}

            return items1.Select(m => m.ToLower()).OrderByDescending(m => m.Length)
                .ToList();
        }        
    }
}