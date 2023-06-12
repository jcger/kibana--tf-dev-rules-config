# elasticstack_kibana_action_connector.my_index_connector:
resource "elasticstack_kibana_action_connector" "my_index_connector" {
  config = jsonencode(
    {
      executionTimeField = null
      index              = ".test-index"
      refresh            = false
    }
  )
  connector_id      = "170570f0-006a-11ee-b7b1-8dc858d45594"
  connector_type_id = ".index"
  name              = "index-connector-1"
  space_id          = "default"
}

# elasticstack_kibana_alerting_rule.my_rule:
resource "elasticstack_kibana_alerting_rule" "my_rule" {
  consumer    = "alerts"
  enabled     = true
  interval    = "1m"
  name        = "changed rule 1"
  notify_when = "onActionGroupChange"
  params = jsonencode(
    {
      aggField = "sheet.version"
      aggType  = "avg"
      groupBy  = "top"
      index = [
        ".test-index",
      ]
      termField = "name.keyword"
      termSize  = 6
      threshold = [
        500,
      ]
      thresholdComparator = ">"
      timeField           = "@timestamp"
      timeWindowSize      = 5
      timeWindowUnit      = "m"
    }
  )
  rule_id      = "1787c050-006a-11ee-b7b1-8dc858d45594"
  rule_type_id = ".index-threshold"
  space_id     = "default"
  tags         = []

  actions {
    group = "threshold met"
    id    = "170570f0-006a-11ee-b7b1-8dc858d45594"
    params = jsonencode(
      {
        documents = [
          {
            alert_id = "{{alert.id}}"
            rule_id  = "{{rule.id}}"
          },
        ]
      }
    )
  }
}

# elasticstack_kibana_alerting_rule.my_second_rule:
resource "elasticstack_kibana_alerting_rule" "my_second_rule" {
  consumer    = "alerts"
  enabled     = true
  interval    = "1m"
  name        = "rule 2"
  notify_when = "onActionGroupChange"
  params = jsonencode(
    {
      aggField = "sheet.version"
      aggType  = "avg"
      groupBy  = "top"
      index = [
        ".test-index",
      ]
      termField = "name.keyword"
      termSize  = 6
      threshold = [
        1000,
      ]
      thresholdComparator = ">"
      timeField           = "@timestamp"
      timeWindowSize      = 5
      timeWindowUnit      = "m"
    }
  )
  rule_id      = "17891fe0-006a-11ee-b7b1-8dc858d45594"
  rule_type_id = ".index-threshold"
  space_id     = "default"
  tags         = []

  actions {
    group = "threshold met"
    id    = "170570f0-006a-11ee-b7b1-8dc858d45594"
    params = jsonencode(
      {
        documents = [
          {
            alert_id = "{{alert.id}}"
            rule_id  = "{{rule.id}}"
          },
        ]
      }
    )
  }
}
