SHELL = /bin/bash

runway-deploy-master:
	@CI=1 DEPLOY_ENVIRONMENT=master runway deploy

runway-deploy-network:
	@CI=1 DEPLOY_ENVIRONMENT=network runway deploy

runway-deploy-commons:
	@CI=1 DEPLOY_ENVIRONMENT=commons runway deploy

runway-deploy-sandbox:
	@CI=1 DEPLOY_ENVIRONMENT=sandbox runway deploy

runway-deploy-develop:
	@CI=1 DEPLOY_ENVIRONMENT=develop runway deploy

runway-deploy-staging:
	@CI=1 DEPLOY_ENVIRONMENT=staging runway deploy

runway-deploy-product:
	@CI=1 DEPLOY_ENVIRONMENT=product runway deploy


#
# CAUTION: DESTRUCTIVE FUNCTIONS!
#
runway-destroy-master:
	@CI=1 DEPLOY_ENVIRONMENT=master  runway destroy

runway-destroy-network:
	@CI=1 DEPLOY_ENVIRONMENT=network runway destroy

runway-destroy-commons:
	@CI=1 DEPLOY_ENVIRONMENT=commons runway destroy

runway-destroy-sandbox:
	@CI=1 DEPLOY_ENVIRONMENT=sandbox runway destroy

runway-destroy-develop:
	@CI=1 DEPLOY_ENVIRONMENT=develop runway destroy

runway-destroy-staging:
	@CI=1 DEPLOY_ENVIRONMENT=staging runway destroy

runway-destroy-product:
	@CI=1 DEPLOY_ENVIRONMENT=product runway destroy

runway-destroy-all:
	@$(MAKE) runway-destroy-master
	@$(MAKE) runway-destroy-network
	@$(MAKE) runway-destroy-commons
	@$(MAKE) runway-destroy-sandbox
	@$(MAKE) runway-destroy-develop
	@$(MAKE) runway-destroy-staging
	@$(MAKE) runway-destroy-product