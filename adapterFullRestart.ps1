# Commented Credentials designation for potential use. Per Security controls should only be entered by tech when executing

# Set the administrator credentials
#  $username = "adminUsername" #Allow for End User input"
#  $password = "adminPassword" | ConvertTo-SecureString -AsPlainText -Force
#  $credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Get the active network adapter object
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

# Wake up the network adapter if it is "Asleep"
if ($adapter.PowerManagement -eq "Asleep") {
    Write-Output "Waking up adapter $($adapter.Name)..."
    $adapter | Set-NetAdapterPowerManagement -WakeOnMagicPacket Enable
}

# Release the current IP address
Write-Output "Releasing current IP address for adapter $($adapter.Name)..."
$adapter | ipconfig /release

# Renew the IP address
Write-Output "Renewing IP address for adapter $($adapter.Name)..."
$adapter | ipconfig /renew

# Restart the network adapter as an administrator
Write-Output "Restarting the network adapter: $($adapter.Name) as an administrator..."
# Start-Process PowerShell -Credential $credential -Verb runAs
Restart-NetAdapter -Name $adapter.Name -Confirm:$false

# $wifiSSID = Read-Host -Prompt 'Input your Wifi name'

# Get the list of wireless network profiles
#$wifiProfiles = Get-WifiNetwork

# Find the network profile that matches the specified SSID
# $wifiProfile = $wifiProfiles | Where-Object {$_.Ssid -eq $wifiSSID}

# If the profile was found
# if ($null -ne $wifiProfile) {
  # Forget the wireless network
  # Remove-WifiNetwork -Ssid $wifiSSID
  # Write-Output "Wireless network with SSID '$wifiSSID' forgotten!"
# }
# else {
#  Write-Output "Wireless network with SSID '$wifiSSID' not found!"
# }
##
#Final Output
Write-Output "Process Complete. Please restart your device."