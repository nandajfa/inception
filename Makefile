# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jefernan <jefernan@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/16 15:54:37 by jefernan          #+#    #+#              #
#    Updated: 2023/08/31 13:44:26 by jefernan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN	= \e[92m
RESET	= \e[0m

LOGIN	= jefernan
COMPOSE	= srcs/docker-compose.yml
VOLUME	= /home/jefernan/data

all: run

run:
	@echo "$(GREEN)** Files for volumes ** $(RESET)"
	@sudo mkdir -p $(VOLUME)/wordpress
	@sudo mkdir -p $(VOLUME)/mariadb
	@echo "$(GREEN)** Compose Up ** $(RESET)"
	@docker-compose --file=$(COMPOSE) up --build --detach
	@sudo grep $(LOGIN).42.fr /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts

up:
	@echo "$(GREEN)** Compose Up ** $(RESET)"
	@docker-compose --file=$(COMPOSE) up --build --detach 

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

clean: down

fclean: clean
	@echo "$(GREEN)** Removing data... **$(RESET)"
	@sudo rm -rf $(VOLUME)
	@sudo sed -in '/127.0.0.1 $(LOGIN).42.fr/d' /etc/hosts
	
re: fclean all
	@echo "$(GREEN)** Restarting containers... **$(RESET)"

.PHONY: all run up down start stop ls clean fclean re
