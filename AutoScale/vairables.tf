variable "region" {
  default = "us-east-2"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_access_key" {
  type = "string"
}

variable "notification_arn" {
  type = "string"
}

variable "notification_role_arn" {
  type ="string"
}
