﻿using ArmA2.Script.Compile.TextWriters;
using ArmA2.Script.ScriptProcessor;

namespace ArmA2.Script.Compile.Commands.Common
{
    internal class CmdPreprocessor : CmdCommand
    {
        public override void Render(ScriptWriter writer)
        {
            var pos = writer.BaseStream.Position;
            var t0 = pos;

            while(pos > 0)
            {
                pos = pos - 1;
                writer.BaseStream.Position = pos;

                char ch = (char) writer.BaseStream.ReadByte();
                if (ch != ' ' && ch != '\n')
                {
                    pos = pos + 1;
                    break;
                }
            }

            if (pos != t0)
            {
                writer.BaseStream.Position = pos;
                writer.BaseStream.SetLength(pos);
            }


            if (this.Text.Equal("#endif"))
                writer.Indent--; 

            if (writer.BaseStream.Length > 0)
            {
                if (Parser.Compiler.Settings.ScriptMinimized)
                {
                    writer.Write("\n");
                };
                if (!Parser.Compiler.Settings.ScriptMinimized)
                {
                    writer.WriteIndent(true, "");

                    if (this.Text.Equal("#endif") == false)
                        writer.WriteIndent(true, "");
                }
            }
            
            base.Render(writer);

            if (this.Text.Equal("#endif") && !Parser.Compiler.Settings.ScriptMinimized)
                writer.WriteIndent(true, "");
            
            if (this.Text.Equal("#ifdef") ||
                this.Text.Equal("#ifndef"))
                writer.Indent++;
        }
    }
}