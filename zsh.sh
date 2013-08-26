ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eturnilnetwork"
COMPLETION_WAITING_DOTS="true"
plugins=(git gitfast pip)

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/shellenv.sh

zle -N rationalise-dot
bindkey . rationalise-dot
