#get-childitem c:\Music\* -include *.mp3 -recurse -force | format-table -auto

$pathname = read-host "Enter the path to your files."

$file_type = read-host "Enter the file extension you would like a list of."

# here we exclude each file that starts with a period such as .thumbnails
$content = Get-ChildItem $pathname -exclude .* -recurse -force
$write = $content | select-object Basename
$write

$i = 0
foreach ($item in $content)
    {
    $i++
    }

#$convert = $content | where {$_.extension -eq ".$file_type"}  

$content | select-object BaseName,Extension,Length,FullName | 
export-csv -path C:\Users\Kristen\Desktop\PowerShell\Extension_List_CSV.csv -force -NoTypeInformation #-confirm 

write-host $i

#The following are available column names for this instance of get-childitem and examples:

#PSPath                - Microsoft.PowerShell.Core\FileSystem::C:\music\Alien Ant Farm- ANThology\Alien Ant Farm- Attitude.mp3
#PSParentPath          - Microsoft.PowerShell.Core\FileSystem::C:\music\Alien Ant Farm- ANThology
#PSChildName           - Alien Ant Farm- Attitude.mp3
#PSDrive               - C
#PSProvider            - Microsoft.PowerShell.Core\FileSystem
#PSIsContainer         - FALSE
#VersionInfo           - "File: C:\music\Alien Ant Farm- ANThology\Alien Ant Farm- Attitude.mp3
                         #InternalName:     
                         #OriginalFilename: 
                         #FileVersion:      
                         #FileDescription:  
                         #Product:          
                         #ProductVersion:   
                         #Debug:            False
                         #Patched:          False
                         #PreRelease:       False
                         #PrivateBuild:     False
                         #SpecialBuild:     False
                         #Language:         
                         #"

#BaseName              - Alien Ant Farm- Attitude
#Mode                  - -a---
#Name                  - Alien Ant Farm- Attitude.mp3
#Length                - 4718887
#DirectoryName         - C:\music\Alien Ant Farm- ANThology
#Directory             - C:\music\Alien Ant Farm- ANThology
#IsReadOnly            - FALSE
#Exists                - TRUE
#FullName              - C:\music\Alien Ant Farm- ANThology\Alien Ant Farm- Attitude.mp3
#Extension             - .mp3
#CreationTime          - 9/20/2011 23:07
#CreationTimeUTC       - 9/21/2011 5:07
#LastAccessTime        - 9/20/2011 23:07
#LastAccessTimeUTC     - 9/21/2011 5:07
#LastWriteTime         - 9/20/2011 23:02
#LastWriteTimeUTC      - 9/21/2011 5:02
#Attributes            - Archive
