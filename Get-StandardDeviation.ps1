function Get-StandardDeviation
{
    <#
    .Synopsis
        Gets the standard deviation of a series of numbers
    .Description
        Gets the standard deviation of a series of numbers
    .Example
        Get-StandardDeviation 2,4,6,8
    #>
    param(
    # The series of numbers 
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
    [Double[]]
    $Number
    )
    
    begin {
        $numberSeries = @()
    }
    
    process {
        $numberSeries += $number
    }
    
    end {
        $scriptBlock = "
# Start the total at zero
`$total = 0
"
        foreach ($n in $numberSeries) {
            $scriptBlock += "
# Add $n to the total             
`$total += $n
"            
        }
        
        $scriptBlock += "
# The average is the total divided by the number of items $($numberSeries.Count)
`$average = `$total / $($numberSeries.Count)
`$deviationTotal = 0 
"


foreach ($n in $NumberSeries) {
            $scriptBlock += "
# Add $n to the total             
`$deviationTotal += [Math]::Pow(($n - `$average), 2) 
"            

}

        $scriptBlock += "
`$deviationAverage = `$deviationTotal / $($numberSeries.Count)


`$standardDeviation = [Math]::Sqrt(`$deviationAverage)
"

        $sb=  [ScriptBlock]::Create($scriptBlock)        
        
        $null = . $sb
        $standardDeviation
    }
} 
