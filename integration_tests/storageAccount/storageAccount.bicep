param storagePrefix string

param storageSKU string = 'Standard_LRS'

param location string = resourceGroup().location

var storageLocations = ['east', 'west']

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageSKU
  }
}

resource storageAccounts 'Microsoft.Storage/storageAccounts@2022-09-01' = [for index in range (0, 10): {
  location: location
  kind: 'StorageV2'
  sku: {
    name: storageSKU
  }
}]

resource storageAccountsByLocation 'Microsoft.Storage/storageAccounts@2022-09-01' = [for location in storageLocations:{
   location: location
   kind: 'StorageV2'
   sku: {
     name: storageSKU
   }
}]

resource exampleExistingStorage 'Microsoft.Storage/storageAccounts@2021-02-01' existing = {
  name: 'existingStorageName'
}

resource myExistingResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'existingResourceGroupName'
}

output storageEndpoint object = storage.properties.primaryEndpoints
output existingEndpoint object = exampleExistingStorage.properties.primaryEndpoints