Set-ExecutionPolicy RemoteSigned
# Import the module for the Export-NAVApplicationObject cmdLet
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\140\RoleTailored Client\Microsoft.Dynamics.Nav.Ide.psm1' 
# Import the module for the Split-NAVApplicationObjectFile cmdLet
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\140\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1' 

# Export objects from database
Export-NAVApplicationObject -DatabaseServer 'localhost' -DatabaseName 'Demo Database BC (14-0)' `
                            -Filter 'Type=Page;Id=20..21' `
                            -Path 'c:\temp\Al-Conversion\Objects.txt' `
                            -Username 'Admin' -Password 'Passw0rd' `
                            -ExportToNewSyntax

# Create deltafiles to make table extensions and page extensions
# Export object files as text from the development environment 
# Export both standard objects and changed objects
Compare-NAVApplicationObject -OriginalPath "C:\Temp\AL\Objects_Standard.txt" `
                            -ModifiedPath "C:\Temp\AL\Objects_Changed.txt" `
                            -DeltaPath "C:\Temp\AL\AL" `
                            -ExportToNewSyntax

# Split the txt file into separate txt files pr object
Split-NAVApplicationObjectFile -Source 'C:\temp\Al\*.txt' -Destination 'c:\temp\Al\cal'

# Create the .al files
$Command = "C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\140\RoleTailored Client\txt2al.exe" 
& $Command --source c:\temp\Al\cal --target c:\temp\Al\al

# Clean up all text files
Remove-Item c:\temp\Al-Conversion\cal\*.*
Remove-Item c:\temp\Al-Conversion\*.*
