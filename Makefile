# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jefernan <jefernan@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/16 15:54:37 by jefernan          #+#    #+#              #
#    Updated: 2023/08/24 10:58:41 by jefernan         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LOGIN	= jefernan
COMPOSE	= srcs/docker-compose.yml
VOL_PATH	= /home/jefernan/data

all: srcs/.env up
	@make setup
	@make up

up:
	docker-compose --file=$(COMPOSE) up --build --detach

down:
	docker-compose --file=$(COMPOSE) down

setup: srcs/.env
	mkdir -p $(VOL_PATH)/wordpress
	mkdir -p $(VOL_PATH)/mariadb
	grep $(LOGIN).42.fr /etc/hosts || echo "127.0.0.1 $(LOGIN).42.fr" >> /etc/hosts


	


