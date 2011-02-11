using System;
using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    public partial class Processor
    {
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

        public static bool IsOperator(string value)
        {
            value = value.ToLower().Trim();
            return Operators.Any(m => m == value);
        }

        private const string _operatorList = @"
!
!=
%
&&
greater
greater=
less
less=
or
and
plus
*
-
/
==
=
:
||
>=
<=
^
&
";
    }
}