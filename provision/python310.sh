#!/bin/sh
# sudo apt install software-properties-common -y
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:deadsnakes/ppa -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y \
python3.10 \
python3.10-dev \
python3.10-venv \
python3.10-lib2to3 \
python3.10-gdbm
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
sudo apt -y remove --purge python3-apt
sudo apt autoclean
sudo apt -y install python3-apt
sudo apt install python3.10-distutils
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3.10 get-pip.py
sudo -H pip3.10 install virtualenv
sudo -H pip3.10 install virtualenv
sudo pip3.10 install jupyter
