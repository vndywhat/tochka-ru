.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: env install build migrate

env: ## Setup environment variables
	cp .env.example .env

build: ## Build app image
	vendor/bin/sail build

migrate:
	vendor/bin/sail run --rm laravel.test php artisan voyager:install --with-dummy

install: ## Install Composer Packages
	docker run --rm \
        -u "$$(id -u):$$(id -g)" \
        -v "$$(pwd):/var/www/html" \
        -w /var/www/html \
        laravelsail/php82-composer:latest \
        composer install --ignore-platform-reqs

up: ## Start app
	vendor/bin/sail up -d

down: ## Stop app
	vendor/bin/sail down
