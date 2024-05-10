function Compare-With-Golden {
    param (
        [Parameter(Mandatory)]
        [string]$RunCommand,

        [Parameter(Mandatory)]
        [string]$InputPath,

        [Parameter(Mandatory)]
        [string]$GoldenPath
    )

    $cmd = "$RunCommand $InputPath"
    Compare-Object (Invoke-Expression $cmd) (Get-Content $GoldenPath)
}

$testsDir = "tests"
$goldenDir = Join-Path -Path $testsDir -ChildPath "data"
Get-ChildItem "tests" -Filter *.lox | Foreach-Object {
    $loxFile = Join-Path -Path $testsDir -ChildPath $_
    $golden = Join-Path -Path $goldenDir -ChildPath ($_.Name + ".data")
    $diff = Compare-With-Golden "java -jar .\\build\\Lox.jar" $loxFile $golden
    if ($diff -eq $null) {
        echo "[PASSED] $loxFile"
    } else {
        echo "[FAILED] $loxFile"
    }
}

