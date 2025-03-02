# Variables to set in the environment:
#
# 	OLLAMA_HOST				- Host and port to run the ollama server
# 	OLLAMA_PORT				- Port to run the ollama server
# 	OLLAMA_BIN				- Path to the ollama binary
# 	OLLAMA_LOGS				- Path to the logs folder
#	OLLAMA_DEFAULT_MODEL	- Default model to use

#	export OLLAMA_HOST=192.168.1.42
# 	export OLLAMA_PORT=11434
# 	export OLLAMA_BIN=/usr/local/bin/ollama
# 	export OLLAMA_LOGS=/var/log/ollama

NAME						= ollama
CURRENT_DIR 				= $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))

OLLAMA_BIN 					?= ollama
OLLAMA_DEFAULT_MODEL		?= llama3.2:3b
OLLAMA_HOST					?= 127.0.0.1:$(OLLAMA_PORT)
OLLAMA_LOGS					?= $(CURRENT_DIR)/../logs
OLLAMA_PORT					?= 11434

# Ollama command
#
OLLAMA_COMMAND				= OLLAMA_HOST=$(OLLAMA_HOST) $(OLLAMA_BIN)

# Command line arguments handler
#
RULES_WITH_ARGUMENTS		:= 	pull
FUNCTION 					= $(filter $(1),$(RULES_WITH_ARGUMENTS))
ifeq ($(call FUNCTION,$(firstword $(MAKECMDGOALS))),$(firstword $(MAKECMDGOALS)))
    ARG1 					:= $(word 2,$(MAKECMDGOALS))
    ARG1					:= $(subst :,\:,$(ARG1))
    $(eval $(ARG1):;@:)
    ARG1					:= $(subst \:,:,$(ARG1))
endif

all:						$(NAME)

$(NAME):
							@$(MAKE) --no-print-directory pull $(DEFAULT_MODEL)
							@$(MAKE) --no-print-directory serve

# Start server
#
serve:
							$(OLLAMA_COMMAND) serve > $(OLLAMA_LOGS)/ollama.log 2>&1 &
							@echo Host: http://$(HOST)

# Pull a model
#
pull:
							$(OLLAMA_COMMAND) pull $(ARG1)

# View configuration
#
view-config:
							@echo "Variables:\n" \
									"\tOLLAMA_BIN=$(OLLAMA_BIN)\n" \
									"\tOLLAMA_DEFAULT_MODEL=$(OLLAMA_DEFAULT_MODEL)\n" \
									"\tOLLAMA_HOST=$(OLLAMA_HOST)\n" \
									"\tOLLAMA_LOGS=$(OLLAMA_LOGS)\n" \
									"\tOLLAMA_PORT=$(OLLAMA_PORT)\n" \
								"\nCommands:\n" \
									"\tollama: $(OLLAMA_COMMAND)\n"

clean:
							pkill ollama 2>/dev/null || echo "\t- No ollama process running"

fclean:						clean # Remove logs & models
#							rm -rf $(OLLAMA_LOGS)/*

re:							fclean all

.PHONY:						all clean fclean re \
							ollama \
							pull \
							view-config \
							serve
