param principalId string

@description('The role definition ID')
param roleDefinitionId string

resource roleAssignmentReader 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(principalId, subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId))
  scope: az.resourceGroup()
  properties: {
    principalId: principalId
    principalType: 'Group'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
  }
}
