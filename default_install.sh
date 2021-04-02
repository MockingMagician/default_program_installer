# friendly password
password=$(zenity --password)

# update password
echo $password | sudo -S apt upgrade

# install apt repositories
sudo apt install -y \
  xclip \
  terminator \
  zsh \
  docker.io \
  docker-compose \
  php \
  php-zip \
  php-intl \
  php-mbstring \
  composer \
  nodejs \
  npm \
  yarn \
  curl \
  wget

# install slack
slack=$(curl https://slack.com/intl/fr-fr/downloads/instructions/ubuntu | grep -oE https://downloads.slack-edge.com/linux_releases/.+\.deb) # fetch slack download url
wget -O slack.deb $slack # downlod file
sudo dpkg -i slack.deb # install
unlink slack.deb # delete installer

# install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add - # add repo key
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list # add repo
sudo apt update # update apt cache
sudo apt install anydesk # install anydesk

# install jetbrain toolbox
wget -O jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.7940.tar.gz # download installer
sudo -S tar -xf jetbrains-toolbox.tar.gz -C /opt # extract installer
cd /opt/jetbrains-toolbox-1.20.7940 && ./jetbrains-toolbox # install toolbox
cd - # go back
unlink jetbrains-toolbox.tar.gz # delete installer
zenity --info --text="continue to install program like phpstorm, etc... from the jetbrain toolbox window." --width=200 --height=100 # user message continue to manually install
