variable "EC2_AWS_REGION"{
  type     = string
  nullable = false
}

variable "EC2_VPC_ID"{
  type     = string
  nullable = false
}

variable "EC2_AMI_ID" {
  description = "AMI ID for EC2, e.g., Ubuntu Server 22.04 LTS"
  type        = string
}

variable "EC2_INSTANCE_TYPE" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "EC2_CONTAINERS_IMAGE_URL"{
  type     = string
  nullable = false
}

variable "EC2_PRIVATE_SUBNET_ID_LIST"{
  type     = list(string)
  nullable = false
}

variable "EC2_LB_SECURITY_GROUP_LIST"{
  type     = list(string)
  nullable = false
}

variable "EC2_LB_TARGET_GROUP_ARN"{
  type     = string
  nullable = false
}

variable "EC2_LOG_GROUP_NAME"{
  type     = string
  nullable = false
}
