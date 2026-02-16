# data "aws_ami" "aws-windows2022" {
#   most_recent               = true
#   owners                    = ["amazon"]

# # Windows Server 2022 Base AMI published by Amazon
#   filter {
#     name                    = "name"
#     values                  = ["Windows_Server-2022-English-Full-Base-*"]
#   }

#   filter {
#     name                    = "virtualization-type"
#     values                  = ["hvm"]
#   }
# }

resource "aws_instance" "am-win-ec2instance" {
  count                     = var.instance_count
  #ami                       = data.aws_ami.aws-windows2022.id
  ami                       = var.ami_id
  instance_type             = var.instance_type

  subnet_id                 = var.subnet_id
  vpc_security_group_ids    = var.security_group_ids

# For Windows Admin password retrieval, key pair is recommended.
# If key_name is empty, it will be null.
  key_name                  = length(trimspace(var.key_name)) == 0 ? null : var.key_name
  get_password_data         = length(trimspace(var.key_name)) == 0 ? false : true

# Volume 1: Root (C:)
  root_block_device {
    volume_size             = var.root_volume_size_gb
    volume_type             = "gp3"
    encrypted               = true
  }

# Volume 2: Data disk 
# It will appear in Windows Disk Management for initialization.
# device_name is in Linux format. AWS uses this format. Windows will still see it as a disk.
  ebs_block_device {
    device_name             = "/dev/sdf"
    volume_size             = var.data_volume_size_gb
    volume_type             = "gp3"
    encrypted               = true
  }

  tags                      = var.ec2_tags
}