page 50100 "CSD Seminar Setup"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 3-4
{
    PageType = Card;
    SourceTable = "CSD Seminar Setup";
    Caption = 'Seminar Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; "Seminar Nos.")
                {
                }
                field("Seminar Registration Nos."; "Seminar Registration Nos.")
                {
                }
                field("Posted Seminar Reg. Nos."; "Posted Seminar Reg. Nos.")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportSoap)
            {
                ApplicationArea = All;
                Caption = 'Import Currencies Soap';
                RunObject = codeunit "CSD Import FloatRate Soap";
                Image = ImportCodes;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
            action(ImportRest)
            {
                ApplicationArea = All;
                Caption = 'Import Currencies Rest';
                RunObject = codeunit "CSD Import FloatRate Rest";
                Image = ImportCodes;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
        }
    }
    trigger OnOpenPage();
    begin
        if not get then begin
            init;
            insert;
        end;
    end;
}
