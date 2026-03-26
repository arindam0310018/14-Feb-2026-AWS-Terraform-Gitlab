resource "aws_vpc" "amvpc" {
  cidr_block                  = var.vpc_cidr
  enable_dns_support          = true
  enable_dns_hostnames        = true
  tags                        = var.vpc_tags
}

resource "aws_subnet" "amsubnet" {
  vpc_id                      = aws_vpc.amvpc.id
  cidr_block                  = var.subnet_cidr
  availability_zone           = var.availability_zone
  map_public_ip_on_launch     = false
  tags                        = var.subnet_tags
}

resource "aws_security_group" "amsg" {
  name                        = var.security_group_name
  description                 = var.security_group_description
  vpc_id                      = aws_vpc.amvpc.id

  dynamic "ingress" {
    for_each                  = var.ingress_rules
    content {
      description             = ingress.value.description
      from_port               = ingress.value.from_port
      to_port                 = ingress.value.to_port
      protocol                = ingress.value.protocol
      cidr_blocks             = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each                  = var.egress_rules
    content {
      description             = egress.value.description
      from_port               = egress.value.from_port
      to_port                 = egress.value.to_port
      protocol                = egress.value.protocol
      cidr_blocks             = egress.value.cidr_blocks
    }
  }

  tags                        = var.security_group_tags
}
