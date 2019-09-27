codeunit 50148 "CSD Upgrade Codeunit"
{
    Subtype = Upgrade;
    trigger OnCheckPreconditionsPerCompany()
    var
        myInt: Integer;
    begin

    end;

    trigger OnUpgradePerCompany()
    var
        ModuleInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(ModuleInfo);
        case format(ModuleInfo.AppVersion) of
            '1':
                DoSomeThing();
            '2':
                DoSomeThingElse();
        end;
    end;

    trigger OnValidateUpgradePerDatabase()
    var
        myInt: Integer;
    begin

    end;

    local procedure DoSomeThing()
    var
        myInt: Integer;
    begin

    end;

    local procedure DoSomeThingElse()
    var
        myInt: Integer;
    begin

    end;
}