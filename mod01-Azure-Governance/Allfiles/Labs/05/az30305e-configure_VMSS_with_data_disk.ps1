Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Remove-Item 'C:\inetpub\wwwroot\iisstart.htm' -ErrorAction SilentlyContinue
Add-Content -Path 'C:\inetpub\wwwroot\iisstart.htm' -Value "Hello World from $env:computername"

$disks = Get-Disk | Where-Object {$_.PartitionStyle -like "Raw"} | Sort-Object -Property number
$i = 0
$accessPath = @()
$accessPath += 102..121 | ForEach-Object {"$([char]$_):\" }
Foreach ($disk in $disks) {
    Initialize-Disk -PartitionStyle GPT -Number $disk.Number
    New-Volume -Disk $disk -FileSystem NTFS -FriendlyName Data -AccessPath $accessPath[$i]
    $i++
}