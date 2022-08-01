param name string

param firstTwoOctets string = '10.0'

var location = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '${firstTwoOctets}.0.0/16'
      ]
    }
    enableDdosProtection: false
    enableVmProtection: false
  }
}

resource serversSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
  name: 'servers'
  parent: vnet
  properties: {
    addressPrefix: '${firstTwoOctets}.0.0/24'
  }
}
