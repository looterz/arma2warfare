using System;
using System.Collections.Generic;

namespace ArmA2.Script.ScriptProcessor
{
    public class Validation
    {
        private static void GetTwoArgs(CmdText cmd, List<string> validate, out CmdBase nextOp, out CmdBase prevOp)
        {
            prevOp = cmd.NextCmd(-1);
            nextOp = cmd.NextCmd(1);

            if (prevOp == null)
                validate.Add(string.Format("First argument '{0}' is not defined", cmd.Text));

            if (nextOp == null)
                validate.Add(string.Format("Second argument '{0}' is not defined", cmd.Text));
        }

        public static void ValidateElement(CmdElement root, List<string> errorList)
        {
            for (int i = 0; i < root.Items.Count; i++)
            {
                CmdBase item = root.Items[i];
                if (item is CmdOperator)
                {
                    ValidateOperator((CmdOperator)item, errorList);
                    continue;
                }
                if (item is CmdCommand)
                {
                    ValidateCommand((CmdCommand)item, errorList);
                    continue;
                }
                if (item is CmdElement)
                {
                    ValidateElement((CmdElement) item, errorList);
                }
            }
        }

        public static void ValidateOperator(CmdOperator cmd, List<string> validate)
        {
            CmdBase nextOp, prevOp;
            GetTwoArgs(cmd, validate, out nextOp, out prevOp);

            if (prevOp != null && !(prevOp is CmdElement || prevOp is CmdVariable || prevOp is CmdFloat))
               validate.Add(string.Format("1st argument must be (valuetype) '{0}'", cmd.Text));

            if (nextOp != null && !(nextOp is CmdElement || nextOp is CmdVariable || nextOp is CmdFloat))
               validate.Add(string.Format("2nd argument must be (valuetype) '{0}'", cmd.Text));
        }

        public static void ValidateCommand(CmdCommand cmd, List<string> validate)
        {
            if (cmd.Function.OnValidate != null)
                cmd.Function.OnValidate(cmd, validate);

        }

        public static void ForEach(CmdCommand cmd, List<string> validate)
        {
            CmdBase prevOp, nextOp;
            GetTwoArgs(cmd, validate, out nextOp, out prevOp);

            if (prevOp != null && !(prevOp is CmdScopeCode || prevOp is CmdVariable))
               validate.Add(string.Format("{0}: 1st argument must be codeScope or variable", cmd.Text));

            if (nextOp != null && !(nextOp is CmdScopeBase || nextOp is CmdVariable))
               validate.Add(string.Format("{0}: 2nd argument can be array|expression|code scope|variable", cmd.Text));

            var endOp = cmd.NextCmd(2);
            if (endOp != null && !(endOp is CmdSeparator || ((CmdSeparator)endOp).Text == ";"))
                validate.Add(string.Format("{0}: operation not closed with ;", cmd.Text));

        }

        public static void If(CmdCommand cmd, List<string> errorList)
        {
        }
    }
}