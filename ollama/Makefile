NAME			= ollama
OLLAMA			= /usr/local/bin/ollama

CURRENT_DIR 	:= $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))
MODEL			= llama3:8b
MODELS_FOLDER	= $(CURRENT_DIR)/models
LOGS_FOLDER		= $(CURRENT_DIR)/../logs

IP				= $(shell ifconfig \
					| grep -Eo 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' \
					| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' \
					| grep -v '127.0.0.1' \
					| grep -v '\.1$$')
LOCALHOST		= 127.0.0.1
PORT			= 11434

# Command line arguments handler
#
RULES_WITH_ARGUMENTS	:= 	pull server test
FUNCTION 	= $(filter $(1),$(RULES_WITH_ARGUMENTS))
ifeq ($(call FUNCTION,$(firstword $(MAKECMDGOALS))),$(firstword $(MAKECMDGOALS)))
    ARG1 		:= $(word 2,$(MAKECMDGOALS))
    ARG1		:= $(subst :,\:,$(ARG1))
    $(eval $(ARG1):;@:)
	ARG1		:= $(subst \:,:,$(ARG1))
endif

all:			$(NAME)

$(NAME):
				@$(MAKE) --no-print-directory pull $(MODEL)
				@$(MAKE) --no-print-directory server

ip_view:
				@echo $(IP)

# Pull model
#
ifeq ($(ARG1),)
pull:
				@echo "\nPlease specify the model.\n" \
					"\te.g: make pull llama3:8b\n"
else
pull:
				@docker run --name ollama_temp -d --rm \
					-v $(MODELS_FOLDER):/root/.ollama/models \
					ollama/ollama:latest serve
				docker exec -it ollama_temp ollama pull $(ARG1)
				@docker stop ollama_temp		
endif

# Start server
#
ifeq ($(ARG1),)
           HOST	= $(LOCALHOST):$(PORT)
else
           HOST	= $(ARG1):$(PORT)
endif
server:
				OLLAMA_DEBUG=1 \
				OLLAMA_HOST=$(HOST) \
				OLLAMA_KEEP_ALIVE=5m \
				OLLAMA_MAX_LOADED_MODELS=100 \
				OLLAMA_MAX_QUEUE=256 \
				OLLAMA_MODELS="$(MODELS_FOLDER)" \
				OLLAMA_NUM_PARALLEL=1 \
				OLLAMA_NOPRUNE=0 \
				OLLAMA_ORIGINS="*" \
				OLLAMA_SCHED_SPREAD=0 \
				OLLAMA_TMPDIR="/tmp" \
				OLLAMA_FLASH_ATTENTION=0 \
				$(OLLAMA) serve > $(LOGS_FOLDER)/ollama.log 2>&1

clean:
				@docker stop ollama_temp 2>/dev/null || echo "\t- No docker contianer named 'ollama_temp' running"
				@pkill ollama 2>/dev/null || echo "\t- No ollama process running"

fclean:			clean

re:				fclean all

f:				all clean

.PHONY:			all clean fclean re f \
				ollama \
				ip_view \
				pull \
				server
