MAKEFLAGS += --no-print-directory
.PHONY: app-start app-ps app-stats app-finish kill-project-app cloud-init-aws cloud-upgrade-aws \
		cloud-validate-aws cloud-plan-aws cloud-start-aws cloud-finish-aws cloud-list-state \
		cloud-remove-state-all cloud-logs cloud-logs-follow github-actions-cloud-start-aws

-include env/dev.env

app-start:
	@docker compose -p $(DOCKER_PROJECT_NAME) -f application/containers/$(DOCKER_ENV).docker-compose.yml up -d

app-ps:
	@docker compose -p $(DOCKER_PROJECT_NAME) -f application/containers/$(DOCKER_ENV).docker-compose.yml ps

app-stats:
	@docker stats --no-stream --format "table"

app-finish:
	@echo ">>>>> Remove containers"
	@docker compose -p $(DOCKER_PROJECT_NAME) -f application/containers/$(DOCKER_ENV).docker-compose.yml down --remove-orphans

kill-project-app:
	@echo ">>>>> Remove containers and images"
	@docker compose -p $(DOCKER_PROJECT_NAME) -f application/containers/$(DOCKER_ENV).docker-compose.yml down --rmi local --remove-orphans
	@docker system prune -f --volumes


cloud-init-aws:
	@cd terraform/aws && terraform init -reconfigure -lock=false

cloud-upgrade-aws:
	@cd terraform/aws && terraform init -upgrade

cloud-validate-aws:
	@cd terraform/aws && terraform validate

cloud-plan-aws:
	@cd terraform/aws && terraform plan -var-file="../../env/prod.tfvars"

cloud-start-aws:
	@cd terraform/aws && terraform apply -var-file="../../env/prod.tfvars" -auto-approve

cloud-finish-aws:
	@cd terraform/aws && terraform destroy -var-file="../../env/prod.tfvars" -auto-approve

cloud-list-state:
	@cd terraform/azure && terraform state list

cloud-remove-state-all:
	@cd terraform/azure && terraform state rm $$(terraform state list)

cloud-logs:
	

cloud-logs-follow:


# CI/CD Commands

github-actions-cloud-start-aws:
	@cd terraform/aws && terraform apply -auto-approve
