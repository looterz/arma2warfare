using System;

namespace Script.Compiler.Core.Attributes
{
    partial class ScriptAttribute
    {
        #region Поля класса

        internal Type InternalImplements;

        #endregion

        #region Свойства класса

        /// <summary>
        /// Supports redirecting BCLImplementation.
        /// </summary>
        public Type Implements
        {
            get
            {
                if (InternalImplements == null)
                {
                    if (!string.IsNullOrEmpty(ImplementsViaAssemblyQualifiedName))
                    {
                        // yay.
                        InternalImplements = Type.GetType(ImplementsViaAssemblyQualifiedName);
                        ImplementsViaAssemblyQualifiedName = null;
                        // cannot be both!
                    }
                }

                return InternalImplements;
            }
            set { InternalImplements = value; }
        }

        /// <summary>
        /// Supports redirecting BCLImplementation type while the target is visible.
        /// 
        /// Example for F# interactive: typeof[System.Tuple].AssemblyQualifiedName;;
        /// </summary>
        public string ImplementsViaAssemblyQualifiedName { get; set; }

        #endregion
    }
}