function Get-RandomFlashcard
{
    <#
    .Synopsis
        Gets a random flashcard
    .Description
        Gets a random flashcard for grades 1-4
    #>
    param(
    )

    $gradeLevel = '1st', '2nd', '3rd', '4th' | Get-Random

    Get-Flashcard -GradeLevel $gradeLevel 
} 
