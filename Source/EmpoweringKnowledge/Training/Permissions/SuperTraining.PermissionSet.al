namespace EmpoweringKnowledge.Training.Permissions;

using EmpoweringKnowledge.Training.MasterData;

permissionset 50100 "Super Training"
{
    Caption = 'Super Training', Comment = 'ESP = "SUPER Formaciones"';
    Assignable = true;
    Permissions = // Read, Insert, Mod, Delete
    tabledata Training = RIMD,
        table Training = X,
        tabledata "Training Edition" = RIMD,
        page "Training List" = X,
        table "Training Edition" = X,
        page "Training Card" = X,
        page "Training Editions" = X,
        page "Training Editions Factbox" = X;
}