.PHONY: help init plan apply destroy test deploy status clean

help:
	@echo "YouTube Data Engineering Pipeline - Commands"
	@echo ""
	@echo "Deployment:"
	@echo "  make init              Initialize Terraform"
	@echo "  make plan              Show Terraform plan"
	@echo "  make apply             Deploy infrastructure"
	@echo "  make destroy           Destroy all resources"
	@echo ""
	@echo "Testing:"
	@echo "  make lambda-invoke     Test Lambda function"
	@echo "  make status            Show pipeline status"
	@echo ""
	@echo "Utilities:"
	@echo "  make clean             Clean artifacts"
	@echo "  make cost-estimate     Show cost estimate"
	@echo ""

init:
	cd terraform && terraform init

plan:
	cd terraform && terraform plan

apply:
	cd terraform && terraform apply

destroy:
	cd terraform && terraform destroy

lambda-invoke:
	@echo "Invoking Lambda..."
	@aws lambda invoke \
		--function-name youtube-data-pipeline-prod-ingestion \
		--payload '{"regions": ["US"], "date": "2024-01-01"}' \
		response.json
	@cat response.json | jq '.'

status:
	@echo "Pipeline Status:"
	@aws stepfunctions list-state-machines | jq '.stateMachineArns[] | select(contains("youtube"))'
	@echo ""
	@echo "Lambda Functions:"
	@aws lambda list-functions | jq '.Functions[] | select(.FunctionName | contains("youtube")) | {Name: .FunctionName, Runtime: .Runtime}'

cost-estimate:
	@echo "Estimated Monthly Costs:"
	@echo "Lambda:        \$$40"
	@echo "Glue:          \$$5"
	@echo "S3:            \$$2.30"
	@echo "Athena:        \$$5"
	@echo "Step Functions: \$$25"
	@echo "Other:         \$$1"
	@echo "─────────────────────"
	@echo "Total:         \$$78/month"

clean:
	rm -rf terraform/.terraform terraform/.terraform.lock.hcl terraform/tfplan
	rm -f response.json error_response.json

.DEFAULT_GOAL := help
