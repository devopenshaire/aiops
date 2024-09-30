NAME			= aiops
CURRENT_DIR 	= $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))
OLLAMA_DIR		= $(CURRENT_DIR)/ollama

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

all:			$(NAME)

$(NAME):		aiops_compose

aiops_compose:
				HOST=docker.for.mac.localhost \
				docker compose up -d

ollama:
				@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory ollama

clean:
				@$(MAKE) --directory $(OLLAMA_DIR) --no-print-directory clean
				docker compose down

fclean:			clean

re:				fclean all

f:				all clean

.PHONY:			all clean fclean re f \
				ollama
