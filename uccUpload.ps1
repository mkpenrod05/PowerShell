<# ==============================================================================================
NAME: UCC UpLoads Script 
Description:  Script to produce a input file for UCC
 
AUTHOR: Stan Holmes, 75 ABW/SCOSC
         Enterprise Development Engineer
         75 ABW/SCOSC
         7879 Wardleigh Rd
         Bldg 891
         Hill AFB, UT  84056-5996
DATE  : 2/9/2012
 
Comments and  Versions:
1.01 - 2012 0501 - Tweaked for Recall Database - StanH
1.00 - 2012 0209 - Created script working with Michael Penrod  -Stan Holmes
 
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
$filePath = "\\fshill\Data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports\"
$filename =  $filePath + "SC_Mil_and_Civ.csv"
$filename_mil_only = $filePath + "SC_Mil_only.csv"
$filename_ALL = $filePath + "SC_ALL.csv"

# $WebServURL = "https://wbhill08dev.hill.afmc.ds.af.mil/Buffalo/WebServiceUCC.asmx"
# $WebServURL = "https://wbhill03.hill.af.mil/ucc/WebServiceUCC.asmx"
$WebServURL = "https://wbhill03.hill.af.mil/buffalo/WebServiceUCC.asmx"

# end variables

cd $filepath

$Number = 900000000
# Reset variable values
$CC = "US"
$UNIT = "75ABW/SC"
$LAST_NAME = "" 
$FIRST_NAME = ""
$SSN = "" # Blank
$ACCOUNT = ""  # Blank
$RANK = ""
$MIDDLE_NAME = ""
$PHONE = ""
$HOME_PHONE = ""
$BUILDING_NUM = ""
$ROOM_NUM = ""
$AFSC = ""
$TDY = "N"
$DEPLOYED = "N"
$DEAD = "N"
$HDSP = "N"
$LEAVE = "N"
$MISS = "N"
$REMARKS = "" 
$USERNAME = ""

# Variables for easy reading
#$HEADER = "CC,UNIT,LAST_NAME,FIRST_NAME,SSN,RANK,MIDDLE_NAME,PHONE,BUILDING_NUM,ROOM_NUM,AFSC,TDY,DEPLOYED,DEAD,LEAVE,MISS,REMARKS"
##$HEADER = "CC,UNIT,LAST_NAME,FIRST_NAME,SSN,ACCOUNT,RANK,MIDDLE_NAME,PHONE,HOME_PHONE,BUILDING_NUM,ROOM_NUM,AFSC,TDY,DEPLOYED,DEAD,HDSP,LEAVE,MISS,REMARKS"

$ds = new-object System.Data.DataSet
$ds.Tables.Add("USERLIST")
[void]$ds.Tables["USERLIST"].Columns.Add("CC",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("UNIT",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("LAST_NAME",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("FIRST_NAME",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("SSN",[string])
# [void]$ds.Tables["USERLIST"].Columns.Add("ACCOUNT",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("RANK",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("MIDDLE_NAME",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("PHONE",[string])
#[void]$ds.Tables["USERLIST"].Columns.Add("HOME_PHONE",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("BUILDING_NUM",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("ROOM_NUM",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("AFSC",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("TDY",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("DEPLOYED",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("DEAD",[string])
# [void]$ds.Tables["USERLIST"].Columns.Add("HDSP",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("LEAVE",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("MISS",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("REMARKS",[string])
[void]$ds.Tables["USERLIST"].Columns.Add("USERNAME",[string])


#Read in the Custom List
$mylistnum = Import-Csv '.\CustomList.csv' | Measure-Object | Select Count

if ($mylistnum.count -gt 0)  {
$mylist = Import-Csv '.\CustomList.csv' 
$mylist | % {
    # Add to data list
    $dr = $ds.Tables["USERLIST"].NewRow()
    $dr["CC"] = $_.CC
    $dr["UNIT"] = $_.UNIT
    $dr["LAST_NAME"] = $_.LAST_NAME
    $dr["FIRST_NAME"] = $_.FIRST_NAME
    $dr["SSN"] = $_.SSN
    # $dr["ACCOUNT"] = $_.ACCOUNT
    $dr["RANK"] = $_.RANK
    $dr["MIDDLE_NAME"] = $_.MIDDLE_NAME
    $dr["PHONE"] = $_.PHONE
    # $dr["HOME_PHONE"] = $_.HOME_PHONE
    $dr["BUILDING_NUM"] = $_.BUILDING_NUM
    $dr["ROOM_NUM"] = $_.ROOM_NUM
    $dr["AFSC"] = $_.AFSC
    $dr["TDY"] = $_.TDY
    $dr["DEPLOYED"] = $_.DEPLOYED
    $dr["DEAD"] = $_.DEAD
    # $dr["HDSP"] = $_.HDSP
    $dr["LEAVE"] = $_.LEAVE
    $dr["MISS"] = $_.MISS
    $dr["REMARKS"] = $_.REMARKS
    $dr["USERNAME"] = $_.USERNAME
    $ds.Tables["USERLIST"].Rows.Add($dr)
    $USERNAME
}
}

# Search active directory
$searcher = New-Object System.DirectoryServices.DirectorySearcher([adsi]"LDAP://OU=Users,OU=SC,OU=75 ABW,OU=Users and Groups,OU=O Zone,OU=HI,DC=hill,DC=afmc,DC=ds,DC=af,DC=mil","(objectCategory=Person)")

# retrieve all search objects in scope
$results = $searcher.FindAll() 

# enumerate collection
# foreach($result in $results){
foreach ($result in $results) { 

    #Get the directory entry for this result/
    $user=$result.GetDirectoryEntry() 

    #$user | sort -descending -property LAST_NAME | foreach {
    $user | foreach {
    
    $CC = "US"
    # if ($_.extensionAttribute4 -ne $Null){$CC = $_.extensionAttribute4}  # "US"
        
    $UNIT = "75ABW/SC"
      
    $LAST_NAME = $_.sn.value            # Holmes
    
    $FIRST_NAME = $_.givenName.value    # Stan
    
    $RANK = ""
    # Rank: Use Personaltitle then ExtensionAttribute1 then DisplayName 
    # if ($_.extensionAttribute1){$RANK = $_.extensionAttribute1}  
    # if ($_.personalTitle -ne $Null){$RANK = $_.personalTitle}
    if ($_.displayName){$DISPLAYNAME = $_.displayname}
    $TRANK = ([regex]"^.*(AB|Amn|A1C|SrA|SSgt|TSgt|MSgt|SMSgt|CMSgt|Capt|Maj|Lt Col|Lt. Col|Civ|CTR) USAF").match($DISPLAYNAME).groups[1].value 
    # $TRANK = [regex]::match($DISPLAYNAME,"^.*(AB|Amn|A1C|SrA|SSgt|TSgt|MSgt|SMSgt|CMSgt|Capt|Maj|Lt Col|Lt. Col|CIv|CTR) USAF","IgnoreCase").Value
    if ($TRANK -ne 'false') {$RANK = $TRANK}
        
    $MIDDLE_NAME = ""
    if ($_.initials -ne $Null) {$MIDDLE_NAME = $_.initials.value}    # B
    
    $PHONE = ""
    if ($_.telephoneNumber -ne $Null) {$PHONE = $_.telephoneNumber}    # 7772083
    $PHONE = $PHONE.value -ireplace "[a-z]", ""
      
    $BUILDING_NUM = ""
    if ($_.StreetAddress -ne $Null) {$Address = $_.StreetAddress    # 891
        $has_building_num = ([regex]"^*(Bldg|Bldg.|Building) (\d{1,5})").match($Address).groups[2].value
        if ($has_building_num -ne 'false') {$BUILDING_NUM = $has_building_num}
    } 
    
    # room is officename
    $ROOM_NUM = ([regex]"^.*AFMC .*/(.*)$").match($DISPLAYNAME).groups[1].value  #SCOSC
    
    if ($ROOM_NUM -eq "") {$ROOM_NUM = $_.physicalDeliveryOfficeName.value}  #SCOSC
    # elseif ($ROOM_NUM -eq "CCA"){$ROOM_NUM = "SCXX"}
    # elseif ($ROOM_NUM -eq "CSS"){$ROOM_NUM = "SCXX"}
    # elseif ($ROOM_NUM -eq "GHOMO"){$ROOM_NUM = "SCXX"}
    # elseif ($ROOM_NUM -eq "CEAHU"){$ROOM_NUM = "SCXX"}
    
    if ($ROOM_NUM.startswith("SC")) { 
    #  do nothing
     } else {
     $ROOM_NUM = "SCXX"
     }
     #SCOSC
    
    
    #switch($ROOM_NUM.ToUpper)
    #{
    #    "CCA", "CSS", "GHOMO", "CEAHU" {$ROOM_NUM = "SCXX" }
    #    default { }
    #}
        
    
    $SSN = ""
    if ($_.userPrincipalName -ne $Null) {$userPrincipalName = $_.userPrincipalName  #EDIPI remove the 1 in front  4073438732
        $EDIPI = ([regex]"^1(\d{9})@mil").match($userPrincipalName).groups[1].value
        # $EDIPI
        IF ($EDIPI -ne ""){$SSN = $EDIPI}else{
            $NUMBER = $NUMBER + 1
            $SSN = $NUMBER}
        #Penrod 2 - replace leading Zero with 9 for Excel    
        $SSN = $SSN -replace "^0","9"
    }
    
    $USERNAME = $_.sAMAccountName.value.ToLower()
    $USERNAME
    # $ROOM_NUM
    # ""
    
    

    # Add to data list
    $dr = $ds.Tables["USERLIST"].NewRow()
    $dr["CC"] = $CC
    $dr["UNIT"] = $UNIT
    $dr["LAST_NAME"] = $LAST_NAME
    $dr["FIRST_NAME"] = $FIRST_NAME
    $dr["SSN"] = $SSN
    # $dr["ACCOUNT"] = $ACCOUNT
    $dr["RANK"] = $RANK
    $dr["MIDDLE_NAME"] = $MIDDLE_NAME
    $dr["PHONE"] = $PHONE
    # $dr["HOME_PHONE"] = $HOME_PHONE
    $dr["BUILDING_NUM"] = $BUILDING_NUM
    $dr["ROOM_NUM"] = $ROOM_NUM
    $dr["AFSC"] = $AFSC
    $dr["TDY"] = $TDY
    $dr["DEPLOYED"] = $DEPLOYED
    $dr["DEAD"] = $DEAD
    # $dr["HDSP"] = $HDSP
    $dr["LEAVE"] = $LEAVE
    $dr["MISS"] = $MISS
    $dr["REMARKS"] = $REMARKS
    $dr["USERNAME"] = $USERNAME
    $ds.Tables["USERLIST"].Rows.Add($dr)

}
  

}

# $ds.Tables["USERLIST"].Columns.Remove("USERNAME")

$ds.Tables["USERLIST"] | where {$_.RANK -ne "CTR"} | Sort ROOM_NUM, LAST_NAME, FIRST_NAME, MIDDLE_NAME | export-csv -path $filename -force -NoTypeInformation

$ds.Tables["USERLIST"] | where {$_.RANK -ne "CTR"} | where {$_.RANK -ne "Civ"} | Sort ROOM_NUM, LAST_NAME, FIRST_NAME, MIDDLE_NAME | export-csv -path $filename_mil_only -force -NoTypeInformation

$ds.Tables["USERLIST"] | Sort ROOM_NUM, LAST_NAME, FIRST_NAME, MIDDLE_NAME | export-csv -path $filename_ALL -force -NoTypeInformation


""
""
""
"Files for UL/UC2 are Complete - now updating UCC Database..."
"Do not close this window."
"Please allow to run in the background until complete."
""
""
Start-Sleep -s 5

if ([Environment]::UserName -eq 'stanley.holmes') {
# $env:username
$FileBackDir = $home + "\Backup2012\fshill\data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports\"
$FileNameDB = $home + "\Backup2012\fshill\data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports\dbBackup.csv"

"Starting Backup"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection 
$SqlConnection.ConnectionString = "Data Source=dbm2p;Initial Catalog=Buffalo;Persist Security Info=True;Integrated Security=True"  
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
$SqlCmd.CommandText = "select * from checkin" 
$SqlCmd.Connection = $SqlConnection 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
$SqlAdapter.SelectCommand = $SqlCmd 
$DataSetDB = New-Object System.Data.DataSet 
$SqlAdapter.Fill($DataSetDB) 
$SqlConnection.Close() 
# $DataSet.Tables[0] | Format-Table

# export to file
$DataSetDB.Tables[0] | export-csv -path $FileNameDB -force -NoTypeInformation

# Backup Copy to Workstation
# copy-item $fileObj -Destination $dest C:\Users\stanley.holmes\Backup2012\fshill\data\CommInfo\75 CS\Hill CFP\Recall Rosters\
# copy-item "\\fshill\Data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports\*" -Destination "C:\Users\stanley.holmes\Backup2012\fshill\data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports" -force -Whatif
copy-item "\\fshill\Data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports\*" -Destination "C:\Users\stanley.holmes\Backup2012\fshill\data\CommInfo\75 CS\Hill CFP\Recall Rosters\Exports" -force

}


$WS = New-WebServiceProxy -Uri $WebServURL -UseDefaultCredential

$ds.Tables["USERLIST"] | foreach $_.USERNAME {

# if ($inputDB -eq "Y") { # Update database 
    # update the SQL Via webservice
    # $Data = ($WS.syncperson($_.sAMAccountName.value))
    $Data = ($WS.syncperson($_.USERNAME))
    $_.USERNAME
    $Data
    " "
 
 #   }
    
    }

"UCC Database Update Complete"
""

"Working UCC Database Purge"
$Data = ($WS.PurgeCheckInRecords(-2))
$Data
"UCC Database Purge Complete"

Start-Sleep -s 120

# read-host "Please confirm close? Y/N Please type Y"
    