using Arma2.Script.Language;

namespace a2mission
{
    public class Tank : Vehicle
    {
        public static int MaxFieldValue = GetMaxValue();
        public static string MaxFieldValueNa = "MotherNature";
        public static Tank StartTank = null;

        private double _speed;
        public Tank _startTank = null;

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
            StartTank.Speed = 50;
            _startTank.Speed = 25;
            _startTank._speed = 25;

            int[] speeds = new int[]{ 100, 200, 500, 1000, 0 };
            speeds[1] = 20;

            for (int i = 0; i < speeds.Length; i = i + 1 )
            {
                Speed = speeds[i*2];
            }

            int end = speeds.Length;
            for (int i = 0; i < end; i = i + 1)
            {
                speeds[i * 2] = (int) Speed;
            }

            SetSpeed();

            int[] speeds1 = _allowedSpeeds;

            int speed01 = speeds1[1] * 5;
            speeds1[1] = speed01 + 100;
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
                Speed = Speed / 2;
            }
        }

        public bool _hasSpeed;

        public void SetSpeed()
        {
            _speed = 5;
        }

        /// <summary>
        /// Delete Tank
        /// </summary>
        public virtual void Delete()
        {
            this._startTank.Speed = 5;

            object[] states = new object[50];

            ((object[])(states[1]))[5] = (_speed < 100);

            _speed = (_speed < 100) ? 500 : 100;
            _hasSpeed = (_speed < 100); 
            
            if (!(_speed < 100))
            {
                _speed = 100;
            }
            else
            {
                _speed = 50;
            }

            Reload();
        }

        public void Reload()
        {
            _speed = 0;
            int maxLoad = 50;

            bool c = (maxLoad == 50);

        }
    }

}
