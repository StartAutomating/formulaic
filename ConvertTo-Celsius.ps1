function ConvertTo-Celsius
{
    <#
    .Synopsis
        Converts fahrenheit to celsius
    .Description
        Converts degrees in fahrenheit to celsius
    .Example
        ConvertTo-Celsius 32    
    #>
    [OutputType([Double])]
    param(
    # The temperature, in fahrenheit
    [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
    [Double]
    $TemperatureInFahrenheit,

    # If set, will not round the result to the nearest degree
    [switch]
    $DoNotRound
    )


    process {
        $result = (5/ 9) * ($TemperatureInFahrenheit - 32)

        if ($DoNotRound) {
            $result
        } else {
            [Math]::Round($result)
        }
        
    }
    
    

    
} 
