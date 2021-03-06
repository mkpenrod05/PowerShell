#copy-item C:\Users\Kristen\Desktop\tmp\cut_paste\items\* -destination C:\Users\Kristen\Desktop\tmp\cut_paste -recurse -PassThru 
#move-item C:\Users\Kristen\Desktop\tmp\cut_paste\items\* -destination C:\Users\Kristen\Desktop\tmp\cut_paste -PassThru 

$pathname = read-host "Enter the path to your files."

$file_type = read-host "Enter the file extension you would like moved."

$destination = read-host "Enter the destination for your files."

#$content = Get-ChildItem C:\Users\Kristen\Desktop\tmp\cut_paste\items -recurse
$content = Get-ChildItem $pathname -recurse

#if (Test-Path C:\Users\Kristen\Desktop\tmp\cut_paste\items)
#    {
#    Write-Host $content.Count "items exist!"
#    }
#else
#    {
#    "Doesn't Exist!"
#    }
#foreach ($file in $content)
#{
#move-item $file -destination C:\Users\Kristen\Desktop\tmp\cut_paste -PassThru
#Write-Host $file
#}

#$move = $content | where {$_.extension -eq ".txt" -or $_.extension -eq ".pdf"}
$move = $content | where {$_.extension -eq ".$file_type"}

#$move | move-item -destination C:\Users\Kristen\Desktop\tmp\cut_paste -whatif
$move | move-item -destination $destination -force -whatif

Write-Host $move.Count "items were moved!" -whatif