# OS Check
#
# Get the OS type
OS 					:= $(shell uname)
ifeq ($(OS), Linux)
    LOCALHOST		= 127.0.0.1
else ifeq ($(OS), Darwin)
    LOCALHOST		= docker.for.mac.localhost
    SERVER_HOST		= $(shell ifconfig \
					| grep -Eo 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' \
					| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' \
					| grep -v '127.0.0.1' \
					| grep -v '\.1$$')
    ifneq ($(shell echo "$(SERVER_HOST)" | grep -q "^192\.168"; echo $$?), 0)
        SERVER_HOST	= 127.0.0.1
	endif
else ifeq ($(OS), Windows_NT)
else
endif

NAME				= aiops
CURRENT_DIR 		= $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))
OLLAMA_DIR			= $(CURRENT_DIR)/ollama

# # Command line arguments handler
# #
# RULES_WITH_ARGUMENTS	:=
# FUNCTION 	= $(filter $(1),$(RULES_WITH_ARGUMENTS))
# ifeq ($(call FUNCTION,$(firstword $(MAKECMDGOALS))),$(firstword $(MAKECMDGOALS)))
#     ARG1 		:= $(word 2,$(MAKECMDGOALS))
#     ARG1		:= $(subst :,\:, $(ARG1))
#     $(eval $(ARG1):;@:)
# 	ARG1		:= $(subst \:,:, $(ARG1))
# endif

all:				$(NAME)

test:
					@echo $(SERVER_HOST)

$(NAME):			aiops_compose

aiops_compose:
					@LOCALHOST=$(LOCALHOST) \
					SERVER_HOST=$(SERVER_HOST) \
					docker compose up -d

ollama:
					@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory ollama

clean:
					@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory clean
					@docker compose down

fclean:				clean

re:					fclean all

f:					all clean

.PHONY:				all clean fclean re f \
					ollama
