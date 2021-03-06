function Invoke-Equation
{    
    <#
    .Synopsis
        Invokes a PowerShell script for an equation
    .Description
        Writes a PowerShell script for an equation.  
        To make sure that this is safe, you can only do the following things inside of a script.
                        
        Use static methods from the [Math] class.                
        Use constant numbers
        Use the following operators         
            '=','+', '-','-lt', '*', '-gt','-lt', '-ge','-le', '-ne', '-eq', '%', '/'
            
        
    .Example
        Invoke-Equation -Step { 
# Square A
$aSquared = $a * $a
# Square B
$bSquared = $b * $b
# Get the square root of the values
[Math]::Sqrt($aSquared  + $bSquared)   
        }    
    #>
    param(
    # The list of steps.  Each step's comments will become 
    [ScriptBlock[]]
    $Step,
    
    # The name of the equation.  If not directly set, the equation name will become the name of the parent function    
    [string]$EquationName,
    
    # If set, waits this amount of time between each step
    [Timespan]$WaitBetweenStep
    ) 
    
    process {

        #Region Filter out Bad Scripts
        $ok = $true
        foreach ($scriptBlock in $step) {
            $tokens = @([Management.Automation.PSParser]::Tokenize($step, [ref]$null))



            for ($i =0 ;$i -lt $tokens.Count; $i++) {
                $Token = $tokens[$i]    
                if ($token.Type -eq 'Command') { 
                    Write-Error "Cannot use commands in the filter"
                    $ok = $false
                    break
                }
                if ($token.Type -eq 'Keyword') { 
                    if ('if', 'else', 'elseif' -contains $token.Content) {
                    } 
                    Write-Error "Cannot use keywords in the filter"
                    $ok = $false
                    break
                }
                if ($token.Type -eq 'String') {
                    Write-Error "No Strings allowed"
                    $ok = $false
                    break
                }
                if ($token.Type -eq 'Type' -and ($token.Content -ne '[Math]' -and $token.Content -ne 'Math')) 
                {
                    Write-Error "Can only use the [Math] class in equations"
                    $ok = $false
                    break
                }
                if ($token.Type -eq 'Type') {
                    # Make sure the next item is a static member refrence
                    if ($i -eq ($tokens.Count - 1)) { 
                        Write-Error "May only use methods from [Math]"
                        $ok = $false
                        break
                    } else {
                        $i++
                    }
                }
                if ($token.Type -eq 'GroupStart' -and ('(','{' -notcontains $token.Content)) {
                    Write-Error "Only Parenthesis are allowed in equations"
                    $ok = $false
                    break
                }
                if ($token.Type -eq 'GroupEnd' -and (')','}' -notcontains $token.Content)) {
                    Write-Error "Only Parenthesis are allowed in equations"
                    $ok = $false
                    break
                }
                if ($token.Type -eq 'Variable' -or $Token.Type -eq 'Number' -or $token.Type -eq 'GroupEnd') {                                    
                    if (! $tokens[$i +1]) { 
                        break 
                    }           
                    $nextToken = $tokens[$i + 1]
                    $validOperators = '=','+', '-','-lt', '*', '-gt','-lt', '-ge','-le', '-ne', '-eq', '%', '/'
                    if (($nextToken.Type -ne 'Operator' -and 
                        $validOperators -notcontains $nextToken.Type) -and (
                        $nextToken.Type -ne 'Newline'                        
                        ) -and (
                        $nextToken.Type -ne 'GroupEnd'                        
                        )) {
                        Write-Error "`$$($token.Content) must be followed by one of the following operators $validOperators"
                        $ok = $false                        
                    } else {
                        $i = $i + 1
                    }                   
                }   
                if ($token.Type -eq 'Operator') {                    
                    $validOperators = '=','+', '-','-lt', '*', '-gt','-lt', '-ge','-le', '-ne', '-eq', '%', '/'
                    if ($validOperators -notcontains $token.Content) {
                        Write-Error "Unexpected Operator $($token.Content) ($($token.StartLine.ToString() +','+  $token.StartColumn)))"                   
                        $ok = $false
                        break
                    }
                }
                

            }
            foreach ($token in $tokens) { 
                
                if ($token.Type -eq 'Number') {                                    
                    if (! $foreach.MoveNext()) { 
                        break 
                    }           
                    $validOperators = '=','+', '-','-lt', '*', '-gt','-lt', '-ge','-le', '-ne', '-eq', '%', '/'
                    if (($foreach.current.Type -ne 'Operator' -and 
                        $validOperators -notcontains $foreach.current.Content) -and (
                        $foreach.current.Type -ne 'Newline'                        
                        ) -and (
                        $foreach.current.Type -ne 'GroupEnd'                        
                        )) {
                        Write-Error "`$$($token.Content) must be followed by one of the following operators $validOperators"
                        $ok = $false                        
                    }                    
                }
                
                if ($token.Type -eq 'GroupEnd') {                                    
                    if (! $foreach.MoveNext()) { 
                        break 
                    }           
                    $validOperators = '=','+', '-','-lt', '*', '-gt','-lt', '-ge','-le', '-ne', '-eq', '%', '/'
                    if (($foreach.current.Type -ne 'Operator' -and 
                        $validOperators -notcontains $foreach.current.Content) -and (
                        $foreach.current.Type -ne 'Newline'                        
                        ) -and (
                        $foreach.current.Type -ne 'GroupEnd'                        
                        )) {
                        Write-Error "`$$($token.Content) must be followed by one of the following operators $validOperators"
                        $ok = $false                        
                    }                    
                }
                 
                
                
                                                            
            }
        }                   
        
        
        if (-not $Ok) { return }
        #Endregion Filter out Bad Scripts
        
        #region Combine Scripts and get steps/explanations
        $text = $combinedScript = $step -join ([Environment]::NewLine)
        
        $tokens  = [Management.Automation.PSParser]::Tokenize($combinedScript, [ref]$null)
        $work = & { 
            $lastResult = @{Explanation=""}
            foreach ($token in $tokens) {        
                if ($token.Type -eq "Newline") { continue }
                if ($token.Type -ne "Comment" -or $token.StartColumn -gt 1) {
                    $isInContent = $true
                    if (-not $lastToken) { $lastToken = $token } 
                } else {
                    if ($lastToken.Type -ne "Comment" -and $lastToken.StartColumn -eq 1) {
                        $chunk = $text.Substring($lastToken.Start, 
                            $token.Start - 1 - $lastToken.Start)
                        $lastResult.Script = [ScriptBlock]::Create($chunk)
                        # mutliparagraph, split up the results if multiparagraph
                        
                        $paragraphs = @()    
                        $lastResult.Explanation = $lastResult.Explanation.trim()                
                        New-Object PSObject -Property $lastResult                    
                        $null = $paragraphs
                        $lastToken = $null
                        $lastResult = @{Explanation="";}
                        $isInContent = $false                
                    }
                }
                if (-not $isInContent) {
                    $lines = $token.Content.Trim("<>#")
                    $lines = $lines.Split([Environment]::NewLine, [StringSplitOptions]"RemoveEmptyEntries")
                    foreach ($l in $lines) {
                        switch ($l) {                                                   
                            default {
                                $lastResult.Explanation += ($l + [Environment]::NewLine)                        
                            }
                        }
                    }
                }                    
            }
            
            if ($lastToken -and $lastResult) {
                
                $chunk = $text.Substring($lastToken.Start)
                $lastResult.Explanation = $lastResult.Explanation.trim()                
                $lastResult.Script = [ScriptBlock]::Create($chunk)
                New-Object PSObject -Property $lastResult
            } elseif ($lastResult) { 
                $lastResult.Explanation = $lastResult.Explanation.trim()                
                New-Object PSObject -Property  $lastResult
            }
        }
        #endregion Combine Scripts and get steps/explanations
        
        #region Determine Equation Name
        if (-not $psBoundParameters.ContainsKey('EquationName')) {
            $EquationName = Get-PSCallStack | 
                Select-Object -Skip 1 -First 1 -ExpandProperty Command
        }
        #endregion Determine Equation Name
        
        #region Walk thru the equation
        $totalStepCount = @($work).Count
        foreach ($equationStep in $work) {
            Write-Progress "$EquationName " "$($equationStep.Explanation)" 
            $stepNumber++            
            $stepResult = New-Object PSObject -Property @{
                Number = $stepNumber
                Step = "$($equationStep.Explanation)"
                Script = $equationStep.Script
                Result =  . $equationStep.Script
            }            
            if ($stepResult.Result -eq $null) {
                $tokens =[MAnagement.Automation.PSParser]::Tokenize(
                    $equationStep.Script,
                    [ref]$null)
                for ($i =0; $i -lt $tokens.Count; $i++) {
                    $t = $tokens[$i]                    
                    if ($t.Type -eq 'NewLine') { continue }
                    if ($t.Type -eq 'Variable') {
                        $next = $tokens[$i+1]
                        if ($next.Type -eq 'Operator' -and ('=', '+=', '-=', '/=', '*=', '%=' -contains $next.Content)) {
                            $stepResult.Result = Invoke-Expression "`$$($t.Content)"
                        }
                    }
                }
            }            
            $null =$stepResult.pstypenames.Clear()
            $null = $stepResult.pstypenames.add('MathStep')
            if ($showWork) { $stepResult } 
            if ($stepNumber -eq $totalStepCount) {
                if ($showWork) {
                    $result = 
                        New-Object PSOBject -Property @{
                            Number = $stepNumber + 1
                            Step = "Done"
                            Script = ""                            
                            Result = $stepResult.Result
                        }
                    $null = $result.pstypenames.Clear()
                    $null = $result.pstypenames.add('MathResult')
                    $result
                } else {
                    $stepResult.Result
                }                        
            }
            
            
            if ($waitBetweenStep -and $waitBetweenStep.TotalMilliseconds) {
                Start-Sleep -Milliseconds $WaitBetweenStep.TotalMilliseconds
            }
        }
        #endregion
    }
} 
