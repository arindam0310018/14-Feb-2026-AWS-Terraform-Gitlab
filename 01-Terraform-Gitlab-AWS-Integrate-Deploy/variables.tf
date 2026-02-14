variable "aws_region" {
  type                            = string
}

variable "network" {
  description = "Network configuration"
  type = object({
    vpc_cidr                      = string
    subnet_cidr                   = string
    availability_zone             = string
    vpc_tags                      = map(string)
    subnet_tags                   = map(string)
    security_group_name           = string
    security_group_description    = string
    ingress_rules                 = list(object({
      description                 = string
      from_port                   = number
      to_port                     = number
      protocol                    = string
      cidr_blocks                 = list(string)
    }))
    egress_rules                  = list(object({
      description                 = string
      from_port                   = number
      to_port                     = number
      protocol                    = string
      cidr_blocks                 = list(string)
    }))
    security_group_tags           = map(string)
  })
}

variable "ec2" {
  description = "EC2 configuration"
  type = object({
    instance_count                = number
    instance_type                 = string
    key_name                      = string
    root_volume_size_gb           = number
    data_volume_size_gb           = number
    ec2_tags                      = map(string)
  })
}

variable "ebs" {
  type = object({
    volume_size_gb                = number
    volume_type                   = string
    encrypted                     = bool
    device_names                  = list(string)
    ebs_tags                      = map(string)
  })
}
