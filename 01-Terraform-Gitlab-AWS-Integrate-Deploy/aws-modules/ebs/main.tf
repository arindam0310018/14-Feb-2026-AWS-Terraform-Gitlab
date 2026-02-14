# Map Instance ID to the corresponding Device Name:-
locals {
  instance_map_device = {
    for i, instance_id in var.instance_ids :
    i => {
      instance_id           = instance_id
      device_name           = var.device_names[i]
    }
  }
}

# Retrieve Instance Ids so that ebs volume can be in the same AZ:-
data "aws_instance" "am-ec2-instance" {
  for_each                  = local.instance_map_device
  instance_id               = each.value.instance_id
}

# Create EBS Volume:-
resource "aws_ebs_volume" "am-ebs-vol" {
  for_each                  = local.instance_map_device
  availability_zone         = data.aws_instance.am-ec2-instance[each.key].availability_zone

  size                      = var.volume_size_gb
  type                      = var.volume_type
  encrypted                 = var.encrypted

  tags                      = var.ebs_tags

  lifecycle {
    prevent_destroy         = true
  }
}

resource "aws_volume_attachment" "am-ebs-vol-attach" {
  for_each                  = local.instance_map_device
  device_name               = each.value.device_name

  volume_id                 = aws_ebs_volume.am-ebs-vol[each.key].id
  instance_id               = each.value.instance_id

  # set to false if you don't want Terraform to detach on destroy
  force_detach              = false
}
