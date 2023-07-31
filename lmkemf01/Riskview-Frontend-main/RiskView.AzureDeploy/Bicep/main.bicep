targetScope = 'subscription'

param tagsParam object = {}
param resourceGroupParam object
param logAnalyticsParam object
param applicationInsightsParam object
param wafParam object
param frontDoorParam object
param staticSiteMappingParam object
param staticSiteOmniboxParam object
param staticSiteTermsAndConditionsParam object
param staticSiteProductCategoriesParam object
param staticSiteProductDiscoveryParam object
param staticSiteDashboardParam object
param staticSiteBasketParam object
param staticSitePropertyConfirmationWizardParam object
param staticSiteContractPackVaultParam object

var serviceName = 'RiskView'

module resourceGroupUKS 'Modules/resource-group.bicep' = {
  name: '${serviceName}--resource-group'
  scope: subscription()
  params: {
    resourceGroup: resourceGroupParam
    tags: tagsParam
  }
}

// module logAnalytics 'Modules/log-analytics.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--log-analytics'
//   params: {
//     logAnalytics: logAnalyticsParam
//     resourceGroup: resourceGroupParam
//     tags: tagsParam
//   }
// }

module applicationInsights 'Modules/application-insights.bicep' = {
  scope: resourceGroup(resourceGroupParam.name)
  dependsOn: [
    resourceGroupUKS
    logAnalytics
  ]
  name: '${serviceName}--application-insights'
  params: {
    applicationInsights: applicationInsightsParam
    resourceGroup: resourceGroupParam
    logAnalyticsId: logAnalytics.outputs.id
    tags: tagsParam
  }
}

// module waf 'Modules/waf.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--waf'
//   params: {
//     waf: wafParam
//     tags: tagsParam
//   }
// }

// module frontDoor 'Modules/front-door.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--front-door'
//   params: {
//     frontDoor: frontDoorParam
//     tags: tagsParam
//     logAnalyticsId: logAnalytics.outputs.id
//     wafId: waf.outputs.id
//     staticSiteMappingHostname: staticSiteMapping.outputs.defaultHostname
//     staticSiteOmniboxHostname: staticSiteOmnibox.outputs.defaultHostname
//     staticSiteTermsAndConditionsHostname: staticSiteTermsAndConditions.outputs.defaultHostname
//     staticSiteProductCategoriesHostname: staticSiteProductCategories.outputs.defaultHostname
//     staticSiteProductDiscoveryHostname: staticSiteProductDiscovery.outputs.defaultHostname
//     staticSiteDashboardHostname: staticSiteDashboard.outputs.defaultHostname
//     staticSiteBasketHostname: staticSiteBasket.outputs.defaultHostname
//     staticSitePropertyConfirmationWizardHostname: staticSitePropertyConfirmationWizard.outputs.defaultHostname
//     staticSiteContractPackVaultHostname: staticSiteContractPackVault.outputs.defaultHostname
//   }
// }

// module staticSiteMapping 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-mapping'
//   params: {
//     staticSite: staticSiteMappingParam
//     tags: tagsParam
//   }
// }

// module staticSiteOmnibox 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-omnibox'
//   params: {
//     staticSite: staticSiteOmniboxParam
//     tags: tagsParam
//   }
// }

// module staticSiteTermsAndConditions 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-terms-and-conditions'
//   params: {
//     staticSite: staticSiteTermsAndConditionsParam
//     tags: tagsParam
//   }
// }

// module staticSiteProductCategories 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-product-categories'
//   params: {
//     staticSite: staticSiteProductCategoriesParam
//     tags: tagsParam
//   }
// }

// module staticSiteProductDiscovery 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-product-discovery'
//   params: {
//     staticSite: staticSiteProductDiscoveryParam
//     tags: tagsParam
//   }
// }

// module staticSiteDashboard 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-dashboard'
//   params: {
//     staticSite: staticSiteDashboardParam
//     tags: tagsParam
//   }
// }

// module staticSiteBasket 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-basket'
//   params: {
//     staticSite: staticSiteBasketParam
//     tags: tagsParam
//   }
// }

// module staticSitePropertyConfirmationWizard 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-propertyconfirmationwizard'
//   params: {
//     staticSite: staticSitePropertyConfirmationWizardParam
//     tags: tagsParam
//   }
// }

// module staticSiteContractPackVault 'Modules/static-site.bicep' = {
//   scope: resourceGroup(resourceGroupParam.name)
//   dependsOn: [
//     resourceGroupUKS
//   ]
//   name: '${serviceName}--static-site-contractpackvault'
//   params: {
//     staticSite: staticSiteContractPackVaultParam
//     tags: tagsParam
//   }
// }
