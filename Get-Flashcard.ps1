function Get-Flashcard
{
    <#
    .Synopsis
        Gets flashcards
    .Description
        Generates flashcards for a given grade level
    #>
    param(
    # The grade level for the flashcard
    #|Default 3rd
    [Parameter(Mandatory=$true,Position=0, ValueFromPipeline=$true)]
    [ValidateSet("1st", "2nd",  "3rd", "4th", "5th",  "6th", "7th")]
    [string]
    $GradeLevel
    )
 

    process {
        $TheFlashcard = @{
            Operator = $null
            FirstNumber = $null
            SecondNumber = $null
            Answer = $null
            Question = $null
            Maximum = 10
            DecimalPlaces = 0
            GradeLevel = $GradeLevel
        } 

 
        if ($GradeLevel -eq "1st") {

            $TheFlashcard.Operator = "+"  | Get-Random
            $TheFlashcard.Maximum = 10
            $TheFlashcard.DecimalPlaces = 0

        } elseif ($GradeLevel -eq "2nd") {
        
            $TheFlashcard.Operator = "+", "-" | Get-Random
            $TheFlashcard.OperatorChoices = "+", "-"
            $TheFlashcard.Maximum = 25
            $TheFlashcard.DecimalPlaces = 0

        } elseif ($GradeLevel -eq "3rd") {        

            $TheFlashcard.Operator = "+", "-",  "*" | Get-Random
            $TheFlashcard.OperatorChoices = "+", "-",  "*"
            $TheFlashcard.Maximum = 50
            $TheFlashcard.DecimalPlaces = 0

        } elseif ($GradeLevel -eq "4th") {
       
            $TheFlashcard.Operator = "+", "-",  "*", '/' | Get-Random
            $TheFlashcard.OperatorChoices = "+", "-",  "*", "/"
            $TheFlashcard.Maximum = 100  
            $TheFlashcard.DecimalPlaces = 0

        } elseif ($GradeLevel -eq "5th") {
        
            $TheFlashcard.Operator = "+", "-",  "*", '/' | Get-Random
            $TheFlashcard.OperatorChoices = "+", "-",  "*", "/"
            $TheFlashcard.WholeNumbersOnly = $false
            $TheFlashcard.Maximum = 300
            $TheFlashcard.DecimalPlaces = 1

        } elseif ($GradeLevel -eq "6th") {        

            $TheFlashcard.Operator = "+", "-",  "*", '/' | Get-Random
            $TheFlashcard.OperatorChoices = "+", "-",  "*", "/"
            $TheFlashcard.WholeNumbersOnly = $false
            $TheFlashcard.Maximum = 1000
            $TheFlashcard.DecimalPlaces = 2

        } elseif ($GradeLevel -eq "7th") {

          
            $TheFlashcard.Operator = "+", "-",  "*", '/' | Get-Random
            $TheFlashcard.OperatorChoices = "+", "-",  "*", "/"
            $TheFlashcard.WholeNumbersOnly = $false
            $TheFlashcard.Maximum = 5000
            $TheFlashcard.DecimalPlaces = 2

        }

        $haveAnAnswer = $false
 
        do {
            $multiplyBy = if ($TheFlashcard.DecimalPlaces) {
                [Math]::Pow(10, $TheFlashcard.DecimalPlaces)
            } else {
                1
            }

            $TheFlashcard.FirstNumber = [Math]::Round(((Get-Random -Maximum ($TheFlashcard.Maximum * $multiplyBy))) / $multiplyBy, $TheFlashcard.DecimalPlaces)
            $TheFlashcard.SecondNumber  = [Math]::Round(((Get-Random -Minimum 1   -Maximum ($TheFlashcard.Maximum * $multiplyBy))) / $multiplyBy, $TheFlashcard.DecimalPlaces)
            $script = [ScriptBlock]::Create("$($TheFlashcard.FirstNumber) $($TheFlashcard.Operator) $($TheFlashcard.SecondNumber)")

            Write-Verbose "$script"

            $theAnswer = Invoke-Arithmetic -Arithmetic $script

            $haveAnAnswer = $true

            if (!  $TheFlashcard.DecimalPlaces) {
                if ([Math]::Round($theAnswer, $TheFlashcard.DecimalPlaces) -ne $theAnswer) {
                    $haveAnAnswer = $false                        
                }  
            }

            
        } while (-not $haveAnAnswer ) 

        Write-Verbose "Answer Found"

        # If DropItem is 1, drop the operator

        # If DropItem is 2, drop the first number

        # If DropItem is 3, drop the second number

        # If DropItem is 4, drop the answer

 

 

        if ("1st", "5th",  "6th", "7th" -notcontains $GradeLevel) {
          
            # First grade only drops one part of the question
            $dropItem = Get-Random -Minimum 2 -Maximum  4         

        } else {

            # All other grades can drop any item
            $dropItem = Get-Random -Minimum 1 -Maximum  4

        }      

        $wordQuestion  = $false

        if ("3rd", "4th",  "5th", "6th", "7th" -contains $GradeLevel) {
            $wordQuestion = ([Math]::Round((Get-Random -Maximum 10)/10)) -as [Bool]
        }

        $friendlyOperatorName  = {
            param($op)

            if ($op  -eq '+') {
                'plus',  'and'
            } elseif ($op -eq '-')  {
                'minus'
            } elseif ($op -eq '/') {
                'divided by', 'into' 
            } elseif ($op -eq '*') {
                'multiplied by', 'times' 
            }
        }

 
        if ($wordQuestion) {
            $friendly = & $friendlyOperatorName $theFlashCard.Operator | Get-Random
            if ($dropItem -eq 1) {
            
                $question = "$($TheFlashcard.FirstNumber) __ $($TheFlashcard.SecondNumber) is $TheAnswer"
                $answer = $theFlashCard.Operator
            
            } elseif ($dropItem -eq 2) {           
                
                $question = "__ $friendly $($TheFlashcard.SecondNumber) is $TheAnswer"
                $answer = $theFlashCard.FirstNumber
            
            } elseif ($dropItem -eq 3) {

                $question = "$($TheFlashcard.FirstNumber) $friendly __ = $TheAnswer"
                $answer = $theFlashCard.SecondNumber

            } elseif ($dropItem -eq 4) {

                $question = "$($TheFlashcard.FirstNumber) $friendly $($TheFlashcard.SecondNumber) = __"
                $answer = $theAnswer

            }

        } else {

            if ($dropItem -eq 1) {

                $question = "$($TheFlashcard.FirstNumber) __ $($TheFlashcard.SecondNumber) = $TheAnswer"

                $answer = $theFlashCard.Operator

            } elseif ($dropItem -eq 2) {

                $question = "__ $($theFlashcard.Operator) $($TheFlashcard.SecondNumber) = $TheAnswer"

                $answer = $theFlashCard.FirstNumber

            } elseif ($dropItem -eq 3) {

                $question = "$($TheFlashcard.FirstNumber) $($theFlashcard.Operator) __ = $TheAnswer"

                $answer = $theFlashCard.SecondNumber

            } elseif ($dropItem -eq 4) {

                $question = "$($TheFlashcard.FirstNumber) $($theFlashcard.Operator) $($TheFlashcard.SecondNumber) = __"

                $answer = $theAnswer

            }

        }

        $theFlashCard = New-Object PSObject -property $TheFlashcard 
        $theFlashCard = $theFlashCard | 
            Add-Member NoteProperty Question $question -Force -PassThru |
            Add-Member NoteProperty Answer $answer -Force -PassThru 


        $TheFlashcard.pstypenames.clear()
        $TheFlashcard.pstypenames.add('formulaic.flashcard')
        $TheFlashcard

    }

} 
 
