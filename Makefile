#!make
include srcs/.env

COMPOSE_FILE			=	./srcs/docker-compose.yml
DATA_DIR			=	/home/$(MYSQL_USER)/data

WORDPRESS_DIR			=	$(DATA_DIR)/wordpress
MYSQL_DIR			=	$(DATA_DIR)/mysql

DIRS				=	$(WORDPRESS_DIR) $(MYSQL_DIR)

CMD_DOCKER_COMPOSE		=	docker compose
CMD_DOCKER_COMPOSE_FILE		=	$(CMD_DOCKER_COMPOSE) -f $(COMPOSE_FILE)

all: build up

build:
	sudo mkdir -p $(DIRS)
	$(CMD_DOCKER_COMPOSE_FILE) build

up:
	$(CMD_DOCKER_COMPOSE_FILE) up

down:
	$(CMD_DOCKER_COMPOSE_FILE) down

clean: down
	@sudo rm -rf $(DIRS)

.PHONY: build up down clean
