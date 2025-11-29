
param StorageName string
param Location string = resourceGroup().location
param env string = 'dev'

var stgacc_name = '${StorageName}${uniqueString(resourceGroup().id)}'
var acr_name = 'basicstorage${env}${uniqueString(resourceGroup().id)}'
var bsns_name = 'service-bus-${env}-${uniqueString(resourceGroup().id)}'
var app_name = 'webapp-${env}-${uniqueString(resourceGroup().id)}'
var asp_name = 'ASP-${app_name}'


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


resource hostingPlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: asp_name
  location: Location
  kind: 'linux'
  tags: null

  sku: {
    tier: 'Basic'
    name: 'B1'
    size: 'B1'
    family: 'B1'
  }
  dependsOn: []
}


resource WebApp 'Microsoft.Web/sites@2022-03-01' = {
  name: app_name
  location: Location
  tags: null
  properties: {
   serverFarmId: hostingPlan.id
   clientAffinityEnabled: false
   httpsOnly: true
  }
  dependsOn: [
  ]
}
