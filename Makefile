include .env

STAGE ?= dev
PROJECT_NAME ?= beti-infra
ACCOUNT_ALIAS ?= default
STACK_NAME ?= $(PROJECT_NAME)-$(STAGE)

package:
	sam package --profile $(ACCOUNT_ALIAS) \
		--output-template-file BuildArtifact.yml

deploy:
	sam deploy --profile $(ACCOUNT_ALIAS) --stack-name $(STACK_NAME) \
		--no-fail-on-empty-changeset \
		--no-disable-rollback

all: package deploy

delete:
	aws cloudformation --profile $(ACCOUNT_ALIAS) delete-stack --stack-name $(STACK_NAME)
