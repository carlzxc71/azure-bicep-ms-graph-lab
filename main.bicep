targetScope = 'subscription'

provider microsoftGraph

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-prod-sc-bicep'
  location: 'swedencentral'
}

// Reader role assignment

resource entraGroupReader 'Microsoft.Graph/groups@v1.0' = {
  displayName: 'sec-rg-prod-sc-bicep-reader'
  mailEnabled: false
  mailNickname: 'sec-rg-prod-sc-bicep-reader'
  securityEnabled: true
  uniqueName: 'sec-rg-prod-sc-bicep-reader'
}

module readerRoleAssignment 'modules/roleAssignmentReader.bicep' = {
  name: 'readerRoleAssignment'
  scope: resourceGroup
  params: {
    principalId : entraGroupReader.id
    roleDefinitionId: 'acdd72a7-3385-48ef-bd42-f606fba81ae7' // Reader role definition ID
  }
}

// Contributor role assignment

resource entraGroupContributor 'Microsoft.Graph/groups@v1.0' = {
  displayName: 'sec-rg-prod-sc-bicep-contributor'
  mailEnabled: false
  mailNickname: 'sec-rg-prod-sc-bicep-contributor'
  securityEnabled: true
  uniqueName: 'sec-rg-prod-sc-bicep-contributor'
}

module contributorRoleAssignment 'modules/roleAssignmentContributor.bicep' = {
  name: 'contributorRoleAssignment'
  scope: resourceGroup
  params: {
    principalId : entraGroupContributor.id
    roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c' // Contributor role definition ID
  }
}

// Owner role assignment

resource entraGroupOwner 'Microsoft.Graph/groups@v1.0' = {
  displayName: 'sec-rg-prod-sc-bicep-owner'
  mailEnabled: false
  mailNickname: 'sec-rg-prod-sc-bicep-owner'
  securityEnabled: true
  uniqueName: 'sec-rg-prod-sc-bicep-owner'
}

module ownerRoleAssignment 'modules/roleAssignmentOwner.bicep' = {
  name: 'ownerRoleAssignment'
  scope: resourceGroup
  params: {
    principalId : entraGroupOwner.id
    roleDefinitionId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635' // Owner role definition ID
  }
}
