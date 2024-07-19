# Because these are the bits I forget

We'll be using the Microsoft.Graph module primarily in PowerShell core.  Check it is installed:
```get-module -ListAvailable -Name "Microsoft.Graph"```
or
```get-module -ListAvailable | Where-Object { $_.Name -like 'Microsoft.Graph.*' }```

Also, we'll use the Microsoft.Graph.Entra module.  At the time of writing in July 2024 this requires the AllowPrelease switch:
```Install-Module Microsoft.Graph.Entra -Repository PSGallery -AllowPrerelease -Scope CurrentUser -Force```
