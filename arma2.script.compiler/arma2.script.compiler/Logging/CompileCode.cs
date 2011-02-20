namespace ArmA2.Script
{
    public enum CompileCode
    {
        None,
        Warning = 5000,
        PerfomanceIssue,
        OutOfScopeDeclaration,
        AssigmentToReserved,
        PrivateVarUndeclared,
        PrivateVarDuplicate,
        PrivateVarUnused,

        Error = 10000,
        UseUndeclaredVariable,
        InvalidArrayElement,
        CommandInvalidArgument,
        MissingSeparator,

        /// <summary>
        /// FSM Заголовок не найден
        /// </summary>
        FsmMissedProperty,
        FsmMissedClass,
        FsmInvalidValueType
    }
}