# MAC
```bash
# Check connection to port
sudo lsof -nP -i4TCP | grep 11434
sudo lsof -nP -i4TCP | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}:11434' | tr -s " "
sudo lsof -nP -i4TCP | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}:11434' | tr -s " " | cut -d " " -f 2 
for i in `sudo lsof -nP -i4TCP | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}:11434' | tr -s " " | cut -d " " -f 2`; do kill -9 $i; done
```

# Linux (bash)
```bash
```