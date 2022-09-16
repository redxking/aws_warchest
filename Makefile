SHELL = /bin/bash

runway-deploy-master:
	@CI=1 DEPLOY_ENVIRONMENT=master runway deploy

runway-deploy-network:
	@CI=1 DEPLOY_ENVIRONMENT=network runway deploy

runway-deploy-commons:
	@CI=1 DEPLOY_ENVIRONMENT=commons runway deploy

runway-deploy-develop:
	@CI=1 DEPLOY_ENVIRONMENT=develop runway deploy

runway-deploy-staging:
	@CI=1 DEPLOY_ENVIRONMENT=staging runway deploy

runway-deploy-product:
	@CI=1 DEPLOY_ENVIRONMENT=product runway deploy