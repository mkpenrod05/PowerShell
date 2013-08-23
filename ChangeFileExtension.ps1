Clear
$OriginalFiles = Get-ChildItem "F:\Log"

$OriginalFiles | % {
    #$ext = $_.Extension
    #$fileName = $_.FileName
    #"Original: " + $_
    $new = Join-Path -Path $_.Directory -ChildPath "$($_.basename).txt"
    Rename-Item $_.FullName $new -PassThru
}