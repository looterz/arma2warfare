using System;
using System.IO;

namespace Script.Compiler.Core.ScriptWriter
{
    public interface IScriptWriter : IDisposable
    {
        int Ident { get; set; }
        bool AutoFlush { get; set; }
        Stream BaseStream { get; }
        void WriteLiteral(string text);
        void WriteSelf();
        void WriteBeginScope();
        void WriteEndScope();
        void WriteSpace();
        IScriptWriter GetScopeWriter();
        void Commit();
        IScriptWriter Scope(string openChar = null, string closeChar = null);
        void WriteIdent();
        void Write(string value, params object[] args);
        void WriteLine(string value, params object[] args);
        void WriteLine(string value);
        void WriteAssignment();
        void WriteDelimiter();
        void WriteLine();
        void Write(char value);
        void Write(char[] buffer);
        void Write(char[] buffer, int index, int count);
        void Write(bool value);
        void Write(int value);
        void Write(uint value);
        void Write(long value);
        void Write(ulong value);
        void Write(float value);
        void Write(double value);
        void Write(decimal value);
        void Write(string value);
        void Write(object value);
        void Write(string format, object arg0);
        void Write(string format, object arg0, object arg1);
        void Write(string format, object arg0, object arg1, object arg2);
        void WriteLine(char value);
        void WriteLine(char[] buffer);
        void WriteLine(char[] buffer, int index, int count);
        void WriteLine(bool value);
        void WriteLine(int value);
        void WriteLine(uint value);
        void WriteLine(long value);
        void WriteLine(ulong value);
        void WriteLine(float value);
        void WriteLine(double value);
        void WriteLine(decimal value);
        void WriteLine(object value);
        void WriteLine(string format, object arg0);
        void WriteLine(string format, object arg0, object arg1);
        void WriteLine(string format, object arg0, object arg1, object arg2);
    }
}