function ConvertTo-Metric
{
    <#
    .Synopsis
        Converts units from imperial to metric
    .Description
        Converts a variety of units from imperial to metric  
    .Example
        ConvertTo-Metric 1 pound  
    #>
    [OutputType([PSObject])]
    param(
    # The value to convert into metric
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
    [Double]$Value,
    # The unit the value is in
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=1)]
    [ValidateSet('Inch','Inches','Foot','Feet','Yard','Yards','Mile','Miles', 'Pound', 'Pounds', 'Lb', 'Lbs', 'In', 'Mi', 'Ft')]
    [string]$Unit   
    )
        
    process {
        switch ($unit) {
            { 'Inch', 'Inches', 'In' -contains $_ } {                
                New-Object PSObject |
                    Add-Member NoteProperty mm ($value * 25.4) -PassThru |
                    Add-Member NoteProperty cm ($value * 2.54) -PassThru |
                    Add-Member NoteProperty m ($value * .0254) -PassThru |
                    Add-Member NoteProperty km ($value * .0000254) -PassThru 
            }
            { 'Foot', 'Feet', 'Ft' -contains $_ } {
                New-Object PSObject |
                    Add-Member NoteProperty mm ($value * 304.8) -PassThru |
                    Add-Member NoteProperty cm ($value * 30.48) -PassThru |
                    Add-Member NoteProperty m ($value * .3048) -PassThru |
                    Add-Member NoteProperty km ($value * .0003048) -PassThru 
            }
            { 'Yard', 'Yards' -contains $_ } {
                New-Object PSObject |
                    Add-Member NoteProperty km ($value * .0009144) -PassThru |
                    Add-Member NoteProperty m ($value * .9144) -PassThru |
                    Add-Member NoteProperty cm ($value * 91.44) -PassThru |
                    Add-Member NoteProperty mm ($value * 914.4) -PassThru                   
                    
            }
            { 'Mile', 'Miles', 'Mi' -contains $_ } {
                New-Object PSObject |
                    Add-Member NoteProperty km ($value * 1.609) -PassThru |
                    Add-Member NoteProperty m ($value * 1609) -PassThru |
                    Add-Member NoteProperty cm ($value * 160900) -PassThru |
                    Add-Member NoteProperty mm ($value * 1609000) -PassThru                                                           
            }
              
            
            { 'Pound', 'Pound', 'Lbs', 'Lb' -contains $_ }  {
                New-Object PSObject |
                    Add-Member NoteProperty mg ($value * 4536000) -PassThru |                                                         
                    Add-Member NoteProperty g ($value *  4536) -PassThru |
                    Add-Member NoteProperty kg ($value *  .4536 ) -PassThru
            }
            
            { 'Ton', 'Tons', 'Tn' -contains $_ }  {
                New-Object PSObject |
                    Add-Member NoteProperty mg ($value * 900000000) -PassThru |                                                         
                    Add-Member NoteProperty g ($value *  900000) -PassThru |
                    Add-Member NoteProperty kg ($value *  900 ) -PassThru
            }                       
        }
    }
} 
