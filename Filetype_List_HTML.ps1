#get-childitem c:\Music\* -include *.mp3 -recurse -force | format-table -auto

$pathname = read-host "Enter the path to your files."

$file_type = read-host "Enter the file extension you would like a list of."

$content = Get-ChildItem $pathname -recurse -force

$convert = $content | where {$_.extension -eq ".$file_type"} 

$x = 0

foreach ($count in $convert)
{
$x = $x + 1
} 

$title = "Search Results For ." + $file_type 

$body = "<center><h1>Here is a list of your selected file types!</h1></center><hr>
Your search for the file extension <b>." + $file_type + "</b> returned <b>" + $x + "</b> results.<hr>"

$convert | 
convertto-html BaseName,Extension,Length,FullName -title $title -body $body | 
set-content  c:\users\kristen\desktop\PowerShell\Extension_List_HTML.htm 

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