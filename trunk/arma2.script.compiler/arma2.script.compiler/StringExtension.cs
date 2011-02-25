using System;

namespace ArmA2.Script
{
    internal static class StringExtension
    {
        internal static char GetSafeChar(this string str, int pos)
        {
            return (0 <= pos && pos < str.Length) ? str[pos] : (char) 0;
        }

        internal static bool Equal(this string str, string equal)
        {
            return str.Equals(equal, StringComparison.CurrentCultureIgnoreCase);
        }

        internal static bool Equal(this string str, string equal, int pos, bool ignoreCase=false)
        {
            int j = 0;
            for(int i=pos; i>=0 && i< str.Length && j < equal.Length; i++, j++)
            {
                if (ignoreCase)
                    if (char.ToLower(str[i]) != char.ToLower(equal[j]))
                        return false;

                if (!ignoreCase) 
                    if (str[i] != equal[j])
                        return false;
            }

            return (j == equal.Length);
        }

        internal static bool IsStartString(this string content, int pos)
        {
            return (0 <= pos  && pos < content.Length && (content[pos] == '"' || content[pos] == '\''));
        }

        internal static int GetEndQuote(this string content, int startPos)
        {
            if (startPos == -1)
                return -1;

            char openCh = content[startPos];

            for (int i = startPos + 1; i < content.Length; i++)
            {
                char ch = content.GetSafeChar(i);
                char chNext = content.GetSafeChar(i + 1);

                //if (ch == '\\' && chNext == openCh) { i++; continue; }     // skip pattern \" 
                if (ch == openCh && chNext == openCh) { i++; continue; }    // skip pattern ""

                if (ch == openCh)
                    return i;
            }

            Logger.Log(LogLevel.Error, "Unterminated string: {0}", content.Substring(startPos));
            return -1;
        }
    }
}