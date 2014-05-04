function Measure-Correlation
{
    
    param(
    # The input object
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [PSObject[]]
    $InputObject,

    # If set, will not show progress
    [Switch]
    $HideProgress
    )


    begin {
        $allObjects = @()
        $propertyTotals = @{}
        $propertyCounts = @{}
        $propertyUnits = @{}
        if (-not $HideProgress) {
            $progressId = Get-Random
        }
    }
    
    process {
        # We need to collect all objects, but we can do the first bit of math while we're at it:
        # To get the average of the objects, we need their totals and counts, so pick that up on the way
        $allObjects += $InputObject

        if (-not $HideProgress) {
            Write-Progress "Accumulating Input and Totaling Data" $allObjects.Count -Id $progressId
        }

        foreach ($in in $InputObject) {
            foreach ($property in $in.psobject.properties) {
                if ($property.Value -as [float] -ne $null) {
                    if (-not $propertyCounts[$property.Name]) {
                        $propertyTotals[$property.Name] = 0
                        $propertyCounts[$property.Name] = 0 
                    }
                    $propertyCounts[$property.Name]++
                    $propertyTotals[$property.Name]+=($property.Value -as [float])
                }
            }
        }
        
    }

    end {
        # Now that we've got all the data, calculate the average without making a pass thru the data
        if (-not $HideProgress) {
            Write-Progress "Averaging Input" " " -Id $progressId
        }

        $propertyAverages = @{}
        foreach ($kv in $propertyCounts.GetEnumerator()) {
            $propertyAverages[$kv.Key] = $propertyTotals[$kv.Key] / $propertyCounts[$kv.Key]
        }

        # To get the standard deviation, we need to total the deviation from each property from the average
        # This requires us to make our second pass thru the data
        $deviationTotals =  @{}
        $allObjectCount = $allObjects.Count
        $iterator = 0
        foreach ($object in $allObjects) {
            if (-not $HideProgress) {
                $iterator++
                $perc = ([float]$iterator/$allObjects.Count) * 100
            }
            

            foreach ($key in $propertyAverages.Keys) {
                $value = $object.psobject.properties[$key]
                if (-not $value) {continue }

                if (-not $HideProgress) {
                    Write-Progress "Calculating Standard Deviations" "$key" -Id $progressId -PercentComplete $perc 
                }

                $deviation = $Value.Value - $propertyAverages[$key]
                if (-not $deviationTotals[$key]) {
                    $deviationTotals[$key] = 0
                }
                $deviationTotals[$key] += [Math]::Pow($deviation, 2)
            }
        }

        # Now take the deviation totals, divide by the number of each item, and calculate the standard deviation
        $StandardDeviations = @{}
        foreach ($deviation in $deviationTotals.GetEnumerator()) {
            $standardDeviation = 
                [Math]::Sqrt($deviation.Value / $propertyCounts[$deviation.Key])
            $StandardDeviations[$deviation.Key] = $standardDeviation
        }


        # To calculte the correlation of any two sets of data, we need to convert each observation into a standard unit
        # A standard unit is the data distance of each point, divided by the standard deviation for that data
        # While we're doing this, we get to do the "fun" and expansive part:
        #     Taking each combination of factors and calculating the delta of the standard units, or the correlation
        


        $correlationTotals = @{}
        $correlationCounts = @{}

        $iterator = 0
        foreach ($object in $allObjects) {
            if (-not $HideProgress) {
                $iterator++
                $perc = ([float]$iterator/$allObjects.Count) * 100
            }
            $properties = @($object.psobject.properties | Select-Object -ExpandProperty Name)
            
            $correlationsInObject = @{}
            $valuesInStandardUnits = @{}

            foreach ($prop in $properties) {
                if (-not $object.psobject.properties[$prop]) { continue } 
                if ($standardDeviations[$prop]) {
                    if (-not $HideProgress) {
                        Write-Progress "Computing Standard Units" "$prop" -Id $progressId -PercentComplete $perc 
                    }
                    $valuesInStandardUnits[$prop] = ($object.$prop - $propertyAverages[$prop]) / $StandardDeviations[$prop]
                }
            }

            for ($i = 0; $i -lt $properties.Count;$i++) {
                if (-not $propertyAverages[$properties[$i]]) { continue }
                for($j = 0; $j -lt $properties.Count;$j++) {
                    if ($j -eq $i) { continue } # Skip comparing with itself
                    if (-not $propertyAverages[$properties[$j]]) { continue }
                    
                    $correlationName = @($properties[$i], $properties[$j] | Sort-Object ) -join " x " 
                    if ($correlationsInObject[$correlationName]) { continue } # Already computed?
                    if (-not $HideProgress) {
                        Write-Progress "Correlating" "$correlationName" -Id $progressId -PercentComplete $perc 
                    }
                    $correlationsInObject[$correlationName] = 
                        $valuesInStandardUnits[$properties[$i]] * $valuesInStandardUnits[$properties[$j]] 
                    if (-not $correlationCounts[$correlationName]) {
                        $correlationCounts[$correlationName] = 0
                        $correlationTotals[$correlationName] = 0
                    }
                    $correlationCounts[$correlationName]++
                    $correlationTotals[$correlationName] += $correlationsInObject[$correlationName]
                }
            }
        }
        
        $correlations = @{}


        $total = $correlationCounts.Count
        $iterator =0 
        # Finally, each correlation should be averaged to produce a result
        foreach ($cc in $correlationCounts.GetEnumerator()) {
            if (-not $HideProgress) {
                $iterator++
                $perc = ([float]$iterator / $total) * 100
                Write-Progress "Averaging Correlations" $cc.Key -Id $progressId -PercentComplete $perc 
            }
            $correlations[$cc.Key] = $correlationTotals[$cc.Key] / $cc.Value 
        }

        if (-not $HideProgress) {
            Write-Progress "Outputting Correlations" " " -Id $progressId -Completed
        }

        New-Object PSObject -Property $correlations



    }
}