
module vwanModule 'vwan-pattern.bicep' = [for ndx in range(0,5): {
  name: 'vwanModule${ndx}'
  params: {
    ndx: ndx
  }
}]
