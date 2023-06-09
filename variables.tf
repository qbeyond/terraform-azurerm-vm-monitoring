variable "log_analytics_workspace" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
  })
  description = "Log Analytics Worksapce that all VMs are connected to for monitoring"
  nullable = false
}

variable "webhook_name" {
  type = string
  description = "Name of the alert webhook"
  nullable = false
}

variable "webhook_service_uri" {
  type = string
  description = "Link to the webhook receiver URL"
  nullable = false
}

variable "additional_queries" {
  type = map(object({
    query_path  = string
    description = string
    time_window = number
  }))
  description = "List of additional alert rule queries to create with a file path, description and time_window"
  default = {}
  nullable = false
}
