
module vnetModule '../../components/network/vnet.bicep' = [for ndx in range(0,10): {
  name: 'vnetModule${ndx}'
  params: {
    name: 'vnet-${ndx}'
    firstTwoOctets: '10.${ndx}'
  }
}]
