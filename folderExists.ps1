###Test if a folder exists###

# Enter PC Name/IP Address
$hostIP = Read-Host "Enter User IP Address" # USE 127.0.0.1 or localhost to test on your machine
$folderName = Read-Host "Enter Folder Name"



##############Function for testing#######################
#########################################################
function folderExists{
    #Checks if Host is Online
    Write-Output "Checking for $hostIP......"
    Test-Connection $hostIP -Quiet

    #Checks if Folder exists on host C:\ Drive
    if (Test-Path \\$hostIP\C$\$folderName -PathType Any) {
        
        Write-Output "This Folder Exists"
   
        Do{
        
            $userInput = Read-Host "Do you want to delete? Y or N"
        
            if($userInput -eq "y"){
            Remove-Item -Path \\$hostIP\C$\$folderName
            Write-Output "`nFolder Deleted."
            Start-Sleep -Seconds 1
            break
            }
        
            elseif($userInput -eq "n"){
            Write-Output "Folder was not deleted."
            Start-Sleep -Seconds 1
            break
            }
        }While($userInput -ne "y" -or "n")
    
    }

# Creates Data Folder if doesnt exist
   else {
        New-Item -Path \\$hostIP\C$\$folderName -ItemType Directory
        Write-Output "`nNew Folder Created"
        Start-Sleep -Seconds 1
    }
}

Do{
    try {
        folderExists
        break
        
    }
    catch [System.IO.IOException]{
        Write-Warning -Message "ADDRESS IS INVALID OR NOT ON NETWORK"
        $hostIP = Read-Host "Enter User IP Address"
            
    }
}
While($true)
    

