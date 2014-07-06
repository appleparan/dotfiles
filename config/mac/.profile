export TERM="xterm-color"
export CLICOLOR="true"
export LSCOLORS=ExFxCxDxBxegedabagacad

alias ls='ls -FGw'
alias li='ls -lvh'

#TITLEBAR='\[\e]0:\u@\h:\w:\a\]'
#export PS1=${TITLEBAR}'\u@\H:\W\[\e[37:1m\]$\[\e[0m\]'
export PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\W \$\[\033[00m\] "
#export PS1='\[\033[0;36m\]\u@\h\[\033[01m\]:\[\033[0;35m\]\w\[\033[00m\]\[\033[1;30m\]\[\033[0;37m\]`__git_ps1 " (%s)"`\[\033[00m\]\[\033[0;37m\]\$ '

export PATH=$PATH:/usr/local/bin:/usr/local/sbin
