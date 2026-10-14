table 50100 Training
{
    CaptionML = ENU = 'Training', ESP = 'Formación';
    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', ESP = 'Núm.';

        }
        field(2; Name; text[100])
        {
            CaptionML = ENU = 'Name', ESP = 'Nombre';

        }
        field(3; Price; Decimal)
        {
            DecimalPlaces = 2 : 2;
            BlankZero = true;
            CaptionML = ENU = 'Price', ESP = 'Precio';

        }
        field(4; Blocked; Boolean)
        {
            CaptionML = ENU = 'Blocked', ESP = 'Bloqueado';

        }
        field(5; "Language Code"; Code[10])
        {
            TableRelation = Language;
            CaptionML = ENU = 'Language Code', ESP = 'Cód. idioma';

        }
        field(6; "Duration (hours)"; Decimal)
        {
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            CaptionML = ENU = 'Duration (hours)', ESP = 'Duración (horas)';


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
            CaptionML = ENU = 'No. of sessions', ESP = 'Núm. de sesiones';


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
            CaptionML = ENU = 'Hours per session', ESP = 'Horas por sesión';


            trigger OnValidate()
            var
                HoursCannotBeNegative: TextConst ESP = 'Las horas por sesiones (%1) no puede ser negativas',
                                                 ENU = 'The hours per session (%1) can not be negative';
            begin
                if Rec."Hours per session" < 0 then
                    Error(HoursCannotBeNegative, Rec."Hours per session");
            end;
        }
    }

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
}