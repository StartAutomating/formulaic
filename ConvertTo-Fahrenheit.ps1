function ConvertTo-Fahrenheit
{
    <#
    .Synopsis
        Converts celsius to fahrenheit
    .Description
        Converts degrees in celsius to fahrenheit
    .Example
        ConvertTo-Fahrenheit 233
    #>
    [OutputType([Double])]
    param(
    # The temperature, in celsius
    [Parameter(Mandatory=$true,ValueFromPipeline=$true,Position=0)]
    [Double]
    $TemperatureInCelsius,

    # If set, will not round the result to the nearest degree
    [switch]
    $DoNotRound
    )


    process {
        $result = (1.8 * $TemperatureInCelsius) + 32

        if ($DoNotRound) {
            $result
        } else {
            [Math]::Round($result)
        }
        
    }
    
    

    
} 
 
