using Arma2.Script.Language.Contracts;

namespace Arma2.Script.Language
{
    public class Position : IPosition
    {
        public double X { get; set; }
        public double Y { get; set; }
        public double Z { get; set; }
    }
}