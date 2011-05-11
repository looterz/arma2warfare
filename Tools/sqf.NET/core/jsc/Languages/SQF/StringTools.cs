namespace Script.Compiler.Languages.SQF
{
    static class StringTools
    {
        public static string GetName(int index)
        {
            const int count = 'z' - 'a';
            string name = "";
            while (true)
            {
                int id = index / count;
                int r = index - (id * count);

                name = string.Format("{0}", (char) ('a' + r)) + name;
                if (id == 0)
                    break;
            }
            return name;
        }
    }
}