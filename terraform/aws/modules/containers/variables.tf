variable "ECS_AWS_REGION"{
  type     = string
  nullable = false
}

variable "ECS_VPC_ID"{
  type     = string
  nullable = false
}

variable "ECS_CONTAINERS_IMAGE_URL"{
  type     = string
  nullable = false
}

variable "ECS_PRIVATE_SUBNET_ID_LIST"{
  type     = list(string)
  nullable = false
}

variable "ECS_LB_SECURITY_GROUP_LIST"{
  type     = list(string)
  nullable = false
}

variable "ECS_LB_TARGET_GROUP_ARN"{
  type     = string
  nullable = false
}

variable "ECS_LOG_GROUP_NAME"{
  type     = string
  nullable = false
}