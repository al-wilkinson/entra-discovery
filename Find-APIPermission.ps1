# Define the APIs that will be included in the search in a hashtable
$includedAPIs = @{
    "4d01fdc5-bd92-4ec6-bb0b-78c16d1c125e" = "graphAPI";
    "17c5b195-0f56-4fde-8b02-021548a7c3ca" = "Microsoft Mixed Reality"
}

# count just to help me figure out the output.
$count = 0
ForEach ($API in $includedAPIs.GetEnumerator()) {
    $count++
    # Because the next line requires a call to Entra we only want to do it once
    # Maybe make the servicePrincipal variable an array. Loop through one time to populate, one time for searching?
    $servicePrincipal = Get-MgServicePrincipal -ServicePrincipalId $($API.Name)
    # Loop through and output all the application scopes.  Wish Microsoft wouldn't use "role" here and scope or permission in docco/portal.    
    ForEach ($appRole in $servicePrincipal.AppRoles) {
        Write-Host $count $appRole.value $appRole.Id $servicePrincipal.DisplayName 
    }    
    
}