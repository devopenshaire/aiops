```bash
OLLAMA_HOST=0.0.0.0:11434 docker run -d -v ${PWD}/ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
OLLAMA_HOST=0.0.0.0:11434 docker run -d -v ${PWD}/ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
docker exec -it ollama ollama run llama2
docker exec -it ollama ollama run llama3:8b

```

# GPU

```bash
sudo lshw -C display


# Simple command-line script (wrapper for nvidia-smi) for querying and monitoring GPU status
sudo apt install gpustat
gpustat -cp # --debug


sudo apt install radeontop
radeontop

lspci -vnnn | perl -lne 'print if /^\d+\:.+(\[\S+\:\S+\])/' | grep VGA
sudo lspci -vnnn |less
sudo lspci -vnnn | grep VGA
```

# Ref:
##  https://brainsteam.co.uk/2024/04/20/self-hosting-llama-3-on-a-home-server/
##  https://github.com/ollama/ollama/blob/main/docs/api.md
## 