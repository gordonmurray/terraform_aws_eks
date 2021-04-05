variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}

variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}