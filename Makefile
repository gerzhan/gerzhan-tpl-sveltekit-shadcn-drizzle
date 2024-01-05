.DEFAULT_GOAL := help

# -*- globals -*- #
SRC_DIR = src
# BUILD_DIR - путь к директории сборки
BUILD_DIR = build
CLEAN += $(BUILD_DIR)/*

VERSION = $(shell node -e 'console.log(require("./package.json").version)')

PUBLIC_DOMAIN_NAME=localhost.dev

#--- добавление переменных из переменных окружения
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

MAKEFILE_LIST = Makefile
THIS_DIR := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

# NOTE: самодокументирование команд makefile
help: ## help - отображение списка доступных команд
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

mkcert_create: ## mkcert_create - первичная генерация ssl сертификатов для локальной разработки
	mkdir -p .mkcert && echo .mkcert >> .gitignore && echo .mkcert >> .dockerignore
	mkcert -key-file ./.mkcert/key.pem -cert-file ./.mkcert/cert.pem $(PUBLIC_DOMAIN_NAME) "*.$(PUBLIC_DOMAIN_NAME)" localhost

version: ## version - текущая версия репозитория
	@printf "%s\n" "$(VERSION)"

domain: ## domain name
	@printf "%s\n" "$(PUBLIC_DOMAIN_NAME) "

db_studio: ## db_studio - UI для просмотра содеражения БД
	npx drizzle-kit studio --config=drizzle.config.ts

db_check: ## db_check - проверить БД и сформировать migration/meta/_journal.json
	npx drizzle-kit check:sqlite --config=drizzle.config.ts

db_generate: ## db_generate - применить миграции к БД
	npx drizzle-kit generate:sqlite --config=drizzle.config.ts

db_push: ## db_push - применить миграции к БД
	npx drizzle-kit push:sqlite --config=drizzle.config.ts

.PHONY: help start mkcert_create

# -*- cleanup -*- #
.PHONY: clean
clean: ## clean - удаление всех собранных приложений и библиотек
	rm -fr $(CLEAN)