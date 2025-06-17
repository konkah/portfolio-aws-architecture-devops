variable "LB_VPC_ID"{
  type     = string
  nullable = false
}

variable "LB_PUBLIC_SUBNET_ID_LIST"{
  type     = list(string)
  nullable = false
}
