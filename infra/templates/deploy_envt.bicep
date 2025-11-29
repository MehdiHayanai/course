
param StorageName string
param Location string = resourceGroup().location
param env string = 'dev'

var stgacc_name = '${StorageName}${uniqueString(resourceGroup().id)}'
var acr_name = 'basic-storage-${env}-${uniqueString(resourceGroup().id)}'
var bsns_name = 'service-bus-${env}-${uniqueString(resourceGroup().id)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: stgacc_name
  location: Location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}


resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: acr_name
  location: Location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: bsns_name
  location: Location
  sku: {
    name: 'Basic'
    capacity: 1
    tier: 'Basic'
  }
}


