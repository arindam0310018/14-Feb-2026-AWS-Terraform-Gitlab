variable "vpc_cidr" {
  type                    = string
  description             = "CIDR block for the VPC"
}

variable "subnet_cidr" {
  type                    = string
  description             = "CIDR block for the subnet"
}

variable "availability_zone" {
  type                    = string
}

variable "vpc_tags" {
  type                    = map(string)
  description             = "Tags for VPC"
}

variable "subnet_tags" {
  type                    = map(string)
  description             = "Tags for Subnet"
}

variable "security_group_name" {
  type                    = string
  description             = "Security Group Name"
}

variable "security_group_description" {
  type                    = string
  description             = "Security Group Description"
}

variable "ingress_rules" {
  description             = "List of ingress rules"
  type                    = list(object({
    description           = string
    from_port             = number
    to_port               = number
    protocol              = string
    cidr_blocks           = list(string)
  }))
}

variable "egress_rules" {
  description             = "List of egress rules"
  type                    = list(object({
    description           = string
    from_port             = number
    to_port               = number
    protocol              = string
    cidr_blocks           = list(string)
  }))
}

variable "security_group_tags" {
  type                    = map(string)
  description             = "Tags for Security Group"
}
