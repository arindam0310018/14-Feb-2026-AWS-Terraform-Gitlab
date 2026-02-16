aws_region                      = "eu-central-1"

network = {
  vpc_cidr                      = "192.168.10.0/24"
  subnet_cidr                   = "192.168.10.0/27"
  availability_zone             = "eu-central-1a"

  vpc_tags = {
    Name                        = "prod-vpc"
    Environment                 = "prod"
    Owner                       = "platform-team"
    Test                        = "Ranajoy"              
  }

  subnet_tags = {
    Name                        = "prod-subnet"
    Environment                 = "prod"
  }

  security_group_name           = "prod-sg"
  security_group_description    = "Security group for prod"

  ingress_rules = [
    {
      description               = "Allow SSH"
      from_port                 = 22
      to_port                   = 22
      protocol                  = "tcp"
      cidr_blocks               = ["0.0.0.0/0"]
    },
    {
      description               = "Allow RDP"
      from_port                 = 3389
      to_port                   = 3389
      protocol                  = "tcp"
      cidr_blocks               = ["0.0.0.0/0"]
    },
    {
      description               = "Allow SQL"
      from_port                 = 1433
      to_port                   = 1433
      protocol                  = "tcp"
      cidr_blocks               = ["0.0.0.0/0"]
    },
    {
      description               = "Allow Oracle"
      from_port                 = 1521
      to_port                   = 1521
      protocol                  = "tcp"
      cidr_blocks               = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      description               = "Allow all outbound"
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      cidr_blocks               = ["0.0.0.0/0"]
    }
  ]

  security_group_tags = {
    Name                        = "prod-sg"
    Environment                 = "prod"
  }
}

ec2 = {
  instance_count                = 2
  ami_id                        = "ami-08f7638d7dc2a351c"
  instance_type                 = "t3.micro"   # Free-tier - t2.micro or t3.micro depending on account/region.
  key_name                      = ""  # recommended for Windows admin password retrieval.

  root_volume_size_gb           = 40
  data_volume_size_gb           = 40

  ec2_tags = {
    Application                 = "app01"
    Environment                 = "prod"
    Component                   = "ec2-windows"
    ManagedBy                   = "terraform"
  }
}

ebs = {
  volume_size_gb                = 20
  volume_type                   = "gp3"
  encrypted                     = true

  device_names                  = ["/dev/sdf", "/dev/sdg"] # Must match instance_count (2 instances -> 2 device names)

  ebs_tags = {
    Application                 = "app01"
    Environment                 = "prod"
    Component                   = "ebs-data"
    ManagedBy                   = "terraform"
  }
}