# Define the APIs that will be included in the search in a hashtable

$includedAPIs = @{
    "4d01fdc5-bd92-4ec6-bb0b-78c16d1c125e" = "graphAPI";
    "17c5b195-0f56-4fde-8b02-021548a7c3ca" = "Microsoft Mixed Reality"
}


$count = 0
ForEach ($API in $includedAPIs.GetEnumerator()) {
    $count++
    $count    
    # Write-Host "$($API.Name): $($API.Value)"
    # $($API.Name).GetType()
    # $($API.Value)
    $servicePrincipal = Get-MgServicePrincipal -ServicePrincipalId $($API.Name)
    Write-Host $servicePrincipal.AppRoles.Value $servicePrincipal.DisplayName 
    
}