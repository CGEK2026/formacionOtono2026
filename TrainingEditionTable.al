table 50101 "Training Edition"
{
    CaptionML = ENU = 'Training Edition', ESP = 'Edición formación';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Training No."; Code[20])
        {
            CaptionML = ENU = 'Training No.', ESP = 'No. formación';
            TableRelation = Training;

        }
        field(2; Edition; Code[20])
        {
            CaptionML = ENU = 'Edition', ESP = 'Edición';

        }
        field(3; "Start Date"; Date)
        {
            CaptionML = ENU = 'Start Date', ESP = 'Fecha inicio';
        }
        field(4; "End Date"; Date)
        {
            CaptionML = ENU = 'End Date', ESP = 'Fecha final';
        }
        field(5; "Max. students"; integer)
        {
            CaptionML = ENU = 'Max. students', ESP = 'Estudiantes maximos';
            trigger OnValidate()
            var
                SelectType: TextConst ENU = 'Max. Students cannot be set if Type is not specified',
                                        ESP = 'No se puede especificar Máx. alumnos si no se establece el Tipo';
                MaxSXtudentsNotAllowedOnVideoTutorial: TextConst ENU = 'Cannot have Max. Students on a VCideo Tutorial',
                                                                ESP = 'No se puede especificar Máx. alumnos para un Vídeo tutorial';
                UnknownType: TextConst ENU = 'Unknown Type %1', ESP = 'Tipo %1 desconocido';

            begin
                case Rec."Type (Enum)" of
                    Rec."Type (Enum)"::" ":
                        if Rec."Max. students" > 0 then
                            Error(SelectType);
                    Rec."Type (Enum)"::"Instructor-Lead":
                        ;
                    Rec."Type (Enum)"::"Video Tutorial":
                        if Rec."Max. students" <> 0 then
                            Error(MaxSXtudentsNotAllowedOnVideoTutorial);
                    else
                        Error(UnknownType);


                end;

            end;
        }
        field(6; Type; Option)
        {
            CaptionML = ENU = 'Type', ESP = 'Tipo';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaptionML = ENU = ' ,Instructor-Lead, Video Tutorial', ESP = ' , Guiado por profesor, Video tutorial';
        }
        field(7; "Type (Enum)"; Enum "Edition Type")
        {
            CaptionML = ENU = 'Type (Enum)', ESP = 'Tipo (Enum)';
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