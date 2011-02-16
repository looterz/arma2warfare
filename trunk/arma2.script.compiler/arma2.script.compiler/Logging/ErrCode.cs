namespace ArmA2.Script
{
    public enum ErrCode
    {
        None,
        Warning = 5000,
        WarningPerfomance,
        WarningOutOfScopeDeclaration,
        WarningAssigmentToReserved,
        WarningVariableNotDeclared,


        Error = 1000
    }
}