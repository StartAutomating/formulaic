function Measure-Tip
{
    <#
    .Synopsis

    .Description
        Calculates tips.  
        
        
        Select service quality to determine the tip percent:

        * OK (15%)
        * Good (20%)
        * Awesome (25%)

        Then choose if you want to round up

    #>
    param(
    # The check
    [Parameter(Mandatory=$true)]
    [Double]
    $Check,

    # The quality of the service
    [Parameter(Mandatory=$true)]
    [ValidateSet("OK", "Good", "Awesome")]
    [string]
    $ServiceQuality,

    # If you want, set your own rate.  
    [ValidateRange(1,100)]
    [Double]
    $MyRate,

    

    # If set, will round tips up to the nearest dollar
    [Switch]
    $RoundUp,

    # The number of ways the check is split
    [ValidateRange(1,25)]
    [Uint32]
    $Split =1
    )

    process {
        $subtotal = $check / $Split

        $rate = 
            if ($MyRate) {
                $MyRate / 100
            } elseif ($ServiceQuality -eq 'OK') {
                .15
            } elseif ($ServiceQuality -eq 'Good') {
                .20
            } elseif ($ServiceQuality -eq 'Awesome') {
                .25
            }
    

        $withTip = $subTotal + ($subtotal * $rate)


        if ($RoundUp) {
            [Math]::Round($withTip)
        } else {
            [Math]::Round($withTip,2 )
        }
    }

} 
