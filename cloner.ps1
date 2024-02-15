function cloner($originalVM, $snapshotOG, $newVM){
  try{
    Write-Host $originalVM # Grabs original VM
    Write-Host $snapshotOG # Grabs snapshot of original VM
    Write-Host $newVM # Stores name of new VM
  
    $vm = Get-VM -Name $originalVM
    $snapshot = Get-Snapshot -VM $vm -Name $snapshotOG
    $vmhost = Get-VMHost -Name "192.168.7.19"
    $ds = Get-DataStore -Name "datastore1"
    $linkedClone = "{0}.linked" -f $vm.name
    $linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
    $newvm = New-VM -Name "$newVM.base" -VM $linkedVM -VMHost $vmhost -Datastore $ds
    $newvm | New-Snapshot -Name "Base"
    $linkedvm | Remove-VM
  }
  catch {
    Write-Host "Try again" # Just in case it doesn't work
    exit
  }
}
