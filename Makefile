DOCKER_COMPOSE = docker-compose

up:
	@$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml up --build -d

down:
	@$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml down

restart:
	@$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml restart

re: down up

status:
	@$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml ps

reset: down
	@docker system prune -a -f

.PHONY: up down restart
