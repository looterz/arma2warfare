namespace ArmA2.Script.Compile
{
    public enum CompileCode
    {
        None,
        Warning = 100,
        PerfomanceIssue,
        OutOfScopeDeclaration,
        AssigmentToReserved,
        PrivateVarUndeclared,
        PrivateVarDuplicate,
        PrivateVarUnused,

        Error = 500,
        UsedNotAssigned,
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