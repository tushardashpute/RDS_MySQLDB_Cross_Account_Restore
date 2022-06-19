variable "tag" {
  description = "key name for the instance"
  default = "terraform_test"
}

variable "alias_name" {
  description = "The name of the key alias"
  type        = string
  default     = "testtf"
}

variable "deletion_window_in_days" {
  description = "The duration in days after which the key is deleted after destruction of the resource"
  type        = string
  default     = 30
}

variable "description" {
  description = "The description of this KMS key"
  type        = string
  default     = "For RDS snapshot creation to share across acccount"
}

variable "environment" {
  description = "The environment this KMS key belongs to"
  type        = string
  default     = "Source"
}

variable "key_policy" {
  description = "The policy of the key usage"
  type        = string
  default     = ""
}


variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to be added to kms-cmk"
  default     = {}
}
