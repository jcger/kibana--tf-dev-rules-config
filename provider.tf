provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = "changeme"
    endpoints = ["http://localhost:9200"]
  }

  kibana {
    username  = "elastic"
    password  = "changeme"
    endpoints = ["http://localhost:5601"]
  }
}
