param name string

param firstTwoOctets string = '10.0'

var location = resourceGroup().location

output jumpID string = vnet.properties.subnets[2].id

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
