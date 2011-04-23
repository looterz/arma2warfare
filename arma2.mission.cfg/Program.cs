using System;
using System.Collections;
using System.IO;
using System.Linq;
using System.Xml;
using Mac.Arma.Config;
using Mac.Arma.Files;
using Mac.Arma.Misc;
using Microsoft.CSharp.RuntimeBinder;

namespace ConsoleApplication2
{
    class Program
    {
        static void Main(string[] args)
        {
            string sourceFile =
                @"c:\Users\Evgeny_Zyuzin\Documents\ArmA 2 Other Profiles\Bomba\missions\a2ru\co.40.chernarus\mission.sqm.bak";

            var missionFiles = Directory.GetFiles(@"c:\Users\Evgeny_Zyuzin\Documents\ArmA 2 Other Profiles\Bomba\missions\a2ru\",
                               "mission.sqm.bak", SearchOption.AllDirectories);

            //var missionFile = sourceFile;
            foreach (var missionFile in missionFiles)
            {
                var path = Path.GetDirectoryName(missionFile);

                string newName = path + "\\mission.sqm";
                if (File.Exists(newName))
                    File.Delete(newName);

                if (newName != missionFile)
                    File.Move(missionFile, newName);

                ProcessMissionFile(newName);
            }
        }

        private static void ProcessMissionFile(string sourceFile)
        {
            ConfigClass cfgClass = CPPFile.ReadConfig(sourceFile);

            dynamic config = new EasyConfigEntry(cfgClass);

            var groups = (EasyConfigEntry)config.Mission.Groups;

            var westSlots = groups.Where(m => IsPlayerSlot("WestSlot", m)).ToArray();
            var eastSlots = groups.Where(m => IsPlayerSlot("EastSlot", m)).ToArray();

            int maxSlots = 20;
            for (int i = westSlots.Length; i < maxSlots; i++ )
                AddSlot(groups, ((dynamic)westSlots[0]).Vehicles.Item(0), i);

            for (int i = eastSlots.Length; i < maxSlots; i++)
                AddSlot(groups, ((dynamic)eastSlots[0]).Vehicles.Item(0), i);


            NormalizePosition(groups, "WestSlot", maxSlots);
            NormalizePosition(groups, "EastSlot", maxSlots);

            var textualize = new Textualiser();
            var s = textualize.Visit(cfgClass);

            File.Move(sourceFile, sourceFile + ".bak");
            File.WriteAllText(sourceFile, s);
        }

        private static void NormalizePosition(EasyConfigEntry groups, string slotName, int maxSlots)
        {
            double x0 = 0, y0 = 0, z0 = 0;
            double x = 0, y = 0, z = 0;

            int row = 0;
            int maxrow = maxSlots / 2;
            int id = 0;

            groups.Where(m => IsPlayerSlot(slotName, m)).ForEach(m =>
            {
                var position = (ArrayProperty) ((dynamic) m).Vehicles.Item(0).position().Entry;

                if (id++ == 0)
                {
                    x0 = Convert.ToDouble(position[0]);
                    y0 = Convert.ToDouble(position[1]);
                    z0 = Convert.ToDouble(position[2]);
                    x = x0;
                    y = y0;
                    z = z0;
                }

                position[0] = (float)x;
                position[1] = (float)y0;
                position[2] = (float)z;

                x = x + 1;
                if (++row >= maxrow)
                {
                    x = x0;
                    z = z - 1;
                    row = 0;
                }
            });
        }

        private static bool IsPlayerSlot(string baseName, EasyConfigEntry m)
        {
            try
            {
                return ((dynamic)m).Vehicles.Item(0).text.StartsWith(baseName);
            }
            catch (RuntimeBinderException e)
            {
                return false;
            }
            return true;
        }

        private static void AddSlot(EasyConfigEntry cgroups, EasyConfigEntry cbaseItem0, int id)
        {
            dynamic baseItem0 = cbaseItem0;
            dynamic groups = cgroups;

            groups.items = groups.items + 1;

            var groupClass = ((ConfigClass) cgroups.Entry);
            var maxName = groupClass.Where(m => m.Name.StartsWith("Item")).Max(m => int.Parse(m.Name.Substring(4)));

            var westSlot = new ConfigClass(string.Format("Item{0}",  maxName+1));
            westSlot.Add(new StringProperty("side", baseItem0.side));
            {
                var slotVehicles = new ConfigClass("Vehicles");
                slotVehicles.Add(new IntProperty("items", 1));
                {
                    var vehicleItem = new ConfigClass("Item0");

                    vehicleItem.Add(new IntProperty("id", groups.items));

                    string text = baseItem0.text;
                    text = text.Substring(0, "WestSlot".Length) + id;

                    vehicleItem.Add(new StringProperty("text", text));

                    var position = new ArrayProperty("position", baseItem0.position);
                    vehicleItem.Add(position);

                    vehicleItem.Add(new StringProperty("vehicle", baseItem0.vehicle));
                    vehicleItem.Add(new StringProperty("side", baseItem0.side));
                    vehicleItem.Add(new StringProperty("player", baseItem0.player));
                    vehicleItem.Add(new IntProperty("leader", baseItem0.leader));
                    vehicleItem.Add(new StringProperty("rank", baseItem0.rank));
                    vehicleItem.Add(new FloatProperty("skill", baseItem0.skill));

                    slotVehicles.Add(vehicleItem);
                }
                westSlot.Add(slotVehicles);
            }
            groups.Entry.Add(westSlot);
        }
    }
}
