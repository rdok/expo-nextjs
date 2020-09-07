variable "aws_region" {
  default = "eu-west-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "name" {
  default = "expo-nextjs-template"
  type        = string
}
