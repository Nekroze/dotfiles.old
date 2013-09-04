if [ -d ~/dotfiles ]
then
  echo "\033[0;33mYou already have dotfiles installed.\033[0m You'll need to remove ~/dotfiles if you want to install"
  exit
fi

echo "\033[0;34mCloning dotfiles...\033[0m"
hash git >/dev/null && /usr/bin/env git clone https://github.com/Nekroze/dotfiles.git ~/dotfiles || {
  echo "git not installed"
  exit
}

QUITE=TRUE /usr/bin/env bash ~/dotfiles/install.sh
