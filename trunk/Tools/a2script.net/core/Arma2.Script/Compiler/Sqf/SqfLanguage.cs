// FIXED �� ������������� ��������� ��������� ����������
// FIXED �� ����������� ��������� ������������ ������
// FIXED �� ���������� ������� ������������
// FIXED �� �������������� inline ����� ��� ������� ����2
// ASDESIGNED �������� ������� _var = []; - ������ ��������� ������,

using Arma2.Script.Compiler.Sqf;
using Reflector.CodeModel;

namespace Arma2.Script.Compiler.Sqf
{
    public class SqfLanguage : ILanguage
    {
        #region ���� ������

        private readonly bool addInMode;

        #endregion

        #region ������������ ������

        public SqfLanguage()
        {
            addInMode = false;
        }

        public SqfLanguage(bool addInMode)
        {
            this.addInMode = addInMode;
        }

        #endregion

        #region ���������� ������

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