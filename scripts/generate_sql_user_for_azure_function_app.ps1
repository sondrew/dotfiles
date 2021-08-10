if (!$args[0]) {
    Write-Host "Call script with Azure Function App name as argument"
    exit
}

function ConvertTo-Sid {
    param (
        [string]$appId
    )
    [guid]$guid = [System.Guid]::Parse($appId)
    foreach ($byte in $guid.ToByteArray()) {
        $byteGuid += [System.String]::Format("{0:X2}", $byte)
    }
    return "0x" + $byteGuid
}

# Input the Azure subcription of your Function App
$azureSubcription=""

az account set -s $subscription

$servicePrincipals = az ad sp list --display-name $args[0] | ConvertFrom-Json
$appId = $servicePrincipals[0].appId

$sid = ConvertTo-Sid $appId

Write-Host "Azure Function App: $($args[0])" -ForegroundColor green
Write-Host "Application Id: $($appId)" -ForegroundColor green
Write-Host "Secure Identifier (SID): $($sid)" -ForegroundColor green

Write-Host "`r`n`r`nUse this SQL query to give your Function App access to an SQL database:"
Write-Host "
BEGIN TRANSACTION
-- Check db users and roles before giving Function App access
SELECT princ.name
,      princ.type_desc
,      perm.permission_name
,      perm.state_desc
,      perm.class_desc
,      object_name(perm.major_id)
FROM sys.database_principals princ
LEFT JOIN sys.database_permissions perm
ON        perm.grantee_principal_id = princ.principal_id

SELECT * FROM [sys].[sysusers]

-- Give Function App a db user with db owner access
CREATE USER [$($args[0])] WITH DEFAULT_SCHEMA=[dbo], SID=$($sid), TYPE=E 
ALTER ROLE db_owner ADD MEMBER [$($args[0])]

-- Check db users and roles after giving Function App access
SELECT princ.name
,      princ.type_desc
,      perm.permission_name
,      perm.state_desc
,      perm.class_desc
,      object_name(perm.major_id)
FROM sys.database_principals princ
LEFT JOIN sys.database_permissions perm
ON        perm.grantee_principal_id = princ.principal_id

SELECT * FROM [sys].[sysusers]

-- Change to COMMIT after checking everything looks in order
ROLLBACK TRANSACTION
" -ForegroundColor yellow
