Clear

$ds = New-Object System.Data.Dataset
$ds.Tables.Add("Items")
[void]$ds.Tables["Items"].Columns.Add("Date",[string])
[void]$ds.Tables["Items"].Columns.Add("TrunkID",[string])
#[void]$ds.Tables["Items"].Columns.Add("File",[string])

$NumOfFiles = (Get-ChildItem "E:\Temp" -filter "*.txt").count

for ($i = 1; $i -le $NumOfFiles; $i++){
#for ($i = 1; $i -le 3; $i++){
Get-Date
""
"Importing contents of file: default-Zone001-$i"
""

sleep -s 3

#$txt = Get-Content "E:\temp\testPSImport.txt" 
$txt = Get-Content "E:\temp\default-Zone001-$i.txt" 
#$txt.count
#$txt

#$string = "User = "
$a = "Radio Status Traffic -  Radio Affiliation ; Individual = "
$b = "Radio Status Traffic -  Deaffiliation ; Reason = Deaffiliation by ISW ; Individual = "
$c = "Radio Status Traffic -  Subscriber Reject ; Reason = #71, Individual not allowed to interrupt current audio source ; Individual = "
$d = "Radio Status Traffic -  Subscriber Reject ; Reason = #48, Talkgroup request rejected due to Multigroup activity ; Individual = "
$e = "Radio Status Traffic -  Subscriber Reject ; Reason = #4, Invalid Talkgroup Id ; Individual = "
$f = "Radio Status Traffic -  Subscriber Reject ; Reason = #24, Clear request made on a Coded Only Group or by Coded Only Ind ; Individual = "
$g = "Radio Status Traffic -  Subscriber Reject ; Reason = #23, Coded PC call made to Target Id who is Clear Only ; Individual = "
$h = "Radio Status Traffic -  Subscriber Reject ; Reason = #22, Interconnect feature disabled for Ind ; Individual = "
###$words = ([regex]::matches($txt, "[0-9]+/[0-9]+/[0-9]+\s*[0-9]+:[0-9]+:[0-9]+\]\s*$string[0-9]+") | 
###%{$_.value -replace "\s*[0-9]+:[0-9]+:[0-9]+\s*]\s*$string", " "})

#$words = ([regex]::matches($txt, "([0-9]+/[0-9]+/[0-9]+)\s*[0-9]+:[0-9]+:[0-9]+\]\s*($a|$b|$c|$d|$e|$f|$g|$h)([0-9]+)")) 
$words = ([regex]::matches($txt, "([0-9]+/[0-9]+/[0-9]+)\s*[0-9]+:[0-9]+:[0-9]+\]\s*[a-zA-Z0-9;\-\(\)\[\]\{\}\s=#,/]*Individual = ([0-9]+)")) 

#%{$_.value -replace "\s*[0-9]+:[0-9]+:[0-9]+\s*]\s*$string", " "}) 

$words | % {
        #$_
        $dr = $ds.Tables["Items"].NewRow()
        #$dr["Date"] = $_.Substring(0,8)
        $dr["Date"] = $_.Groups[1]
        #$dr["TrunkID"] = $_.Substring(9,6)
        $dr["TrunkID"] = $_.Groups[3]
        #$dr["File"] = "default-Zone001-$i" 
        $ds.Tables["Items"].Rows.Add($dr)  
    }

"Sorting data..."
""
$ds.Tables["Items"] | 
    Select Date,TrunkID -Unique | 
    sort Date,TrunkID | 
    ConvertTo-Csv -NoTypeInformation |
    Add-Content "E:\Temp\Export.csv" 
$ds.Tables["Items"].Clear()    
}
""
"All Files Imported..."
""
"Checking For Duplicates..."
""
sleep -s 3

Import-Csv "E:\Temp\Export.csv" | 
% {
    #$_
    $dr = $ds.Tables["Items"].NewRow()
        $dr["Date"] = $_.Date
        $dr["TrunkID"] = $_.TrunkID
        $ds.Tables["Items"].Rows.Add($dr)
}
$ds.Tables["Items"] | 
    Select Date,TrunkID -Unique | 
    sort Date,TrunkID | 
    Export-Csv "E:\Temp\ExportCleaned.csv" -force -NoTypeInformation
$ds.Tables["Items"].Clear()

"Complete!"    