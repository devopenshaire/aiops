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

$(NAME):
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory serve $(SERVER_HOST)
						@$(MAKE) --directory $(CURRENT_DIR) --no-print-directory aiops_compose

view_server_host:
						@echo $(SERVER_HOST)

aiops_compose:
						@DOCKER_LOCALHOST=$(DOCKER_LOCALHOST) \
						SERVER_HOST=$(SERVER_HOST) \
						docker compose up -d
ifeq ($(ARG1),)
ollama:
						@echo "\nPlease specify the command.\n" \
							"\te.g: make ollama serve\n" \
							"\t     make ollama stop\n"
else ifeq ($(ARG1),serve)
ollama:
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory $(ARG1) $(SERVER_HOST)
else ifeq ($(ARG1),stop)
ollama:
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory clean
endif

clean:
						@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory clean
						@docker compose down

fclean:					clean

re:						fclean all

f:						all clean

.PHONY:					all clean fclean re f \
						ollama
