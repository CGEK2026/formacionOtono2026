namespace EmpoweringKnowledge.Training.MasterData;

using Microsoft.Foundation.NoSeries;
using Microsoft.Projects.Resources.Setup;
using System.Globalization;
table 50100 Training
{
    Caption = 'Training', Comment = 'ESP = "Formación"';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            // Uso de RegEx
            // (.*)ML = ENU = '(.*)', ESP = '(.*)';
            // $1 = '$2', Comment = 'ESP = "$3"';
            Caption = 'No.', Comment = 'ESP = "Núm."';
            // Caption = 'No.', Locked = true;
            // Caption = 'No.', MaxLength = 100;
            // * Poner la traduccion en el comentario para pasarla al fichero final.
            // Caption = 'No.', Comment = 'ESP="Núm."';

            trigger OnValidate()
            var
                ResourcesSetup: Record "Resources Setup";
                NoSeries: Codeunit "No. Series";
                IsHandled: Boolean;


            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    ResourcesSetup.Get();
                    NoSeries.TestManual(ResourcesSetup."Resource Nos.");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; Name; text[100])
        {
            Caption = 'Name', Comment = 'ESP = "Nombre"';

        }
        field(3; Price; Decimal)
        {
            DecimalPlaces = 2 : 2;
            BlankZero = true;
            Caption = 'Price', Comment = 'ESP = "Precio"';

        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked', Comment = 'ESP = "Bloqueado"';

        }
        field(5; "Language Code"; Code[10])
        {
            TableRelation = Language;
            Caption = 'Language Code', Comment = 'ESP = "Cód. idioma"';

        }
        field(6; "Duration (hours)"; Decimal)
        {
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            Caption = 'Duration (hours)', Comment = 'ESP = "Duración (horas)"';


            trigger OnValidate()
            begin
                CalcDurations();
            end;
        }
        field(7; "No. of Sessions"; Integer)
        {
            MinValue = 0;
            InitValue = 1;
            BlankZero = true;
            Caption = 'No. of sessions', Comment = 'ESP = "Núm. de sesiones"';


            trigger OnValidate()
            begin
                CalcDurations();
            end;
        }
        field(8; "Hours per session"; Decimal)
        {
            // MinValue = 0;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            Editable = false;
            Caption = 'Hours per session', Comment = 'ESP = "Horas por sesión"';


            trigger OnValidate()
            var
                // Se usa Label
                // HoursCannotBeNegativeErr: TextConst ESP = 'Las horas por sesiones (%1) no puede ser negativas',
                //  ENU = 'The hours per session (%1) can not be negative';
                HoursCannotBeNegativeErr: Label 'The hours per session (%1) can not be negative', Comment = 'ESP= Las horas por sesiones (%1) no puede ser negativas';

            begin
                if Rec."Hours per session" < 0 then
                    Error(HoursCannotBeNegativeErr, Rec."Hours per session");
            end;

        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
    }

    trigger OnInsert()
    var
        Training: Record Training;
        ResourcesSetup: Record "Resources Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            ResourcesSetup.Get();
            ResourcesSetup.TestField("Resource Nos.");
            "No. Series" := ResourcesSetup."Resource Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Training.ReadIsolation(IsolationLevel::ReadUncommitted);
            Training.SetLoadFields("No.");
            while Training.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");
        end;

        // DimMgt.UpdateDefaultDim(
        //   DATABASE::Resource, "No.",
        //   "Global Dimension 1 Code", "Global Dimension 2 Code");

    end;

    local procedure CalcDurations()
    begin
        if Rec."No. of Sessions" = 0 then
            rec."No. of Sessions" := 1;

        if Rec."Duration (hours)" = 0 then
            rec."Duration (hours)" := 1;

        // Rec."Hours per session" := -(Rec."Duration (hours)" / rec."No. of Sessions");
        // Rec.Validate("Hours per session");

        Rec.Validate("Hours per session", (Rec."Duration (hours)" / rec."No. of Sessions"));
    end;

    procedure AssistEdit(OldTraining: Record Training) Result: Boolean
    var
        Training: Record Training;
        ResourcesSetup: Record "Resources Setup";
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldTraining, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Training := Rec;
        ResourcesSetup.Get();
        ResourcesSetup.TestField("Resource Nos.");
        if NoSeries.LookupRelatedNoSeries(ResourcesSetup."Resource Nos.", OldTraining."No. Series", Training."No. Series") then begin
            Training."No." := NoSeries.GetNextNo(Training."No. Series");
            Rec := Training;
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Training: Record Training; xOldTraining: Record Training; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Training: Record Training; xTraining: Record Training; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Training: Record Training; var IsHandled: Boolean; var xTraining: Record Training)
    begin
    end;


}