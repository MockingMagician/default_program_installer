#instal apt repositoring
password=$(zenity --password)
echo $password | sudo -S apt upgrade && sudo apt install -y \
  xclip \
  git \
  npm \
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

#instal slack
slack=$(curl https://slack.com/intl/fr-fr/downloads/instructions/ubuntu | grep -oE https://downloads.slack-edge.com/linux_releases/.+\.deb) #recup de l'url
wget -O slack.deb $slack #dwnld du fichier
sudo dpkg -i slack.deb #instal de slack
unlink slack.deb #supp fichier instal

#instal owmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#instal anydesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add - #ajouter cles repo
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list #ajoute repo
sudo apt update #update apt cache
sudo apt install anydesk #instal anydesk

#instal phpstorm
wget -O jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.7940.tar.gz #telecharger l'installer
sudo -S tar -xf jetbrains-toolbox.tar.gz -C /opt #extraire l'archive
cd /opt/jetbrains-toolbox-1.20.7940 && ./jetbrains-toolbox #installer toolbox
cd - #retour dans repertoire
unlink jetbrains-toolbox.tar.gz #supp le fichier apres installation
zenity --info --text="continuer l'installation dans tool box." --width=200 --height=100 #message pour la suite manuel
