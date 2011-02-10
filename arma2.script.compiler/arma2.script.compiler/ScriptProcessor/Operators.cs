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
                    _operators = ReadUniqueItemCollection(_operatorList, "Duplicated operator");
                }
                return _operators;
            }
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
*
plus
-
/
==
^
or
=
:
";
    }
}