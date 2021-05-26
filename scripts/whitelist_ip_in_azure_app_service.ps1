# Azure CLI documentation for access restriction:
# https://docs.microsoft.com/en-us/cli/azure/webapp/config/access-restriction

if (!$args[0]) {
    Write-Host "Call script with device name as first argument"
    Write-Host "Optional second argument can specify IP, otherwise IP of this device is used"
    Write-Host "Use argument 'help' for more info"
    exit
}

if ($args[0] -eq "help") {
    Write-Host "MyB whitelisting script`r`n"
    Write-Host "Pass your device name as the first argument to the script (e.g robert-home)"
    Write-Host "Use optional second argument to specify IP other than this device to whitelist`r`n"
    Write-Host "If your IP is already whitelisted, nothing happens"
    Write-Host "If your IP is not whitelisted and device name does not exist, the IP is whitelisted with given name"
    Write-Host "If your IP is not whitelisted but device name already exist, the existing access is removed and a new is added`r`n"
    Write-Host "Happy developing :D"
    exit
}

$subscription=""
$resourceGroup=""
$appService=""
$userIp = ""

if (!$args[1]) {
    $userIp = (Invoke-WebRequest -uri "https://ifconfig.me/ip").Content
    Write-Host "Using local device IP '$($userIp)'`r`n"
} elseif ([ipaddress]::TryParse($args[1], [ref][ipaddress]::Loopback)) {
    $userIp = $args[1]
    Write-Host "Using given IP '$($userIp)'`r`n"
} else {
    $userIp = $args[1]
    Write-Host "Error: Second argument '$($userIp)' is not a valid IP" -ForegroundColor red
    exit
}


function ConfigureDeviceAccessForResource{
    Param([String]$resourceName, [String]$appService, [String]$ip, [String]$deviceName)

    $userIpHasAccess = CheckIfIpIsWhitelisted $resourceName $appService $ip
    $deviceNameHasAccess = CheckIfNameIsWhitelisted $resourceName $appService $deviceName

    if ($userIpHasAccess) {
        Write-Host "IP is already whitelisted in $($resourceName)" -ForegroundColor green
    } else {
        Write-Host "IP is not whitelisted in $($resourceName)"
        if ($deviceNameHasAccess) {
            Write-Host "There's an existing whitelisting for device name $($deviceName) with different IP"
            Write-Host "Removing existing access device with this name"
            $removeExistingAccess = RemoveDeviceWhitelisting $resourceName $appService $deviceName
            if (!$removeExistingAccess) {
                Write-Host "Error: Removing device access failed" -ForegroundColor red
                exit
            } else {
                Write-Host "Success: Existing device with this name removed" -ForegroundColor green
                $addDeviceAccess = AddDeviceToWhitelist $resourceName $appService $deviceName $ip
                if (!$addDeviceAccess) {
                    Write-Host "Error: Adding device to whitelist failed" -ForegroundColor red
                    exit
                } else {
                    Write-Host "Success: Device $($deviceName) with IP $($ip) whitelisted in $($appService)" -ForegroundColor green
                }
            }
        } else {
            Write-Host "There's no existing whitelisting for device with name $($deviceName)"
            Write-Host "Adding device to whitelist"
            $addNewDeviceAccess = AddDeviceToWhitelist $resourceName $appService $deviceName $ip
            if (!$addNewDeviceAccess) {
                Write-Host "Error: Adding device to whitelist failed" -ForegroundColor red
                exit
            } else {
                Write-Host "Success: Device $($deviceName) with IP $($ip) whitelisted in $($appService)" -ForegroundColor green
            }
        }
    }
    Write-Host ""
}

function CheckIfIpIsWhitelisted{
    Param([String]$resource, [String]$appName, [String]$deviceIp)
    $ipExists = az webapp config access-restriction show `
        --resource-group $resource --name $appName `
        --query "ipSecurityRestrictions[?ip_address=='$deviceIp/32'].name" `
        -o tsv
    if (!$?) {
        Write-Host "Error checking access restrictions"
        exit
    }
    if (!$ipExists) {
        return $false
    } else {
        return $true
    }
}

function CheckIfNameIsWhitelisted{
    Param([String]$resource, [String]$appName, [String]$device)
    $ipExists = az webapp config access-restriction show `
        --resource-group $resource --name $appName `
        --query "ipSecurityRestrictions[?name=='$device'].name" `
        -o tsv
    if (!$?) {
        Write-Output "Error checking access restrictions"
        exit
    }
    if (!$ipExists) {
        return $false
    } else {
        return $true
    }
}

function RemoveDeviceWhitelisting{
    Param([String]$resource, [String]$appName, [String]$device)
    $removeDevice = az webapp config access-restriction remove `
        --resource-group $resource --name $appName `
        --rule-name $device
    if (!$?) {
        return $false
    }
    return $true
}

function AddDeviceToWhitelist{
    Param([String]$resource, [String]$appName, [String]$device, [String]$deviceIp)
    $addDevice = az webapp config access-restriction add `
            --resource-group $resource --name $appName `
            --rule-name $device `
            --action Allow `
            --ip-address "$deviceIp/32" `
            --priority 65000 `
            --description "Access rule added by MyB whitelisting script"
    if (!$?) {
        return $false
    }
    return $true
}

az account set -s $subscription
ConfigureDeviceAccessForResource $resourceGroup $appService $userIp $args[0]
