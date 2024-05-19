$text = Read-Host "Enter a text"

$words = $text -split ' '

function Shuffle-Array {
    param (
        [array]$array
    )
    $random = New-Object System.Random
    for ($i = $array.Length - 1; $i -ge 0; $i--) {
        $j = $random.Next(0, $i + 1)
        $tmp = $array[$i]
        $array[$i] = $array[$j]
        $array[$j] = $tmp
    }
    return $array
}

$shuffledWords = Shuffle-Array -array $words

Write-Output ($shuffledWords -join ' ')
