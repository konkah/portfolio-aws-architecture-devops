resource "aws_instance" "portfolio_api_ubuntu_instance" {
  ami                    = var.EC2_AMI_ID
  instance_type          = var.EC2_INSTANCE_TYPE
  subnet_id              = var.EC2_SUBNET_ID_LIST[0]
  vpc_security_group_ids = var.EC2_LB_SECURITY_GROUP_LIST
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/initialize_vm.sh.tpl", {
    VM_CONTAINERS_IMAGE_URL = var.EC2_CONTAINERS_IMAGE_URL
    VM_AWS_REGION           = var.EC2_AWS_REGION
  })

  tags = {
    Name = "portfolio-api-ubuntu-instance"
  }
}
