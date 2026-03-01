# Variables
GO_BIN = ~/go/bin
APP_NAME = todocli
SRC_DIR = ./cmd/todocli
AIR = ~/go/bin/air
GOOSE = goose
SQLC = sqlc
MIGRATIONS_DIR = ./internal/db/migrations
WEB_DIR = ./web

include .env
export

.PHONY: dev
dev:
	${AIR} serve

.PHONY: dev-web
dev-web:
	cd ${WEB_DIR} && pnpm dev

.PHONY: build
build:
	go build -o $(APP_NAME) $(SRC_DIR)

.PHONY: migrate-up
migrate-up:
	$(GOOSE) -dir=${MIGRATIONS_DIR} postgres $(DATABASE_URL) up

.PHONY: migrate-down
migrate-down:
	$(GOOSE) -dir=${MIGRATIONS_DIR} postgres $(DATABASE_URL) down

.PHONY: migrate-reset
migrate-reset:
	$(GOOSE) -dir=${MIGRATIONS_DIR} postgres $(DATABASE_URL) reset

.PHONY: migrate-status
migrate-status:
	$(GOOSE) -dir=${MIGRATIONS_DIR} postgres $(DATABASE_URL) status

.PHONY: sqlc
sqlc:
	$(SQLC) generate
