param ($InputFile, $OutputFile, $NaNString = "NaN")

$fileData = Get-Content -Path $InputFile

# For the first two columns a hash table is used to get rid of duplicates.
# Only the keys are used.
$Col1 = @{}
$Col2 = @{}
# This map is used to build a structure to resolve present XYZ values.
$Values = @{}

$i = 0
foreach ($line in $fileData) {
    Write-Progress -Activity "  Parsing File" `
            -percentComplete ($i / $fileData.Length * 100)

    if ($line -match `
            '\s*(?<Col1>[\w-\.]+)\s+(?<Col2>[\w-\.]+)\s+(?<Col3>[\w-\.]+)') {
        # Store values. Duplicates are filtered out by the hash tables
        $Col1[$Matches.Col1] = ""
        $Col2[$Matches.Col2] = ""
        # Store present XYZ values
        $Values[$Matches.Col1 + " " + $Matches.Col2] = $Matches.Col3
    }

    $i++
}

# Sort columns 1 and 2 to get a "clean" file
$Col1Ordered = $Col1.Keys | Sort-Object { [float]$_ }
$Col2Ordered = $Col2.Keys | Sort-Object { [float]$_ }

if (Test-Path -Path $OutputFile -PathType Leaf) {
    Clear-Content -Path $OutputFile
} else {
    New-Item -Path $OutputFile -Type File | Out-Null
}

# Iterate over every combination
$i = 0
foreach ($ItemCol2 in $Col2Ordered) {
    Write-Progress -Activity "  Writing file" `
            -percentComplete ($i / $Col2Ordered.Length * 100)

    foreach ($ItemCol1 in $Col1Ordered) {
        $Col3 = $Values[$ItemCol1 + " " + $ItemCol2]
        # If no XYZ value is given, use the NANString
        if ([string]::IsNullOrWhiteSpace($Col3)) {
            $Col3 = $NaNString
        }
        Add-Content -Path $OutputFile `
                -Value ($ItemCol1 + "`t" + $ItemCol2 + "`t" + $Col3)
    }
    $i++
}
