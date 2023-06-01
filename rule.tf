resource "elasticstack_kibana_alerting_rule" "my_rule" {
  name         = "rule 1"
  consumer     = "alerts"
  rule_type_id = ".index-threshold"
  notify_when  = "onActionGroupChange"
  interval     = "1m"
  enabled      = true

  params = jsonencode({
    aggType             = "avg"
    termSize            = 6
    thresholdComparator = ">"
    timeWindowSize      = 5
    timeWindowUnit      = "m"
    groupBy             = "top"
    threshold           = [500]
    index               = [".test-index"]
    timeField           = "@timestamp"
    aggField            = "sheet.version"
    termField           = "name.keyword"
  })

  actions {
    id    = elasticstack_kibana_action_connector.my_index_connector.connector_id
    group = "threshold met"
    params = jsonencode({
      "documents" : [{
        "rule_id" : "{{rule.id}}",
        "alert_id" : "{{alert.id}}"
      }]
    })
  }
}

resource "elasticstack_kibana_alerting_rule" "my_second_rule" {
  name         = "rule 2"
  consumer     = "alerts"
  rule_type_id = ".index-threshold"
  notify_when  = "onActionGroupChange"
  interval     = "1m"
  enabled      = true

  params = jsonencode({
    aggType             = "avg"
    termSize            = 6
    thresholdComparator = ">"
    timeWindowSize      = 5
    timeWindowUnit      = "m"
    groupBy             = "top"
    threshold           = [1000]
    index               = [".test-index"]
    timeField           = "@timestamp"
    aggField            = "sheet.version"
    termField           = "name.keyword"
  })

  actions {
    id    = elasticstack_kibana_action_connector.my_index_connector.connector_id
    group = "threshold met"
    params = jsonencode({
      "documents" : [{
        "rule_id" : "{{rule.id}}",
        "alert_id" : "{{alert.id}}"
      }]
    })
  }
}

resource "elasticstack_kibana_action_connector" "my_index_connector" {
  name              = "index-connector-1"
  connector_type_id = ".index"

  config = jsonencode({
    index = ".test-index"
  })
}
