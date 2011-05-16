using System;
using System.Linq;
using Arma2.Script.Language;
using Arma2.Script.Language.Contracts;

namespace a2mission
{
    public class M1A1 : Tank
    {
        public override void Delete()
        {
            string time1 = string.Format("Now: {0}", time);

            if (Speed < 50)
            {
                Speed = 50;
            }
            base.Delete();
        }

        public void TankKilled()
        {
            IUnitGroup group = null;
            group.addWaypoint(new Position(0, 5, 5), 50);

            assignTeam(TeamType.Red);
            var target = assignedTarget();

            double value = Math.Asin(5) * Math.PI / 2;

            player.vehicle();


            player.addEventHandler("killed", TankKilled);

            player.action("action", null);

            string s = string.Empty + "HelloWorld" + string.Format("Hello \" world, {0} {{0} {0:D1}", "hello");

            player.addAction("1234", "/sqs", null, 5, true, true, "", "function=1");

            fuel();
            var currentFuel = _startTank.fuel() * 5;
            player.action("eject", this, player, player.vehicle());

            int[] speeds = { 100, 200, 500, 1000, 0 };
            foreach (int speed in speeds)
            {
                if (Speed < 100)
                {
                    Speed = speed;
                }
            }

            string a1;
            speeds.ForEach(m =>
            {
                a1 = "HelloWorld123121";
            });
        }

        public M1A1(int maxSpeed, int maxHeight)
            : base(maxSpeed, maxHeight)
        {
            IUnitGroup group = null;
            var pos111 = new double[] {1, 1, 1, 1, 1, 1, 1, 0};
            group.addWaypoint(pos111, 50);

 

        }
    }
}