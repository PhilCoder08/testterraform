variable "resource_group_name" {
  default = "terraform_rg"
}

variable "default_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    autodeploy  = 1,
    environment = "dev"
    contact     = "DevOps Team"
  }
}