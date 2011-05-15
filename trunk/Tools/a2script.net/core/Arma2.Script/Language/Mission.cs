using System;
using Arma2.Script.Compiler.Sqf.Attributes;
using Arma2.Script.Language.Contracts;

namespace Arma2.Script.Language
{
    public class Mission
    {
        [InlineMethod("accTime")]
        public static double accTime { get { throw new NotImplementedException(); } }

        /// <summary>
        /// Returns a list of dikCodes of buttons assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <returns></returns>
        [InlineMethod("actionKeys {0}")]
        public static int[] actionKeys(string userAction) { throw new NotImplementedException(); }

        /// <summary>
        /// Returns a list of button images or names assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <returns></returns>
        [InlineMethod("actionKeysImages {0}")]
        public static string[] actionKeysImages(string userAction) { throw new NotImplementedException(); }

        /// <summary>
        /// Returns a list of button images or names assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <param name="maxKeys">A maximum of maxKeys keys is listed.</param>
        /// <returns></returns>
        [InlineMethod("actionKeysImages[{0}, {1}]")]
        public static string[] actionKeysImages(string userAction, int maxKeys) { throw new NotImplementedException(); }

        /// <summary>
        /// Returns a list of button names assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <returns></returns>
        [InlineMethod("actionKeysNames {0}")]
        public static string actionKeysNames(string userAction) { throw new NotImplementedException(); }

        /// <summary>
        /// Returns a list of button names assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <param name="maxKeys">A maximum of maxKeys keys is listed.</param>
        /// <returns></returns>
        [InlineMethod("actionKeysNames[{0}, {1}]")]
        public static string actionKeysNames(string userAction, int maxKeys) { throw new NotImplementedException(); }

        /// <summary>
        /// Returns a list of button names assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <param name="maxKeys">A maximum of maxKeys keys is listed.</param>
        /// <returns></returns>
        [InlineMethod("actionKeysNamesArray {0}")]
        public static string[] actionKeysNamesArray(string userAction) { throw new NotImplementedException(); }

        /// <summary>
        /// Returns a list of button names assigned to the given user action.
        /// </summary>
        /// <param name="userAction"></param>
        /// <param name="maxKeys">A maximum of maxKeys keys is listed.</param>
        /// <returns></returns>
        [InlineMethod("actionKeysNamesArray[{0}, {1}]")]
        public static string[] actionKeysNamesArray(string userAction, int maxKeys) { throw new NotImplementedException(); }

        /// <summary>
        /// Activates the given keyname for the current user profile. The keys are used to unlock missions or campaigns.
        /// </summary>
        /// <param name="keyName"></param>
        /// <returns></returns>
        [InlineMethod("activateKey {0}")]
        public static void activateKey(string keyName) { throw new NotImplementedException(); }

        /// <summary>
        /// Creates the camera shaking effect, like when you are near an explosion
        /// </summary>
        /// <param name="power"></param>
        /// <param name="duration"></param>
        /// <param name="frequency"></param>
        [InlineMethod("addCamShake[{0}, {1}, {2}]")]
        public static void addCamShake(double power, double duration, double frequency) { throw new NotImplementedException(); }

        [InlineMethod("{0} addMagazinePool[{1}, {2}]")]
        public static void addMagazinePool(string name, double offsetX, double offsetY) { throw new NotImplementedException(); }

        [InlineMethod("{0} addPublicVariableEventHandler {1}")]
        public static void addPublicVariableEventHandler(string staticFieldName, Action eventHandler) { throw new NotImplementedException(); }

        [InlineMethod("addSwitchableUnit {0}")]
        public static void addSwitchableUnit(string unitName) { throw new NotImplementedException(); }

        [InlineMethod("{0} addTeamMember {1}")]
        public static void addTeamMember(IObject team, IObject teamMember) { throw new NotImplementedException(); }

        [InlineMethod("addWeaponPool[{0}, {1}]")]
        public static void addWeaponPool(string weaponName, int count) { throw new NotImplementedException(); }

        [InlineMethod("player")]
        public static IUnit player { get { throw new NotImplementedException(); } }

        [InlineMethod("agent {0}")]
        public static IUnit agent(IObject teamMember) { throw new NotImplementedException(); }

        [InlineMethod("agents {0}")]
        public static IUnit[] agents() { throw new NotImplementedException(); }

        [InlineMethod("AISFinishHeal [{0}, {1}, {2}]")]
        public static void AISFinishHeal(IUnit wounded, IUnit medic, bool flag) { throw new NotImplementedException(); }

        [InlineMethod("allDead")]
        public static IObject[] allDead() { throw new NotImplementedException(); }

        [InlineMethod("allGroups")]
        public static IUnitGroup[] allGroups() { throw new NotImplementedException(); }

        [InlineMethod("allMissionObjects {0}")]
        public static IObject[] allMissionObjects(string objectType) { throw new NotImplementedException(); }

        [InlineMethod("{0} allowGetIn {1}")]
        public static void allowGetIn(IUnit[] units, bool allowGetIn) { throw new NotImplementedException(); }

        [InlineMethod("allUnits")]
        public static IUnit[] allUnits() { throw new NotImplementedException(); }

        [InlineMethod("time")]
        public static double time { get { throw new NotImplementedException(); } }
    }
}