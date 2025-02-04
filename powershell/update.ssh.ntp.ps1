# # Define the ESXi hosts and their credentials (if different)
$NTPServer = "10.0.0.253" 

$esxiHosts = @(
    @{ Hostname = "esxi-1.vcf.sddc.lab"; User = "root"; Password = "VMware123!VMware123!" },
    @{ Hostname = "esxi-2.vcf.sddc.lab"; User = "root"; Password = "VMware123!VMware123!" },
    @{ Hostname = "esxi-3.vcf.sddc.lab"; User = "root"; Password = "VMware123!VMware123!" },
    @{ Hostname = "esxi-4.vcf.sddc.lab"; User = "root"; Password = "VMware123!VMware123!" }
)

foreach ($esxiHost in $esxiHosts) {
    $hostname = $esxiHost.Hostname
    $user = $esxiHost.User
    $password = $esxiHost.Password
    try {
        Connect-VIServer -Server $hostname -User $user -Password $password -ErrorAction Stop
        Get-VMHost $hostname | Get-VMHostService | Where-Object { $_.Key -eq "TSM-SSH" } | Start-VMHostService
        # Add-VMHostNtpServer -VMHost $hostname -NtpServer $NTPServer -Confirm:$false
        # Get-VMHostService -VMHost $hostname | Where-Object {$_.Key -eq "ntpd"} | Start-VMHostService -Confirm:$false

        Disconnect-VIServer -Confirm:$false
        Write-Host "SSH started on $hostname"
        # Write-Host "NTPD started on $hostname"
    }
    catch {
        Write-Error "Error on " $hostname $($_.Exception.Message)
    }
}

Write-Host "Script Completed"

