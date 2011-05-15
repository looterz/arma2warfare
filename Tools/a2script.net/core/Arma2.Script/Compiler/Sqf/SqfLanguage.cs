// FIXED Не декларируются приватные локальные переменные
// FIXED Не объявляются статичные перемененные класса
// FIXED Не вызываются базовые конструкторы
// FIXED Не поддерживается inline вызов АПИ методов АрмА2
// ASDESIGNED Создание массива _var = []; - всегда создается пустой,

using Arma2.Script.Compiler.Sqf;
using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf
{
    public class SqfLanguage : ILanguage
    {
        #region Поля класса

        private readonly bool addInMode;

        #endregion

        #region Конструкторы класса

        public SqfLanguage()
        {
            addInMode = false;
        }

        public SqfLanguage(bool addInMode)
        {
            this.addInMode = addInMode;
        }

        #endregion

        #region Интерфейсы класса

        #region ILanguage Members

        public string Name
        {
            get { return (!addInMode) ? "ArmA2" : "ArmA2 Add-In"; }
        }

        public string FileExtension
        {
            get { return ".sqf"; }
        }

        public bool Translate
        {
            get { return true; }
        }

        public ILanguageWriter GetWriter(IFormatter formatter, ILanguageWriterConfiguration configuration)
        {
            return new LanguageWriter(formatter, configuration);
        }

        #endregion

        #endregion
    }
}