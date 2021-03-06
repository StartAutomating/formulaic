function Get-CircleCircumference
{
    <#
    .Synopsis
        Gets the Circumference of a circle
    .Description
        Gets the Circumference of a circle, using the simple equation
        
        Circumference = Pi * Radius^2        
    #>
    [CmdletBinding(DefaultParameterSetName='Radius')]
    param(
    # The radius
    [Parameter(Mandatory=$true,ParameterSetName='Radius')]    
    [Double]
    $Radius,
    
    # The diameter
    [Parameter(Mandatory=$true,ParameterSetName='Diameter')]    
    [Double]
    $Diameter,

    [Switch]
    $ShowWork
    )
    
    process {
        if ($psCmdlet.ParameterSetName -eq 'Radius') {
            Invoke-Equation {
# Double the radius
$doubleRadius = $radius * 2
# Get the value of Pi
$pi = [Math]::PI
# Circumference is 2 * pi * radius
$circleCircumference = $pi * $doubleRadius
} -ShowWork:$ShowWork                        
        } elseif ($psCmdlet.ParameterSetName -eq 'Diameter') {
            Invoke-Equation {
# Get the value of Pi
$pi = [Math]::PI
# Circumference is pi * d
$circleCircumference = $pi * $diameter
} -ShowWork:$ShowWork                        
        
        }
    }
} 
 
