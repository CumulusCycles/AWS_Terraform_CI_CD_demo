variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the instance security group is created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance is launched"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "name" {
  description = "Name used for the EC2 instance and its security group"
  type        = string
}

variable "project" {
  description = "Project tag applied to the instance and security group"
  type        = string
  default     = "CC TF Demo"
}
