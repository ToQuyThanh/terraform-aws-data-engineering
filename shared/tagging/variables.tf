# Tagging and naming conventions

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to merge with common tags"
  type        = map(string)
  default     = {}
}

variable "cost_center" {
  description = "Cost center for billing purposes"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = ""
}

variable "backup_schedule" {
  description = "Backup schedule tag for automated backups"
  type        = string
  default     = ""
}

