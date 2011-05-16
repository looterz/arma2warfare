using System;
using System.Collections;
using System.Globalization;
using System.IO;
using System.Linq;
using Arma2.Script.Compiler.Sqf;
using Arma2.Script.Compiler.Sqf.Visitors;
using Reflector.CodeModel;
using Reflector.CodeModel.Memory;

namespace Arma2.Script.Compiler.Sqf
{
    internal partial class LanguageWriter : ILanguageWriterEx
    {
        #region Поля класса

        private static Hashtable specialMethodNames;
        private static Hashtable specialTypeNames;
        private readonly ILanguageWriterConfiguration configuration;
        private readonly IFormatter formatter;

        private readonly string[] keywords = new[]
        {
            "and", "array", "as", "asm",
            "begin", "case", "class", "const",
            "constructor", "destructor", "dispinterface", "div",
            "do", "downto", "else", "end",
            "except", "exports", "file", "finalization",
            "finally", "for", "function", "goto",
            "if", "implementation", "in", "inherited",
            "initialization", "inline", "interface", "is",
            "label", "library", "mod", "nil",
            "not", "object", "of", "or",
            "out", "packed", "procedure", "program",
            "property", "raise", "record", "repeat",
            "resourcestring", "set", "shl", "shr",
            /*"string", */    "then", "threadvar", "to",
            "try", "type", "unit", "until",
            "uses", "var", "while", "with",
            "xor"
        };

        private readonly NumberFormat _numberFormat;
        private int _blockStatementLevel;

        private bool _hasSeparator;
        private bool forLoop;
        private int _pendingOutdent;
        private bool _renderOptionalSpaces;

        #endregion

        internal void WriteOptionalSpace()
        {
            if (_renderOptionalSpaces)
            {
                formatter.Write(" ");
            }
        }

        #region Конструкторы класса

        public LanguageWriter(IFormatter formatter, ILanguageWriterConfiguration configuration)
        {
            this.formatter = formatter;
            this.configuration = configuration;

            if (specialTypeNames == null)
            {
                specialTypeNames = new Hashtable();
                specialTypeNames["Void"] = " ";
                specialTypeNames["Object"] = "";
                specialTypeNames["String"] = "";
                specialTypeNames["SByte"] = "";
                specialTypeNames["Byte"] = "";
                specialTypeNames["Int16"] = "";
                specialTypeNames["UInt16"] = "";
                specialTypeNames["Int32"] = "";
                specialTypeNames["UInt32"] = "";
                specialTypeNames["Int64"] = "";
                specialTypeNames["UInt64"] = "";
                specialTypeNames["Char"] = "";
                specialTypeNames["Boolean"] = "";
                specialTypeNames["Single"] = "";
                specialTypeNames["Double"] = "";
                specialTypeNames["Decimal"] = "";
            }

            if (specialMethodNames == null)
            {
                specialMethodNames = new Hashtable();
                specialMethodNames["op_UnaryPlus"] = "+";
                specialMethodNames["op_Addition"] = "+";
                specialMethodNames["op_Increment"] = "++";
                specialMethodNames["op_UnaryNegation"] = "-";
                specialMethodNames["op_Subtraction"] = "-";
                specialMethodNames["op_Decrement"] = "--";
                specialMethodNames["op_Multiply"] = "*";
                specialMethodNames["op_Division"] = "/";
                specialMethodNames["op_Modulus"] = "%";
                specialMethodNames["op_BitwiseAnd"] = "&";
                specialMethodNames["op_BitwiseOr"] = "|";
                specialMethodNames["op_ExclusiveOr"] = "^";
                specialMethodNames["op_Negation"] = "!";
                specialMethodNames["op_OnesComplement"] = "~";
                specialMethodNames["op_LeftShift"] = "<<";
                specialMethodNames["op_RightShift"] = ">>";
                specialMethodNames["op_Equality"] = "==";
                specialMethodNames["op_Inequality"] = "!=";
                specialMethodNames["op_GreaterThanOrEqual"] = ">=";
                specialMethodNames["op_LessThanOrEqual"] = "<=";
                specialMethodNames["op_GreaterThan"] = ">";
                specialMethodNames["op_LessThan"] = "<";
                specialMethodNames["op_True"] = "true";
                specialMethodNames["op_False"] = "false";
                specialMethodNames["op_Implicit"] = "implicit";
            }

            _renderOptionalSpaces = (configuration["Formatter.OptionalSpaces"] == "false") ? false : true;

            switch (configuration["NumberFormat"])
            {
                case "Hexadecimal":
                    _numberFormat = NumberFormat.Hexadecimal;
                    break;

                case "Decimal":
                    _numberFormat = NumberFormat.Decimal;
                    break;

                default:
                    _numberFormat = NumberFormat.Auto;
                    break;
            }
        }

        #endregion

        #region Интерфейсы класса

        #region ILanguageWriter Members

        public void WriteAssembly(IAssembly value)
        {
        }

        public void WriteAssemblyReference(IAssemblyReference value)
        {
        }

        public void WriteModule(IModule value)
        {
        }

        public void WriteModuleReference(IModuleReference value)
        {
        }

        public void WriteResource(IResource value)
        {
        }

        public void WriteNamespace(INamespace value)
        {
        }

        public void WriteTypeDeclaration(ITypeDeclaration value)
        {
 }

        public void WriteFieldDeclaration(IFieldDeclaration value)
        {
            formatter.Write(Helper.GetFieldName(value));
            WriteOptionalSpace();
            formatter.Write("=");
            WriteOptionalSpace();

            byte[] data = null;

            IExpression initializer = value.Initializer;
            if (initializer != null)
            {
                var literalExpression = initializer as ILiteralExpression;
                if ((literalExpression != null) && (literalExpression.Value != null) && (literalExpression.Value is byte[]))
                {
                    data = (byte[])literalExpression.Value;
                }
                else
                {
                    WriteExpression(initializer, formatter);
                }
            }
            else
            {
                formatter.Write("nil");
            }

            if (!IsEnumerationElement(value))
            {
                formatter.Write(";");
            }
        }

        public void WritePropertyDeclaration(IPropertyDeclaration value)
        {
            if ((configuration["ShowCustomAttributes"] == "true") && (value.Attributes.Count != 0))
            {
                WriteCustomAttributeList(value, formatter);
                formatter.WriteLine();
            }

            IMethodDeclaration getMethod = null;
            if (value.GetMethod != null)
            {
                getMethod = value.GetMethod.Resolve();
            }

            IMethodDeclaration setMethod = null;
            if (value.SetMethod != null)
            {
                setMethod = value.SetMethod.Resolve();
            }

            bool hasSameAttributes = true;
            if ((getMethod != null) && (setMethod != null))
            {
                hasSameAttributes &= (getMethod.Visibility == setMethod.Visibility);
                hasSameAttributes &= (getMethod.Static == setMethod.Static);
                hasSameAttributes &= (getMethod.Final == setMethod.Final);
                hasSameAttributes &= (getMethod.Virtual == setMethod.Virtual);
                hasSameAttributes &= (getMethod.Abstract == setMethod.Abstract);
                hasSameAttributes &= (getMethod.NewSlot == setMethod.NewSlot);
            }

            if (hasSameAttributes)
            {
                if (getMethod != null)
                {
                    WriteMethodAttributes(getMethod, formatter);
                }
                else if (setMethod != null)
                {
                    WriteMethodAttributes(setMethod, formatter);
                }
            }

            formatter.WriteKeyword("property");
            formatter.Write(" ");

            // Name
            string propertyName = value.Name;
            //if (propertyName == "Item")
            //	propertyName = "Item";

            WriteDeclaration(propertyName, value, formatter);

            IParameterDeclarationCollection parameters = value.Parameters;
            if (parameters.Count > 0)
            {
                formatter.Write("[");
                WriteParameterDeclarationList(parameters, formatter, configuration);
                formatter.Write("]");
            }
            formatter.Write(": ");

            // PropertyType
            WriteType(value.PropertyType, formatter);

            if (getMethod != null)
            {
                formatter.Write(" ");
                if (!hasSameAttributes)
                {
                    formatter.Write("{");
                    WriteMethodAttributes(getMethod, formatter);
                    formatter.Write("}");
                    formatter.Write(" ");
                }

                formatter.WriteKeyword("read");
                formatter.Write(" ");
                WriteMethodReference(getMethod, formatter);
            }

            if (setMethod != null)
            {
                formatter.Write(" ");
                if (!hasSameAttributes)
                {
                    formatter.Write("{");
                    WriteMethodAttributes(setMethod, formatter);
                    formatter.Write("}");
                    formatter.Write(" ");
                }

                formatter.WriteKeyword("write");
                formatter.Write(" ");
                WriteMethodReference(setMethod, formatter);
            }

            if (value.Initializer != null)
            {
                // in Delphi we do not have a property initializer. Or do we ?
                // PS
                formatter.Write("{(pseudo) := ");
                WriteExpression(value.Initializer, formatter);
                formatter.Write(" }");
            }

            formatter.Write(";");
            WriteDeclaringType(value.DeclaringType as ITypeReference, formatter);
        }

        public void WriteEventDeclaration(IEventDeclaration value)
        {
            if ((configuration["ShowCustomAttributes"] == "true") && (value.Attributes.Count != 0))
            {
                WriteCustomAttributeList(value, formatter);
                formatter.WriteLine();
            }

            ITypeDeclaration declaringType = (value.DeclaringType as ITypeReference).Resolve();
            if (!declaringType.Interface)
            {
                WriteMethodVisibility(Helper.GetVisibility(value), formatter);
            }

            if (Helper.IsStatic(value))
            {
                formatter.WriteKeyword("static");
                formatter.Write(" ");
            }

            formatter.Write("event");
            formatter.Write(" ");
            WriteType(value.EventType, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword(value.Name);
            formatter.Write(";");
            WriteDeclaringType(value.DeclaringType as ITypeReference, formatter);
        }

        #endregion

        #endregion

        #region Методы класса

        public void WriteTypeVisibility(TypeVisibility visibility, IFormatter formatter)
        {
            switch (visibility)
            {
                case TypeVisibility.Public:
                    formatter.WriteKeyword("public");
                    break;
                case TypeVisibility.NestedPublic:
                    formatter.WriteKeyword("public");
                    break;
                case TypeVisibility.Private:
                    formatter.WriteKeyword("strict private");
                    break;
                case TypeVisibility.NestedAssembly:
                    formatter.WriteKeyword("private");
                    break;
                case TypeVisibility.NestedPrivate:
                    formatter.WriteKeyword("strict private");
                    break;
                case TypeVisibility.NestedFamily:
                    formatter.WriteKeyword("strict protected");
                    break;
                case TypeVisibility.NestedFamilyAndAssembly:
                    formatter.WriteKeyword("protected");
                    break;
                case TypeVisibility.NestedFamilyOrAssembly:
                    formatter.WriteKeyword("protected");
                    formatter.Write(" ");
                    formatter.WriteComment("{internal}");
                    break;
                default:
                    throw new NotSupportedException();
            }
            formatter.Write(" ");
        }

        public void WriteFieldVisibility(FieldVisibility visibility, IFormatter formatter)
        {
            switch (visibility)
            {
                case FieldVisibility.Public:
                    formatter.WriteKeyword("public");
                    break;
                case FieldVisibility.Private:
                    formatter.WriteKeyword("strict private");
                    break;
                case FieldVisibility.PrivateScope:
                    formatter.WriteKeyword("private");
                    formatter.Write(" ");
                    formatter.WriteComment("{scope}");
                    break;
                case FieldVisibility.Family:
                    formatter.WriteKeyword("strict protected");
                    break;
                case FieldVisibility.Assembly:
                    formatter.WriteKeyword("private");
                    break;
                case FieldVisibility.FamilyOrAssembly:
                    formatter.WriteKeyword("protected");
                    break;
                case FieldVisibility.FamilyAndAssembly:
                    formatter.WriteKeyword("protected");
                    formatter.Write(" ");
                    formatter.WriteComment("{internal}");
                    break;
                default:
                    throw new NotSupportedException();
            }
            formatter.Write(" ");
        }

        public void WriteMethodVisibility(MethodVisibility visibility, IFormatter formatter)
        {
            switch (visibility)
            {
                case MethodVisibility.Public:
                    formatter.WriteKeyword("public");
                    break;
                case MethodVisibility.Private:
                    formatter.WriteKeyword("strict private");
                    break;
                case MethodVisibility.PrivateScope:
                    formatter.WriteKeyword("private");
                    formatter.Write(" ");
                    formatter.WriteComment("{scope}");
                    break;
                case MethodVisibility.Family:
                    formatter.WriteKeyword("strict protected");
                    break;
                case MethodVisibility.Assembly:
                    formatter.WriteKeyword("private");
                    break;
                case MethodVisibility.FamilyOrAssembly:
                    formatter.WriteKeyword("protected");
                    break;
                case MethodVisibility.FamilyAndAssembly:
                    formatter.WriteKeyword("protected");
                    formatter.Write(" ");
                    formatter.WriteComment("{internal}");
                    break;
                default:
                    throw new NotSupportedException();
            }
            formatter.Write(" ");
        }

        private void WriteDeclaringTypeReference(ITypeReference value, IFormatter formatter)
        {
            var owner = (value.Owner as ITypeReference);
            if (owner != null)
            {
                WriteDeclaringTypeReference(owner, formatter);
            }
            WriteType(value, formatter);
            formatter.Write(".");
        }

        private string GetDelphiStyleResolutionScope(ITypeReference reference)
        {
            string result = reference.ToString();
            while (true)
            {
                var OwnerRef = (reference.Owner as ITypeReference);
                if (OwnerRef == null)
                {
                    string namespacestr = reference.Namespace;
                    if (namespacestr.Length == 0)
                    {
                        return result;
                    }
                    else
                    {
                        return namespacestr + "." + result;
                    }
                }
                reference = OwnerRef;
                result = reference + "." + result;
            }
        }

        private void WriteType(IType type, IFormatter formatter)
        {
            var typeReference = type as ITypeReference;
            if (typeReference != null)
            {
                string description = Helper.GetTypeName(typeReference);
                WriteTypeReference(typeReference, formatter, description, typeReference);
                return;
            }

            var arrayType = type as IArrayType;
            if (arrayType != null)
            {
                WriteType(arrayType.ElementType, formatter);
                formatter.Write("[");

                IArrayDimensionCollection dimensions = arrayType.Dimensions;
                for (int i = 0; i < dimensions.Count; i++)
                {
                    if (i != 0)
                    {
                        formatter.Write(",");
                    }

                    if ((dimensions[i].LowerBound != 0) && (dimensions[i].UpperBound != -1))
                    {
                        if ((dimensions[i].LowerBound != -1) || (dimensions[i].UpperBound != -1))
                        {
                            formatter.Write((dimensions[i].LowerBound != -1) ? dimensions[i].LowerBound.ToString(CultureInfo.InvariantCulture) : ".");
                            formatter.Write("..");
                            formatter.Write((dimensions[i].UpperBound != -1) ? dimensions[i].UpperBound.ToString(CultureInfo.InvariantCulture) : ".");
                        }
                    }
                }

                formatter.Write("]");
                return;
            }

            var pointerType = type as IPointerType;
            if (pointerType != null)
            {
                WriteType(pointerType.ElementType, formatter);
                formatter.Write("*");
                return;
            }

            var referenceType = type as IReferenceType;
            if (referenceType != null)
            {
                // formatter.WriteKeyword ("var"); // already done before the param name - HV
                // formatter.Write (" ");
                WriteType(referenceType.ElementType, formatter);
                return;
            }

            var optionalModifier = type as IOptionalModifier;
            if (optionalModifier != null)
            {
                WriteType(optionalModifier.ElementType, formatter);
                formatter.Write(" ");
                formatter.WriteKeyword("modopt");
                formatter.Write("(");
                WriteType(optionalModifier.Modifier, formatter);
                formatter.Write(")");
                return;
            }

            var requiredModifier = type as IRequiredModifier;
            if (requiredModifier != null)
            {
                WriteType(requiredModifier.ElementType, formatter);
                formatter.Write(" ");
                formatter.WriteKeyword("modreq");
                formatter.Write("(");
                WriteType(requiredModifier.Modifier, formatter);
                formatter.Write(")");
                return;
            }

            var functionPointer = type as IFunctionPointer;
            if (functionPointer != null)
            {
                WriteType(functionPointer.ReturnType.Type, formatter);
                formatter.Write(" *(");
                for (int i = 0; i < functionPointer.Parameters.Count; i++)
                {
                    if (i != 0)
                    {
                        formatter.Write(", ");
                    }

                    WriteType(functionPointer.Parameters[i].ParameterType, formatter);
                }

                formatter.Write(")");
                return;
            }

            var genericParameter = type as IGenericParameter;
            if (genericParameter != null)
            {
                formatter.Write(genericParameter.Name);
                return;
            }

            var genericArgument = type as IGenericArgument;
            if (genericArgument != null)
            {
                WriteType(genericArgument.Resolve(), formatter);
                return;
            }

            throw new NotSupportedException();
        }

        private void WriteMethodAttributes(IMethodDeclaration methodDeclaration, IFormatter formatter)
        {
            ITypeDeclaration declaringType = (methodDeclaration.DeclaringType as ITypeReference).Resolve();
            if (!declaringType.Interface)
            {
                WriteMethodVisibility(methodDeclaration.Visibility, formatter);

                if (methodDeclaration.Static)
                {
                    formatter.WriteKeyword("class");
                    formatter.Write(" ");
                }
            }
        }

        private void WriteMethodDirectives(IMethodDeclaration methodDeclaration, IFormatter formatter)
        {
        }

        private void WriteParameterDeclaration(IParameterDeclaration value, IFormatter formatter, ILanguageWriterConfiguration configuration)
        {
        }

        private void WriteParameterDeclarationList(IParameterDeclarationCollection parameters, IFormatter formatter, ILanguageWriterConfiguration configuration)
        {
            for (int i = 0; i < parameters.Count; i++)
            {
                IParameterDeclaration parameter = parameters[i];
                IType parameterType = parameter.ParameterType;
                if ((parameterType != null) || ((i + 1) != parameters.Count))
                {
                    if (i != 0)
                    {
                        formatter.Write("; ");
                    }

                    WriteParameterDeclaration(parameter, formatter, configuration);
                }
            }
        }

        private void WriteCustomAttributeList(ICustomAttributeProvider provider, IFormatter formatter)
        {
        }

        private void WriteGenericArgumentList(ITypeCollection parameters, IFormatter formatter)
        {
        }

        private void WriteGenericParameterConstraint(IType value, IFormatter formatter)
        {
            var defaultConstructorConstraint = value as IDefaultConstructorConstraint;
            if (defaultConstructorConstraint != null)
            {
                formatter.WriteKeyword("new");
                formatter.Write("()");
                return;
            }

            var referenceTypeConstraint = value as IReferenceTypeConstraint;
            if (referenceTypeConstraint != null)
            {
                formatter.WriteKeyword("class");
                return;
            }

            var valueTypeConstraint = value as IValueTypeConstraint;
            if (valueTypeConstraint != null)
            {
                formatter.WriteKeyword("struct");
                return;
            }

            WriteType(value, formatter);
        }

        private void WriteGenericParameterConstraintList(IGenericArgumentProvider provider, IFormatter formatter)
        {
            ITypeCollection genericArguments = provider.GenericArguments;
            if (genericArguments.Count > 0)
            {
                for (int i = 0; i < genericArguments.Count; i++)
                {
                    var parameter = genericArguments[i] as IGenericParameter;
                    if ((parameter != null) && (parameter.Constraints.Count > 0))
                    {
                        formatter.Write(" ");
                        formatter.WriteKeyword("where");
                        formatter.Write(" ");
                        formatter.Write(parameter.Name);
                        formatter.Write(":");
                        formatter.Write(" ");

                        for (int j = 0; j < parameter.Constraints.Count; j++)
                        {
                            if (j != 0)
                            {
                                formatter.Write(", ");
                            }

                            IType constraint = parameter.Constraints[j];
                            WriteGenericParameterConstraint(constraint, formatter);
                        }
                    }
                }
            }
        }

        private void WriteDeclaringType(ITypeReference value, IFormatter formatter)
        {
            formatter.WriteProperty("Declaring Type", GetDelphiStyleResolutionScope(value));
            WriteDeclaringAssembly(Helper.GetAssemblyReference(value), formatter);
        }

        private void WriteDeclaringAssembly(IAssemblyReference value, IFormatter formatter)
        {
            if (value != null)
            {
                string text = ((value.Name != null) && (value.Version != null)) ? (value.Name + ", Version=" + value.Version) : value.ToString();
                formatter.WriteProperty("Assembly", text);
            }
        }

        private string GetTypeReferenceDescription(ITypeReference typeReference)
        {
            return Helper.GetTypeName(typeReference);
        }

        private string GetFieldReferenceDescription(IFieldReference fieldReference)
        {
            IFormatter formatter = new TextFormatter();

            WriteType(fieldReference.FieldType, formatter);
            formatter.Write(" ");
            formatter.Write(GetTypeReferenceDescription(fieldReference.DeclaringType as ITypeReference));
            formatter.Write(".");
            WriteDeclaration(fieldReference.Name, formatter);
            formatter.Write(";");

            return formatter.ToString();
        }

        private string GetMethodReferenceDescription(IMethodReference value)
        {
            IFormatter formatter = new TextFormatter();

            if (IsConstructor(value))
            {
                formatter.Write(GetTypeReferenceDescription(value.DeclaringType as ITypeReference));
                formatter.Write(".");
                formatter.Write(Helper.GetTypeName(value.DeclaringType as ITypeReference));
            }
            else
            {
                // TODO custom attributes [return: ...]
                WriteType(value.ReturnType.Type, formatter);
                formatter.Write(" ");
                formatter.Write(Helper.GetTypeName(value.DeclaringType as ITypeReference));
                formatter.Write(".");
                formatter.Write(value.Name);
            }

            WriteGenericArgumentList(value.GenericArguments, formatter);

            formatter.Write("(");

            WriteParameterDeclarationList(value.Parameters, formatter, null);

            if (value.CallingConvention == MethodCallingConvention.VariableArguments)
            {
                formatter.WriteKeyword(", __arglist");
            }

            formatter.Write(")");
            formatter.Write(";");

            return formatter.ToString();
        }

        private string GetPropertyReferenceDescription(IPropertyReference propertyReference)
        {
            IFormatter formatter = new TextFormatter();

            WriteType(propertyReference.PropertyType, formatter);
            formatter.Write(" ");

            // Name
            string propertyName = propertyReference.Name;
            if (propertyName == "Item")
            {
                propertyName = "self";
            }

            formatter.Write(GetTypeReferenceDescription(propertyReference.DeclaringType as ITypeReference));
            formatter.Write(".");
            WriteDeclaration(propertyName, formatter);

            // Parameters
            IParameterDeclarationCollection parameters = propertyReference.Parameters;
            if (parameters.Count > 0)
            {
                formatter.Write("[");
                WriteParameterDeclarationList(parameters, formatter, null);
                formatter.Write("]");
            }

            formatter.Write(" ");
            formatter.Write("{ ... }");

            return formatter.ToString();
        }

        private string GetEventReferenceDescription(IEventReference eventReference)
        {
            IFormatter formatter = new TextFormatter();

            formatter.WriteKeyword("event");
            formatter.Write(" ");
            WriteType(eventReference.EventType, formatter);
            formatter.Write(" ");
            formatter.Write(GetTypeReferenceDescription(eventReference.DeclaringType as ITypeReference));
            formatter.Write(".");
            WriteDeclaration(eventReference.Name, formatter);
            formatter.Write(";");

            return formatter.ToString();
        }

        private static bool IsType(IType value, string namespaceName, string name)
        {
            return (IsType(value, namespaceName, name, "mscorlib") || IsType(value, namespaceName, name, "sscorlib"));
        }

        private static bool IsType(IType value, string namespaceName, string name, string assemblyName)
        {
            var typeReference = value as ITypeReference;
            if (typeReference != null)
            {
                return ((typeReference.Name == name) && (typeReference.Namespace == namespaceName) && (IsAssemblyReference(typeReference, assemblyName)));
            }

            var requiredModifier = value as IRequiredModifier;
            if (requiredModifier != null)
            {
                return IsType(requiredModifier.ElementType, namespaceName, name);
            }

            var optionalModifier = value as IOptionalModifier;
            if (optionalModifier != null)
            {
                return IsType(optionalModifier.ElementType, namespaceName, name);
            }

            return false;
        }

        private static bool IsAssemblyReference(ITypeReference value, string assemblyName)
        {
            return (Helper.GetAssemblyReference(value).Name == assemblyName);
        }

        private ICustomAttribute GetCustomAttribute(ICustomAttributeProvider value, string namespaceName, string name, string assemblyName)
        {
            foreach (ICustomAttribute customAttribute in value.Attributes)
            {
                if (IsType(customAttribute.Constructor.DeclaringType, namespaceName, name, assemblyName))
                {
                    return customAttribute;
                }
            }

            return null;
        }

        private bool IsConstructor(IMethodReference value)
        {
            return ((value.Name == ".ctor") || (value.Name == ".cctor"));
        }

        private bool IsEnumerationElement(IFieldDeclaration value)
        {
            IType fieldType = value.FieldType;
            IType declaringType = value.DeclaringType;
            if (fieldType.Equals(declaringType))
            {
                var typeReference = fieldType as ITypeReference;
                if (typeReference != null)
                {
                    return Helper.IsEnumeration(typeReference);
                }
            }

            return false;
        }

        private string QuoteLiteralExpression(string text)
        {
            text = text.Replace("\"", "\"\"");

            using (var writer = new StringWriter(CultureInfo.InvariantCulture))
            {
                for (int i = 0; i < text.Length; i++)
                {
                    char character = text[i];
                    ushort value = character;
                    if (value > 0x00ff)
                    {
                        writer.Write("#$" + value.ToString("x4", CultureInfo.InvariantCulture));
                    }
                    else
                    {
                        switch (character)
                        {
                            case '\r':
                                writer.Write("#13");
                                break;
                            case '\t':
                                writer.Write("#9");
                                break;
                            case '\'':
                                writer.Write("\'\'");
                                break;
                            case '\0':
                                writer.Write("#0");
                                break;
                            case '\n':
                                writer.Write("#10");
                                break;
                            default:
                                writer.Write(character);
                                break;
                        }
                    }
                }
                return writer.ToString();
            }
        }

        private void WriteDeclaration(string name, IFormatter formatter)
        {
            formatter.WriteDeclaration((Array.IndexOf(keywords, name) != -1) ? (name) : name);
        }

        private void WriteDeclaration(string name, object target, IFormatter formatter)
        {
            formatter.WriteDeclaration((Array.IndexOf(keywords, name) != -1) ? (name) : name, target);
        }

        private void WriteReference(string name, IFormatter formatter, string toolTip, object reference)
        {
            string text = name;
            formatter.WriteReference(text, toolTip, reference);
        }

        #endregion

        #region Expression

        #region Интерфейсы класса

        public void WriteExpression(IExpression value)
        {
            WriteExpression(value, formatter);
        }

        #endregion

        #region Методы класса

        public void WriteExpression(IExpression value, IFormatter formatter)
        {
            if (value == null)
            {
                throw new ArgumentNullException("value");
            }

            if (value is ILiteralExpression)
            {
                WriteLiteralExpression(value as ILiteralExpression, formatter);
                return;
            }

            if (value is IAssignExpression)
            {
                WriteAssignExpression(value as IAssignExpression, formatter);
                return;
            }

            if (value is ITypeOfExpression)
            {
                WriteTypeOfExpression(value as ITypeOfExpression, formatter);
                return;
            }

            if (value is IFieldOfExpression)
            {
                WriteFieldOfExpression(value as IFieldOfExpression, formatter);
                return;
            }

            if (value is IMethodOfExpression)
            {
                WriteMethodOfExpression(value as IMethodOfExpression, formatter);
                return;
            }

            if (value is IMemberInitializerExpression)
            {
                WriteMemberInitializerExpression(value as IMemberInitializerExpression, formatter);
                return;
            }

            if (value is ITypeReferenceExpression)
            {
                WriteTypeReferenceExpression(value as ITypeReferenceExpression, formatter);
                return;
            }

            if (value is IFieldReferenceExpression)
            {
                WriteFieldReferenceExpression(value as IFieldReferenceExpression, formatter);
                return;
            }

            if (value is IEventReferenceExpression)
            {
                WriteEventReferenceExpression(value as IEventReferenceExpression, formatter);
                return;
            }

            if (value is IMethodReferenceExpression)
            {
                WriteMethodReferenceExpression(value as IMethodReferenceExpression, formatter);
                return;
            }

            if (value is IArgumentListExpression)
            {
                WriteArgumentListExpression(value as IArgumentListExpression, formatter);
                return;
            }

            if (value is IStackAllocateExpression)
            {
                WriteStackAllocateExpression(value as IStackAllocateExpression, formatter);
                return;
            }

            if (value is IPropertyReferenceExpression)
            {
                WritePropertyReferenceExpression(value as IPropertyReferenceExpression, formatter);
                return;
            }

            if (value is IArrayCreateExpression)
            {
                WriteArrayCreateExpression(value as IArrayCreateExpression, formatter);
                return;
            }

            if (value is IBlockExpression)
            {
                WriteBlockExpression(value as IBlockExpression, formatter);
                return;
            }

            if (value is IBaseReferenceExpression)
            {
                WriteBaseReferenceExpression(value as IBaseReferenceExpression, formatter);
                return;
            }

            if (value is IUnaryExpression)
            {
                WriteUnaryExpression(value as IUnaryExpression, formatter);
                return;
            }

            if (value is IBinaryExpression)
            {
                WriteBinaryExpression(value as IBinaryExpression, formatter);
                return;
            }

            if (value is ITryCastExpression)
            {
                WriteTryCastExpression(value as ITryCastExpression, formatter);
                return;
            }

            if (value is ICanCastExpression)
            {
                WriteCanCastExpression(value as ICanCastExpression, formatter);
                return;
            }

            if (value is ICastExpression)
            {
                WriteCastExpression(value as ICastExpression, formatter);
                return;
            }

            if (value is IConditionExpression)
            {
                WriteConditionExpression(value as IConditionExpression, formatter);
                return;
            }

            if (value is INullCoalescingExpression)
            {
                WriteNullCoalescingExpression(value as INullCoalescingExpression, formatter);
                return;
            }

            if (value is IDelegateCreateExpression)
            {
                WriteDelegateCreateExpression(value as IDelegateCreateExpression, formatter);
                return;
            }

            if (value is IAnonymousMethodExpression)
            {
                WriteAnonymousMethodExpression(value as IAnonymousMethodExpression, formatter);
                return;
            }

            if (value is IArgumentReferenceExpression)
            {
                WriteArgumentReferenceExpression(value as IArgumentReferenceExpression, formatter);
                return;
            }

            if (value is IVariableDeclarationExpression)
            {
                WriteVariableDeclarationExpression(value as IVariableDeclarationExpression, formatter);
                return;
            }

            if (value is IVariableReferenceExpression)
            {
                WriteVariableReferenceExpression(value as IVariableReferenceExpression, formatter);
                return;
            }

            if (value is IPropertyIndexerExpression)
            {
                WritePropertyIndexerExpression(value as IPropertyIndexerExpression, formatter);
                return;
            }

            if (value is IArrayIndexerExpression)
            {
                WriteArrayIndexerExpression(value as IArrayIndexerExpression, formatter);
                return;
            }

            if (value is IMethodInvokeExpression)
            {
                WriteMethodInvokeExpression(value as IMethodInvokeExpression, formatter);
                return;
            }

            if (value is IDelegateInvokeExpression)
            {
                WriteDelegateInvokeExpression(value as IDelegateInvokeExpression, formatter);
                return;
            }

            if (value is IObjectCreateExpression)
            {
                WriteObjectCreateExpression(value as IObjectCreateExpression, formatter);
                return;
            }

            if (value is IThisReferenceExpression)
            {
                WriteThisReferenceExpression(value as IThisReferenceExpression, formatter);
                return;
            }

            if (value is IAddressOfExpression)
            {
                WriteAddressOfExpression(value as IAddressOfExpression, formatter);
                return;
            }

            if (value is IAddressReferenceExpression)
            {
                WriteAddressReferenceExpression(value as IAddressReferenceExpression, formatter);
                return;
            }

            if (value is IAddressOutExpression)
            {
                WriteAddressOutExpression(value as IAddressOutExpression, formatter);
                return;
            }

            if (value is IAddressDereferenceExpression)
            {
                WriteAddressDereferenceExpression(value as IAddressDereferenceExpression, formatter);
                return;
            }

            if (value is ISizeOfExpression)
            {
                WriteSizeOfExpression(value as ISizeOfExpression, formatter);
                return;
            }

            if (value is ITypeOfTypedReferenceExpression)
            {
                WriteTypeOfTypedReferenceExpression(value as ITypeOfTypedReferenceExpression, formatter);
                return;
            }

            if (value is IValueOfTypedReferenceExpression)
            {
                WriteValueOfTypedReferenceExpression(value as IValueOfTypedReferenceExpression, formatter);
                return;
            }

            if (value is ITypedReferenceCreateExpression)
            {
                WriteTypedReferenceCreateExpression(value as ITypedReferenceCreateExpression, formatter);
                return;
            }

            if (value is IGenericDefaultExpression)
            {
                WriteGenericDefaultExpression(value as IGenericDefaultExpression, formatter);
                return;
            }

            if (value is IQueryExpression)
            {
                WriteQueryExpression(value as IQueryExpression, formatter);
                return;
            }

            if (value is ILambdaExpression)
            {
                WriteLambdaExpression(value as ILambdaExpression, formatter);
                return;
            }

            if (value is ISnippetExpression)
            {
                WriteSnippetExpression(value as ISnippetExpression, formatter);
                return;
            }

            throw new ArgumentException("Invalid expression type.", "value");
        }

        public void WriteExpressionList(IExpressionCollection expressions, IFormatter formatter)
        {
            // Indent++;
            for (int i = 0; i < expressions.Count; i++)
            {
                if (i != 0)
                {
                    formatter.Write(", ");
                }

                WriteExpression(expressions[i], formatter);
            }
            // Indent--;
        }

        private void WriteGenericDefaultExpression(IGenericDefaultExpression value, IFormatter formatter)
        {
            formatter.WriteKeyword("default");
            formatter.Write("(");
            WriteType(value.GenericArgument, formatter);
            formatter.Write(")");
        }

        private void WriteTypeOfTypedReferenceExpression(ITypeOfTypedReferenceExpression value, IFormatter formatter)
        {
            formatter.WriteKeyword("__reftype");
            formatter.Write("(");
            WriteExpression(value.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteValueOfTypedReferenceExpression(IValueOfTypedReferenceExpression value, IFormatter formatter)
        {
            formatter.WriteKeyword("__refvalue");
            formatter.Write("(");
            WriteExpression(value.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteTypedReferenceCreateExpression(ITypedReferenceCreateExpression value, IFormatter formatter)
        {
            formatter.WriteKeyword("__makeref");
            formatter.Write("(");
            WriteExpression(value.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteMemberInitializerExpression(IMemberInitializerExpression value, IFormatter formatter)
        {
            WriteMemberReference(value.Member, formatter);
            formatter.Write("=");
            WriteExpression(value.Value, formatter);
        }

        private void WriteMemberReference(IMemberReference memberReference, IFormatter formatter)
        {
            var fieldReference = memberReference as IFieldReference;
            if (fieldReference != null)
            {
                WriteFieldReference(fieldReference, formatter);
            }

            var methodReference = memberReference as IMethodReference;
            if (methodReference != null)
            {
                WriteMethodReference(methodReference, formatter);
            }

            var propertyReference = memberReference as IPropertyReference;
            if (propertyReference != null)
            {
                WritePropertyReference(propertyReference, formatter);
            }

            var eventReference = memberReference as IEventReference;
            if (eventReference != null)
            {
                WriteEventReference(eventReference, formatter);
            }
        }

        private void WriteTargetExpression(IExpression expression, IFormatter formatter)
        {
            WriteExpression(expression, formatter);
        }

        private void WriteTypeOfExpression(ITypeOfExpression expression, IFormatter formatter)
        {
            formatter.WriteKeyword("typeof");
            formatter.Write("(");
            WriteType(expression.Type, formatter);
            formatter.Write(")");
        }

        private void WriteFieldOfExpression(IFieldOfExpression value, IFormatter formatter)
        {
            formatter.WriteKeyword("fieldof");
            formatter.Write("(");
            WriteType(value.Field.DeclaringType, formatter);
            formatter.Write(".");
            formatter.WriteReference(value.Field.Name, GetFieldReferenceDescription(value.Field), value.Field);

            if (value.Type != null)
            {
                formatter.Write(", ");
                WriteType(value.Type, formatter);
            }

            formatter.Write(")");
        }

        private void WriteMethodOfExpression(IMethodOfExpression value, IFormatter formatter)
        {
            formatter.WriteKeyword("methodof");
            formatter.Write("(");

            WriteType(value.Method.DeclaringType, formatter);
            formatter.Write(".");
            formatter.WriteReference(value.Method.Name, GetMethodReferenceDescription(value.Method), value.Method);

            if (value.Type != null)
            {
                formatter.Write(", ");
                WriteType(value.Type, formatter);
            }

            formatter.Write(")");
        }

        private void WriteArrayElementType(IType type, IFormatter formatter)
        {
            var arrayType = type as IArrayType;
            if (arrayType != null)
            {
                WriteArrayElementType(arrayType.ElementType, formatter);
            }
            else
            {
                WriteType(type, formatter);
            }
        }

        private void WriteArrayCreateExpression(IArrayCreateExpression expression, IFormatter formatter)
        {
            if (expression.Initializer != null)
            {
                formatter.Write("[");
                WriteExpression(expression.Initializer, formatter);
                formatter.Write("]");
            }
            else
            {
                var type = (expression.Type as ITypeReference).Resolve();
                var value = type.ValueType ? "0" : "objNull";

                var size = expression.Dimensions[0] as ILiteralExpression;
                if (size != null && size.Value is int)
                {
                    int sz = (int) size.Value;
                    if (sz < 10)
                    {
                        formatter.Write("[");
                        for (int i = 0; i < sz; i++)
                        {
                            if (i != 0)
                            {
                                formatter.Write(",");
                                WriteOptionalSpace();
                            }
                            formatter.Write(value);
                        }
                        formatter.Write("]");
                        return;
                    }
                    var initArrayScript1 =
                        "(call {private[\"_array\", \"_i\"];_array=[]; for \"_i\" from 0 to " + sz + " do {_array set[_i," + value + "];};_array})";
                    formatter.Write(initArrayScript1);
                    return;
                }

                TextFormatter maxValue = new TextFormatter();
                WriteExpression(expression.Dimensions[0], maxValue);
                var initArrayScript = 
                    "(call {private[\"_array\", \"_i\"];_array=[];_i=0;while{_i<" + maxValue + "} do {_array set[_i,"+ value + "];_i=_i+1;};_array})";
                formatter.Write(initArrayScript);
            }
        }

        private void WriteBlockExpression(IBlockExpression expression, IFormatter formatter)
        {
            if (expression.Expressions.Count > 16)
            {
                formatter.WriteLine();
                formatter.WriteIndent();
            }

            for (int i = 0; i < expression.Expressions.Count; i++)
            {
                if (i != 0)
                {
                    formatter.Write(", ");

                    if ((i % 16) == 0)
                    {
                        formatter.WriteLine();
                    }
                }

                WriteExpression(expression.Expressions[i], formatter);
            }

            if (expression.Expressions.Count > 16)
            {
                formatter.WriteOutdent();
                formatter.WriteLine();
            }
        }

        private void WriteBaseReferenceExpression(IBaseReferenceExpression expression, IFormatter formatter)
        {
            formatter.Write("_this");
        }

        private void WriteTryCastExpression(ITryCastExpression expression, IFormatter formatter)
        {
            WriteType(expression.TargetType, formatter);
            formatter.Write("(");
            WriteExpression(expression.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteCanCastExpression(ICanCastExpression expression, IFormatter formatter)
        {
            WriteExpression(expression.Expression, formatter);
        }

        private void WriteCastExpression(ICastExpression expression, IFormatter formatter)
        {
            WriteExpression(expression.Expression, formatter);
        }

        private void WriteConditionExpression(IConditionExpression expression, IFormatter formatter)
        {
            // Delphi does not implement this, but let's output it the 'Delphi way'
            formatter.WriteKeyword("if");
            WriteOptionalSpace();
            formatter.Write("{");
            WriteOptionalSpace();
            WriteExpression(expression.Condition, formatter);
            WriteOptionalSpace();
            formatter.Write("}");
            WriteOptionalSpace();
            formatter.WriteKeyword("then");
            WriteOptionalSpace();
            formatter.Write("{");
            WriteOptionalSpace();
            WriteExpression(expression.Then, formatter);
            WriteOptionalSpace();
            formatter.Write("}");
            WriteOptionalSpace();
            formatter.WriteKeyword("else");
            WriteOptionalSpace();
            formatter.Write("{");
            WriteOptionalSpace();
            WriteExpression(expression.Else, formatter);
            WriteOptionalSpace();
            formatter.Write("}");
        }

        private void WriteNullCoalescingExpression(INullCoalescingExpression value, IFormatter formatter)
        {
            formatter.WriteComment(" {pseudo} ");
            formatter.Write("(");
            formatter.WriteKeyword("if");
            formatter.Write(" ");
            WriteExpression(value.Condition, formatter);
            formatter.WriteKeyword(" not ");
            formatter.WriteKeyword(" nil ");
            formatter.Write(" ");
            formatter.WriteKeyword("then");
            formatter.Write(" ");
            WriteExpression(value.Condition, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("else");
            formatter.Write(" ");
            WriteExpression(value.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteDelegateCreateExpression(IDelegateCreateExpression expression, IFormatter formatter)
        {
            WriteTypeReference(expression.DelegateType, formatter);
            formatter.Write(".");
            formatter.Write("Create");
            formatter.Write("(");
            WriteTargetExpression(expression.Target, formatter);
            formatter.Write(",");
            WriteMethodReference(expression.Method, formatter); // TODO Escape = true
            formatter.Write(")");
        }

        private void WriteAnonymousMethodExpression(IAnonymousMethodExpression value, IFormatter formatter)
        {
            formatter.Write("{");
            formatter.WriteIndent();

            WriteMethodDeclarationParameters(value.CapturedMethodDeclaration, true);

            WriteBlockStatement(value.Body, formatter);
            formatter.WriteOutdent();
            formatter.WriteLine();
            formatter.Write("}");
        }

        private void WriteTypeReferenceExpression(ITypeReferenceExpression expression, IFormatter formatter)
        {
            WriteTypeReference(expression.Type, formatter);
        }

        private void WriteSetFieldReferenceExpression(IFieldReferenceExpression expression, IExpression value, IFormatter formatter)
        {
            if (!expression.Field.Resolve().Static)
            {
                WriteTargetExpression(expression.Target, formatter);
                formatter.Write(" setVariable [\"");
                WriteFieldReference(expression.Field, formatter);
                formatter.Write("\",");
                WriteOptionalSpace();
                WriteSetExpression(value, formatter);
                formatter.Write("]");
            }
            else
            {
                formatter.Write(Helper.GetFieldName(expression.Field));
                WriteOptionalSpace();
                formatter.Write("=");
                WriteOptionalSpace();
                WriteSetExpression(value, formatter);
            }
        }

        private void WriteFieldReferenceExpression(IFieldReferenceExpression expression, IFormatter formatter)
        {
            if (VisitorFactory.BaseVisitor.WriteFieldReferenceExpression(expression, this, formatter))
                return;

            if (!expression.Field.Resolve().Static)
            {
                formatter.Write("(");
                WriteTargetExpression(expression.Target, formatter);
                formatter.Write(" getVariable \"");
                WriteFieldReference(expression.Field, formatter);
                formatter.Write("\"");
                formatter.Write(")");
                return;
            }
            else if (Helper.IsEnumeration((ITypeReference)expression.Field.DeclaringType))
            {
                var inlineAttribute = Helper.GetInlineAttribute(expression.Field.Resolve().Attributes);
                if (inlineAttribute != null)
                {
                    var value = (string)((ILiteralExpression)inlineAttribute.Arguments[0]).Value;
                    formatter.Write(value);
                    return;
                }
            }

            formatter.Write(Helper.GetFieldName(expression.Field));    
        }

        private void WriteArgumentReferenceExpression(IArgumentReferenceExpression expression, IFormatter formatter)
        {
            // TODO Escape name?
            // TODO Should there be a Resovle() mechanism

            var textFormatter = new TextFormatter();
            WriteParameterDeclaration(expression.Parameter.Resolve(), textFormatter, null);
            textFormatter.Write("; // Parameter");
            if (expression.Parameter.Name != null)
            {
                WriteReference(expression.Parameter.Name, formatter, textFormatter.ToString(), null);
            }
        }

        private void WriteArgumentListExpression(IArgumentListExpression expression, IFormatter formatter)
        {
            formatter.WriteKeyword("__arglist");
        }

        private void WriteVariableReferenceExpression(IVariableReferenceExpression expression, IFormatter formatter)
        {
            WriteVariableReference(expression.Variable, formatter);
        }

        private void WriteVariableReference(IVariableReference value, IFormatter formatter)
        {
            IVariableDeclaration variableDeclaration = value.Resolve();

            var textFormatter = new TextFormatter();
            WriteVariableDeclaration(variableDeclaration, textFormatter);
            textFormatter.Write(" // Local Variable");

            if (!variableDeclaration.Name.StartsWith("_"))
                variableDeclaration.Name = "_" + variableDeclaration.Name;

            formatter.WriteReference(variableDeclaration.Name, textFormatter.ToString(), null);
        }

        private void WritePropertyIndexerExpression(IPropertyIndexerExpression expression, IFormatter formatter)
        {
            WriteTargetExpression(expression.Target, formatter);
            formatter.Write("[");

            bool first = true;

            foreach (IExpression index in expression.Indices)
            {
                if (first)
                {
                    first = false;
                }
                else
                {
                    formatter.Write(", ");
                }

                WriteExpression(index, formatter);
            }

            formatter.Write("]");
        }

        private void WriteSetArrayIndexerExpression(IArrayIndexerExpression expression, IExpression expressionValue, IFormatter formatter)
        {
            for (int i = 0; i < expression.Indices.Count - 1; i++)
                formatter.Write("(");

            WriteTargetExpression(expression.Target, formatter);

            for (int i = 0; i < expression.Indices.Count - 1; i++)
            {
                if (i != 0)
                {
                    formatter.Write(")");
                    WriteOptionalSpace();
                }

                formatter.Write(" select ");
                WriteExpression(expression.Indices[i], formatter);
            }
            formatter.Write(" set [");
            WriteExpression(expression.Indices.Cast<IExpression>().Last(), formatter);
            formatter.Write(",");
            WriteOptionalSpace();
            WriteSetExpression(expressionValue, formatter);
            formatter.Write("]");
        }

        private void WriteArrayIndexerExpression(IArrayIndexerExpression expression, IFormatter formatter)
        {   //
            // ((array select 0) select 0) select 0

            formatter.Write("(");
            for (int i = 0; i < expression.Indices.Count - 1; i++)
                formatter.Write("(");

            WriteTargetExpression(expression.Target, formatter);

            for (int i = 0; i < expression.Indices.Count; i++)
            {
                if (i != 0)
                {
                    formatter.Write(")");
                    WriteOptionalSpace();
                }

                formatter.Write(" select ");
                WriteExpression(expression.Indices[i], formatter);
            }
            formatter.Write(")");
        }



        private void WriteMethodReferenceExpression(IMethodReferenceExpression expression, IFormatter formatter)
        {
            formatter.Write("call ");
            WriteMethodReference(expression.Method, formatter);
        }

        private void WriteEventReferenceExpression(IEventReferenceExpression expression, IFormatter formatter)
        {
            // TODO bool escape = true;
            if (expression.Target != null)
            {
                // TODO escape = false;
                WriteTargetExpression(expression.Target, formatter);
                if (!(expression.Target is IBaseReferenceExpression)) // no dot for "inherited"
                {
                    formatter.Write(".");
                }
            }
            WriteEventReference(expression.Event, formatter);
        }

        private void WriteDelegateInvokeExpression(IDelegateInvokeExpression expression, IFormatter formatter)
        {
            if (expression.Target != null)
            {
                WriteTargetExpression(expression.Target, formatter);
            }

            formatter.Write("(");
            WriteExpressionList(expression.Arguments, formatter);
            formatter.Write(")");
        }



        private void WriteThisReferenceExpression(IThisReferenceExpression expression, IFormatter formatter)
        {
            formatter.WriteKeyword("_this");
        }

        private void WriteAddressOfExpression(IAddressOfExpression expression, IFormatter formatter)
        {
            formatter.Write("@(");
            WriteExpression(expression.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteAddressReferenceExpression(IAddressReferenceExpression expression, IFormatter formatter)
        {
            formatter.Write("@(");
            WriteExpression(expression.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteAddressOutExpression(IAddressOutExpression expression, IFormatter formatter)
        {
            formatter.Write("@(");
            WriteExpression(expression.Expression, formatter);
            formatter.Write(")");
        }

        private void WriteAddressDereferenceExpression(IAddressDereferenceExpression expression, IFormatter formatter)
        {
            var addressOf = expression.Expression as IAddressOfExpression;
            if (addressOf != null)
            {
                WriteExpression(addressOf.Expression, formatter);
            }
            else
            {
                // formatter.Write("*(");
                WriteExpression(expression.Expression, formatter);
                // formatter.Write(")");
            }
        }

        private void WriteSizeOfExpression(ISizeOfExpression expression, IFormatter formatter)
        {
            formatter.WriteKeyword("sizeof");
            formatter.Write("(");
            WriteType(expression.Type, formatter);
            formatter.Write(")");
        }

        private void WriteStackAllocateExpression(IStackAllocateExpression expression, IFormatter formatter)
        {
            formatter.WriteKeyword("stackalloc");
            formatter.Write(" ");
            WriteType(expression.Type, formatter);
            formatter.Write("[");
            WriteExpression(expression.Expression, formatter);
            formatter.Write("]");
        }

        private void WriteLambdaExpression(ILambdaExpression value, IFormatter formatter)
        {
            if (value.Parameters.Count > 1)
            {
                formatter.Write("(");
            }

            for (int i = 0; i < value.Parameters.Count; i++)
            {
                if (i != 0)
                {
                    formatter.Write(", ");
                }

                // this.WriteVariableIdentifier(value.Parameters[i].Variable.Identifier, formatter);
                WriteDeclaration(value.Parameters[i].Name, formatter);
            }

            if (value.Parameters.Count > 1)
            {
                formatter.Write(")");
            }

            formatter.Write(" ");

            formatter.Write("=>");

            formatter.Write(" ");

            WriteExpression(value.Body, formatter);
        }

        private void WriteQueryExpression(IQueryExpression value, IFormatter formatter)
        {
            formatter.Write("(");

            WriteFromClause(value.From, formatter);

            if ((value.Body.Clauses.Count > 0) || (value.Body.Continuation != null))
            {
                formatter.WriteLine();
                formatter.WriteIndent();
            }
            else
            {
                formatter.Write(" ");
            }

            WriteQueryBody(value.Body, formatter);

            formatter.Write(")");

            if ((value.Body.Clauses.Count > 0) || (value.Body.Continuation != null))
            {
                formatter.WriteOutdent();
            }
        }

        private void WriteQueryBody(IQueryBody value, IFormatter formatter)
        {
            // from | where | let | join | orderby
            for (int i = 0; i < value.Clauses.Count; i++)
            {
                WriteQueryClause(value.Clauses[i], formatter);
                formatter.WriteLine();
            }

            // select | group
            WriteQueryOperation(value.Operation, formatter);

            // into
            if (value.Continuation != null)
            {
                formatter.Write(" ");
                WriteQueryContinuation(value.Continuation, formatter);
            }
        }

        private void WriteQueryContinuation(IQueryContinuation value, IFormatter formatter)
        {
            formatter.WriteKeyword("into");
            formatter.Write(" ");
            WriteDeclaration(value.Variable.Name, formatter);
            formatter.WriteLine();
            WriteQueryBody(value.Body, formatter);
        }

        private void WriteQueryClause(IQueryClause value, IFormatter formatter)
        {
            if (value is IWhereClause)
            {
                WriteWhereClause(value as IWhereClause, formatter);
                return;
            }

            if (value is ILetClause)
            {
                WriteLetClause(value as ILetClause, formatter);
                return;
            }

            if (value is IFromClause)
            {
                WriteFromClause(value as IFromClause, formatter);
                return;
            }

            if (value is IJoinClause)
            {
                WriteJoinClause(value as IJoinClause, formatter);
                return;
            }

            if (value is IOrderClause)
            {
                WriteOrderClause(value as IOrderClause, formatter);
                return;
            }

            throw new NotSupportedException();
        }

        private void WriteQueryOperation(IQueryOperation value, IFormatter formatter)
        {
            if (value is ISelectOperation)
            {
                WriteSelectOperation(value as ISelectOperation, formatter);
                return;
            }

            if (value is IGroupOperation)
            {
                WriteGroupOperation(value as IGroupOperation, formatter);
                return;
            }

            throw new NotSupportedException();
        }

        private void WriteFromClause(IFromClause value, IFormatter formatter)
        {
            formatter.WriteKeyword("from");
            formatter.Write(" ");
            WriteDeclaration(value.Variable.Name, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("in");
            formatter.Write(" ");
            WriteExpression(value.Expression, formatter);
        }

        private void WriteWhereClause(IWhereClause value, IFormatter formatter)
        {
            formatter.WriteKeyword("where");
            formatter.Write(" ");
            WriteExpression(value.Expression, formatter);
        }

        private void WriteLetClause(ILetClause value, IFormatter formatter)
        {
            formatter.WriteKeyword("let");
            formatter.Write(" ");
            WriteDeclaration(value.Variable.Name, formatter);
            formatter.Write(" = ");
            WriteExpression(value.Expression, formatter);
        }

        private void WriteJoinClause(IJoinClause value, IFormatter formatter)
        {
            formatter.WriteKeyword("join");
            formatter.Write(" ");
            WriteDeclaration(value.Variable.Name, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("in");
            formatter.Write(" ");
            WriteExpression(value.In, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("on");
            formatter.Write(" ");
            WriteExpression(value.On, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("equals");
            formatter.Write(" ");
            WriteExpression(value.Equality, formatter);

            if (value.Into != null)
            {
                formatter.Write(" ");
                formatter.WriteKeyword("into");
                formatter.Write(" ");
                WriteDeclaration(value.Into.Name, formatter);
            }
        }

        private void WriteOrderClause(IOrderClause value, IFormatter formatter)
        {
            formatter.WriteKeyword("orderby");
            formatter.Write(" ");
            WriteExpression(value.Expression, formatter);

            if (value.Direction == OrderDirection.Descending)
            {
                formatter.Write(" ");
                formatter.WriteKeyword("descending");
            }
        }

        private void WriteSelectOperation(ISelectOperation value, IFormatter formatter)
        {
            formatter.WriteKeyword("select");
            formatter.Write(" ");
            WriteExpression(value.Expression, formatter);
        }

        private void WriteGroupOperation(IGroupOperation value, IFormatter formatter)
        {
            formatter.WriteKeyword("group");
            formatter.Write(" ");
            WriteExpression(value.Item, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("by");
            formatter.Write(" ");
            WriteExpression(value.Key, formatter);
        }

        private void WriteSnippetExpression(ISnippetExpression expression, IFormatter formatter)
        {
            formatter.WriteComment(expression.Value);
        }

        private void WriteUnaryExpression(IUnaryExpression expression, IFormatter formatter)
        {
            switch (expression.Operator)
            {
                case UnaryOperator.BitwiseNot:
                    formatter.WriteKeyword("not");
                    formatter.Write(" ");
                    WriteExpression(expression.Expression, formatter);
                    break;

                case UnaryOperator.BooleanNot:
                    formatter.WriteKeyword("not");
                    formatter.Write(" ");
                    WriteExpression(expression.Expression, formatter);
                    break;

                case UnaryOperator.Negate:
                    formatter.Write("-");
                    WriteExpression(expression.Expression, formatter);
                    break;

                case UnaryOperator.PreIncrement:
                    formatter.Write("++");
                    WriteExpression(expression.Expression, formatter);
                    break;

                case UnaryOperator.PreDecrement:
                    formatter.Write("--");
                    WriteExpression(expression.Expression, formatter);
                    break;

                case UnaryOperator.PostIncrement:
                    WriteExpression(expression.Expression, formatter);
                    formatter.Write("++");
                    break;

                case UnaryOperator.PostDecrement:
                    WriteExpression(expression.Expression, formatter);
                    formatter.Write("--");
                    break;

                default:
                    throw new NotSupportedException(expression.Operator.ToString());
            }
        }

        private void WriteBinaryExpression(IBinaryExpression expression, IFormatter formatter)
        {
            formatter.Write("(");
            WriteExpression(expression.Left, formatter);
            WriteOptionalSpace();
            WriteBinaryOperator(expression.Operator, formatter);
            WriteOptionalSpace();
            WriteExpression(expression.Right, formatter);
            formatter.Write(")");
        }

        private void WriteBinaryOperator(BinaryOperator operatorType, IFormatter formatter)
        {
            switch (operatorType)
            {
                case BinaryOperator.Add:
                    formatter.Write("+");
                    break;

                case BinaryOperator.Subtract:
                    formatter.Write("-");
                    break;

                case BinaryOperator.Multiply:
                    formatter.Write("*");
                    break;

                case BinaryOperator.Divide:
                    formatter.WriteKeyword("/");
                    break;

                case BinaryOperator.Modulus:
                    formatter.WriteKeyword("mod");
                    break;

                case BinaryOperator.ShiftLeft:
                    formatter.WriteKeyword("shl");
                    break;

                case BinaryOperator.ShiftRight:
                    formatter.WriteKeyword("shr");
                    break;

                case BinaryOperator.ValueInequality:
                case BinaryOperator.IdentityInequality:
                    formatter.Write("!=");
                    break;

                case BinaryOperator.ValueEquality:
                case BinaryOperator.IdentityEquality:
                    formatter.Write("==");
                    break;

                case BinaryOperator.BitwiseOr:
                    formatter.WriteKeyword("|");
                    break;

                case BinaryOperator.BitwiseAnd:
                    formatter.WriteKeyword("&");
                    break;

                case BinaryOperator.BitwiseExclusiveOr:
                    formatter.WriteKeyword("^");
                    break;

                case BinaryOperator.BooleanOr:
                    formatter.WriteKeyword("||");
                    break;

                case BinaryOperator.BooleanAnd:
                    formatter.WriteKeyword("&&");
                    break;

                case BinaryOperator.LessThan:
                    formatter.Write("<");
                    break;

                case BinaryOperator.LessThanOrEqual:
                    formatter.Write("<=");
                    break;

                case BinaryOperator.GreaterThan:
                    formatter.Write(">");
                    break;

                case BinaryOperator.GreaterThanOrEqual:
                    formatter.Write(">=");
                    break;

                default:
                    throw new NotSupportedException(operatorType.ToString());
            }
        }

        private void WriteLiteralExpression(ILiteralExpression value, IFormatter formatter)
        {
            if (value.Value == null)
            {
                formatter.WriteLiteral("objNull");
            }
            else if (value.Value is char)
            {
                var text = new string(new[] { (char)value.Value });
                text = QuoteLiteralExpression(text);
                formatter.WriteLiteral("\"" + text + "\"");
            }
            else if (value.Value is string)
            {
                var text = (string)value.Value;
                text = QuoteLiteralExpression(text);
                formatter.WriteLiteral("\"" + text + "\"");
            }
            else if (value.Value is byte)
            {
                WriteNumber((byte)value.Value, formatter);
            }
            else if (value.Value is sbyte)
            {
                WriteNumber((sbyte)value.Value, formatter);
            }
            else if (value.Value is short)
            {
                WriteNumber((short)value.Value, formatter);
            }
            else if (value.Value is ushort)
            {
                WriteNumber((ushort)value.Value, formatter);
            }
            else if (value.Value is int)
            {
                WriteNumber((int)value.Value, formatter);
            }
            else if (value.Value is uint)
            {
                WriteNumber((uint)value.Value, formatter);
            }
            else if (value.Value is long)
            {
                WriteNumber((long)value.Value, formatter);
            }
            else if (value.Value is ulong)
            {
                WriteNumber((ulong)value.Value, formatter);
            }
            else if (value.Value is float)
            {
                // TODO
                formatter.WriteLiteral(((float)value.Value).ToString(CultureInfo.InvariantCulture));
            }
            else if (value.Value is double)
            {
                // TODO
                formatter.WriteLiteral(((double)value.Value).ToString("R", CultureInfo.InvariantCulture));
            }
            else if (value.Value is decimal)
            {
                formatter.WriteLiteral(((decimal)value.Value).ToString(CultureInfo.InvariantCulture));
            }
            else if (value.Value is bool)
            {
                formatter.WriteLiteral(((bool)value.Value) ? "true" : "false");
            }
                /*
        else if (expression.Value is byte[])
        {
            formatter.WriteComment("{ ");

            byte[] bytes = (byte[])expression.Value;
            for (int i = 0; i < bytes.Length; i++)
            {
                if (i != 0)
                {
                    formatter.Write(", ");
                }

                formatter.WriteComment("0x" + bytes[i].ToString("X2", CultureInfo.InvariantCulture));
            }

            formatter.WriteComment(" }");
        }
        */
            else
            {
                throw new ArgumentException("expression");
            }
        }

        private void WriteNumber(IConvertible value, IFormatter formatter)
        {
            var formattable = (IFormattable)value;

            switch (GetNumberFormat(value))
            {
                case NumberFormat.Decimal:
                    formatter.WriteLiteral(formattable.ToString(null, CultureInfo.InvariantCulture));
                    break;

                case NumberFormat.Hexadecimal:
                    formatter.WriteLiteral("$" + formattable.ToString("x", CultureInfo.InvariantCulture));
                    break;
            }
        }

        private NumberFormat GetNumberFormat(IConvertible value)
        {
            NumberFormat format = _numberFormat;
            if (format == NumberFormat.Auto)
            {
                long number = (value is ulong) ? (long)(ulong)value : value.ToInt64(CultureInfo.InvariantCulture);

                if (number < 16)
                {
                    return NumberFormat.Decimal;
                }

                if (((number % 10) == 0) && (number < 1000))
                {
                    return NumberFormat.Decimal;
                }

                return NumberFormat.Hexadecimal;
            }

            return format;
        }

        private void WriteTypeReference(ITypeReference typeReference, IFormatter formatter)
        {
            WriteType(typeReference, formatter);
        }

        private void WriteTypeReference(ITypeReference typeReference, IFormatter formatter, string description, object target)
        {
            formatter.Write(Helper.GetTypeName(typeReference));
        }

        private void WriteFieldReference(IFieldReference fieldReference, IFormatter formatter)
        {
            // TODO Escape?
            WriteReference(fieldReference.Name, formatter, GetFieldReferenceDescription(fieldReference), fieldReference);
        }

        private void WriteMethodReference(IMethodReference methodReference, IFormatter formatter)
        {
            formatter.Write(Helper.GetMethodName(methodReference));
        }

        private void WritePropertyReference(IPropertyReference propertyReference, IFormatter formatter)
        {
            // TODO Escape?
            WriteReference(propertyReference.Name, formatter, GetPropertyReferenceDescription(propertyReference), propertyReference);
        }

        private void WriteEventReference(IEventReference eventReference, IFormatter formatter)
        {
            // TODO Escape?
            WriteReference(eventReference.Name, formatter, GetEventReferenceDescription(eventReference), eventReference);
        }

        #endregion

        #endregion

        #region Statement

        #region Интерфейсы класса

        public void WriteStatement(IStatement value)
        {
            WriteStatement(value, formatter);
        }

        #endregion

        #region Методы класса

        private void WriteStatement(IStatement value, IFormatter formatter)
        {
            WriteStatement(value, formatter, false);
        }

        private void WriteStatement(IStatement value, IFormatter formatter, bool lastStatement)
        {
            if (value == null)
            {
                throw new ArgumentNullException("value");
            }

            if (value is IBlockStatement)
            {
                WriteBlockStatement(value as IBlockStatement, formatter);
                return;
            }

            if (value is IExpressionStatement)
            {
                WriteExpressionStatement(value as IExpressionStatement, formatter);
                return;
            }

            if (value is IGotoStatement)
            {
                WriteGotoStatement(value as IGotoStatement, formatter);
                return;
            }

            if (value is ILabeledStatement)
            {
                WriteLabeledStatement(value as ILabeledStatement, formatter);
                return;
            }

            if (value is IConditionStatement)
            {
                WriteConditionStatement(value as IConditionStatement, formatter);
                return;
            }

            if (value is IMethodReturnStatement)
            {
                WriteMethodReturnStatement(value as IMethodReturnStatement, formatter, lastStatement);
                return;
            }

            if (value is IForStatement)
            {
                WriteForStatement(value as IForStatement, formatter);
                return;
            }

            if (value is IForEachStatement)
            {
                WriteForEachStatement(value as IForEachStatement, formatter);
                return;
            }

            if (value is IUsingStatement)
            {
                WriteUsingStatement(value as IUsingStatement, formatter);
                return;
            }

            if (value is IFixedStatement)
            {
                WriteFixedStatement(value as IFixedStatement, formatter);
                return;
            }

            if (value is IWhileStatement)
            {
                WriteWhileStatement(value as IWhileStatement, formatter);
                return;
            }

            if (value is IDoStatement)
            {
                WriteDoStatement(value as IDoStatement, formatter);
                return;
            }

            if (value is ITryCatchFinallyStatement)
            {
                WriteTryCatchFinallyStatement(value as ITryCatchFinallyStatement, formatter);
                return;
            }

            if (value is IThrowExceptionStatement)
            {
                WriteThrowExceptionStatement(value as IThrowExceptionStatement, formatter);
                return;
            }

            if (value is IAttachEventStatement)
            {
                WriteAttachEventStatement(value as IAttachEventStatement, formatter);
                return;
            }

            if (value is IRemoveEventStatement)
            {
                WriteRemoveEventStatement(value as IRemoveEventStatement, formatter);
                return;
            }

            if (value is ISwitchStatement)
            {
                WriteSwitchStatement(value as ISwitchStatement, formatter);
                return;
            }

            if (value is IBreakStatement)
            {
                WriteBreakStatement(value as IBreakStatement, formatter);
                return;
            }

            if (value is IContinueStatement)
            {
                WriteContinueStatement(value as IContinueStatement, formatter);
                return;
            }

            if (value is IMemoryCopyStatement)
            {
                WriteMemoryCopyStatement(value as IMemoryCopyStatement, formatter);
                return;
            }

            if (value is IMemoryInitializeStatement)
            {
                WriteMemoryInitializeStatement(value as IMemoryInitializeStatement, formatter);
                return;
            }

            if (value is IDebugBreakStatement)
            {
                WriteDebugBreakStatement(value as IDebugBreakStatement, formatter);
                return;
            }

            if (value is ILockStatement)
            {
                WriteLockStatement(value as ILockStatement, formatter);
                return;
            }

            if (value is ICommentStatement)
            {
                WriteCommentStatement(value as ICommentStatement, formatter);
                return;
            }

            throw new ArgumentException("Invalid statement type.", "value");
        }

        private void WritePendingOutdent(IFormatter formatter)
        {
            if (_pendingOutdent > 0)
            {
                formatter.WriteOutdent();
                _pendingOutdent = 0;
            }
        }

        private void MakePendingOutdent()
        {
            _pendingOutdent = 1;
        }

        private void WriteStatementSeparator(IFormatter formatter)
        {
            if (_hasSeparator)
            {
                _hasSeparator = false;
            }
            else if (!forLoop)
            {
                formatter.Write(";");
                formatter.WriteLine();
            }
            WritePendingOutdent(formatter);
        }

        private void WriteBlockStatement(IBlockStatement statement, IFormatter formatter)
        {
            _blockStatementLevel++;
            if (statement.Statements.Count > 0)
            {
                WriteStatementList(statement.Statements, formatter);
            }
            _blockStatementLevel++;
        }

        private void WriteStatementList(IStatementCollection statements, IFormatter formatter)
        {
            _hasSeparator = true;
            // put Delphi Loop detection here for now
            //			DetectDelphiIterationStatement1(statements);
            //			DetectDelphiIterationStatement2(statements);
            //
            for (int i = 0; i < statements.Count; i++)
            {
                WriteStatement(statements[i], formatter, (i == statements.Count - 1));
            }
        }

        private void WriteMemoryCopyStatement(IMemoryCopyStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("memcpy");
            formatter.Write("(");
            WriteExpression(statement.Source, formatter);
            formatter.Write(", ");
            WriteExpression(statement.Destination, formatter);
            formatter.Write(", ");
            WriteExpression(statement.Length, formatter);
            formatter.Write(")");
        }

        private void WriteMemoryInitializeStatement(IMemoryInitializeStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("meminit");
            formatter.Write("(");
            WriteExpression(statement.Offset, formatter);
            formatter.Write(", ");
            WriteExpression(statement.Value, formatter);
            formatter.Write(", ");
            WriteExpression(statement.Length, formatter);
            formatter.Write(")");
        }

        private void WriteDebugBreakStatement(IDebugBreakStatement value, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("debug");
        }

        private void WriteLockStatement(ILockStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("lock");
            formatter.Write(" ");
            formatter.Write("(");
            WriteExpression(statement.Expression, formatter);
            formatter.Write(")");
            formatter.WriteLine();

            formatter.Write("{");
            formatter.WriteIndent();

            if (statement.Body != null)
            {
                WriteStatement(statement.Body, formatter);
                formatter.WriteLine();
            }

            formatter.WriteOutdent();
            formatter.WriteKeyword("}");
        }

        internal static IExpression InverseBooleanExpression(IExpression expression)
        {
            var binaryExpression = expression as IBinaryExpression;
            if (binaryExpression != null)
            {
                switch (binaryExpression.Operator)
                {
                    case BinaryOperator.GreaterThan:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.LessThanOrEqual;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.GreaterThanOrEqual:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.LessThan;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.LessThan:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.GreaterThanOrEqual;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.LessThanOrEqual:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.GreaterThan;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.IdentityEquality:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.IdentityInequality;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.IdentityInequality:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.IdentityEquality;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.ValueInequality:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.ValueEquality;
                        target.Right = binaryExpression.Right;
                        return target;
                    }
                    case BinaryOperator.ValueEquality:
                    {
                        IBinaryExpression target = new BinaryExpression();
                        target.Left = binaryExpression.Left;
                        target.Operator = BinaryOperator.ValueInequality;
                        target.Right = binaryExpression.Right;
                        return target;
                    }

                    case BinaryOperator.BooleanAnd: // De Morgan
                    {
                        IExpression left = InverseBooleanExpression(binaryExpression.Left);
                        IExpression right = InverseBooleanExpression(binaryExpression.Right);
                        if ((left != null) && (right != null))
                        {
                            IBinaryExpression target = new BinaryExpression();
                            target.Left = left;
                            target.Operator = BinaryOperator.BooleanOr;
                            target.Right = right;
                            return target;
                        }
                    }
                        break;

                    case BinaryOperator.BooleanOr: // De Morgan
                    {
                        IExpression left = InverseBooleanExpression(binaryExpression.Left);
                        IExpression right = InverseBooleanExpression(binaryExpression.Right);
                        if ((left != null) && (right != null))
                        {
                            IBinaryExpression target = new BinaryExpression();
                            target.Left = left;
                            target.Operator = BinaryOperator.BooleanAnd;
                            target.Right = right;
                            return target;
                        }
                    }
                        break;
                }
            }

            var unaryExpression = expression as IUnaryExpression;
            if (unaryExpression != null)
            {
                if (unaryExpression.Operator == UnaryOperator.BooleanNot)
                {
                    return unaryExpression.Expression;
                }
            }

            IUnaryExpression unaryOperator = new UnaryExpression();
            unaryOperator.Operator = UnaryOperator.BooleanNot;
            unaryOperator.Expression = expression;
            return unaryOperator;
        }

        //-------------------------------------------
        // this writes one line of variable declaration and sets the hasvar flag to true
        //  if it was false, put out the "var" definition line
        private void WriteVariableListEntry(IVariableDeclaration variable, IFormatter formatter, ref bool hasvar)
        {
            if (variable != null)
            {
                if (hasvar == false)
                {
                    formatter.WriteLine();
                    formatter.WriteKeyword("var");
                    formatter.WriteLine();
                    formatter.WriteIndent();
                    hasvar = true;
                }
                WriteVariableDeclaration(variable, formatter);
            }
        }

        private void WriteVariableList(IVariableDeclarationExpression expression, IFormatter formatter, ref bool hasvar)
        {
            if (expression != null)
            {
                WriteVariableListEntry(expression.Variable, formatter, ref hasvar);
            }
        }

        private void WriteVariableList(IStatement statement, IFormatter formatter, ref bool hasvar)
        {
            var blockStatement = statement as IBlockStatement;
            if (blockStatement != null)
            {
                WriteVariableList(blockStatement.Statements, formatter, ref hasvar);
                return;
            }

            var labeledStatement = statement as ILabeledStatement;
            if (labeledStatement != null)
            {
                WriteVariableList(labeledStatement.Statement, formatter, ref hasvar);
                return;
            }

            var forEachStatement = statement as IForEachStatement;
            if (forEachStatement != null)
            {
                WriteVariableListEntry(forEachStatement.Variable, formatter, ref hasvar);
                WriteVariableList(forEachStatement.Body, formatter, ref hasvar);
                return;
            }

            var conditionStatement = statement as IConditionStatement;
            if (conditionStatement != null)
            {
                WriteVariableList(conditionStatement.Then, formatter, ref hasvar);
                WriteVariableList(conditionStatement.Else, formatter, ref hasvar);
                return;
            }

            var forStatement = statement as IForStatement;
            if (forStatement != null)
            {
                WriteVariableList(forStatement.Initializer, formatter, ref hasvar);
                WriteVariableList(forStatement.Body, formatter, ref hasvar);
                return;
            }

            var switchStatement = statement as ISwitchStatement;
            if (switchStatement != null)
            {
                foreach (ISwitchCase switchCase in switchStatement.Cases)
                {
                    WriteVariableList(switchCase.Body, formatter, ref hasvar);
                }
                return;
            }

            var doStatement = statement as IDoStatement;
            if (doStatement != null)
            {
                WriteVariableList(doStatement.Body, formatter, ref hasvar);
                return;
            }

            var lockStatement = statement as ILockStatement;
            if (lockStatement != null)
            {
                WriteVariableList(lockStatement.Body, formatter, ref hasvar);
                return;
            }

            var whileStatement = statement as IWhileStatement;
            if (whileStatement != null)
            {
                WriteVariableList(whileStatement.Body, formatter, ref hasvar);
                return;
            }

            var fixedStatement = statement as IFixedStatement;
            if (fixedStatement != null)
            {
                WriteVariableListEntry(fixedStatement.Variable, formatter, ref hasvar);
                WriteVariableList(fixedStatement.Body, formatter, ref hasvar);
                return;
            }

            var usingStatement = statement as IUsingStatement;
            if (usingStatement != null)
            {
                var assignExpression = usingStatement.Expression as IAssignExpression;
                if (assignExpression != null)
                {
                    var variableDeclarationExpression = assignExpression.Target as IVariableDeclarationExpression;
                    if (variableDeclarationExpression != null)
                    {
                        WriteVariableListEntry(variableDeclarationExpression.Variable, formatter, ref hasvar);
                    }
                }

                return;
            }

            var tryCatchFinallyStatement = statement as ITryCatchFinallyStatement;
            if (tryCatchFinallyStatement != null)
            {
                WriteVariableList(tryCatchFinallyStatement.Try, formatter, ref hasvar);
                foreach (ICatchClause catchClause in tryCatchFinallyStatement.CatchClauses)
                {
                    WriteVariableList(catchClause.Body, formatter, ref hasvar);
                }
                WriteVariableList(tryCatchFinallyStatement.Fault, formatter, ref hasvar);
                WriteVariableList(tryCatchFinallyStatement.Finally, formatter, ref hasvar);
                return;
            }

            var expressionStatement = statement as IExpressionStatement;
            if (expressionStatement != null)
            {
                WriteVariableList(expressionStatement.Expression as IVariableDeclarationExpression, formatter, ref hasvar);
                return;
            }
        }

        // write a list of variable definitions by recursing through the statements and define
        //  the corresponding variable names
        private void WriteVariableList(IStatementCollection statements, IFormatter formatter, ref bool hasvar)
        {
            foreach (IStatement statement in statements)
            {
                WriteVariableList(statement, formatter, ref hasvar);
            }
        }

        private void WriteCommentStatement(ICommentStatement statement, IFormatter formatter)
        {
            WriteComment(statement.Comment, formatter);
        }

        private void WriteComment(IComment comment, IFormatter formatter)
        {
            string[] parts = comment.Text.Split(new[] { '\n' });
            if (parts.Length <= 1)
            {
                foreach (string part in parts)
                {
                    formatter.WriteComment("// ");
                    formatter.WriteComment(part);
                    formatter.WriteLine();
                }
            }
            else
            {
                formatter.WriteComment("{ ");
                formatter.WriteLine();

                foreach (string part in parts)
                {
                    formatter.WriteComment(part);
                    formatter.WriteLine();
                }

                formatter.WriteComment("}");
                formatter.WriteLine();
            }
        }

        private void WriteMethodReturnStatement(IMethodReturnStatement statement, IFormatter formatter, bool lastStatement)
        {
            WriteStatementSeparator(formatter);
            if (statement.Expression == null)
            {
            }
            else
            {
                WriteExpression(statement.Expression, formatter);
            }
        }

        private void WriteConditionStatement(IConditionStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("if");
            WriteOptionalSpace();
            formatter.Write("{");
            if (statement.Condition is IBinaryExpression)
            {
                WriteExpression(statement.Condition, formatter);
            }
            else
            {
                formatter.Write("(");
                WriteExpression(statement.Condition, formatter);
                formatter.Write(")");
            }

            formatter.Write("}");
            WriteOptionalSpace();
            formatter.WriteKeyword("then");
            WriteOptionalSpace();
            formatter.Write("{");

            if (statement.Then.Statements.Count > 1)
            {
                formatter.WriteLine();
                formatter.WriteIndent();
            }

            if (statement.Then != null)
            {
                WriteStatement(statement.Then, formatter);
            }

            if (statement.Then.Statements.Count > 1)
            {
                formatter.WriteLine();
                formatter.WriteOutdent();
            }
            WriteOptionalSpace();
            formatter.Write("}");

            if ((statement.Else != null) && (statement.Else.Statements.Count > 0))
            {
                WriteOptionalSpace();
                formatter.WriteKeyword("else");
                WriteOptionalSpace();
                formatter.Write("{");

                if (statement.Else.Statements.Count > 1)
                {
                    formatter.WriteLine();
                    formatter.WriteIndent();
                }

                WriteStatement(statement.Else, formatter);

                if (statement.Else.Statements.Count > 1)
                {
                    formatter.WriteLine();
                    formatter.WriteOutdent();
                }
                WriteOptionalSpace();
                formatter.WriteKeyword("}");
            }
        }

        private void WriteTryCatchFinallyStatement(ITryCatchFinallyStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            if ((statement.Finally != null) && (statement.Finally.Statements.Count > 0) && (statement.CatchClauses.Count > 0))
            {
                formatter.WriteKeyword("try");
                formatter.WriteLine();
                formatter.WriteIndent();
            }
            if ((statement.Finally != null) && (statement.Finally.Statements.Count > 0) || (statement.CatchClauses.Count > 0))
            {
                formatter.WriteKeyword("try");
                WriteOptionalSpace();
                formatter.Write("{");
                formatter.WriteLine();
                formatter.WriteIndent();
            }
            if (statement.Try != null)
            {
                WriteStatement(statement.Try, formatter);
            }
            WritePendingOutdent(formatter);
            formatter.WriteLine();
            formatter.WriteOutdent();
            formatter.Write("}");
            WriteOptionalSpace();

            if (statement.CatchClauses.Count > 0)
            {
                foreach (ICatchClause catchClause in statement.CatchClauses)
                {
                    formatter.WriteKeyword("catch");
                    WriteOptionalSpace();
                    formatter.Write("{");
                    formatter.WriteLine();
                    formatter.WriteIndent(); 
                    
                    catchClause.Variable.Name = "_exception";
                    if (catchClause.Body != null)
                    {
                        WriteStatement(catchClause.Body, formatter);
                    }

                    WritePendingOutdent(formatter);
                    formatter.WriteLine();
                    formatter.WriteOutdent();
                    formatter.Write("};");
                }
            }
        }

        private void WriteAssignExpression(IAssignExpression value, IFormatter formatter)
        {
            var binaryExpression = value.Expression as IBinaryExpression;
            if (binaryExpression != null)
            {
                if (value.Target.Equals(binaryExpression.Left))
                {
                    string operatorText = string.Empty;
                    switch (binaryExpression.Operator)
                    {
                        case BinaryOperator.Add:
                            operatorText = "inc";
                            break;

                        case BinaryOperator.Subtract:
                            operatorText = "dec";
                            break;
                    }

                    if (operatorText.Length != 0)
                    {
                        // Op(a,b)
                        formatter.Write(operatorText);
                        formatter.Write("(");
                        WriteExpression(value.Target, formatter);
                        formatter.Write(",");
                        formatter.Write(" ");
                        WriteExpression(binaryExpression.Right, formatter);
                        formatter.Write(")");

                        return;
                    }
                }
            }

            // x := y + z

            //formatter.Write("[array]");

            if (value.Target is IArrayIndexerExpression)
            {
                WriteSetArrayIndexerExpression((IArrayIndexerExpression)value.Target, value.Expression, formatter);
            }
            else if (value.Target is IFieldReferenceExpression)
            {
                WriteSetFieldReferenceExpression((IFieldReferenceExpression)value.Target, value.Expression, formatter);
            }
            else if (value.Target is IPropertyReferenceExpression)
            {
                WriteSetPropertyReferenceExpression(value, formatter);
            }
            else
            {
                WriteExpression(value.Target, formatter);
                WriteOptionalSpace();
                formatter.Write("=");
                WriteOptionalSpace();

                WriteSetExpression(value.Expression, formatter);
            }
        }

        private void WriteSetExpression(IExpression expression, IFormatter formatter)
        {
            if (Helper.IsLogicExpression(expression) == false)
            {
                WriteExpression(expression, formatter);
                return;
            }

            formatter.Write("if(");
            WriteExpression(expression, formatter);
            formatter.Write(")");
            WriteOptionalSpace();
            formatter.Write("then");
            WriteOptionalSpace();
            formatter.Write("{");
            WriteOptionalSpace();
            formatter.Write("true");
            WriteOptionalSpace();
            formatter.Write("}");
            WriteOptionalSpace();
            formatter.Write("else");
            WriteOptionalSpace();
            formatter.Write("{");
            WriteOptionalSpace();
            formatter.Write("false");
            WriteOptionalSpace();
            formatter.Write("}");
        }

        private void WriteSetPropertyReferenceExpression(IAssignExpression value, IFormatter formatter)
        {
            IPropertyReferenceExpression target = (IPropertyReferenceExpression)value.Target;

            var setMethod = target.Property.Resolve().SetMethod;
            if (!setMethod.Resolve().Static)
            {
                formatter.Write("[");
                WriteExpression(target.Target, formatter);
                formatter.Write(",");
                WriteOptionalSpace();
                WriteSetExpression(value.Expression, formatter);
                formatter.Write("]");
            }
            else
            {
                formatter.Write("(");
                WriteSetExpression(value.Expression, formatter);
                formatter.Write(")");
            }
            formatter.Write(" call ");
            WriteMethodReference(setMethod, formatter);
        }

        private void WriteExpressionStatement(IExpressionStatement statement, IFormatter formatter)
        {
            // in Delphi we have to filter the IExpressionStatement that is a IVariableDeclarationExpression
            // as this is defined/dumped in the method's var section by WriteVariableList
            if (!(statement.Expression is IVariableDeclarationExpression))
            {
                WriteStatementSeparator(formatter);
                var unaryExpression = statement.Expression as IUnaryExpression;
                if (unaryExpression != null &&
                    (unaryExpression.Operator == UnaryOperator.PostIncrement ||
                     unaryExpression.Operator == UnaryOperator.PostDecrement))
                {
                    WriteExpression(unaryExpression.Expression, formatter);
                    WriteOptionalSpace();
                    formatter.Write("=");
                    WriteOptionalSpace();
                    WriteExpression(unaryExpression.Expression, formatter);
                    WriteOptionalSpace();
                    formatter.Write(unaryExpression.Operator == UnaryOperator.PostIncrement ? "+" : "-");
                    WriteOptionalSpace();
                    formatter.Write("1");
                }
                else
                {
                    WriteExpression(statement.Expression, formatter);
                }
            }
        }

        private void WriteForStatement(IForStatement statement, IFormatter formatter)
        {
            bool canUseForLoop = false;

            // Check if the iteration statement is limited enough to emit a Delphi for-loop
            var initAssignmentStatement = statement.Initializer as IExpressionStatement;
            var incrementAssignmentStatement = statement.Increment as IExpressionStatement;

            IAssignExpression initAssignment = null;
            IAssignExpression incrementAssignment = null;

            if (initAssignmentStatement != null)
            {
                initAssignment = initAssignmentStatement.Expression as IAssignExpression;
            }

            if (incrementAssignmentStatement != null)
            {
                incrementAssignment = incrementAssignmentStatement.Expression as IAssignExpression;
            }

            var testOperator = statement.Condition as IBinaryExpression;
            IBinaryExpression IncrRight = null;

            if ((initAssignment != null) && (incrementAssignment != null) && (testOperator != null))
            {
                var InitLeft = initAssignment.Target as IVariableReferenceExpression;
                // ILiteralExpression InitRight = InitAssignment.Right as ILiteralExpression;
                var IncrLeft = incrementAssignment.Target as IVariableReferenceExpression;
                IncrRight = incrementAssignment.Expression as IBinaryExpression;
                var TestLeft = testOperator.Left as IVariableReferenceExpression;

                if ((InitLeft != null) && (IncrLeft != null) && (IncrRight != null) && (TestLeft != null))
                {
                    if ((InitLeft.Variable == IncrLeft.Variable) && (InitLeft.Variable == TestLeft.Variable))
                    {
                        var IncrFromVar = IncrRight.Left as IVariableReferenceExpression;
                        var IncrExp = IncrRight.Right as ILiteralExpression;
                        if ((IncrFromVar != null) && (IncrExp != null))
                        {
                            if ((InitLeft.Variable == IncrFromVar.Variable) && (IncrExp.Value.Equals(1)))
                            {
                                if ((IncrRight.Operator == BinaryOperator.Add) &&
                                    ((testOperator.Operator == BinaryOperator.LessThan) ||
                                     (testOperator.Operator == BinaryOperator.LessThanOrEqual)))
                                {
                                    canUseForLoop = true;
                                }
                                else if ((IncrRight.Operator == BinaryOperator.Subtract) &&
                                         ((testOperator.Operator == BinaryOperator.GreaterThan) ||
                                          (testOperator.Operator == BinaryOperator.GreaterThanOrEqual)))
                                {
                                    canUseForLoop = true;
                                }
                            }
                        }
                    }
                }
            }

            if (canUseForLoop)
            {
                WriteStatementSeparator(formatter);
                formatter.WriteKeyword("for ");
                _hasSeparator = true;
                WriteStatement(statement.Initializer, formatter);
                if (IncrRight.Operator == BinaryOperator.Add)
                {
                    formatter.WriteKeyword(" to ");
                }
                else
                {
                    formatter.WriteKeyword(" downto ");
                }
                WriteExpression(testOperator.Right, formatter);
                // TODO: Handle special case of literal+1 -> 1 etc.
                if (IncrRight.Operator == BinaryOperator.Add)
                {
                    if (testOperator.Operator == BinaryOperator.LessThan)
                    {
                        formatter.WriteLiteral("-1 ");
                    }
                }
                else
                {
                    if (testOperator.Operator == BinaryOperator.GreaterThan)
                    {
                        formatter.WriteLiteral("+1 ");
                    }
                }
            }
            else
            {
                // Fall back to version that emits while-loops!
                if (statement.Initializer != null)
                {
                    WriteStatement(statement.Initializer, formatter);
                    WriteStatementSeparator(formatter);
                }

                formatter.WriteKeyword("while");
                WriteOptionalSpace();
                formatter.Write("{");
                if (statement.Condition != null)
                {
                    WriteExpression(statement.Condition, formatter);
                }
                else
                {
                    formatter.WriteLiteral("true");
                }
                formatter.Write("}");
            }
            WriteOptionalSpace();
            formatter.WriteKeyword("do");
            WriteOptionalSpace();
            formatter.WriteKeyword("{");

            bool multiLine =
                (statement.Body != null && statement.Body.Statements.Count > 1) || (!canUseForLoop && statement.Increment != null);

            if (multiLine)
            {
                formatter.WriteLine();
                formatter.WriteIndent();
            }

            if (statement.Body != null)
            {
                WriteStatement(statement.Body, formatter);
            }
            if (!canUseForLoop)
            {
                if (statement.Increment != null)
                {
                    WriteStatement(statement.Increment, formatter);
                }
            }

            if (multiLine)
            {
                formatter.WriteLine();
                formatter.WriteOutdent();
            }
            formatter.WriteKeyword("}");
        }

        private void WriteForEachStatement(IForEachStatement value, IFormatter formatter)
        {
            // TODO statement.Variable declaration needs to be rendered some where

            WriteStatementSeparator(formatter);
            string store = value.Variable.Name;
            value.Variable.Name = "_x";

            formatter.Write("{");
            if (value.Body != null)
            {
                if (value.Body.Statements.Count > 1)
                {
                    formatter.WriteLine();
                    formatter.WriteIndent();
                }
                else
                {
                    WriteOptionalSpace();
                }

                WriteStatement(value.Body, formatter);

                if (value.Body.Statements.Count > 1)
                {
                    formatter.WriteLine();
                    formatter.WriteOutdent();
                }
                else
                {
                    WriteOptionalSpace();
                }
            }
            formatter.Write("}");
            WriteOptionalSpace();
            formatter.Write("forEach ");
            WriteExpression(value.Expression, formatter);

            value.Variable.Name = store;
        }

        private void WriteUsingStatement(IUsingStatement statement, IFormatter formatter)
        {
            IVariableReference variable = null;

            var assignExpression = statement.Expression as IAssignExpression;
            if (assignExpression != null)
            {
                var variableDeclarationExpression = assignExpression.Target as IVariableDeclarationExpression;
                if (variableDeclarationExpression != null)
                {
                    variable = variableDeclarationExpression.Variable;
                }

                var variableReferenceExpression = assignExpression.Target as IVariableReferenceExpression;
                if (variableReferenceExpression != null)
                {
                    variable = variableReferenceExpression.Variable;
                }
            }

            WriteStatementSeparator(formatter);
            // make a comment that Reflector detected this as a using statement
            formatter.Write("{using");

            if (variable != null)
            {
                formatter.Write(" ");
                WriteVariableReference(variable, formatter);
            }

            formatter.Write("}");
            formatter.WriteLine();

            // and replace this with
            // - create obj
            // - try ... finally obj.Dispose end

            formatter.WriteKeyword("begin");
            formatter.WriteLine();
            formatter.WriteIndent();

            if (variable != null)
            {
                WriteVariableReference(variable, formatter);
                formatter.Write(" ");
                formatter.WriteKeyword(":=");
                formatter.Write(" ");
                WriteExpression(assignExpression.Expression, formatter);
                WriteStatementSeparator(formatter);
            }

            formatter.WriteKeyword("try");
            formatter.WriteLine();
            formatter.WriteIndent();

            if (statement.Body != null)
            {
                WriteBlockStatement(statement.Body, formatter);
            }

            formatter.WriteLine();
            formatter.WriteOutdent();
            formatter.WriteKeyword("finally");
            formatter.WriteLine();
            formatter.WriteIndent();

            if (variable != null)
            {
                _hasSeparator = true;
                WriteVariableReference(variable, formatter);
                formatter.Write(".");
                formatter.Write("Dispose");
                formatter.WriteLine();
            }
            else
            {
                _hasSeparator = true;
                WriteExpression(statement.Expression);
                formatter.Write(".");
                formatter.Write("Dispose");
                formatter.WriteLine();
            }

            formatter.WriteOutdent();
            formatter.WriteKeyword("end");
            formatter.WriteLine();
            formatter.WriteOutdent();
            formatter.WriteKeyword("end");
        }

        private void WriteFixedStatement(IFixedStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("fixed");
            formatter.Write(" ");
            formatter.Write("(");
            WriteVariableDeclaration(statement.Variable, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("=");
            formatter.Write(" ");
            WriteExpression(statement.Expression, formatter);
            formatter.Write(")");

            formatter.WriteLine();
            formatter.WriteKeyword("begin");
            formatter.WriteLine();
            formatter.WriteIndent();

            if (statement.Body != null)
            {
                WriteBlockStatement(statement.Body, formatter);
            }

            formatter.WriteOutdent();
            formatter.WriteKeyword("end ");
        }

        private void WriteWhileStatement(IWhileStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("while");
            formatter.Write(" ");
            if (statement.Condition != null)
            {
                formatter.Write("(");
                WriteExpression(statement.Condition, formatter);
                formatter.Write(")");
            }
            else
            {
                formatter.WriteLiteral("true");
            }

            formatter.Write(" ");
            formatter.WriteKeyword("do");
            formatter.WriteLine();
            formatter.WriteKeyword("begin");
            formatter.WriteLine();
            formatter.WriteIndent();
            if (statement.Body != null)
            {
                WriteStatement(statement.Body, formatter);
            }
            formatter.WriteLine();
            formatter.WriteOutdent();
            formatter.WriteKeyword("end");
        }

        private void WriteDoStatement(IDoStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("repeat");
            formatter.WriteLine();
            formatter.WriteIndent();
            if (statement.Body != null)
            {
                WriteStatement(statement.Body, formatter);
            }
            formatter.WriteLine();
            formatter.WriteOutdent();
            formatter.WriteKeyword("until");
            formatter.Write(" ");

            if (statement.Condition != null)
            {
                WriteExpression(InverseBooleanExpression(statement.Condition), formatter);
            }
            else
            {
                formatter.WriteLiteral("true");
            }
        }

        private void WriteBreakStatement(IBreakStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("break");
            formatter.Write(";");
            formatter.WriteLine();
        }

        private void WriteContinueStatement(IContinueStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("continue");
            formatter.Write(";");
            formatter.WriteLine();
        }

        private void WriteThrowExceptionStatement(IThrowExceptionStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("raise");
            formatter.Write(" ");
            if (statement.Expression != null)
            {
                WriteExpression(statement.Expression, formatter);
            }
            else
            {
                WriteDeclaration("Exception", formatter);
                formatter.Write(".");
                formatter.WriteKeyword("Create");
            }
        }

        private void WriteVariableDeclarationExpression(IVariableDeclarationExpression expression, IFormatter formatter)
        {
            // this.WriteVariableDeclaration(formatter, expression.Variable); // this is for C#
            //
            // no variable declaration expression in Delphi. Convert this to a variable reference only!
            WriteVariableReference(expression.Variable, formatter);
        }

        private void WriteVariableDeclaration(IVariableDeclaration variableDeclaration, IFormatter formatter)
        {
            WriteDeclaration(variableDeclaration.Name, formatter); // TODO Escape = true
            formatter.Write(": ");
            WriteType(variableDeclaration.VariableType, formatter);

            if (variableDeclaration.Pinned)
            {
                formatter.Write(" ");
                formatter.WriteKeyword("pinned");
            }

            if (!forLoop)
            {
                formatter.Write(";");
                formatter.WriteLine();
            }
        }

        private void WriteAttachEventStatement(IAttachEventStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            WriteEventReferenceExpression(statement.Event, formatter);
            formatter.Write(" += ");
            WriteExpression(statement.Listener, formatter);
            formatter.Write(";");
            formatter.WriteLine();
        }

        private void WriteRemoveEventStatement(IRemoveEventStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            WriteEventReferenceExpression(statement.Event, formatter);
            formatter.Write(" -= ");
            WriteExpression(statement.Listener, formatter);
            formatter.Write(";");
            formatter.WriteLine();
        }

        private void WriteSwitchStatement(ISwitchStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);

            formatter.WriteKeyword("case");
            formatter.Write(" ");
            WriteExpression(statement.Expression, formatter);
            formatter.Write(" ");
            formatter.WriteKeyword("of");
            formatter.WriteLine();
            formatter.WriteIndent();
            foreach (ISwitchCase switchCase in statement.Cases)
            {
                var conditionCase = switchCase as IConditionCase;
                if (conditionCase != null)
                {
                    WriteSwitchCaseCondition(conditionCase.Condition, formatter);
                }

                var defaultCase = switchCase as IDefaultCase;
                if (defaultCase != null)
                {
                    formatter.WriteKeyword("default");
                    formatter.Write(":");
                }

                formatter.WriteIndent();
                formatter.WriteKeyword("begin");
                formatter.WriteLine();
                formatter.WriteIndent();

                if (switchCase.Body != null)
                {
                    WriteStatement(switchCase.Body, formatter);
                }

                WritePendingOutdent(formatter);
                formatter.WriteLine();
                formatter.WriteOutdent();
                formatter.WriteKeyword("end");
                formatter.Write(";");
                formatter.WriteOutdent();

                formatter.WriteLine();
            }
            formatter.WriteOutdent();
            formatter.WriteKeyword("end");
        }

        private void WriteSwitchCaseCondition(IExpression condition, IFormatter formatter)
        {
            var binaryExpression = condition as IBinaryExpression;
            if ((binaryExpression != null) && (binaryExpression.Operator == BinaryOperator.BooleanOr))
            {
                WriteSwitchCaseCondition(binaryExpression.Left, formatter);
                WriteSwitchCaseCondition(binaryExpression.Right, formatter);
            }
            else
            {
                WriteExpression(condition, formatter);
                formatter.Write(":");
                formatter.WriteLine();
            }
        }

        private void WriteGotoStatement(IGotoStatement statement, IFormatter formatter)
        {
            WriteStatementSeparator(formatter);
            formatter.WriteKeyword("goto");
            formatter.Write(" ");
            WriteDeclaration(statement.Name, formatter);
        }

        private void WriteLabeledStatement(ILabeledStatement statement, IFormatter formatter)
        {
            if (statement.Statement != null)
            {
                WriteStatementSeparator(formatter);
            }
            formatter.WriteLine();
            formatter.WriteOutdent();
            WriteDeclaration(statement.Name, formatter);
            formatter.Write(":");
            formatter.WriteLine();
            formatter.WriteIndent();
            _hasSeparator = true;
            if (statement.Statement != null)
            {
                WriteStatement(statement.Statement, formatter);
            }
        }

        #endregion

        #endregion

        #region Nested type: NumberFormat

        private enum NumberFormat
        {
            Auto,
            Hexadecimal,
            Decimal
        }

        #endregion

        #region Nested type: TextFormatter



        #endregion
    }
}