######################################################################
# Start SSH Service, change Startup Policy, and Suppress SSH Warning #
######################################################################
 
#Variables
$vCenter = "LABVC01.virtuallyboring.com"
$Cluster = "Nested ESXi Cluster"
 
### Start of Script
# Load VMware Cmdlet and connect to vCenter
Add-PSSnapin vmware.vimautomation.core
connect-viserver -server $vCenter
 
$VMHost = Get-Cluster -Name $Cluster | Get-VMhost
 
# Start SSH Server on a Cluster
ForEach ($VMhost in $Cluster){
Write-Host -ForegroundColor GREEN "Starting SSH Service on " -NoNewline
Write-Host -ForegroundColor YELLOW "$VMhost"
Get-VMHost | Get-VMHostService | ? {($_.Key -eq "TSM-ssh") -and ($_.Running -eq $False)} | Start-VMHostService
}