using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mac.Arma.Config;
using Mac.Arma.Files;

namespace ConsoleApplication2
{
    internal class Textualiser : ConfigVisitor
    {
        // Fields
        private int IndentLevel;
        private int PadSize = 4;
        private StringBuilder Text = new StringBuilder();

        // Methods
        private void AppendIndented(string s)
        {
            for (int i = 0; i < IndentLevel; i++)
                this.Text.Append("\t");

            this.Text.Append(s);
        }

        private void AppendLineIndented(string s)
        {
            for (int i = 0; i < IndentLevel; i++)
                this.Text.Append("\t");

            this.Text.AppendLine(s);
        }

        private void ExpandNestedArray(ICollection<object> objects)
        {
            this.AppendLineIndented("{");
            this.IndentLevel++;
            int num = 0;
            foreach (object obj2 in objects)
            {
                ICollection<object> is2 = obj2 as ICollection<object>;
                if (is2 != null)
                {
                    this.ExpandNestedArray(is2);
                }
                else
                {
                    this.AppendIndented(TextFile.ToString(obj2));
                }
                if (num++ != (objects.Count - 1))
                {
                    this.Text.AppendLine(",");
                }
                else
                {
                    this.Text.AppendLine();
                }
            }
            this.IndentLevel--;
            this.AppendIndented("}");
        }

        private void ExpandNestedArrayEx(ICollection<object> objects)
        {
            this.Text.Append("{");
            //this.IndentLevel++;
            int num = 0;
            foreach (object obj2 in objects)
            {
                ICollection<object> is2 = obj2 as ICollection<object>;
                if (is2 != null)
                {
                    this.ExpandNestedArray(is2);
                }
                else
                {
                    this.Text.Append(TextFile.ToString(obj2));
                }
                if (num++ != (objects.Count - 1))
                {
                    this.Text.Append(", ");
                }
            }
            //this.IndentLevel--;
            this.Text.Append("}");
        }

        public string Visit(ConfigEntry entry)
        {
            base.Visit(entry);
            return this.Text.ToString();
        }

        protected override void VisitArrayProperty(ArrayProperty node)
        {
            this.AppendIndented(node.Name + "[]=");
            this.ExpandNestedArrayEx(node.ToList<object>());
            this.Text.AppendLine(";");
            base.VisitArrayProperty(node);
        }

        protected override void VisitConfigClass(ConfigClass node)
        {
            StringBuilder builder = new StringBuilder("class " + node.Name);
            if (node.ParentName.Length != 0)
            {
                builder.Append(":" + node.ParentName);
            }
            this.AppendLineIndented(builder.ToString());
            this.AppendLineIndented("{");
            this.IndentLevel++;
            base.VisitConfigClass(node);
            this.IndentLevel--;
            this.AppendLineIndented("};");
        }

        protected override void VisitConfigEnum(ConfigEnum node)
        {
            this.AppendLineIndented("enum");
            this.AppendLineIndented("{");
            this.IndentLevel++;
            IList<string> list = node.ToList();
            IDictionary<string, int> dictionary = node.ToDictionary();
            int num = 0;
            foreach (string str in list)
            {
                string s = str + "=" + dictionary[str];
                if (num++ != (node.Count - 1))
                {
                    s = s + ",";
                }
                this.AppendLineIndented(s);
            }
            this.IndentLevel--;
            this.AppendLineIndented("};");
            base.VisitConfigEnum(node);
        }

        protected override void VisitConfigFile(ConfigFile node)
        {
            base.VisitConfigFile(node);
        }

        protected override void VisitDeleteReference(DeleteReference node)
        {
            this.AppendLineIndented("delete " + node.Name);
            base.VisitDeleteReference(node);
        }

        protected override void VisitExternReference(ExternReference node)
        {
            this.AppendLineIndented("class " + node.Name + ";");
            base.VisitExternReference(node);
        }

        protected override void VisitFloatProperty(FloatProperty node)
        {
            this.AppendLineIndented(node.Name + "=" + TextFile.ToString(node.Value) + ";");
            base.VisitFloatProperty(node);
        }

        protected override void VisitIntProperty(IntProperty node)
        {
            this.AppendLineIndented(node.Name + "=" + TextFile.ToString(node.Value) + ";");
            base.VisitIntProperty(node);
        }

        protected override void VisitStringProperty(StringProperty node)
        {
            this.AppendLineIndented(node.Name + "=" + TextFile.ToString(node.Value) + ";");
            base.VisitStringProperty(node);
        }
    }
}