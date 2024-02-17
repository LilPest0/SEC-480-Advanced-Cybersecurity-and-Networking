function cloner($originalVM, $snapshotOG, $newVM, $baseVM){
  try{
    Write-Host $originalVM # Grabs original VM
    Write-Host $snapshotOG # Grabs snapshot of original VM
    Write-Host $newVM # Stores name of new VM
    Write-Host $baseVM
  
    $vm = Get-VM -Name $originalVM
    $snapshot = Get-Snapshot -VM $vm -Name $baseVM
    $vmhost = Get-VMHost -Name "192.168.7.19"
    $ds = Get-DataStore -Name "datastore1"
    $linkedClone = $snapshotOG
    $linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
    $linkedVM | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName 480-WAN
  }
  catch {
    Write-Host "Try again" # Just in case it doesn't work
    exit
  }
}

cloner2 -originalVM "xubuntu-base" -snapshotOG "awx" -newVM "xubuntu-base-2" -baseVm "Base-xubuntu-base"
