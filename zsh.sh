ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eturnilnetwork"
COMPLETION_WAITING_DOTS="true"
plugins=(git gitfast pip)

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/shellenv.sh

rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}

zle -N rationalise-dot
bindkey . rationalise-dot
