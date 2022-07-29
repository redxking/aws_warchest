
runway-plan:
	@$(MAKE) execute-runway DEPLOY_ENVIRONMENT=develop ACTION=plan

runway-deploy:
	@$(MAKE) execute-runway DEPLOY_ENVIRONMENT=develop ACTION=deploy

runway-destroy:
	@$(MAKE) execute-runway DEPLOY_ENVIRONMENT=develop ACTION=destroy

rebuild-runway:
	@docker build --no-cache -t runway:latest --rm .

execute-runway:
	@docker run --rm -t -i \
		-e "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
		-e "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
		-e "AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}" \
		-e SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock \
		--mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock \
		--mount type=bind,src=$(CURDIR),target=/home/runway \
		runway:latest bash -c "DEPLOY_ENVIRONMENT=${DEPLOY_ENVIRONMENT} runway ${ACTION}"

