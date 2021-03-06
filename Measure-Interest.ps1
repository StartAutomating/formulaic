function Measure-Interest
{
    <#
    .Synopsis
        Measures compound interest
    .Description
        Measures compound interest, using the formula:

        
        
        ### P = C(1 + r/n)^nt



        Where:
        
        * P is the future value
        * C is the initial deposit, 
        * r is the rate expressed as a fraction
        * n is the number of times per year interest is compounded
        * t is the number of years invested

    .Example
    #>
    param(
    # The initial deposit
    [Parameter(Mandatory=$true)]
    [Double]$InitialDeposit,

    # The rate, expressed as a percentage
    [Parameter(Mandatory=$true)]
    [ValidateRange(1,100)]
    [Double]$Rate,

    # The number of times interest is compounded per year
    #|Default 1 
    [ValidateRange(1,365)]
    [Double]$TimesCompoundedPerYear = 1,

    # The number of years you keep the investment
    #|Default 1
    [ValidateRange(1,365)]
    [Double]$YearsInvested= 1
    )

    process {
        $InitialDeposit * ([MAth]::Pow(( 1+ ($Rate / 100 / $TimesCompoundedPerYear)),($TimesCompoundedPerYear * $YearsInvested)))

        
    }
} 
