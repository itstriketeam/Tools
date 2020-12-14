Import-Module ActiveDirectory

function Get-ADComputerLastLogon([string]$computerName)
{
  $dcs = Get-ADDomainController -Filter {Name -like "*"}
  $time = 0
  foreach($dc in $dcs)
  { 
    $hostname = $dc.HostName
    $computer = Get-ADComputer $computerName | Get-ADObject -Server $hostname -Properties lastLogon 
    if($computer.LastLogon -gt $time) 
    {
      $time = $computer.LastLogon
    }
  }
  $dt = [DateTime]::FromFileTime($time)
  Write-Host $computername "last logged on at:" $dt }

if ($args[0] -eq $null){
write-host "Must specify computer or user account name."
 }
else{
Get-ADComputerLastLogon -ComputerName $args[0]
}