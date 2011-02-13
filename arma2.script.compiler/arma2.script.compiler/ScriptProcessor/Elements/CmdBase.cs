using System.IO;

namespace ArmA2.Script.ScriptProcessor
{
    public class CmdBase : IScriptRenderer
    {
        public CmdElement Parent { get; set; }
        public virtual void Render(ScriptWriter writer)
        {
        }

        public override string ToString()
        {
            using(var ms = new MemoryStream())
            {
                var writer = new ScriptWriter(ms);
                writer.AutoFlush = true;
                Render(writer);
                writer.Flush();

                ms.Flush();
                ms.Position = 0;
                return (new StreamReader(ms)).ReadToEnd();
            }
        }
    }
}