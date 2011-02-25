using System;
using System.Collections.Generic;
using System.Linq;

namespace ArmA2.Script.ScriptProcessor
{
    internal class FsmClass : INamedItem
    {
        private FsmClass _states;

        internal CmdCommand Command { get; private set; }
        internal string Name { get; private set; }

        internal CmdScopeBase Scope { get; private set; }

        internal bool IsValid { get; private set; }
        internal FsmClass Parent { get; private set; }

        internal bool Compiled { get; set; }

        internal FsmClass(CmdScopeBase scope)
        {
            Scope = scope;
        }

        internal FsmClass States { 
            get
            {
                if (_states == null)
                    return Parent.States;

                return _states;
            }
            set { _states = value; }
        }

        internal FsmClass(CmdElement node)
        {
            IsValid = false;

            var cmd = node.Commands.Get<CmdCommand>(0);
            var name = node.Commands.Get<CmdVariable>(1);
            var scope = node.Commands.Get<CmdScopeBase>(2);

            if (cmd == null || name == null || scope == null)
                return;

            if (cmd.Text.Equal("class") == false)
                return;

            Command = cmd;
            Name = name.Text;
            Scope = scope;
            IsValid = true;
        }

        private NamedList<FsmClass> _classList;
        internal NamedList<FsmClass> ClassList
        {
            get
            {
                if (_classList == null)
                {
                    var nodes = Scope.Commands.Where(m => m is CmdElement);
                    var classes = nodes.Select(m =>
                                               {
                                                   var n = new FsmClass((CmdElement) m);
                                                   n.Parent = this;
                                                   return n;
                                               });
                    var valid = classes.Where(m => m.IsValid).ToList();

                    _classList = new NamedList<FsmClass>();
                    _classList.AddRange(valid);
                }
                return _classList;
            }
        }

        private NamedList<FsmProperty> _propertyList;
        internal NamedList<FsmProperty> PropertyList
        {
            get
            {
                if (_propertyList == null)
                {
                    var nodes = Scope.Commands.Where(m => m is CmdElement);
                    var classes = nodes.Select(m =>
                                               {
                                                   var prop = new FsmProperty((CmdElement) m);
                                                   prop.Parent = this;
                                                   return prop;
                                               });
                    var valid = classes.Where(m => m.IsValid).ToList();

                    _propertyList = new NamedList<FsmProperty>();
                    _propertyList.AddRange(valid);
                }
                return _propertyList;
            }
        }

        public override string ToString()
        {
            string txt = (Parent != null) ? Parent + " // " : "";
            return txt + "class " + Name;
        }

        public string GetName()
        {
            return Name;
        }

        static string[] IgnoredProperty = new[] { "fsmname", "from", "to", "name", "priority", "initstate" };

        internal void Compile(Compiler compiler, CmdScopeCodeRoot fsmCodeScope, string path)
        {
            if (Compiled)
            {
                //Logger.Log(LogLevel.High, path + "X " + "(" + Name + ")" );
                return;
            }
            Compiled = true;

            if (Name.Equal("Links") == false)
            {
                path = path + Name;
                Logger.Log(LogLevel.Trace, path);
                path = path + " -> ";
            }


            foreach(var property in PropertyList)
            {
                if (IgnoredProperty.Any(m => m.Equal(property.Name)))
                    continue;

                try
                {
                    CompileProperty(property, compiler, fsmCodeScope);
                }
                catch (CompileException e)
                {
                    if (e.Throwable)
                        throw;

                    e.WriteToLog();
                }
            }

           

            var next = PropertyList["to"];
            if (next != null)
            {
                var nextClassName = next.GetValue<CmdString>();
                if (nextClassName == null)
                    throw new CompileException(CompileCode.FsmInvalidValueType, "Property value must be string: {0}", next.ToString());

                var nextClass = States.ClassList[nextClassName.Text];
                if (nextClass == null)
                    throw new CompileException(CompileCode.FsmMissedClass, "Next Class '{0}' not found: {1}", nextClassName.Text, next.ToString());

                nextClass.Compile(compiler, fsmCodeScope, path);
            }

            ClassList.ForEach(m => m.Compile(compiler, fsmCodeScope, path));

        }

        private void CompileProperty(FsmProperty property, Compiler compiler, CmdScopeCodeRoot fsmCodeScope)
        {
            var value = property.GetValue<CmdString>();
            if (value == null)
                throw new CompileException(CompileCode.FsmInvalidValueType, "Property value must be string: {0}", property.ToString());

            var valueContent = value.Text.Replace("\"\"", "\"");
            valueContent = compiler.CompilePartial(valueContent, fsmCodeScope);
            value.Text = valueContent.Replace("\"", "\"\"");
        }
    }
}