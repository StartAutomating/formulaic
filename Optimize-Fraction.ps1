function Optimize-Fraction
{
    <#
    .Synopsis
        Optimizes fractions
    .Description
        Simplifies fractions into their optimal form
    .Example
        Optimize-Fraction 2 16
    #>
    param(
    # The numerator
    #|Float
    [Parameter(Mandatory=$true,Position=0)]
    [double]
    $Numerator,

    # The denominator
    #|Float
    [Parameter(Mandatory=$true,Position=1)]
    [double]
    $Denominator
    )

    process {
        $max = if ($Numerator -gt $Denominator) {
            $Numerator
        } else {
            $Denominator
        }
        $sieve = @(2..$max)

        $linkedList = New-Object Collections.Generic.LinkedList[double]
        foreach ($n in 2..$max) {
            $null = $linkedList.Add($n)
        }

        
        
        while ($linkedList.Count) {
            $n = $linkedList.First.Value
            $divideByNumerator = $Numerator/ $n
            $divideByDenominator = $Denominator / $n

            if (($divideByNumerator -eq [Math]::Floor($divideByNumerator)) -and 
                ($divideByDenominator -eq [Math]::Floor($divideByDenominator))) {
                $numerator = $Numerator / $n
                $Denominator = $Denominator / $n 
                break
            } else {
                 # Remove other multiple of the $n from the sieve
                 $originalN = $n 
                 
                 do {
                    
                    
                    $null = $linkedList.Remove($n)
                    $n+=$n    
                    
                 } while ($n -lt $max) 
                 
            }

        }
        
        "$($Numerator)/$($Denominator)"
    }
} 
