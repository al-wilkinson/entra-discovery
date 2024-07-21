## Introduction
The issue we're trying to address with this function is that to be able to report on all _application_ API scopes assigned to a service principal we really would like to be able to provide a meaningful, human readable name eg ```Office 365 Exchange Online``` and not ```00000002-0000-0ff1-ce00-000000000000```.

The [Find-MgGraphPermission](https://learn.microsoft.com/en-us/powershell/microsoftgraph/find-mg-graph-permission?view=graph-powershell-1.0) command makes this relatively easy for Graph API permissions.  Use this together with [Get-MGServicePrincipalAppRoleAssignment](https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.applications/get-mgserviceprincipalapproleassignment?view=graph-powershell-1.0) as in the code block below:

```
# We'll just create a test Azure App Reg, assign it some permissions and blow it away to illustrate this.
# Get the service principal object
$servicePrincipal = Get-MgServicePrincipal | Where-Object { $_.DisplayName -eq "Temp Test App" }

$scopesAssigned = Get-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id 

ForEach ($scope in $scopesAssigned) { 
    $scopeObject = (Find-MgGraphPermission | Where-Object { $_.Id -eq $scope.AppRoleId })
    Write-Host $scopeObject.Name $scopeObject.Id
}
```

In order to develop a function that will return the scope names for non Graph API scopes paradoxically, we will use Graph API. This is because we are working in a test tenant with no licenses applied so the objects for Exchange Online etc are not present.
```
# Load the service principal object into a variable.  In this case Microsoft Graph.
$graphSPN = Get-MgServicePrincipal | Where-Object { $_.DisplayName -like "Microsoft Graph*" }  

# Say we want to return the scope name for Group.Read.All which is 5b567255-7703-4780-807c-7be8301ae99b
($graphSPN.AppRoles | Where-Object { $_.Id -eq "5b567255-7703-4780-807c-7be8301ae99b" } ).Value   
```

We can, in effect, write our own extended version of ```Find-MgGraphPermission``` by deciding which APIs we want to include, loading their service principal objects into variables and then searching as in the final line of the above code snippet.