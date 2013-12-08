ZSH=$HOME/.oh-my-zsh
ZSH_THEME="eturnilnetwork"
COMPLETION_WAITING_DOTS="true"
plugins=(git gitfast git-extras pip python zsh-syntax-highlight)


source $ZSH/oh-my-zsh.sh
source ~/dotfiles/shellenv.sh


# just type '...' to get '../..'
rationalise-dot() {
    if [[ $LBUFFER =~ '(^|/| |      |'$'\n''|\||;|&)\.\.$' ]]; then
        LBUFFER+=/
        zle self-insert
        zle self-insert
    else
        zle self-insert
    fi
}

zle -N rationalise-dot
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
