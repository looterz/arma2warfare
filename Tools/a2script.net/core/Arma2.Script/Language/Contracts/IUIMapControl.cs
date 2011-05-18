using Arma2.Script.Attributes;

namespace Arma2.Script.Language.Contracts
{
    [Script]
    public interface IUIMapControl : IUIControl
    {
        [InlineMethod("{0} addEditorObject[{1}, {2}, {3}]")]
        string addEditorObject(string type, string[] args, string subClass);

        [InlineMethod("{0} addMenu[{1}, {2}]")]
        int addMenu(string text, int priority);

        [InlineMethod("{0} addMenuItem[{1}, {2}, {3}, {4}]")]
        int addMenuItem(int menuId, string text, string command, int priority);

        [InlineMethod("{0} addMenuItem[{1}, {2}, {3}, {4}]")]
        int addMenuItem(string text, string command, int priority);

        [InlineMethod("{0} allow3DMode {1}")]
        void allow3DMode(bool allow3D);

        /// <summary>
        /// Allow/dissallow file ops (load/save etc).
        /// </summary>
        /// <param name="allowLoadSave"></param>
        [InlineMethod("{0} allowFileOperations {1}")]
        void allowFileOperations(bool allowLoadSave);
    }
}