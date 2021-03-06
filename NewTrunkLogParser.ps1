Clear

$ds = New-Object System.Data.Dataset
$ds.Tables.Add("Items")
[void]$ds.Tables["Items"].Columns.Add("Date",[string])
[void]$ds.Tables["Items"].Columns.Add("Action",[string])
[void]$ds.Tables["Items"].Columns.Add("Status",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param1",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param2",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param3",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param4",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param5",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param6",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param7",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param8",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param9",[string])
#[void]$ds.Tables["Items"].Columns.Add("Param10",[string])
[void]$ds.Tables["Items"].Columns.Add("Radio",[string])
[void]$ds.Tables["Items"].Columns.Add("RadioUser",[string])
[void]$ds.Tables["Items"].Columns.Add("TargetGroupID",[string])
[void]$ds.Tables["Items"].Columns.Add("TargetGroupName",[string])
[void]$ds.Tables["Items"].Columns.Add("OLCallNumber",[string])
[void]$ds.Tables["Items"].Columns.Add("Reason",[string])
#[void]$ds.Tables["Items"].Columns.Add("Site",[string])
#[void]$ds.Tables["Items"].Columns.Add("File",[string])

Function GetIndividual($num) {
        if ($_.Groups[$num] -match "Individual ="){
            $data = $_.Groups[$num]
            $data = $data -replace "Individual = ", ""
            $matches = ([regex]::matches($data, "([0-9]{6})\(.*\](.*)$"))
            $matches | % {
                $radio = $_.Groups[1] -replace " ", ""
                $radioUser = $_.Groups[2] -replace " ", ""
                $dr["Radio"] = $radio
                $dr["RadioUser"] = $radioUser
            }
            ###$data
            ###"-----------------------------------------------------"
        }
} #end GetIndividual

Function GetTargetGroup($num) {
        if ($_.Groups[$num] -match "Target Group ="){
            $data = $_.Groups[$num]
            $data = $data -replace "Target Group = ", ""
            $matches = ([regex]::matches($data, "([0-9]{6})\(.*\](.*)$"))
            $matches | % {
                $TargetGroupID = $_.Groups[1] -replace " ", ""
                $TargetGroupName = $_.Groups[2] -replace " ", ""
                $dr["TargetGroupID"] = $TargetGroupID
                $dr["TargetGroupName"] = $TargetGroupName
            }
            ###$data
            ###"-----------------------------------------------------"
        }
} #end GetTargetGroup

Function GetOLCallNumber($num) {
        if ($_.Groups[$num] -match "OL Call# ="){
            $data = $_.Groups[$num]
            $data = $data -replace "OL Call# = ", ""
            $matches = ([regex]::matches($data, "\(([0-9]+)\)"))
            $matches | % {
                $OLCallNumber = $_.Groups[1] -replace " ", ""
                $dr["OLCallNumber"] = $OLCallNumber
            }
            ###$data
            ###"-----------------------------------------------------"
        }
} #end GetOLCallNumber

Function GetReason($num) {
        if ($_.Groups[$num] -match "Reason ="){
            $data = $_.Groups[$num]
            $data = $data -replace "Reason = ", ""
            $dr["Reason"] = $data
            ###$data
            ###"-----------------------------------------------------"
        }
} #end GetReason

#Function GetSite($num) {
#        if ($_.Groups[$num] -match "Site ="){
#            $data = $_.Groups[$num]
#            $data = $data -replace "Site = ", ""
#            $data = $data -replace " } ", ""
#            $dr["Site"] = $data
#            $data
#            "-----------------------------------------------------"
#        }
#} #end GetSite

function InsertIntoDB($table) {
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection 
    $SqlConnection.ConnectionString = "Data Source=.\SQLEXPRESS;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True"
    $SqlConnection.Open()  
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
    $SqlCmd.CommandText = "INSERT INTO $table (TransmitDate, Action, Status, Radio, RadioUser, TargetGroupID, TargetGroupName, OLCallNumber, Reason) 
                          VALUES ('" + $_.Date + "', '" + $_.Action + "', '" + $_.Status + "', '" + $_.Radio + "', '" + $_.RadioUser + "', '" + $_.TargetGroupID + "', '" + $_.TargetGroupName + "', '" + $_.OLCallNumber + "', '" + $_.Reason + "')" 
    $SqlCmd.Connection = $SqlConnection 
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
    $SqlAdapter.SelectCommand = $SqlCmd 
    #$DataSetDB = New-Object System.Data.DataSet 
    #$SqlAdapter.Fill($DataSetDB)
    $flagThrow = $SqlCmd.executenonquery() 
    $SqlConnection.Close()
}

$FileList = Get-ChildItem "e:\Temp\Trunking System"

$FileList | % {

Get-Date
""
"Importing contents of file " + $_.Name
""
$FileName = $_.Name
$txt = Get-Content "E:\Temp\Trunking System\$FileName" 

#$a = "Radio Status Traffic -  Radio Affiliation ; Individual = "
#$b = "Radio Status Traffic -  Deaffiliation ; Reason = Deaffiliation by ISW ; Individual = "
#$c = "Radio Status Traffic -  Subscriber Reject ; Reason = #71, Individual not allowed to interrupt current audio source ; Individual = "
#$d = "Radio Status Traffic -  Subscriber Reject ; Reason = #48, Talkgroup request rejected due to Multigroup activity ; Individual = "
#$e = "Radio Status Traffic -  Subscriber Reject ; Reason = #4, Invalid Talkgroup Id ; Individual = "
#$f = "Radio Status Traffic -  Subscriber Reject ; Reason = #24, Clear request made on a Coded Only Group or by Coded Only Ind ; Individual = "
#$g = "Radio Status Traffic -  Subscriber Reject ; Reason = #23, Coded PC call made to Target Id who is Clear Only ; Individual = "
#$h = "Radio Status Traffic -  Subscriber Reject ; Reason = #22, Interconnect feature disabled for Ind ; Individual = "

$a = "Individual"
$b = "Target Group"

$skip = "a-z A-Z 0-9 \s \- \( \) \[ \] \{ \} _ . : = # , / $"

#$words = ([regex]::matches($txt, "([0-9]+/[0-9]+/[0-9]+)\s*[0-9]+:[0-9]+:[0-9]+\]\s*($a|$b|$c|$d|$e|$f|$g|$h)([0-9]+)")) 
###$words = ([regex]::matches($txt, "([0-9]+/[0-9]+/[0-9]+) [$skip]*] ([$skip]*) -  ([$skip]*) ; [$skip;\s]* $a = ([0-9]+)[$skip;\s]* $b = ([0-9]+)\([$skip;\s]*] ([a-zA-Z]+) ;"))

$words = ([regex]::matches($txt, "([0-9]+/[0-9]+/[0-9]+) [0-9]+:[0-9]+:[0-9]+\] ([$skip]*) -  ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ;"))  

"Matching data..."
""

$words | % {
        #$_
        $dr = $ds.Tables["Items"].NewRow()
        
        ###if ($_.Groups[2] -notmatch "Radio Status Traffic") {
        
        $dr["Date"] = $_.Groups[1]
        $dr["Action"] = $_.Groups[2]
        $dr["Status"] = $_.Groups[3]
        #$dr["Param1"] = $_.Groups[4]
        #$dr["Param2"] = $_.Groups[5]
        #$dr["Param3"] = $_.Groups[6]
        #$dr["Param4"] = $_.Groups[7]
        #$dr["Param5"] = $_.Groups[8]
        #$dr["Param6"] = $_.Groups[9]
        #$dr["Param7"] = $_.Groups[10]
        #$dr["Param8"] = $_.Groups[11]
        #$dr["Param9"] = $_.Groups[12]
        #$dr["Param10"] = $_.Groups[13]
        
        GetIndividual 4
        GetTargetGroup 4
        GetOLCallNumber 4
        GetReason 4
        #GetSite 4
        
        GetIndividual 5
        GetTargetGroup 5
        GetOLCallNumber 5
        GetReason 5
        #GetSite 5
        
        GetIndividual 6
        GetTargetGroup 6
        GetOLCallNumber 6
        GetReason 6
        #GetSite 6
        
        GetIndividual 7
        GetTargetGroup 7
        GetOLCallNumber 7
        GetReason 7
        #GetSite 7
        
        GetIndividual 8
        GetTargetGroup 8
        GetOLCallNumber 8
        GetReason 8
        #GetSite 8
        
        GetIndividual 9
        GetTargetGroup 9
        GetOLCallNumber 9
        GetReason 9
        #GetSite 9
        
        GetIndividual 10
        GetTargetGroup 10
        GetOLCallNumber 10
        GetReason 10
        #GetSite 10
        
        GetIndividual 11
        GetTargetGroup 11
        GetOLCallNumber 11
        GetReason 11
        #GetSite 11
        
        GetIndividual 12
        GetTargetGroup 12
        GetOLCallNumber 12
        GetReason 12
        #GetSite 12
        
        GetIndividual 13
        GetTargetGroup 13
        GetOLCallNumber 13
        GetReason 13
        #GetSite 13
        
        $ds.Tables["Items"].Rows.Add($dr)
        ###}  
    }

"Updating database..."
""
$counter = 1
#$ds.Tables["Items"] | 
#    ConvertTo-Csv -NoTypeInformation |
#    Export-Csv "E:\Temp\Export.csv" -force 



$ds.Tables["Items"] | % { 
    
    try {
        $_.Radio + " - " + $_.Date
    } catch [Exception] {
        "---Undefined---"
    }
    
    if ($_.Action -notmatch "Radio Status Traffic") {
        
        if ($_.Status -match "Start of New Call") {
            
            InsertIntoDB "TrunkingSystemLog"
        
        } elseif ($_.Status -notmatch "Call") {
            
            InsertIntoDB "TrunkingSystemLog_OTHER"
        
        }
        
    } else {
        
        InsertIntoDB "TrunkingSystemLog_RST"
        
    }
    
}
$ds.Tables["Items"] | Export-Csv "E:\Temp\Export.csv" -force -NoTypeInformation
$ds.Tables["Items"].Clear()

} #end $FileList loop

"Complete!"
  
