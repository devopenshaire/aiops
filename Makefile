# OS Check
#
OS 						:= $(shell uname)
ifeq ($(OS), Linux)
    DOCKER_LOCALHOST 	= localhost
    SERVER_HOST			= 127.0.0.1 #TODO
else ifeq ($(OS), Darwin)
    DOCKER_LOCALHOST 	= docker.for.mac.localhost
    SERVER_HOST			= $(shell ifconfig \
						| grep -Eo 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' \
						| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' \
						| grep -v '127.0.0.1' \
						| grep -v '\.1$$')
    ifneq ($(shell echo "$(SERVER_HOST)" | grep -q "^192\.168"; echo $$?), 0)
        SERVER_HOST		= 127.0.0.1
	endif
else ifeq ($(OS), Windows_NT)
    DOCKER_LOCALHOST 	= localhost
    SERVER_HOST			= 127.0.0.1 #TODO
else
    #TODO
    DOCKER_LOCALHOST 	= localhost
    SERVER_HOST			= 127.0.0.1
endif

NAME					= aiops
CURRENT_DIR 			= $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))
OLLAMA_DIR				= $(CURRENT_DIR)/ollama
DOCKER_COMPOSE 			= DOCKER_LOCALHOST=$(DOCKER_LOCALHOST) \
							SERVER_HOST=$(SERVER_HOST) \
							docker-compose

# Command line arguments handler
#
RULES_WITH_ARGUMENTS	:= ollama test
FUNCTION 				= $(filter $(1),$(RULES_WITH_ARGUMENTS))
ifeq ($(call FUNCTION,$(firstword $(MAKECMDGOALS))),$(firstword $(MAKECMDGOALS)))
    ARG1 				:= $(word 2,$(MAKECMDGOALS))
    ARG2				:= $(word 3,$(MAKECMDGOALS))
    $(eval $(ARG1):;@:)
    $(eval $(ARG2):;@:)
endif

all:					$(NAME)

# Start all servers
#
$(NAME):
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory serve $(SERVER_HOST)
						@$(MAKE) --directory $(CURRENT_DIR) --no-print-directory aiops_compose

# View server host
#
view_server_host:
						@echo "http://$(SERVER_HOST)"

# Start all servers using Docker Compose
#
aiops_compose:
						@$(DOCKER_COMPOSE) up --build -d
						@$(MAKE) --no-print-directory view_server_host

# Print docker-compose command
#
view_docker_compose_command:
						@echo $(DOCKER_COMPOSE)

# Ollama server
# 	TODO: Add ollama commands pull, serve, etc.
ollama_command:
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory ollama_command

view_ollama_command:
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory view_ollama_command

# Clean
#
clean:
						@$(DOCKER_COMPOSE) down
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory clean

fclean:					clean

re:						fclean all

f:						all clean

.PHONY:					all clean fclean re f \
						view_server_host \
						aiops_compose \
						ollama
