param(
    # number of minutes to run for  
    [Parameter(Position = 0 )]    
    [int]
    $runMinutes = 2


)
    
$start = Get-Date
start-sleep -Seconds $(Get-Random -Minimum 5 -Maximum 30)
    
function Get-Nonsense {
    param(
        # CharacterSet to use
        [Parameter(Position = 1)]
        [string]
        $characterSet = 'Alpha'
    )        
    switch ($characterSet) {
        Alpha { $charSet = [char[]](65..90) + [char[]](97..122) }
        AlphaNumeric { $charSet = [char[]](48..57) + [char[]](65..90) + [char[]](97..122)}
        Ascii { $charSet = [char[]](33..126) }
    }
    $length = Get-Random -Maximum 12 -Minimum 2
    return (( $charSet | Sort-Object {Get-Random})[0..$length] -join "")
}    

do {

    $blockLength = Get-Random -Maximum 20 -Minimum 1
    for ($j = 0; $j -lt $blockLength; $j++) {
        
        $lineLength = Get-Random -Maximum 30 -Minimum 2
        for ($i = 0; $i -lt $lineLength; $i++) {
            # weight toward words
            
            $words = Get-Random -Minimum 0 -Maximum 9
            switch ($words) {
                1 {$characterSetChoice = "AlphaNumeric"}
                9 {$characterSetChoice = "Ascii"}
                Default {$characterSetChoice = "Alpha"}
            }
            [string]$logLine += "$(Get-Nonsense -characterSet $characterSetChoice) "
        }
        Write-Output $logLine
        $logLine = $null
        start-sleep -Milliseconds $(Get-Random -Minimum 0 -Maximum 100)
    }
    start-sleep -Seconds $(Get-Random -Minimum 20 -Maximum 40)
} until(((Get-Date) - $start).Minutes -ge $runMinutes)

Write-Output "******************************$($env:hostname) Tasks Completed Successfully******************************"