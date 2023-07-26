param frontDoor object
param tags object
param wafId string
param logAnalyticsId string
param staticSiteMappingHostname string
param staticSiteOmniboxHostname string
param staticSiteTermsAndConditionsHostname string
param staticSiteProductCategoriesHostname string
param staticSiteProductDiscoveryHostname string
param staticSiteDashboardHostname string
param staticSiteBasketHostname string
param staticSitePropertyConfirmationWizardHostname string
param staticSiteContractPackVaultHostname string

var frontEndEndpointDefaultHostName = '${frontDoor.name}.azurefd.net'
var frontEndEndpointDefaultName = replace(frontEndEndpointDefaultHostName, '.', '-')
var frontEndEndpointCustomName = replace(frontDoor.customDomainName, '.', '-')
var backendPoolsMappingHostname = replace(replace(staticSiteMappingHostname, 'https://', ''), '/', '')
var backendPoolsOmniboxHostname = replace(replace(staticSiteOmniboxHostname, 'https://', ''), '/', '')
var backendPoolsTermsAndConditionsHostname = replace(replace(staticSiteTermsAndConditionsHostname, 'https://', ''), '/', '')
var backendPoolsProductCategoriesHostname = replace(replace(staticSiteProductCategoriesHostname, 'https://', ''), '/', '')
var backendPoolsProductDiscoveryHostname = replace(replace(staticSiteProductDiscoveryHostname, 'https://', ''), '/', '')
var backendPoolsDashboardHostname = replace(replace(staticSiteDashboardHostname, 'https://', ''), '/', '')
var backendPoolsBasketHostname = replace(replace(staticSiteBasketHostname, 'https://', ''), '/', '')
var backendPoolsPropertyConfirmationWizardHostname = replace(replace(staticSitePropertyConfirmationWizardHostname, 'https://', ''), '/', '')
var backendPoolsContractPackVaultHostname = replace(replace(staticSiteContractPackVaultHostname, 'https://', ''), '/', '')

resource frontDoorResource 'Microsoft.Network/frontDoors@2020-05-01' = {
  name: frontDoor.name
  location: 'global'
  tags: tags
  properties: {
    enabledState: 'Enabled'
    friendlyName: frontDoor.name
    frontendEndpoints: [
      {
        name: frontEndEndpointDefaultName
        properties: {
          hostName: frontEndEndpointDefaultHostName
          sessionAffinityEnabledState: 'Disabled'
          webApplicationFirewallPolicyLink: {
            id: wafId
          }
        }
      }
      {
        name: frontEndEndpointCustomName
        properties: {
          hostName: frontDoor.customDomainName
          sessionAffinityEnabledState: 'Disabled'
          webApplicationFirewallPolicyLink: {
            id: wafId
          }
        }
      }
    ]
    loadBalancingSettings: [
      {
        name: 'loadBalancingSettings'
        properties: {
          sampleSize: 4
          successfulSamplesRequired: 2
          additionalLatencyMilliseconds: 0
        }
      }
    ]
    healthProbeSettings: [
      {
        name: 'healthProbeSettings'
        properties: {
          enabledState: 'Disabled'
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 255
          healthProbeMethod: 'HEAD'
        }
      }
    ]
    backendPools: [
      {
        name: 'mapping'
        properties: {
          backends: [
            {
              address: backendPoolsMappingHostname
              backendHostHeader: backendPoolsMappingHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'omnibox'
        properties: {
          backends: [
            {
              address: backendPoolsOmniboxHostname
              backendHostHeader: backendPoolsOmniboxHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'termsandconditions'
        properties: {
          backends: [
            {
              address: backendPoolsTermsAndConditionsHostname
              backendHostHeader: backendPoolsTermsAndConditionsHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'productdiscovery'
        properties: {
          backends: [
            {
              address: backendPoolsProductDiscoveryHostname
              backendHostHeader: backendPoolsProductDiscoveryHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'productcategories'
        properties: {
          backends: [
            {
              address: backendPoolsProductCategoriesHostname
              backendHostHeader: backendPoolsProductCategoriesHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'dashboard'
        properties: {
          backends: [
            {
              address: backendPoolsDashboardHostname
              backendHostHeader: backendPoolsDashboardHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'basket'
        properties: {
          backends: [
            {
              address: backendPoolsBasketHostname
              backendHostHeader: backendPoolsBasketHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'propertyconfirmationwizard'
        properties: {
          backends: [
            {
              address: backendPoolsPropertyConfirmationWizardHostname
              backendHostHeader: backendPoolsPropertyConfirmationWizardHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
      {
        name: 'contractpackvault'
        properties: {
          backends: [
            {
              address: backendPoolsContractPackVaultHostname
              backendHostHeader: backendPoolsContractPackVaultHostname
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
            }
          ]
          healthProbeSettings: {
            id: resourceId('Microsoft.Network/frontDoors/healthProbeSettings', frontDoor.name, 'healthProbeSettings')
          }
          loadBalancingSettings: {
            id: resourceId('Microsoft.Network/frontDoors/loadBalancingSettings', frontDoor.name, 'loadBalancingSettings')
          }
        }
      }
    ]
    routingRules: [
      {
        name: 'redirect-http-to-https'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Http'
          ]
          patternsToMatch: [
            '/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorRedirectConfiguration'
            redirectType: 'Found'
            redirectProtocol: 'HttpsOnly'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-mapping'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/mapping/*'
            '/mfe/mapping/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'mapping')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-omnibox'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/omnibox/*'
            '/mfe/omnibox/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'omnibox')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-termsandconditions'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/termsandconditions/*'
            '/mfe/termsandconditions/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'termsandconditions')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-productdiscovery'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/productdiscovery/*'
            '/mfe/productdiscovery/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'productdiscovery')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-productcategories'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/productcategories/*'
            '/mfe/productcategories/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'productcategories')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-dashboard'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/dashboard/*'
            '/mfe/dashboard/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'dashboard')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-basket'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/basket/*'
            '/mfe/basket/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'basket')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-propertyconfirmationwizard'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/propertyconfirmationwizard/*'
            '/mfe/propertyconfirmationwizard/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'propertyconfirmationwizard')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
      {
        name: 'forward-https-to-contractpackvault'
        properties: {
          frontendEndpoints: [
            {
              id: resourceId('Microsoft.Network/frontDoors/frontEndEndpoints', frontDoor.name, frontEndEndpointCustomName)
            }
          ]
          acceptedProtocols: [
            'Https'
          ]
          patternsToMatch: [
            '/contractpackvault/*'
            '/mfe/contractpackvault/*'
          ]
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: resourceId('Microsoft.Network/frontDoors/backEndPools', frontDoor.name, 'contractpackvault')
            }
            customForwardingPath: '/'
          }
          enabledState: 'Enabled'
        }
      }
    ]
  }
  resource frontendEndpointResource 'frontendEndpoints' existing = {
    name: frontEndEndpointCustomName
  }
}

resource customHttpsConfiguration 'Microsoft.Network/frontdoors/frontendEndpoints/customHttpsConfiguration@2020-07-01' = {
  parent: frontDoorResource::frontendEndpointResource
  name: 'default'
  properties: {
    protocolType: 'ServerNameIndication'
    certificateSource: 'FrontDoor'
    frontDoorCertificateSourceParameters: {
      certificateType: 'Dedicated'
    }
    minimumTlsVersion: '1.2'
  }
}

resource diagnosticsSettingsResource 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: frontDoorResource
  name: frontDoor.name
  properties: {
    workspaceId: logAnalyticsId
    logs: [
      {
        category: 'FrontdoorAccessLog'
        enabled: true
      }
      {
        category: 'FrontdoorWebApplicationFirewallLog'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}
