#!/usr/bin/env bash
mkdir /home/ubuntu/thehive || true

echo 'Acquire::https::Proxy "http://192.168.50.10:3142/";' > /etc/apt/apt.conf.d/50proxy
echo 'Acquire::http::Proxy "http://192.168.50.10:3142/";' >> /etc/apt/apt.conf.d/50proxy


apt-get update
apt-get -y dist-upgrade

apt-get install -y git htop vim xfce4 slim virtualbox-guest-additions-iso \
                       terminator python3-pip python3-tk python3-dev \
                       ungoogled-chromium unzip
apt-get remove -y xfce4-panel

pip3 install python-dateutil selenium pillow pyautogui fake-useragent matplotlib opencv-python

sed -i 's/#default_user        simone/default_user        ubuntu/g' /etc/slim.conf
sed -i 's/#auto_login          no/auto_login          yes/g' /etc/slim.conf

echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Bionic/ /' | sudo tee /etc/apt/sources.list.d/home:ungoogled_chromium.list
sudo wget -nv https://download.opensuse.org/repositories/home:ungoogled_chromium/Ubuntu_Bionic/Release.key -O "/etc/apt/trusted.gpg.d/home:ungoogled_chromium.asc"

#wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/81.0.4044.138/chromedriver_linux64.zip
wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_linux64.zip
unzip /tmp/chromedriver.zip -d /usr/local/bin
chmod a+x /usr/local/bin/chromedriver


service slim restart
