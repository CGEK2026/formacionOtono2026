namespace EmpoweringKnowledge.Training.MasterData;

table 50101 "Training Edition"
{
    Caption = 'Training Edition', Comment = 'ESP = "Edición formación"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Training No."; Code[20])
        {
            Caption = 'Training No.', Comment = 'ESP = "No. formación"';
            TableRelation = Training;
            ToolTip = 'Help', Comment = 'ESP = "Un texto de ayuda"';

        }
        field(2; Edition; Code[20])
        {
            Caption = 'Edition', Comment = 'ESP = "Edición"';

        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date', Comment = 'ESP = "Fecha inicio"';
        }
        field(4; "End Date"; Date)
        {
            Caption = 'End Date', Comment = 'ESP = "Fecha final"';
        }
        field(5; "Max. students"; integer)
        {
            Caption = 'Max. students', Comment = 'ESP = "Estudiantes maximos"';
            trigger OnValidate()
            var
                // SelectTypeErr: TextConst ENU = 'Max. Students cannot be set if Type is not specified',
                //                         ESP = 'No se puede especificar Máx. alumnos si no se establece el Tipo';
                // MaxSXtudentsNotAllowedOnVideoTutorialErr: TextConst ENU = 'Cannot have Max. Students on a VCideo Tutorial',
                //                                                 ESP = 'No se puede especificar Máx. alumnos para un Vídeo tutorial';
                // UnknownTypeErr: TextConst ENU = 'Unknown Type %1', ESP = 'Tipo %1 desconocido';
                SelectTypeErr: Label 'Max. Students cannot be set if Type is not specified', Comment = 'ESP = No se puede especificar Máx. alumnos si no se establece el Tipo';
                MaxSXtudentsNotAllowedOnVideoTutorialErr: Label 'Cannot have Max. Students on a VCideo Tutorial', Comment = 'ESP = No se puede especificar Máx. alumnos para un Vídeo tutorial';
                UnknownTypeErr: Label 'Unknown Type %1', Comment = 'ESP = Tipo %1 desconocido';

            begin
                case Rec."Type (Enum)" of
                    Rec."Type (Enum)"::" ":
                        if Rec."Max. students" > 0 then
                            Error(SelectTypeErr);
                    Rec."Type (Enum)"::"Instructor-Lead":
                        ;
                    Rec."Type (Enum)"::"Video Tutorial":
                        if Rec."Max. students" <> 0 then
                            Error(MaxSXtudentsNotAllowedOnVideoTutorialErr);
                    else
                        Error(UnknownTypeErr);


                end;

            end;
        }
        field(6; Type; Option)
        {
            Caption = 'Type', Comment = 'ESP = "Tipo"';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaption = ' ,Instructor-Lead, Video Tutorial', Comment = 'ESP = " , Guiado por profesor, Video tutorial"';
        }
        field(7; "Type (Enum)"; Enum "Edition Type")
        {
            Caption = 'Type (Enum)', Comment = 'ESP = "Tipo (Enum)"';
        }
    }

    keys
    {

        key(PK; "Training No.", Edition)
        {
            Clustered = true;
        }
    }
}