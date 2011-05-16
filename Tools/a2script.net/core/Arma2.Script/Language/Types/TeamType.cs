﻿using Arma2.Script.Compiler.Sqf.Attributes;

namespace Arma2.Script.Language.Types
{
    public enum TeamType
    {
        [InlineMethod("\"MAIN\"")]
        Main,
        [InlineMethod("\"RED\"")]
        Red,
        [InlineMethod("\"GREEN\"")]
        Green,
        [InlineMethod("\"BLUE\"")]
        Blue,
        [InlineMethod("\"YELLOW\"")]
        Yellow
    }
}