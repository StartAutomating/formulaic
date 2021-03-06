function Measure-Velocity
{
    <#
    .Synopsis
        Measures velocity
    .Description
        Calculates velocity, using several well-known formula.  

        Velocity can be determined with:

        * Initial Velocity (u), Acceleration (a), and Time (t) (v = u + a * t )
        * Initial Velocity (u), Accleration (a), and Initial Distance (s) (v ^ 2 = u ^ 2 + 2as)         
    
    #>
    param(
    # The initial velocity.
    [Parameter(Mandatory=$true,ParameterSetName='MomentVelocity',Position=0)]
    [Parameter(Mandatory=$true,ParameterSetName='VelocityAfterAcceleration',Position=0)]    
    [Alias('U')]
    [Double]
    $InitialVelocity,


    # The acceleration (a) 
    [Parameter(Mandatory=$true,ParameterSetName='MomentVelocity',Position=1)]
    [Parameter(Mandatory=$true,ParameterSetName='VelocityAfterAcceleration',Position=1)]    
    [Alias('A')]
    [Double]
    $Acceleration,


    # The time travelled
    [Parameter(Mandatory=$true,ParameterSetName='MomentVelocity',Position=2)]    
    [Double]
    $Time,


    # The distance travelled
    [Parameter(Mandatory=$true,ParameterSetName='VelocityAfterAcceleration',Position=3)]    
    [Double]
    $Distance
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'MomentVelocity') {
            & {
# Multiply time and acceleration
$timeAndAcceleration = $Time * $Acceleration

# FinalVelocity is InitialVelocity + TimeAndAcceleration
$InitialVelocity + $timeAndAcceleration
}
            
        } elseif ($PSCmdlet.ParameterSetName -eq 'VelocityAfterAcceleration') {
            & {
# Square the initial velocity
$initalVelocitySquared = $InitialVelocity * $InitialVelocity

# Calculate acceleration and distance
$TwoTimeAccelerationAndDistance = 2 * $Acceleration * $Distance

# Combined Value
$CombinedValue = $initalVelocitySquared + $TwoTimeAccelerationAndDistance

# FinalVelocity is InitialVelocity + TimeAndAcceleration
[Math]::Sqrt($CombinedValue)
} 

        }
    }
} 
