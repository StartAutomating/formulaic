function Invoke-Arithmetic
{
    <#
    .Synopsis
        Does simple arithmetic
    .Description
        Does simple arithmetic
    .Example
        Invoke-Arithmetic { 1 + 1} 
    .Example
        Invoke-Arithmetic { 10 %2 } 
    #>        
    param(
    # Simple arithmetic, like:
    # 1+1
    # 2*20
    # 10/2
    # 20-1
    [Parameter(Mandatory=$true,Position=0)]
    [ScriptBlock]$Arithmetic
    )
    
    process {   
    
        $dsb = "data { $arithmetic }"
        Invoke-Expression $dsb
        
    }
} 
