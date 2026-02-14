variable "instance_count" {
  type              = number
  description       = "Number of EC2 instances to create"
}

variable "instance_type" {
  type              = string
  description       = "EC2 instance type (free-tier typically t2.micro or t3.micro depending on account/region)"
}

variable "key_name" {
  type              = string
  description       = "EC2 Key Pair name (recommended for Windows password retrieval). Use empty string if not needed."
}

variable "subnet_id" {
  type              = string
  description       = "Subnet ID where instances will be launched"
}

variable "security_group_ids" {
  type              = list(string)
  description       = "Security group IDs to attach to instances"
}

variable "root_volume_size_gb" {
  type              = number
  description       = "Root EBS volume size in GB"
}

variable "data_volume_size_gb" {
  type              = number
  description       = "EBS volume size in GB"
}

variable "ec2_tags" {
  type              = map(string)
  description       = "Tags for EC2 instances"
}
