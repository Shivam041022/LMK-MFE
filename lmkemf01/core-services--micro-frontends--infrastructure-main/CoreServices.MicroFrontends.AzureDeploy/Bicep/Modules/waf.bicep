param waf object
param tags object

output id string = wafResource.id

resource wafResource 'Microsoft.Network/FrontDoorWebApplicationFirewallPolicies@2020-11-01' = {
  name: waf.name
  location: 'global'
  tags: tags
  sku: {
    name: 'Classic_AzureFrontDoor'
  }
  properties: {
    policySettings: {
      enabledState: 'Enabled'
      mode: 'Prevention'
      customBlockResponseStatusCode: 403
      customBlockResponseBody: 'Rm9yYmlkZGVu'
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: 'DefaultRuleSet'
          ruleSetVersion: '1.0'
        }
      ]
    }
    customRules: {
      rules: [
        {
          name: 'FrontDoorHeaderCheck'
          enabledState: waf.headerCheckRuleState
          priority: 10
          ruleType: 'MatchRule'
          action: 'Block'
          matchConditions: [
            {
              matchVariable: 'RequestHeader'
              selector: 'X-Azure-FDID'
              operator: 'Equal'
              negateCondition: true
              matchValue: [
                waf.frontDoorIds.low
                waf.frontDoorIds.sfow
                waf.frontDoorIds.osdow
                waf.frontdoorIds.mfelhw
                waf.frontdoorIds.omg
              ]
            }
          ]
        }
        {
          name: 'AllowAuth0Cookies'
          enabledState: 'Enabled'
          priority: 100
          ruleType: 'MatchRule'
          action: 'Allow'
          matchConditions: [
            {
              matchVariable: 'RequestHeader'
              selector: 'Cookie'
              operator: 'Contains'
              negateCondition: false
              matchValue: [
                'a0.spajs.txs'
              ]
              transforms: [
                'Lowercase'
              ]
            }
          ]
        }
      ]
    }
  }
}
