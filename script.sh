#!/bin/bash
for I in {1..5}; do
  echo $I
  sudo useradd -m megastar$I --shell /bin/bash
  sudo useradd -m superstar$I --shell /bin/bash
  sleep 1
done
cat /etc/passwd | grep -i megastar
sudo apt install -y stress jq net-tools
ps -ef | grep  -i  nginx
