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
Get-ChildItem "tests" -Filter *.lox | Foreach-Object {
    $loxFile = Join-Path -Path $testsDir -ChildPath $_
    $golden = $loxFile + ".data"
    $diff = Compare-With-Golden "java -jar .\\Lox.jar" $loxFile $golden
    if ($diff -eq $null) {
        echo "[PASSED] $loxFile"
    } else {
        echo "[FAILED] $loxFile"
    }
}

