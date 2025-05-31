resource "aws_ecr_repository" "portfolio_api_container_hub" {
    name = "portfolio-api-container-hub"
	force_delete = true

    image_scanning_configuration {
	    scan_on_push = true
	}
}

resource "aws_ecr_lifecycle_policy" "portfolio_api_default_policy" {
    repository = aws_ecr_repository.portfolio_api_container_hub.name

	  policy = <<EOF
	{
	    "rules": [
	        {
	            "rulePriority": 1,
	            "description": "Keep only the last ${var.ECR_UNTAGGED_IMAGES} untagged images.",
	            "selection": {
	                "tagStatus": "untagged",
	                "countType": "imageCountMoreThan",
	                "countNumber": ${var.ECR_UNTAGGED_IMAGES}
	            },
	            "action": {
	                "type": "expire"
	            }
	        }
	    ]
	}
	EOF

}

data "aws_caller_identity" "portfolio_api_current" {
}

resource "null_resource" "portfolio_api_docker_packaging" {
	
	  provisioner "local-exec" {
	    command = <<EOF
		aws configure set aws_access_key_id ${var.ECR_AWS_ACCESS_KEY_ID}
		aws configure set aws_secret_access_key ${var.ECR_AWS_SECRET_ACCESS_KEY}
		aws configure set region ${var.ECR_AWS_REGION}
	    aws ecr get-login-password --region ${var.ECR_AWS_REGION} | docker login --username AWS --password-stdin ${data.aws_caller_identity.portfolio_api_current.account_id}.dkr.ecr.${var.ECR_AWS_REGION}.amazonaws.com
		docker build -t "${aws_ecr_repository.portfolio_api_container_hub.repository_url}:latest" -f ../../application/containers/fastapi.Dockerfile ../..
		docker tag "${aws_ecr_repository.portfolio_api_container_hub.repository_url}:latest" "${aws_ecr_repository.portfolio_api_container_hub.repository_url}:${var.ECR_APP_VERSION}"
	    docker push "${aws_ecr_repository.portfolio_api_container_hub.repository_url}:latest"
		docker push "${aws_ecr_repository.portfolio_api_container_hub.repository_url}:${var.ECR_APP_VERSION}"
	    EOF
	  }
	

	  triggers = {
	    "run_at" = timestamp()
	  }
	

	  depends_on = [
	    aws_ecr_repository.portfolio_api_container_hub,
	  ]
}
