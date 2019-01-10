#
# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for full license information.
#

# Input bindings are passed in via param block.
param($req)

# You can write to the Azure Functions log streams as you would in a normal PowerShell script.
Write-Verbose "PowerShell HTTP trigger function processed a request." -Verbose

# You can interact with query parameters, the body of the request, etc.
$name = $req.Query.Name
if (-not $name) { $name = $req.Body.Name }

if($name) {
    # Cast the value to HttpResponseContext explicitly.
    Push-OutputBinding -Name res -Value ([HttpResponseContext]@{
        StatusCode = 202
        Body = GetHelloName -Name $name
    })
}
else {
    # Convert value to HttpResponseContext implicitly for 'http' output.
    Push-OutputBinding -Name res -Value @{
        StatusCode = "400"
        Body = "Please pass a name on the query string or in the request body."
    }
}
