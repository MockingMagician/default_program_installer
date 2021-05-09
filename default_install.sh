WD=$(pwd);

# friendly password
PASSWORD=$(zenity --password)

# update password
echo "$PASSWORD" | sudo -S apt-get update

sudo apt-get update && apt-get install -y \
	libzip-dev \
	libxml2-dev \
	libonig-dev \
	libcurl-ocaml-dev \
	zlib1g-dev \
	xclip \
	zsh \
	nodejs \
	npm \
	curl \
	git \
	zip \
	unzip \
	gpg \
	vim \
	nano \
	wget \
  php \
  php-zip \
  php-xml \
  php-intl \
  php-mbstring \
  php-pcntl \
  php-bcmath \
  php-fileinfo \
  php-pdo \
  php-pdo_mysql \
  php-curl \
  php-opcache \
  php-apcu \
  php-curl

# PHP PECL cases
RUN pecl install apcu
RUN docker-php-ext-enable apcu
RUN pecl clear-cache

# Yarn case
sudo apt-get remove -y cmdtest
sudo apt-get install -y yarnpkg
sudo mv /usr/bin/yarnpkg /usr/bin/yarn

# docker installation
# removing old package (if there)
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# docker compose installation
DC_LAST_VER=$(curl -Ls -o /dev/null -w %"{url_effective}" https://github.com/docker/compose/releases/latest | grep -ohE "([^/]*$)")
DC_DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DC_LAST_VER/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -L "$DC_DOWNLOAD_URL" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install slack
slack=$(curl https://slack.com/intl/fr-fr/downloads/instructions/ubuntu | grep -oE https://downloads.slack-edge.com/linux_releases/.+\.deb) # fetch slack download url
wget -O slack.deb $slack # downlod file
sudo dpkg -i slack.deb # install
unlink slack.deb # delete installer

# install anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add - # add repo key
sudo sh -c "echo 'deb http://deb.anydesk.com/ all main' > /etc/apt/sources.list.d/anydesk-stable.list" # add repo
sudo apt-get update # update apt cache
sudo apt install anydesk # install anydesk

# install oh my zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# install jetbrain toolbox
wget -O jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.7940.tar.gz # download installer
sudo -S tar -xf jetbrains-toolbox.tar.gz -C /opt # extract installer
cd /opt/jetbrains-toolbox-1.20.7940 && ./jetbrains-toolbox # install toolbox
cd "$WD" || exit
unlink jetbrains-toolbox.tar.gz # delete installer
zenity --info --text="continue to install program like phpstorm, etc... from the jetbrain toolbox window." --width=200 --height=100 # user message continue to manually install
