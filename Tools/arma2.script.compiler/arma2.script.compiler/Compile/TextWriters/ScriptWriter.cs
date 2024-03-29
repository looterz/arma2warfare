﻿using System.IO;

namespace ArmA2.Script.Compile.TextWriters
{
    internal class ScriptWriter : StreamWriter
    {
        #region Поля класса

        internal bool ApplyMinimize;

        internal bool Minimized;
        private int _indent;

        #endregion

        #region Свойства класса

        internal int Indent
        {
            get { return _indent; }
            set { _indent = (value >= 0) ? value : 0; }
        }

        #endregion

        #region Конструкторы класса

        internal ScriptWriter(Stream stream, bool renderMinimized) : base(stream)
        {
            NewLine = "\n";
            ApplyMinimize = renderMinimized;
        }

        #endregion

        #region Методы класса

        internal void WriteIndent(bool allowIdent, string content, params object[] args)
        {
            WriteIndent(allowIdent, true, content, args);
        }

        internal void WriteIndent(bool allowIdent, bool newLine, string content, params object[] args)
        {
            if (args.Length > 0)
            {
                content = string.Format(content, args);
            }

            if (!ApplyMinimize && !Minimized && allowIdent)
            {
                base.WriteLine();
                int indent = Indent;
                while (indent-- > 0)
                {
                    base.Write("    ");
                }
            }
            base.Write(content);
        }

        #endregion
    }
}