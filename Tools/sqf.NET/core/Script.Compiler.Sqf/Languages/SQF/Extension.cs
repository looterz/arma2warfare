namespace Script.Compiler.Languages.SQF
{
    public static class Extension
    {
        public static string ToCaml(this string str)
        {
            if (str.Length == 0)
                return string.Empty;

            return char.ToUpper(str[0]) + str.Substring(1);
        }
    }
}