variable "instance_ids" {
  type        = list(string)
  description = "EC2 instance IDs to attach volumes."
}

variable "volume_size_gb" {
  type        = number
  description = "EBS volume size in GB."
}

variable "volume_type" {
  type        = string
  description = "EBS volume type."
}

variable "encrypted" {
  type        = bool
  description = "Encrypt the EBS volumes."
}

variable "device_names" {
  type        = list(string)
  description = "Device names to use."
}

variable "ebs_tags" {
  type        = map(string)
  description = "Tags for EBS volumes."
}