#export TERM="xterm-color"
#export CLICOLOR="true"
#export LSCOLORS=ExFxCxDxBxegedabagacad

alias ls='ls -FGw'
alias li='ls -lvh'

#TITLEBAR='\[\e]0:\u@\h:\w:\a\]'
#export PS1=${TITLEBAR}'\u@\H:\W\[\e[37:1m\]$\[\e[0m\]'
#export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$\[\033[00m\] "
#export PS1='\[\033[0;36m\]\u@\h\[\033[01m\]:\[\033[0;35m\]\w\[\033[00m\]\[\033[1;30m\]\[\033[0;37m\]`__git_ps1 " (%s)"`\[\033[00m\]\[\033[0;37m\]\$ '

PYENV_ROOT="$HOME/.pyenv"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$PYENV_ROOT/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export SHELL=/usr/local/bin/zsh

eval `keychain --eval --agents ssh bitbucket_rsa github_console_rsa`
