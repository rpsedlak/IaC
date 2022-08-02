param name string

param firstTwoOctets string = '10.0'

var location = resourceGroup().location

output jumpID string = vnet.properties.subnets[2].id

param useBastion bool = false

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
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '${firstTwoOctets}.0.0/24'
        }
      }
      {
        name: 'servers-sn'
        properties: {
          addressPrefix: '${firstTwoOctets}.1.0/24'
        }
      }
      {
        name: 'jumpbox-sn'
        properties: {
          addressPrefix: '${firstTwoOctets}.255.0/24'
        }
      }
    ]
  }
}

resource bastionIP 'Microsoft.Network/publicIPAddresses@2022-01-01' = if(useBastion) {
  name: '${name}-bas-pip'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2022-01-01' = if(useBastion) {
  name: '${name}-bas'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'bastion'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          publicIPAddress: {
            id: bastionIP.id
          }
        }
      }
    ]
  }
}
