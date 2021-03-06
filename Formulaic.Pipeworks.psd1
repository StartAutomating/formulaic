@{
    WebCommand = @{        
        'Get-Average' = @{
            FriendlyName = "Average Calculator"
        }
        'Get-CircleArea' = @{            
            FriendlyName = "Circle Area"
        }
        'Get-Flashcard' = @{
            FriendlyName = "Get Flashcard"
        }
        'ConvertTo-Metric' = @{            
            FriendlyName = "Metric Converter"
        }
        'ConvertTo-Fahrenheit' = @{
            FriendlyName = 'Celsius to Fahrenheit'
        }
        'ConvertTo-Celsius' = @{
            FriendlyName = 'Fahrenheit to Celsius'            
        }
        'Get-CircleCircumference' = @{
            FriendlyName = "Circumference"
        }
        'Get-EllipseArea' = @{            
            FriendlyName = "Ellipse Area"
        }
        'Get-ParallelogramArea' = @{                       
            FriendlyName = "Parallelogram Area" 
        }
        'Get-RectangleArea' = @{                 
            FriendlyName = "Rectangle Area" 
        }
        'Get-RectanglePerimeter' = @{                     
            FriendlyName = "Rectangle Perimeter" 
        }
        'Get-SquareArea' = @{                
            FriendlyName = "Square Area"
        }
        'Get-SquarePerimeter' = @{                        
            FriendlyName = "Square Perimeter"
        }
        'Get-TrapezoidArea' = @{                   
            FriendlyName = "Trapezoid Area"
        }
        'Get-TriangleArea' = @{                     
            FriendlyName = "Triangle Area"
        }
        'Get-Angle' = @{
            FriendlyName = 'Calulate an Angle'
        }
        'Get-TrianglePerimeter' = @{                      
            FriendlyName = "Triangle Perimeter"
        }
        'Get-TriangleSide' = @{                 
            FriendlyName = "Triangle Sides"
        }
        'Measure-Mass' = @{                      
            FriendlyName = "Measure Mass"
        }
        'Measure-Velocity' = @{
            FriendlyName = "Measure Velocity"
        }
        'Measure-Tip' = @{
            FriendlyName = 'Tip Calculator'
        }
        'Measure-Interest' = @{
            FriendlyName = 'Interest Calculator'
        }
        'Get-StandardDeviation' = @{
            FriendlyName = 'Standard Deviation'
        }
        "Invoke-Arithmetic" = @{
        
            
            FriendlyName = "Online Calculator"
        }
        "Get-RandomFlashcard" = @{
            Hidden = $true
            FriendlyName = "Random Flashcards"
            RunWithoutInput = $true
        }
        'Measure-Correlation' = @{
            FriendlyName = "Measure Correlatations"
            HideParameter = 'HideProgress'
            ParameterDefaultValue = @{
                HideProgress = $true
            }
        }
        'Optimize-Fraction' = @{
            FriendlyName = 'Simplify Fractions'
        }
       
    }    
    Style = @{
        Body = @{
            'Font' = "Segoe UI, Arial, Helvetica"                        
            'color' = '#560606'
            'background-color' = '#fafafa'
        }

        'a' = @{
            'color' = '#560606'
        }
        'a:hover' = @{
            'text-decoration' ='none'
        }
    }

    Group = @{        
        "Geometry" = "Get-CircleArea", "Get-CircleCircumference", "Get-EllipseArea", "Get-ParallelogramArea", 
            "Get-RectangleArea", "Get-RectanglePerimeter", "Get-SquareArea", "Get-SquarePerimeter", 
            "Get-TriangleArea", "Get-TriangleSide", "Get-TrianglePerimeter", "Get-TrapezoidArea", "Get-Angle"        
    }, @{    
        "Physics" = "Measure-Mass", "Measure-Velocity"
    }, @{
        "Statistics" = "Get-Average", "Get-StandardDeviation", "Measure-Correlation"
    }, @{
        "Converters" = "ConvertTo-Metric", "ConvertTo-Celsius", "ConvertTo-Fahrenheit"
    }, @{
        "Calculators" = "Invoke-Arithmetic", "Measure-Tip", "Measure-Interest", "Optimize-Fraction"
        "Flashcards" = "Get-Flashcard"
    }, @{
        "About Formulaic" = "About Formulaic", "Math as a Service"
    }

        
        
        
        

    

    Logo = "/Formulaic_125_125.png"
    AnalyticsId = 'UA-24591838-11' 
    DomainSchematics = @{
        "get-math.com | www.get-math.com | get-formula.com | www.get-formula.com" = "Default"
    }
    JQueryUITheme = 'Custom'

    CommandTrigger = @{
        "Shake" = "Get-RandomFlashcard"
    }

    AdSense = @{
        Id = '7086915862223923'
        BottomAdSlot = '6352908833'
        TopAdSlot = '7470868750'
    }


    PubCenter = @{
        ApplicationId = "a3cfb4a0-b6ad-46c5-939a-19c977d19ee9"
        BottomAdUnit = "10048316"
    }    

    Win8 = @{
        Identity = @{
            Name="Start-Automating.Formulaic"
            Publisher="CN=3B09501A-BEC0-4A17-8A3D-3DAACB2346F3"
            Version="1.0.0.0"
        }


        Assets = @{
            "splash.png" = "/Formulaic_Splash.png"
            "smallTile.png" = "/Formulaic_Small.png"
            "wideTile.png" = "/Formulaic_Wide.png"
            "storeLogo.png" = "/Formulaic_Store.png"
            "squaretile.png" = "/Formulaic_Tile.png"
        }
        ServiceUrl = "http://get-math.com"

        Name = "Formulaic"
        PublishedUrl = 'http://apps.microsoft.com/windows/app/formulaic/5326b163-7247-4103-96e8-425c960364ff'
    }

    GitHub = @{
        Owner = "StartAutomating"
        Project = "formulaic"
        Url = 'https://github.com/StartAutomating/formulaic'
    }

    SecureSetting = 'AzureStorageAccountName', 'AzureStorageAccountKey', 'WolframAlphaApiKey'

    AllowDownload = $true


    Technet = @{
        Category="Scripting Techniques"
        Subcategory="Writing Scripts"
        OperatingSystem="Windows 7", "Windows Server 2008", "Windows Server 2008 R2", "Windows Vista", "Windows Server 2012", "Windows 8", "Windows XP"
        Tag ='Pipeworks', 'Start-Automating', 'Math', 'Physics', 'Statistics', 'Geometry'
        MSLPL=$true
        Summary="
Formulaic is a PowerShell module for math, physics, and statistics functions.   
"
        Url = 'http://gallery.technet.microsoft.com/Formulaic-8a0879f5'
    }
} 
