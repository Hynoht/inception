DOCKER_COMPOSE = docker-compose
FILE = ./srcs/docker-compose.yml


up: init
	@$(DOCKER_COMPOSE) -f $(FILE) up --build -d

down:
	@$(DOCKER_COMPOSE) -f $(FILE) down -v

restart: down up

clean:
	@docker system prune -f

logs:
	@$(DOCKER_COMPOSE) -f $(FILE) logs -f

ps:
	@docker ps

re: reset up

reset: down
	@docker system prune -a -f

init: 
	@./srcs/requirements/tools/init.sh || (echo "Échec d'initalisation'" && exit 1)

.PHONY: up down restart clean logs reset init
