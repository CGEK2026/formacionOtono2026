page 50102 "Training Editions"
{
    CaptionML = ENU = 'Training Edition', ESP = 'Edición formación';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Training Edition";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("Traning No."; Rec."Training No.")
                {
                    Visible = false;
                }
                field("Edition"; Rec.Edition) { }
                field(Type; Rec.Type) { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
                field("Start Date"; Rec."Start Date") { }
                field("End Date"; Rec."End Date") { }
                field("Max. students"; Rec."Max. students") { }
            }
        }
    }
}