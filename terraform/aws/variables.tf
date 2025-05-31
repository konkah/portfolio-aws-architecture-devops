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
