variable "ECR_AWS_ACCESS_KEY_ID"{
  type     = string
  nullable = false
}

variable "ECR_AWS_SECRET_ACCESS_KEY"{
  type     = string
  nullable = false
}

variable "ECR_AWS_REGION"{
  type     = string
  nullable = false
}

variable "ECR_AWS_ZONE_1"{
  type     = string
  nullable = false
}

variable "ECR_AWS_ZONE_2"{
  type     = string
  nullable = false
}

variable "ECR_UNTAGGED_IMAGES"{
  type     = number
  nullable = false
  default = 1
}
