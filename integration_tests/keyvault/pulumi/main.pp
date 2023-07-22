config resourceGroupName "string" {
    description = "The name of the resource group to operate on"
}
currentResourceGroup = invoke("azure-native:resources:getResourceGroup", {
    resourceGroupName = resourceGroupName
})
config tenantId "string" {
}
config adminPassword "string" {
}
resource kv "azure-native:keyvault:Vault" {
    __logicalName = "kv-contoso"
    properties = {
        sku = {
            family = "A"
            name = "standard"
        }
        tenantId = tenantId
    }
    resourceGroupName = currentResourceGroup.name
}
resource adminPwd "azure-native:keyvault:Secret" {
    options {
        parent = kv
    }
    __logicalName = "admin-password"
    properties = {
        value = adminPassword
    }
    resourceGroupName = currentResourceGroup.name
}
