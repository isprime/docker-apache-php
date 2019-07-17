DOCKER_COMPOSE     = docker-compose

EXEC_PHP           = $(DOCKER_COMPOSE) exec -T web
COMPOSER           = $(EXEC_PHP) composer

##
## Project
## -------
##

build:
	$(DOCKER_COMPOSE) pull --ignore-pull-failures
	$(DOCKER_COMPOSE) build

kill:
	$(DOCKER_COMPOSE) kill
	$(DOCKER_COMPOSE) down --volumes --remove-orphans --rmi all

install: ## Install and start the project
install: build start

reset: ## Stop and start a fresh install of the project
reset: kill install

start: ## Start all project docker container
	$(DOCKER_COMPOSE) up -d --remove-orphans --no-recreate

stop: ## Stop the project
	$(DOCKER_COMPOSE) stop

clean: ## Stop the project and remove generated files
clean: kill
	rm -rf logs

.PHONY: build kill install reset start stop clean

##
## Utils
## -----
##

configure-ext: ## Configure php extensions
	$(EXEC_PHP) docker-php-ext-configure

install-ext: ## Intall php extensions
	$(EXEC_PHP) docker-php-ext-install

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: configure-ext install-ext help
