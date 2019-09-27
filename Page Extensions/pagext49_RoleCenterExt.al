pageextension 50149 "CSD Sales Order RC Ext" extends 9006
{
    actions
    {
        addfirst(Processing)
        {
            action("Run Test")
            {
                ApplicationArea = All;
                Image = ImportCodes;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Codeunit.Run(50147);
                end;
            }
        }
    }

    var
        myInt: Integer;
}