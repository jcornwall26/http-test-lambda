export TF_VAR_pagerduty_key := xyz

plan-lambda-nonprod:
	terraform plan -var-file ./nonprod/main.tfvars

plan-lambda-prod:
	terraform plan -var-file ./nonprod/main.tfvars

create-lambda-nonprod:
	terraform apply -var-file ./nonprod/main.tfvars

create-lambda-prod:
	terraform apply -var-file ./nonprod/main.tfvars