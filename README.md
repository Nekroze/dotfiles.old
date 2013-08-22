dotfiles
========

dotfiles I use in my POSIX development environments.

Installation
------------

This repo contains a simple installer. From a new environment to full setup
this is all you need to do:

    $ cd ~/
    $ git clone https://github.com/Nekroze/dotfiles.git
    $ sh dotfile/install.sh
    
After this the next time your shell is started you will be using this
environment. Any files that get replaced will be moved to `~/dotfiles_old` for
backup.

Features
--------

* Great support for *zsh*
* Automatically installs *oh-my-zsh*
* A nice *zsh* prompt designed for *git* use with a *solarized* color scheme
* Handy *git* aliases to commong commands
* *Rpython* compilation alias for *pypy* compilation of *Rpython* to a binary
* Automatic dot rationalisation for directories in *zsh*
