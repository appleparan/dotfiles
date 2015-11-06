# .bash_profile

# Get the aliases and functions
export SHELL=$HOME/usr/bin/zsh
export EVENT_NOEPOLL=1 
[ -f $HOME/usr/bin/zsh ] && exec $HOME/usr/bin/zsh -l

#if [ -f ~/.bashrc ]; then
#	. ~/.bashrc
#fi

PATH=$HOME/.anyenv/bin:$HOME/bin:$HOME/usr/bin:$PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$HOME/lib:$LD_LIBRARY_PATH
PYTHONPATH=$HOME/usr/lib64/python2.6/site-packages:$PYTHONPATH:

export PYENV_ROOT
export LD_LIBRARY_PATH
export PYTHONPATH

eval "$(anyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
