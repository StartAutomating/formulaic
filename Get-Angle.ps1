function Get-Angle
{
    <#
    .Synopsis
   
    .Description
        Gets the angle of a given slope    
    #>
    param(
    # The rise of the slope
    [Parameter(Mandatory=$true,Position=0)]
    [Double]
    $Rise,

    # The run of the slope
    [Parameter(Mandatory=$true,Position=1)]
    [Double]
    $run
    )

    process {
        Invoke-Equation {
# The tangent of the angle is equal to the opposite (the rise) over the adjacent (the run)
$RiseOverRun = $rise /  $run

# The ArcTan of Rise Over Run provides an angle, in Radians

$AngleInRadians = [Math]::Atan($RiseOverRun)

# To convert to degrees, divide by PI / 180
$angle = $AngleInRadians / ([Math]::PI / 180)
        } -ShowWork:$ShowWork                                
    }
} 
