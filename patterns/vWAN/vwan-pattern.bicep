param ndx int

module vnetModule '../../components/network/vnet.bicep' = {
  name: 'vnetModule${ndx}'
  params: {
    name: 'vnet-${ndx}'
    firstTwoOctets: '10.${ndx}'
    useBastion: ndx == 0 ? true : false
  }
}

module vmModule '../../components/compute/vm.bicep' = {
  name: 'vwanvm${ndx}'
  params: {
    subnetID: vnetModule.outputs.jumpID
    password: '@@0523RnK0524@@'
    vmName: 'vwanvm${ndx}'
    username: 'vmadmin'
  }
}
