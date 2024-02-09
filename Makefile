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
	mkdir -p $(DIRS)
	$(CMD_DOCKER_COMPOSE_FILE) build

up:
	$(CMD_DOCKER_COMPOSE_FILE) up

down:
	$(CMD_DOCKER_COMPOSE_FILE) down

clean: down
	@rm -rf $(DATA_DIR)

fclean: clean
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);
	#docker network rm srcs_docker_network

.PHONY: build up down clean fclean
