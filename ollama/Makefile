NAME			= ai
OLLAMA			= /usr/local/bin/ollama
CURRENT_DIR 	:= $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))

MODELS			= llama3:8b \
					gemma2:2b

IP				= $(shell ifconfig \
					| grep -Eo 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' \
					| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' \
					| grep -v '127.0.0.1' \
					| grep -v '\.1$$')

# Command line arguments handler
#
RULES_WITH_ARGUMENTS	:= 	pull
CONTAINTS_FUNCTION 	= $(filter $(1),$(RULES_WITH_ARGUMENTS))
ifeq ($(call CONTAINTS_FUNCTION,$(firstword $(MAKECMDGOALS))),$(firstword $(MAKECMDGOALS)))
    ARG1 		:= $(word 2,$(MAKECMDGOALS))
    # ARG2 		:= $(word 3,$(MAKECMDGOALS))
    $(eval $(ARG1)|;@|)
    # $(eval $(ARG2)|;@|)
endif

test:
				@echo $(CURRENT_DIR)

all:			$(NAME)

ip_view:
				@echo $(IP)

pull:

# Pull model
#
ifndef ARG1
pull:
							@echo "\nPlease specify the model.\n" \
								"\te.g: make pull llama3:8b\n"
else
pull:
				@docker run --name ollama_test -d --rm -v $(CURRENT_DIR)/models:/root/.ollama/models ollama/ollama:latest serve
				docker exec -it ollama_test ollama pull $(ARG1)
				@docker stop ollama_test		
endif

ollama:
				OLLAMA_DEBUG=1 \
				OLLAMA_HOST=$(IP):11434 \
				OLLAMA_KEEP_ALIVE=5m \
				OLLAMA_MAX_LOADED_MODELS=100 \
				OLLAMA_MAX_QUEUE=256 \
				OLLAMA_MODELS="$(CURRENT_DIR)/ollama/models" \
				OLLAMA_NUM_PARALLEL=1 \
				OLLAMA_NOPRUNE=0 \
				OLLAMA_ORIGINS="*" \
				OLLAMA_SCHED_SPREAD=0 \
				OLLAMA_TMPDIR="/tmp" \
				OLLAMA_FLASH_ATTENTION=0 \
				$(OLLAMA) serve


clean:
				/bin/rm -f $(OBJS)

fclean:			clean

re:				fclean all

f:				all clean

.PHONY:			all clean fclean re f ollama test