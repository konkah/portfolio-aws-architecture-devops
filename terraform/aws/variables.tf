variable "AWS_ACCESS_KEY_ID"{
  type     = string
  nullable = false
}

variable "AWS_SECRET_ACCESS_KEY"{
  type     = string
  nullable = false
}

variable "AWS_REGION"{
  type     = string
  nullable = false
}

variable "AWS_ZONE_1"{
  type     = string
  nullable = false
}

variable "AWS_ZONE_2"{
  type     = string
  nullable = false
}

variable "VPC_IP"{
  type     = string
  nullable = false
}

variable "VPC_SUBNET1_IP"{
  type     = string
  nullable = false
}

variable "VPC_SUBNET2_IP"{
  type     = string
  nullable = false
}

variable "UNTAGGED_IMAGES"{
  type     = number
  nullable = false
  default = 1
}

variable "APP_VERSION"{
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
