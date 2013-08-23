"What is the username that you would like to add to the UCC database?"
$inputUserName = read-host "ie: stanley.holmes"

if ($inputUserName -ne "") {  


# $WebServURL = "https://wbhill08dev.hill.afmc.ds.af.mil/Buffalo/WebServiceUCC.asmx"
# $WebServURL = "https://wbhill03.hill.af.mil/ucc/WebServiceUCC.asmx"
$WebServURL = "https://wbhill03.hill.af.mil/buffalo/WebServiceUCC.asmx"
 
$WS = New-WebServiceProxy -Uri $WebServURL -UseDefaultCredential
    $Data = ($WS.syncperson($inputUserName))
    $inputUserName
    $Data
    " "
    }
    
start-sleep -s 5
    