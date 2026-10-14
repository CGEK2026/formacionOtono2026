page 50101 "Training Card"
{
    CaptionML = ENU = 'Training Card', ESP = 'Ficha formación';
    PageType = Card;
    ApplicationArea = All;
    // Categoria que se ve en el buscador
    // UsageCategory = Administration;
    // * none para no aparecer
    UsageCategory = None;
    SourceTable = Training;

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ESP = 'General';

                field("No."; Rec."No.") { }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
                field(Blocked; Rec.Blocked)
                {

                    Importance = Additional;
                }
            }
            group(TrainingDetails)
            {
                CaptionML = ENU = 'Training Details', ESP = 'Detalles de entrenamiento';
                field("Language Code"; Rec."Language Code") { }
                field("Duration (hours)"; Rec."Duration (hours)")
                {

                    Importance = Promoted;
                }
                field("No. of Sessions"; Rec."No. of Sessions") { }
                field("Hours per Sessions"; Rec."Hours per session") { }

            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
                field("Price"; Rec.Price) { }

            }
        }
    }
}