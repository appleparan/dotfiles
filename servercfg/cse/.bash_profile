# .bash_profile

# Get the aliases and functions
PATH=/bin:/usr/bin:/usr/local/bin:/engrid/ensge/bin/lx24-amd64/
LD_LIBRARY_PATH=/lib:/lib64:/usr/lib:/usr/lib64

PATH=$HOME/usr/local/tmux/bin:$PATH
PATH=$HOME/usr/local/zsh/bin:$PATH

export PATH
export LD_LIBRARY_PATH
export SHELL=$HOME/usr/local/zsh/bin/zsh
export EVENT_NOEPOLL=1 
[ -f $HOME/usr/local/zsh/bin/zsh ] && exec $HOME/usr/local/zsh/bin/zsh -l

#if [ -n "$BASH_VERSION" ]; then
#    # include .bashrc if it exists
#    if [ -f "$HOME/.bashrc" ]; then
#        . "$HOME/.bashrc"
#    fi
#fi

#PYTHONPATH=$HOME/usr/lib64/python2.6/site-packages:$PYTHONPATH
#
#export PYENV_ROOT
#export LD_LIBRARY_PATH
#export PYTHONPATH
#
#eval "$(anyenv init -)"
#eval "$(pyenv virtualenv-init -)"

#alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"
#
## User specific environment and startup programs
## Remove duplicates : http://unix.stackexchange.com/a/40973
#if [ -n "$PATH" ]; then
#  old_PATH=$PATH:; PATH=
#  while [ -n "$old_PATH" ]; do
#    x=${old_PATH%%:*}       # the first remaining entry
#    case $PATH: in
#      *:"$x":*) ;;         # already there
#      *) PATH=$PATH:$x;;    # not there yet
#    esac
#    old_PATH=${old_PATH#*:}
#  done
#  PATH=${PATH#:}
#  unset old_PATH x
#fi
#echo "Environmental variable \$PATH"
#echo $PATH
#
#if [ -n "$LD_LIBRARY_PATH" ]; then
#  old_LD_LIBRARY_PATH=$LD_LIBRARY_PATH:; LD_LIBRARY_PATH=
#  while [ -n "$old_LD_LIBRARY_PATH" ]; do
#    x=${old_LD_LIBRARY_PATH%%:*}       # the first remaining entry
#    case $LD_LIBRARY_PATH: in
#      *:"$x":*) ;;         # already there
#      *) LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$x;;    # not there yet
#    esac
#    old_LD_LIBRARY_PATH=${old_LD_LIBRARY_PATH#*:}
#  done
#  LD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}
#  unset old_LD_LIBRARY_PATH x
#fi
#echo "Environmental variable \$LD_LIBRARY_PATH"
#echo $LD_LIBRARY_PATH
#
#eval `keychain --eval --agents ssh bitbucket_rsa github_rsa cdgist`
