function Get-Median
{
    <#
    .Synopsis
        Gets a median
    .Description
        Gets the median of a series of numbers
    .Example
        Get-Median 2,4,6,8
    .Link
        Get-Average
    .Link
        Get-StandardDeviation
    #>
    param(
    # The numbers to average
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
        $sortedNumbers = @($numberSeries | Sort-Object)
        if ($numberSeries.Count % 2) {
            # Odd, pick the middle
            $sortedNumbers[($sortedNumbers.Count / 2) - 1]
        } else {
            # Even, average the middle two
            ($sortedNumbers[($sortedNumbers.Count / 2)] + $sortedNumbers[($sortedNumbers.Count / 2) - 1]) / 2
        }                        
    }
} 
 
