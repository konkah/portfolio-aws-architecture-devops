resource "aws_instance" "portfolio_api_ubuntu_instance" {
  ami                         = var.EC2_AMI_ID
  instance_type               = var.EC2_INSTANCE_TYPE
  subnet_id                   = var.EC2_SUBNET_ID_LIST[0]
  vpc_security_group_ids      = var.EC2_LB_SECURITY_GROUP_LIST
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_cloudwatch_profile.name
  key_name                    = aws_key_pair.portfolio_api_ubuntu_ssh_key.key_name

  user_data = templatefile("${path.module}/initialize_vm.sh.tpl", {
    VM_CONTAINERS_IMAGE_URL = var.EC2_CONTAINERS_IMAGE_URL
    VM_AWS_REGION           = var.EC2_AWS_REGION
  })

  tags = {
    Name = "portfolio-api-ubuntu-instance"
  }
}

resource "aws_lb_target_group_attachment" "portfolio_api_ec2_attachment" {
  target_group_arn = var.EC2_LB_TARGET_GROUP_ARN
  target_id        = aws_instance.portfolio_api_ubuntu_instance.id
  port             = 80
}

resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_cloudwatch_profile" {
  name = "ec2-cloudwatch-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

resource "tls_private_key" "ed25519" {
  algorithm = "ED25519"
}

resource "local_file" "portfolio_api_private_key" {
  content              = tls_private_key.ed25519.private_key_openssh
  filename             = "${path.module}/ec2_ed25519.pem"
  file_permission      = "0400"
  directory_permission = "0700"
}

resource "aws_key_pair" "portfolio_api_ubuntu_ssh_key" {
  key_name   = "portfolio-api-ubuntu-ssh-key"
  public_key = tls_private_key.ed25519.public_key_openssh
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
