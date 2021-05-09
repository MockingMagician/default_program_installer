# Working DIR
WD=$(pwd);

# APT repositories installation
apt-get update || exit
apt-get install -y \
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
  php-curl || exit

# PHP PECL cases
RUN pecl install apcu
RUN docker-php-ext-enable apcu
RUN pecl clear-cache

# Yarn case
apt-get remove -y cmdtest
apt-get install -y yarnpkg
mv /usr/bin/yarnpkg /usr/bin/yarn

# docker installation
# removing old package (if there)
apt-get remove -y docker docker-engine docker.io containerd runc
apt-get update
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# docker compose installation
DC_LAST_VER=$(curl -Ls -o /dev/null -w %"{url_effective}" https://github.com/docker/compose/releases/latest | grep -ohE "([^/]*$)")
DC_DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DC_LAST_VER/docker-compose-$(uname -s)-$(uname -m)"
curl -L "$DC_DOWNLOAD_URL" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# install slack
slack=$(curl https://slack.com/intl/fr-fr/downloads/instructions/ubuntu | grep -oE https://downloads.slack-edge.com/linux_releases/.+\.deb) # fetch slack download url
wget -O slack.deb $slack # downlod file
dpkg -i slack.deb # install
unlink slack.deb # delete installer

# install anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add - # add repo key
sh -c "echo 'deb http://deb.anydesk.com/ all main' > /etc/apt/sources.list.d/anydesk-stable.list" # add repo
apt-get update # update apt cache
apt install anydesk # install anydesk

# install oh my zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# install jetbrain toolbox
wget -O jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.7940.tar.gz # download installer
tar -xf jetbrains-toolbox.tar.gz -C /opt # extract installer
cd /opt/jetbrains-toolbox-1.20.7940 && ./jetbrains-toolbox # install toolbox
cd "$WD" || exit
unlink jetbrains-toolbox.tar.gz # delete installer
echo "continue to install program like phpstorm, etc... from the jetbrain toolbox window"
