using Arma2.Script.Compiler.Sqf.Attributes;
using Arma2.Script.Language.Contracts;

namespace Arma2.Script.Language
{
    public class Position : IPosition
    {
        [InlineMethod("[{0}, {1}, {2}]")]
        public Position(double x, double y, double z)
        {
            X = x;
            Y = y;
            Z = z;
        }

        public double X { get; set; }
        public double Y { get; set; }
        public double Z { get; set; }
    }
}