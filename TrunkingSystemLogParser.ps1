Clear

Function GetIndividual($Value) {

    $Value = $Value -replace "Individual = ", ""

    $matches = ([regex]::matches($Value, "([0-9]{6})\(.*\](.*)$"))

    $matches | % {

        $radio = $_.Groups[1] -replace " ", ""

        $radioUser = $_.Groups[2] -replace " ", ""

        $dr["Radio"] = $radio

        $dr["RadioUser"] = $radioUser

    }

}

Function GetTargetGroup($Value) {

    $Value = $Value -replace "Target Group = ", ""

    $matches = ([regex]::matches($Value, "([0-9]{6})\(.*\](.*)$"))

    $matches | % {

        $TargetGroupID = $_.Groups[1] -replace " ", ""

        $TargetGroupName = $_.Groups[2] -replace " ", ""

        $dr["TargetGroupID"] = $TargetGroupID

        $dr["TargetGroupName"] = $TargetGroupName

    }

} #end GetTargetGroup

Function GetOLCallNumber($Value) {

    $Value = $Value -replace "OL Call# = ", ""

    $matches = ([regex]::matches($Value, "\(([0-9]+)\)"))

    $matches | % {

        $OLCallNumber = $_.Groups[1] -replace " ", ""

        $dr["OLCallNumber"] = $OLCallNumber

    }

} #end GetOLCallNumber

Function GetReason($Value) {

    $Value = $Value -replace "Reason = ", ""

    $dr["Reason"] = $Value

} #end GetReason

function GetIDRange($TrunkID) {
    
    #Set the $Result variable to a default value
    $Result = "UNKNOWN"

    if (($TrunkID -ne "") -and ($TrunkID -ne $null)) {
        if (($TrunkID -ge "700001") -and ($TrunkID -le "700499")) {$Result = "LAO"}
        elseif (($TrunkID -ge "701000") -and ($TrunkID -le "701499")) {$Result = "388 FW"}
        elseif (($TrunkID -ge "701500") -and ($TrunkID -le "701540")) {$Result = "IG"}
        elseif (($TrunkID -ge "701541") -and ($TrunkID -le "701589")) {$Result = "START"}
        elseif (($TrunkID -ge "702000") -and ($TrunkID -le "702099")) {$Result = "DP-READINESS"}
        elseif (($TrunkID -ge "702100") -and ($TrunkID -le "702249")) {$Result = "388 FW"}
        elseif (($TrunkID -ge "702250") -and ($TrunkID -le "702499")) {$Result = "DP-READINESS"}
        elseif (($TrunkID -ge "702500") -and ($TrunkID -le "702999")) {$Result = "CE"}
        elseif (($TrunkID -ge "703000") -and ($TrunkID -le "703499")) {$Result = "EOD"}
        elseif (($TrunkID -ge "703500") -and ($TrunkID -le "703999")) {$Result = "75 SFS"}
        elseif (($TrunkID -ge "704000") -and ($TrunkID -le "704499")) {$Result = "BASE OPS-SAFETY-TA"}
        elseif (($TrunkID -ge "705000") -and ($TrunkID -le "705799")) {$Result = "388 RANS"}
        elseif (($TrunkID -ge "705800") -and ($TrunkID -le "705999")) {$Result = "388 FW"}
        elseif (($TrunkID -ge "706000") -and ($TrunkID -le "706299")) {$Result = "75 LRS"}
        elseif (($TrunkID -ge "706500") -and ($TrunkID -le "706999")) {$Result = "419TH"}
        elseif (($TrunkID -ge "707000") -and ($TrunkID -le "707499")) {$Result = "MISSILE"}
        elseif (($TrunkID -ge "707500") -and ($TrunkID -le "707799")) {$Result = "HOSPITAL"}
        elseif (($TrunkID -ge "708500") -and ($TrunkID -le "708549")) {$Result = "ENVIRONMENTAL"}
        elseif (($TrunkID -ge "709000") -and ($TrunkID -le "709360")) {$Result = "FIRE"}
        elseif (($TrunkID -ge "709500") -and ($TrunkID -le "709799")) {$Result = "OSI"}
        elseif (($TrunkID -ge "710500") -and ($TrunkID -le "710999")) {$Result = "BASE TAXI"}
        elseif (($TrunkID -ge "711000") -and ($TrunkID -le "711499")) {$Result = "75 COMM"}
        elseif (($TrunkID -ge "711500") -and ($TrunkID -le "711999")) {$Result = "649 MUNS"}
        elseif (($TrunkID -ge "712100") -and ($TrunkID -le "712149")) {$Result = "649 CLSS"}
        elseif (($TrunkID -ge "713000") -and ($TrunkID -le "713499")) {$Result = "75 RANS"}
        elseif (($TrunkID -ge "714000") -and ($TrunkID -le "714049")) {$Result = "299TH"}
        elseif (($TrunkID -ge "715000") -and ($TrunkID -le "715099")) {$Result = "86 FWS DET 1"}
        elseif (($TrunkID -ge "718888") -and ($TrunkID -le "719562")) {$Result = "SLC GUARD DIGITAL"}
        elseif (($TrunkID -ge "720200") -and ($TrunkID -le "720599")) {$Result = "BASE OPS CONSOLE ID"}
        elseif (($TrunkID -ge "720600") -and ($TrunkID -le "720799")) {$Result = "COMMAND POST CONSOLE ID"}
        elseif (($TrunkID -ge "721000") -and ($TrunkID -le "721199")) {$Result = "DP-READINESS CONSOLE ID"}
        elseif (($TrunkID -ge "721200") -and ($TrunkID -le "721599")) {$Result = "FIRE CONSOLE ID"}
        elseif (($TrunkID -ge "721600") -and ($TrunkID -le "721999")) {$Result = "LAO CONSOLE ID"}
        elseif (($TrunkID -ge "722000") -and ($TrunkID -le "722399")) {$Result = "75 SFS CONSOLE ID"}
        elseif (($TrunkID -ge "722400") -and ($TrunkID -le "722499")) {$Result = "UTTR CONSOLE ID"}
        elseif (($TrunkID -ge "722500") -and ($TrunkID -le "722650")) {$Result = "388 FW CONSOLE ID"}
        elseif (($TrunkID -ge "730000") -and ($TrunkID -le "730599")) {$Result = "ANALOG CONSOLE ID"}
        elseif (($TrunkID -ge "731000") -and ($TrunkID -le "732149")) {$Result = "SLC GUARD"}
        elseif (($TrunkID -ge "737001") -and ($TrunkID -le "739999")) {$Result = "DHS"}
    }

    $Range = switch -regex ($TrunkID) {

       

        #These regular expressions were generated from

        #http://utilitymill.com/utility/Regex_For_Range/45

       

        #LAO: 700001-700499

        "\b700(0(0[1-9]|[1-9][0-9])|[1-4][0-9]{2})\b" {"LAO"}

        

        #388 FW: 701000-701499       

        "\b701[0-4][0-9]{2}\b" {"388 FW"}

       

        #IG: 701500-701540

        "\b7015([0-3][0-9]|40)\b" {"IG"}

        

        #START: 701541-701589

        "\b7015(4[1-9]|[5-8][0-9])\b" {"START"}

       

        #DP-READINESS      702000 702099

        "\b7020[0-9]{2}\b" {"DP-READINESS"}

       

        #388 FW      702100 702249

        "\b702(1[0-9]{2}|2[0-4][0-9])\b" {"388 FW"}

       

        #DP-READINESS      702250 702499

        "\b702(2[5-9][0-9]|[34][0-9]{2})\b" {"DP-READINESS"}

       

        #CE   702500 702999

        "\b702[5-9][0-9]{2}\b" {"CE"}

        

        #EOD  703000 703499

        "\b703[0-4][0-9]{2}\b" {"EOD"}

       

        #75 SFS      703500 703999

        "\b703[5-9][0-9]{2}\b" {"75 SFS"}

       

        #BASE OPS-SAFETY-TA 704000 704499

        "\b704[0-4][0-9]{2}\b" {"BASE OPS-SAFETY-TA"}

       

        #388 RANS    705000 705799

        "\b705[0-7][0-9]{2}\b" {"388 RANS"}

       

        #388 FW      705800 705999

        "\b705[89][0-9]{2}\b" {"388 FW"}

       

        #75 LRS      706000 706296

        "\b706([01][0-9]{2}|2([0-8][0-9]|9[0-6]))\b" {"75 LRS"}

 

        #419TH       706500 706999

        "\b706[5-9][0-9]{2}\b" {"419TH"}

   

        #MISSILE     707000 707499

        "\b707[0-4][0-9]{2}\b" {"MISSILE"}

       

        #HOSPITAL    707500 707799

        "\b707[5-7][0-9]{2}\b" {"HOSPITAL"}

   

        #ENVIRONMENTAL     708500 708546

        "\b7085([0-3][0-9]|4[0-6])\b" {"ENVIRONMENTAL"}

       

        #FIRE 709000 709360

        "\b709([0-2][0-9]{2}|3([0-5][0-9]|60))\b" {"FIRE"}

 

        #OSI  709500 709796

        "\b709([56][0-9]{2}|7([0-8][0-9]|9[0-6]))\b" {"OSI"}

   

        #75 LRS (BASE TAXI) 710500 710999

        "\b710[5-9][0-9]{2}\b" {"75 LRS (BASE TAXI)"}

   

        #75 COMM     711000 711499

        "\b711[0-4][0-9]{2}\b" {"75 COMM"}

   

        #649 MUNS    711500 711999

        "\b711[5-9][0-9]{2}\b" {"649 MUNS"}

   

        #649 CLSS    712100 712146

        "\b7121([0-3][0-9]|4[0-6])\b" {"649 CLSS"}

 

        #75 RANS     713000 713499

        "\b713[0-4][0-9]{2}\b" {"75 RANS"}

 

        #299TH       714000 714046

        "\b7140([0-3][0-9]|4[0-6])\b" {"299TH"}

 

        #86 FWS DET 1      715000 715099

        "\b7150[0-9]{2}\b" {"86 FWS DET 1"}

       

        #SLC GUARD DIGITAL 718888 - 719562

        "\b71(8(8(8[89]|9[0-9])|9[0-9]{2})|9([0-4][0-9]{2}|5([0-5][0-9]|6[0-2])))\b" {"SLC GUARD DIGITAL"}

 

        #BASE OPS CONSOLE ID      720200 720599

        "\b720[2-5][0-9]{2}\b" {"BASE OPS CONSOLE ID"}

 

        #COMMAND POST CONSOLE ID  720600 720799

        "\b720[67][0-9]{2}\b" {"COMMAND POST CONSOLE ID"}

 

        #DP-READINESS CONSOLE ID  721000 721199

        "\b721[01][0-9]{2}\b" {"DP-READINESS CONSOLE ID"}

 

        #FIRE CONSOLE ID   721200 721599

        "\b721[2-5][0-9]{2}\b" {"FIRE CONSOLE ID"}

 

        #LAO CONSOLE ID    721600 721999

        "\b721[6-9][0-9]{2}\b" {"LAO CONSOLE ID"}

 

        #75 SFS CONSOLE ID 722000 722399

        "\b722[0-3][0-9]{2}\b" {"75 SFS CONSOLE ID"}

 

        #UTTR CONSOLE ID   722400 722499

        "\b7224[0-9]{2}\b" {"UTTR CONSOLE ID"}

 

        #388 FW CONSOLE ID 722500 722650

        "\b722(5[0-9]{2}|6([0-4][0-9]|50))\b" {"388 FW CONSOLE ID"}

 

        #ANALOG CONSOLE ID 730000 730599

        "\b730[0-5][0-9]{2}\b" {"ANALOG CONSOLE ID"}

 

        #SLC GUARD   731000 732149

        "\b73(1[0-9]{3}|2(0[0-9]{2}|1[0-4][0-9]))\b" {"SLC GUARD"}

 

        #DHS(Department of Homeland Security)   737001 739999

        "\b73(7(0(0[1-9]|[1-9][0-9])|[1-9][0-9]{2})|[89][0-9]{3})\b" {"DHS"}

   

        default {"UNKNOWN"}

       

    }

    return $Result

}

function InsertIntoDB($table, $SerialNumber) {

   

    #$SerialNumber

   

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection

    $SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True" 

    $SqlConnection.Open() 

    

    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand

    

    $SqlCmd.CommandText = "INSERT INTO $table (TransmitDate, Action, Status, Radio, RadioUser, SerialNumber, TargetGroupID, TargetGroupName, OLCallNumber, Reason)

        SELECT '" + $_.Date + "', '" + $_.Action + "', '" + $_.Status + "', '" + $_.Radio + "', '" + $_.RadioUser + "', '" + $SerialNumber + "', '" + $_.TargetGroupID + "', '" + $_.TargetGroupName + "', '" + $_.OLCallNumber + "', '" + $_.Reason + "'

        WHERE NOT EXISTS (

            SELECT 1 FROM $table WHERE

                TransmitDate = '" + $_.Date + "' AND

                Radio = '" + $_.Radio + "' AND

                RadioUser = '" + $_.RadioUser + "' AND

                TargetGroupID = '" + $_.TargetGroupID + "' AND

                TargetGroupName = '" + $_.TargetGroupName + "'

        )"

    

    $SqlCmd.Connection = $SqlConnection

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter

    $SqlAdapter.SelectCommand = $SqlCmd

    #$DataSetDB = New-Object System.Data.DataSet

    #$SqlAdapter.Fill($DataSetDB)

   

    $HideCmd = $SqlCmd.executenonquery()

    #$SqlCmd.executenonquery()

    

    ###if ($HideCmd -eq 0) { $_.Radio }

    

    $SqlConnection.Close()

}

function InsertIntoAssetsDB($TrunkID, $TrunkIDRange) {

   

    #$SerialNumber

   

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection

    $SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True" 

    $SqlConnection.Open() 

    

    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand

    

    $SqlCmd.CommandText = "INSERT INTO assets (trunkID, trunkIDRange, serialNum)

        SELECT '" + $TrunkID + "', '" + $TrunkIDRange + "', '0'

        WHERE NOT EXISTS (

            SELECT 1 FROM assets WHERE trunkID = '" + $TrunkID + "'

        )"

    

    $SqlCmd.Connection = $SqlConnection

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter

    $SqlAdapter.SelectCommand = $SqlCmd

    #$DataSetDB = New-Object System.Data.DataSet

    #$SqlAdapter.Fill($DataSetDB)

   

    $HideCmd = $SqlCmd.executenonquery()

    #$SqlCmd.executenonquery()

    

    ###if ($HideCmd -eq 0) { $_.Radio }

    

    $SqlConnection.Close()

}

function GetSerialNumber($TrunkID) {

   

    #$TrunkID

   

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection

    $SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True"   

    $SqlConnection.Open() 

    

    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand

    

    $SqlCmd.CommandText = "SELECT TOP(1) serialNum FROM dbo.assets WHERE trunkID = '" + $TrunkID + "'"

    

    $SqlCmd.Connection = $SqlConnection

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter

    $SqlAdapter.SelectCommand = $SqlCmd

    $DataSetDB = New-Object System.Data.DataSet

    $throw = $SqlAdapter.Fill($DataSetDB)

   

    #$Reader = $SqlCmd.ExecuteReader()

    $SqlConnection.Close()

    

    $DataSetDB.Tables[0] | % {

        $test = $_.serialNum

    }

 

    Return $test

 

}

function GetSerialNumberFromArchive($TrunkID) {

   

    #$TrunkID

   

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection

    $SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True"   

    $SqlConnection.Open() 

    

    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand

    

    $SqlCmd.CommandText = "SELECT TOP(1) serialNum FROM dbo.[archive-assets] WHERE trunkID = '" + $TrunkID + "' ORDER BY trunkID, modified_date DESC"

    

    $SqlCmd.Connection = $SqlConnection

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter

    $SqlAdapter.SelectCommand = $SqlCmd

    $DataSetDB = New-Object System.Data.DataSet

    ###$throw = $SqlAdapter.Fill($DataSetDB)

   

    $Reader = $SqlCmd.ExecuteReader()

   

    if ($Reader.hasRows) {

        While ($Reader.Read()) {

            $SerialNumber = $Reader['serialNum']

        }

    } else {

        $SerialNumber = "0"

    }

   

    $SqlConnection.Close()

    

    ###$DataSetDB.Tables[0] | % {

    ###    $test = $_.serialNum

    ###}

 

    Return $SerialNumber

 

}

function DeleteOldRecords($Table) {

   

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection

    

    $SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True" 

    

    $SqlConnection.Open() 

    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand

   

    $SqlCmd.CommandText = "DELETE FROM $Table WHERE (TransmitDate < (getdate() - 545))"

   

    $SqlCmd.Connection = $SqlConnection

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter

    $SqlAdapter.SelectCommand = $SqlCmd

   

    $HideCmd = $SqlCmd.executenonquery()

   

    $Message = "Deleted " + $HideCmd + " old records from " + $Table

   

    $SqlConnection.Close()

   

    Return $Message

}

$ds = New-Object System.Data.Dataset

$ds.Tables.Add("Items")

[void]$ds.Tables["Items"].Columns.Add("Date",[string])
[void]$ds.Tables["Items"].Columns.Add("Action",[string])
[void]$ds.Tables["Items"].Columns.Add("Status",[string])
[void]$ds.Tables["Items"].Columns.Add("Radio",[string])
[void]$ds.Tables["Items"].Columns.Add("RadioUser",[string])
[void]$ds.Tables["Items"].Columns.Add("SerialNumber",[string])
[void]$ds.Tables["Items"].Columns.Add("TargetGroupID",[string])
[void]$ds.Tables["Items"].Columns.Add("TargetGroupName",[string])
[void]$ds.Tables["Items"].Columns.Add("OLCallNumber",[string])
[void]$ds.Tables["Items"].Columns.Add("Reason",[string])

#$SetPath = "\\fshill\data\CommInfo\75 CS\Hill CFP\PWCS\Trunking System Log Files"
$SetPath = "C:\Temp"

#$OriginalFiles = Get-ChildItem "\\fshill\data\CommInfo\75 CS\Hill CFP\PWCS\Trunking System Log Files\Log Files"
$OriginalFiles = Get-ChildItem "$SetPath\Log Files"

#The following loop will rename all the files in the specified directory with a .txt extension

$OriginalFiles | % {

    $new = Join-Path -Path $_.Directory -ChildPath "$($_.basename).txt"

    Rename-Item $_.FullName $new -PassThru

}

 

$CurrentDate = get-date -uformat "%m_%d_%Y"

$CurrentDate = $CurrentDate.tostring()

$NewArchiveFolder = "$SetPath\Log Files Archived\$CurrentDate"

 

md $NewArchiveFolder -ErrorAction SilentlyContinue

 

$FileList = Get-ChildItem "$SetPath\Log Files"

 

Get-Date

 

$FileList | % {   

    

    #Get-Date -DisplayHint Time

    #Get-Date -Time

   

    ""

    "Importing contents of file " + $_.Name

    ""

   

    $FileName = $_.Name

   

    $txt = Get-Content "$SetPath\Log Files\$FileName"

   

    $skip = "a-z A-Z 0-9 \s \- \( \) \[ \] \{ \} _ . : = # , / $"

 

    $words = ([regex]::matches($txt, "([0-9]+/[0-9]+/[0-9]+) [0-9]+:[0-9]+:[0-9]+\] ([$skip]*) -  ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ; ([$skip]*) ;")) 

 

    ""

    "Matching data..."

    ""

 

    $words | % {

        #$_

        $dr = $ds.Tables["Items"].NewRow()

       

        $dr["Date"] = $_.Groups[1]

        $dr["Action"] = $_.Groups[2]

        $dr["Status"] = $_.Groups[3]

       

        #The SerialNumber column is set at another point in this script

        $dr["SerialNumber"] = ""

       

        For ($i = 4; $i -lt 14; $i++) {

 

            if ($_.Groups[$i] -match "Individual =") {

               

                #The GetIndividual() function assigns a value to the "Radio" and "RadioUser"

                #columns in the "Items" table.

                GetIndividual $_.Groups[$i]

               

                #Uncomment the following lines to see the data while the script runs.

                #$_.Groups[$i]

                #Write-Host "Radio --------------- " $dr["Radio"]

                #Write-Host "RadioUser ----------- " $dr["RadioUser"]

 

            } elseif ($_.Groups[$i] -match "Target Group =") {

               

                #The GetIndividual() function assigns a value to the "TargetGroupID" and "TargetGroupName"

                #columns in the "Items" table.

                GetTargetGroup $_.Groups[$i]

                

                #Uncomment the following lines to see the data while the script runs.

                #$_.Groups[$i]

                #Write-Host "TargetGroupID ------- " $dr["TargetGroupID"]

                #Write-Host "TargetGroupName ----- " $dr["TargetGroupName"]

 

            } elseif ($_.Groups[$i] -match "OL Call# =") {

           

                #The GetIndividual() function assigns a value to the "OLCallNumber"

                #column in the "Items" table.

                GetOLCallNumber $_.Groups[$i]

 

                #Uncomment the following lines to see the data while the script runs.

                #$_.Groups[$i]

                #Write-Host "OLCallNumber -------- " $dr["OLCallNumber"]

           

            } elseif ($_.Groups[$i] -match "Reason = ") {

           

                #The GetIndividual() function assigns a value to the "Reason"

                #column in the "Items" table.

                GetReason $_.Groups[$i]

 

                #Uncomment the following lines to see the data while the script runs.

                #$_.Groups[$i]

                #Write-Host "Reason -------------- " $dr["Reason"]

           

            }

 

        }

 

        $ds.Tables["Items"].Rows.Add($dr) 

    }

       

    ""

    "Updating Database..."

    ""

 

    $ds.Tables["Items"] | % {

        if (($_.Radio).length -gt 0) {
            $Range = GetIDRange $_.Radio
        } else {
            $Range = "UNKNOWN"
        }

        #This section is just for testing.  Uncomment to see the 
        #the trunk ID range for each trunk ID.

        #try {
        #    "TRUNK ID: " + $_.Radio + " --- ID RANGE: " + $Range
        #} catch [Exception] {
        #    "TRUNK ID: UNDEFINED --- ID RANGE: " + $Range
        #}

      ##############Temp if statement
      if ("x" -eq "y") {  

        #Get the serial number for the current trunkd ID

        $SerialNumber = GetSerialNumber $_.Radio

       

        #The trunk ID was not found in the assets table so let's search

        #for it in the archive table.

        if ($SerialNumber -eq "0") {

            $SerialNumber = GetSerialNumberFromArchive $_.Radio

        }

       

        #The trunk ID wasn't found in either table so we can assume

        #that it is not listed in the db so, let's add it. 

        if (($SerialNumber).length -lt 1) {

            if (($_.Radio).length -gt 0) {

                #Insert trunk id into db....

                $Range = GetIDRange $_.Radio

                InsertIntoAssetsDB $_.Radio $Range

            }

        }

       

        #This serial number parameter is used for exports only

        #it's not required for inserts into the db

        $_.SerialNumber = $SerialNumber

       

        #this try-catch statement is used to display data to the user while the script is running.

        try {

            ###$_.Radio + " - " + $SerialNumber

        } catch [Exception] {

            #this exception will catch if the $SerialNumber variable or $_.Radio value comes back null

            "-----Undefined-----"

        }

       

        if ($_.Action -notmatch "Radio Status Traffic") {   

            

            if ($_.Status -match "Start of New Call") {

               

                InsertIntoDB "TrunkingSystemLog" "$SerialNumber"

           

            } elseif ($_.Status -notmatch "Call") {

           

                InsertIntoDB "TrunkingSystemLog_OTHER" "$SerialNumber"

           

            }

       

        } else {

           

            InsertIntoDB "TrunkingSystemLog_RST" "$SerialNumber"

       

        }

      }####################temp if statement 

    }   

    

    #Uncomment the following line to spit out a csv file of the current data table.

    #$ds.Tables["Items"] | Export-Csv -Path "$SetPath\$FileName" -Force -NoTypeInformation

        

    $ds.Tables["Items"].Clear()

   

    ""

    "Archiving $FileName"

    ""

   

    move-item -path "$SetPath\Log Files\$FileName" -destination $NewArchiveFolder

   

} #end of for loop used to import all text files

 

""

"All Files Imported..."

""

"Deleting Old Records..."

""

DeleteOldRecords "TrunkingSystemLog"

""

DeleteOldRecords "TrunkingSystemLog_OTHER"

""

DeleteOldRecords "TrunkingSystemLog_RST"

""

Get-Date

 

""

"Complete!"