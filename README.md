dotfiles
========

dotfiles I use in my POSIX development environments. While designed for use in
an ubuntu based distribution of linux, these dotfiles will work in almost any
POSIX based environment. The only part likely to fail is the package
installations and maybe some of the aliases for package management.

Features
--------

* Completely modular and reusable design
* Great support for *zsh*
* Automatically installs *oh-my-zsh*
* A nice *zsh* prompt designed for *git* use with a *solarized* color scheme
* Handy *git* aliases to commong commands
* *Rpython* compilation alias for *pypy* compilation of *Rpython* to a binary
* Automatic dot rationalisation for directories in *zsh*
* Sets *emacs* as the default text editor using a daemon for fast loading
* Nice *solorized* style theme for *terminator*
* Can automatically install some basic tools for using *python*
* Many handy configurations and tools for *emacs*

Installation
------------

This repo contains a simple installer. From a new environment to full setup
this is all you need to do:

    $ git clone https://github.com/Nekroze/dotfiles.git ~/dotfiles
    $ python ~/dotfiles/dotfiles.py
    
If you have curl or wget you can use either of the following commands:

    $ curl -L https://github.com/Nekroze/dotfiles/raw/master/grab.sh | sh
    $ wget --no-check-certificate https://github.com/Nekroze/dotfiles/raw/master/grab.sh -O -
    
After this the next time your shell is started you will be using this
environment.

Once installed you will have your own `~/.bashrc` and `~/.zshrc` that are setup
to load the settings of this repo but allow you to tack on your own settings to
these files as well without it interupting this dotfiles repo at all.

Usage
-----

Some usage examples and tutorials.

### ZSH

It is highly recomended that you use these dotfiles in concert with the excelent
*zsh* shell. You can switch your default shell over with this little command:

    $ chsh -s `which zsh`
    
### Emacs

These dotfiles come with a nice amount of support for emacs. If emacs is your jam
or you are undecided I highly recomend it.

You will have a setup to make emacs your default command line text editor but it
will execute a custom command that makes emacs run in the background for much
faster loading and run exclusively in the console.

This can be tweaked if you want but give it a go first.

### Python Projects

If you work with python often you might like the following command for
creating a skeleton python project with some rather nice accoutrements.

    $ newproj
    
Which simply asks you a few questions about you and your project and creates
a new directory ready for developing top quality python projects.

For more information on the project template this command uses visit 
https://github.com/Nekroze/cookiecutter-pypackage the template repository.

Maintenance
-----------

There are some handy commands to keep your environment up to date. If you use
zsh then oh-my-zsh will automatically check for updates. You can update your
dotfiles at any time by calling:

    $ dotupdate
    
You can also update all git repositories (pull them from their remotes) in
the `~/projects/` directory. If you do store you repositories there that is. To
perform a pull on each repo simply call:

    $ pullall
    
If you are running a system that uses the ``apt-get`` package manager you can
use the following command to update all installed packages:

    $ update
    
For convenience you can run all of the maintenance commands at once by calling:

    $ fullupdate
