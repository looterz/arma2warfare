//using System.Linq;
using Script.Compiler.Core.Attributes;

namespace WarfareBE
{
    [Script]
    public class M1A1 : Tank
    {
        public override void Delete()
        {
            if (Speed < 50)
            {
                Speed = 50;
            }
            base.Delete();
        }

        public M1A1(int maxSpeed, int maxHeight)
            : base(maxSpeed, maxHeight)
        {
            int[] speeds = { 100, 200, 500, 1000, 0 };
            foreach (int speed in speeds)
            {
                if (Speed < 100)
                {
                    Speed = speed;
                }
            }
        }
    }

    [Script]
    public class Tank
    {
        public static int MaxFieldValue = GetMaxValue();
        public static string MaxFieldValueNA = "MotherNature";
        public static Tank StartTank = null;

        private double _speed;

        public double Speed
        {
            get { return _speed; }
            set { _speed = value; }
        }

        public static int GetMaxValue()
        {
            return 60;
        }

        private int[] _allowedSpeeds;

        public Tank()
        {
            var speeds = new[]{ 100, 200, 500, 1000, 0 };
            for (int i = 0; i < speeds.Length; i = i + 1 )
            {
                Speed = speeds[i*2];
            }

            var speed01 = _allowedSpeeds[1] * 5;
            _allowedSpeeds[1] = speed01 + 100;
            speeds[1] = speed01;
        }

        public Tank(int maxSpeed)
        {
            int[] speeds = { 100, 200, 500, 1000, 0 };
            foreach (int speed in speeds)
            {
                Speed = speed;
            }
        }

        public Tank(int maxSpeed, int maxHeight)
            : this(maxSpeed)
        {
            int[] speeds = { 100, 200, 500, 1000, 0 };
            foreach (int speed in speeds)
            {
                Speed = speed;
            }
        }

        public virtual void Delete()
        {
            bool c = (_speed < 100) ? true : false;

            if (c)
            {
                _speed = (_speed < 100) ? 500 : 100;
            }
            else
            {
                _speed = 50;
            }
        }
    }

}
