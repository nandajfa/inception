# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jefernan <jefernan@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/16 15:54:37 by jefernan          #+#    #+#              #
#    Updated: 2023/08/25 17:31:17 by jefernan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN	= \e[92m
RESET	= \e[0m

LOGIN	= jefernan
COMPOSE	= srcs/docker-compose.yml
VOLUME	= /home/jefernan/data

all: up

up:
	@echo "$(GREEN)** Files for volumes ** $(RESET)"
	@sudo mkdir -p $(VOLUME)/wordpress
	@sudo mkdir -p $(VOLUME)/mariadb
	@echo "$(GREEN)** Compose Up ** $(RESET)"
	@docker-compose --file=$(COMPOSE) up --build --detach
	@grep $(LOGIN).42.fr /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" >> /etc/hosts

down:
	@echo "$(GREEN)** Compose down ** $(RESET)"
	@docker-compose --file=$(COMPOSE) down --rmi all --remove-orphans -v

start:
	@echo "$(GREEN)** Start containers ** $(RESET)"
	@docker-compose --file=$(COMPOSE) start

stop:
	@echo "$(GREEN)** Stop containers ** $(RESET)"
	@docker-compose --file=$(COMPOSE) stop

ls:
	@echo "$(GREEN)**** List containers ****$(RESET)"
	@docker container ls -a
	@echo "$(GREEN)**** List Images ****$(RESET)"
	@docker images ls -a
	@echo "$(GREEN)**** List Volumes ****$(RESET)"
	@docker volume ls
	@echo "$(GREEN)**** List Network ****$(RESET)"
	@docker network ls

clean: stop

fclean: clean
	@echo "$(GREEN)** Removing containers... **$(RESET)"
	@docker ps -qa | xargs docker rm
	@echo "$(GREEN)** Removing images... **$(RESET)"
	@docker rmi -f $$(docker images -qa)
	@echo "$(GREEN)** Removing volumes... **$(RESET)"
	@docker volume rm $$(docker volume ls -q)
	@echo "$(GREEN)** Removing network... **$(RESET)"
	@docker network rm inception
	@echo "$(GREEN)** Removing data... **$(RESET)"
	@sudo rm -rf $(VOLUME)
	
re: fclean all
	@echo "$(GREEN)** Restarting containers... **$(RESET)"

.PHONY: all up down start stop ls clean fclean re
