<# ==============================================================================================
 
# ============================================================================================== #>
$Host.UI.RawUI.WindowTitle = "UCC Upload"

clear

"Preparing to run script..."
# $inputCIV = read-host "Do you want to include Civians in this list? Y/N"
# $inputCTR = read-host "Do you want to include Contractor in this list? Y/N"


# $inputDB =  read-host "Do you want to Update UCC Recall DataBase (Slower if Y)? Y/N"

#Define File will overwrite

# [Environment]::CurrentDirectory
# $MyInvocation.MyCommand.Path | Split-Path 
###$filePath = "\\fshill\Data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports\"
###$filename =  $filePath + "SC_Mil_and_Civ.csv"
###$filename_mil_only = $filePath + "SC_Mil_only.csv"
###$filename_ALL = $filePath + "SC_ALL.csv"
$FilePathToAssetList = "E:\Temp\"
$FileName = $FilePathToAssetList + "PWCS ASSET LIST BY ACCOUNT.csv"
$FileName
###$WebServURL = "https://wbhill03.hill.af.mil/buffalo/WebServiceUCC.asmx"

# end variables

#cd $FilePathToAssetList

# Reset variable values
$ACCOUNT_NUMBER = "Account Number"
$SERIAL_NUMBER = "" 
$PART_NUMBER = ""
$CAGE = ""
$MODEL_NUMBER = ""
$MODEL_DESC = ""
$ACQ_DATE = ""
$ACQ_COST = ""
""
"Creating DataSet"
""
$ds = new-object System.Data.DataSet
$ds.Tables.Add("ASSETS")
[void]$ds.Tables["ASSETS"].Columns.Add("ACCOUNT_NUMBER",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("SERIAL_NUMBER",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("PART_NUMBER",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("CAGE",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("MODEL_NUMBER",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("MODEL_DESC",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("ACQ_DATE",[string])
[void]$ds.Tables["ASSETS"].Columns.Add("ACQ_COST",[string])
""
"Finished creating DataSet"
""
#Read in the Custom List
###$mylistnum = Import-Csv '.\CustomList.csv' | Measure-Object | Select Count
""
"Importing File"
""
$Counter = 1

$mylist = Import-Csv "E:\Temp\PWCS ASSET LIST BY ACCOUNT.csv" -header("1","ACCOUNT_NUMBER","SERIAL_NUMBER","PART_NUMBER","CAGE","2","3","MODEL_NUMBER","MODEL_DESC","4","5","ACQ_DATE","ACQ_COST")
$mylist | % {
    # Add to data list
    if ($Counter -gt 3){
    $dr = $ds.Tables["ASSETS"].NewRow()
    $dr["ACCOUNT_NUMBER"] = $_.ACCOUNT_NUMBER
    $dr["SERIAL_NUMBER"] = $_.SERIAL_NUMBER
    $dr["PART_NUMBER"] = $_.PART_NUMBER
    $dr["CAGE"] = $_.CAGE
    $dr["MODEL_NUMBER"] = $_.MODEL_NUMBER
    $dr["MODEL_DESC"] = $_.MODEL_DESC
    $dr["ACQ_DATE"] = $_.ACQ_DATE
    $dr["ACQ_COST"] = $_.ACQ_COST
    $ds.Tables["ASSETS"].Rows.Add($dr)
    }
    
    "---------------------------------LOOP $Counter-------------------------------------"
    $Counter++
    
}
""
"Done importing file"
""
""
"Files for UL/UC2 are Complete - now updating UCC Database..."
"Do not close this window."
"Please allow to run in the background until complete."
""
""

"Starting Backup"
#$SqlConnection = New-Object System.Data.SqlClient.SqlConnection 
#$SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=Buffalo;Persist Security Info=True;Integrated Security=True"  
#$SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
#$SqlCmd.CommandText = "select * from checkin" 
#$SqlCmd.Connection = $SqlConnection 
#$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
#$SqlAdapter.SelectCommand = $SqlCmd 
#$DataSetDB = New-Object System.Data.DataSet 
#$SqlAdapter.Fill($DataSetDB) 
#$SqlConnection.Close()



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection 
$SqlConnection.ConnectionString = "Data Source=.\SQLEXPRESS;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True"  
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
$SqlCmd.CommandText = "select * from TEST" 
$SqlCmd.Connection = $SqlConnection 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
$SqlAdapter.SelectCommand = $SqlCmd 
$DataSetDB = New-Object System.Data.DataSet 
$SqlAdapter.Fill($DataSetDB) 
$SqlConnection.Close()



# export to file
$DataSetDB.Tables[0] | export-csv -path "E:\Temp\SQLTest.csv" -force -NoTypeInformation

#$WS = New-WebServiceProxy -Uri $WebServURL -UseDefaultCredential
""
"Starting foreach"
""
$ds.Tables["ASSETS"] | % {
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection 
    $SqlConnection.ConnectionString = "Data Source=.\SQLEXPRESS;Initial Catalog=PWCS;Persist Security Info=True;Integrated Security=True"
    $SqlConnection.Open()  
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
    $SqlCmd.CommandText = "INSERT INTO TEST (test, test2, test3) VALUES ('" + $_.ACCOUNT_NUMBER + "', '" + $_.SERIAL_NUMBER + "', '" + $_.MODEL_DESC + "')" 
    $SqlCmd.Connection = $SqlConnection 
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
    $SqlAdapter.SelectCommand = $SqlCmd 
    #$DataSetDB = New-Object System.Data.DataSet 
    #$SqlAdapter.Fill($DataSetDB)
    $SqlCmd.executenonquery() 
    $SqlConnection.Close()
}

"UCC Database Update Complete"
""  

function CheckIfInDB($SerialNumber){
    
}