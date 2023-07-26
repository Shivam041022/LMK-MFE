param applicationInsights object
param resourceGroup object
param logAnalyticsId string
param tags object

resource applicationInsightsResource 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsights.name
  location: resourceGroup.location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsId
  }
  tags: tags
}
