# Functions
## Project Management
pullall() {
    echo
    echo "Updating all git repositories in ~/git"
    if [ -d ~/git ]; then
        cd ~/git
        for dir in */; do
            if [ -d $dir/.git ]; then
                echo
                echo "Pulling $dir"
                cd $dir
                git pull
                cd ../
            fi
        done
    fi
}
# Shell Aliases
dotupdate () {
    echo
    echo "Updating dotfiles repository"
    cd ~/dotfiles
    git pull
    cd ~/
}
## ls
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
## Mis Aliases
alias rpython=$RPYTHON
alias emacs=$EDITOR
alias clean='find ./ -iname "*.pyc" -exec rm {} \; && find ./ -iname "#*" -exec rm {} \;'
## Project Management
alias newproj='cookiecutter https://github.com/Nekroze/cookiecutter-pypackage.git'
## Package Management
update () {
    if hash apt-get >/dev/null; then
        exec sudo apt-get update
        exec sudo apt-get upgrade -y
    elif hash packer >/dev/null; then
        exec sudo packer -Syu --no-edit --no-confirm
    elif hash pacman >/dev/null; then
        exec sudo pacman -Syu
    fi
}
fullupdate () {
    update
    pullall
    dotupdate
}
## Stupidly Long
alias mc='mc -C base_color=lightgray,blue:normal=blue,default:reverse=green,default:gauge=gray,lightgray:selected=white,blue:marked=yellow,default:markselect=yellow,default:directory=brightblue,default:executable=brightgreen,default:link=cyan,default:device=brightmagenta,default:core=red,default:special=lightgray,default:dnormal=lightgray,blue:dfocus=lightgray,black:dhotnormal=yellow,blue:dhotfocus=yellow,black:menunormal=lightgray,blue:menuhot=yellow,blue:menusel=lightgray,black:menuhotsel=yellow,black:menuinactive=lightgray,gray:errors=lightgray,red:errdhotnormal=yellow,red:errdhotfocus=yellow,lightgray:input=lightblue,gray:inputunchanged=blue,gray:inputmark=white,blue:bbarhotkey=white,black:bbarbutton=lightgray,blue:viewbold=lightgray,default:viewunderline=lightblue,default:viewselected=lightgray,grey:helpnormal=lightgray,default:helpitalic=lightblue,default:helpbold=lightgray,default:helplink=green,default:helpslink=lighgreen,defalt:'
