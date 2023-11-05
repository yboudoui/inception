# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: llescure <llescure@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/06/03 10:40:53 by llescure          #+#    #+#              #
#    Updated: 2021/08/02 10:47:36 by llescure         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE=./srcs/docker-compose.yml

all: run

run: 
	@sudo mkdir -p /home/llescure/data/wordpress
	@sudo mkdir -p /home/llescure/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up --build

up:
	@sudo mkdir -p /home/llescure/data/wordpress
	@sudo mkdir -p /home/llescure/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up -d --build

debug:
	@sudo mkdir -p /home/llescure/data/wordpress
	@sudo mkdir -p /home/llescure/data/mysql
	@docker-compose -f $(COMPOSE_FILE) --verbose up

list:	
	 docker ps -a

list_volumes:
	docker volume ls

clean: 	
	@docker-compose -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	@sudo rm -rf /home/llescure/data/wordpress
	@sudo rm -rf /home/llescure/data/mysql

.PHONY: run up debug list list_volumes clean
