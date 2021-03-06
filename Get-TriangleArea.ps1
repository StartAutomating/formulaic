function Get-TriangleArea
{
    <#
    .Synopsis
        Gets the area of a triangle
    .Description
        Gets the area of a triangle, by solving the following equation:
        
        S = 1/2 * base * height 
    #>
    [CmdletBinding(DefaultParameterSetName='TriangleAreaByBaseAndHeight')]
    param(
    # The base of the triangle
    [Parameter(Mandatory=$true,ParameterSetName='TriangleAreaByBaseAndHeight')]
    [Double]
    $Base,
    
    # The height of the triangle
    [Parameter(Mandatory=$true,ParameterSetName='TriangleAreaByBaseAndHeight')]   
    [Double]
    $Height,
    
    # The length of side A.
    [Parameter(Mandatory=$true,ParameterSetName='TriangleAreaByTwoSidesAndAnAngle')]   
    [Double]
    $LengthOfSideA,      
    
    # The length of side B
    [Parameter(Mandatory=$true,ParameterSetName='TriangleAreaByTwoSidesAndAnAngle')]   
    [Double]
    $LengthOfSideB,
    
    # The angle of C, in radians (unless -InDegrees is also set)
    [Parameter(Mandatory=$true,ParameterSetName='TriangleAreaByTwoSidesAndAnAngle')]   
    [Double]
    $AngleC,      
    
    # If set, angles will be in degrees
    [Parameter(ParameterSetName='TriangleAreaByTwoSidesAndAnAngle')]   
    [Switch]
    $InDegrees
    )
    
    process {
        if ($psCmdlet.ParameterSetName -eq 'TriangleAreaByBaseAndHeight') {
Invoke-Equation {
# S = 1/2 b h
$triangleArea = (1/2) * $Base * $Height
} -ShowWork:$ShowWork        
        } elseif ($psCmdlet.ParameterSetName -eq 'TriangleAreaByTwoSidesAndAnAngle') {
if ($InDegrees) {
Invoke-Equation {
# Convert Angle C into radians
$AngleCInRadians = $AngleC * ([Math]::PI / 180)
# S = 1/2 ab Sin(c)
$triangleArea = (1/2) * $LengthOfSideA* $LengthOfSideB * [Math]::Sin($AngleCInRadians)
} -ShowWork:$ShowWork        

} else {  
Invoke-Equation {
# S = 1/2 ab Sin(c)
$triangleArea = (1/2) * $LengthOfSideA* $LengthOfSideB * [Math]::Sin($AngleC)
} -ShowWork:$ShowWork        

}
        
        }
        
    }
} 
