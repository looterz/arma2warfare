﻿//using System.Linq;

using ScriptCoreLib;

namespace WarfareBE
{
    [Script, ScriptApplicationEntryPoint]
    public class Tank
    {
        private double _speed;

        public double Speed
        {
            get { return _speed; }
            set { _speed = value; }
        }

        private int[] AllowedSpeeds { get; set; }

        public Tank()
        {
            AllowedSpeeds = new[]{ 100, 200, 500, 1000, 0 };
            foreach (int speed in AllowedSpeeds)
            {
                Speed = speed;
            }
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
        {
            int[] speeds = { 100, 200, 500, 1000, 0 };
            foreach (int speed in speeds)
            {
                Speed = speed;
            }
        }

        public void Delete()
        {
        }
    }

}
