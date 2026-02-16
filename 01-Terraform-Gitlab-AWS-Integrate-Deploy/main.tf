module "network" {
  source = "./aws-modules/network"

  vpc_cidr                        = var.network.vpc_cidr
  subnet_cidr                     = var.network.subnet_cidr
  availability_zone               = var.network.availability_zone
  vpc_tags                        = var.network.vpc_tags
  subnet_tags                     = var.network.subnet_tags
  security_group_name             = var.network.security_group_name
  security_group_description      = var.network.security_group_description
  ingress_rules                   = var.network.ingress_rules
  egress_rules                    = var.network.egress_rules
  security_group_tags             = var.network.security_group_tags
}

module "ec2-windows" {
  source = "./aws-modules/ec2-windows"

  instance_count                  = var.ec2.instance_count
  ami_id                          = var.ec2.ami_id
  instance_type                   = var.ec2.instance_type
  key_name                        = var.ec2.key_name
  subnet_id                       = module.network.subnet_id
  security_group_ids              = [module.network.security_group_id]
  root_volume_size_gb             = var.ec2.root_volume_size_gb
  data_volume_size_gb             = var.ec2.data_volume_size_gb
  ec2_tags                        = var.ec2.ec2_tags
}

module "ebs-attach" {
  source = "./aws-modules/ebs"

  instance_ids                    = module.ec2-windows.instance_ids
  volume_size_gb                  = var.ebs.volume_size_gb
  volume_type                     = var.ebs.volume_type
  encrypted                       = var.ebs.encrypted
  device_names                    = var.ebs.device_names
  ebs_tags                        = var.ebs.ebs_tags
}


