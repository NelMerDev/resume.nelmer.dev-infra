variable "my_region" {
  description = "My Primary region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
  default     = "terraform-VPC-us-east"
}

variable "sg_name" {
  description = "The name for the Security Group"
  type        = string
  default     = "terraform-SG-us-east"
}

variable "cidr_block" {
  description = "The cidr block IP range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
