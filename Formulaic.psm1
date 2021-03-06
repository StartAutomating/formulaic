. $psScriptRoot\Invoke-Equation.ps1

. $psScriptRoot\Get-Flashcard.ps1

#region Statistics
. $psScriptRoot\Get-Average.ps1
. $psScriptRoot\Get-Median.ps1
. $psscriptRoot\Get-StandardDeviation.ps1
. $psscriptRoot\Measure-Correlation.ps1
#endregion Statistics


#region Fractions
. $psScriptRoot\Optimize-Fraction.ps1
#endregion Fractions

#region Geometry
. $psScriptRoot\Get-Angle.ps1
. $psScriptRoot\Get-CircleArea.ps1
. $psScriptRoot\Get-Circumference.ps1
. $psScriptRoot\Get-EllipseArea.ps1
. $psScriptRoot\Get-ParallelogramArea.ps1
. $psScriptRoot\Get-RectangleArea.ps1
. $psScriptRoot\Get-RectanglePerimeter.ps1
. $psScriptRoot\Get-SquareArea.ps1
. $psScriptRoot\Get-SquarePerimeter.ps1
. $psScriptRoot\Get-TrapezoidArea.ps1
. $psScriptRoot\Get-TriangleArea.ps1 
. $psScriptRoot\Get-TriangleSide.ps1 
. $psScriptRoot\Get-TrianglePerimeter.ps1 
#endregion Geometry


. $psScriptRoot\Invoke-Arithmetic.ps1

. $psScriptRoot\Measure-Mass.ps1
. $psScriptRoot\Measure-Velocity.ps1

. $psScriptRoot\ConvertTo-Metric.ps1


. $psScriptRoot\Measure-Tip.ps1

. $psScriptRoot\ConvertTo-Celsius.ps1
. $psScriptRoot\ConvertTo-Fahrenheit.ps1

. $psScriptRoot\Get-RandomFlashcard.ps1

. $psScriptRoot\Measure-Interest.ps1

Set-Alias flashcard Get-Flashcard 

Export-ModuleMember -Function * -Alias *
#endregion
