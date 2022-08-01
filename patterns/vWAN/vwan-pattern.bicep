param ndx int

module vnetModule '../../components/network/vnet.bicep' = {
  name: 'vnetModule${ndx}'
  params: {
    name: 'vnet-${ndx}'
    firstTwoOctets: '10.${ndx}'
  }
}

module vmModule '../../components/compute/vm.bicep' = {
  name: 'vm${ndx}'
  params: {
    subnetID: vnetModule.outputs.jumpID
    password: '@@0523RnK0524@@'
    vmName: 'vm${ndx}'
    username: 'vmadmin'
  }
}
