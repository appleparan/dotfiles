# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
if [ -n "$PATH" ]; then
  old_PATH=$PATH:; PATH=
  while [ -n "$old_PATH" ]; do
    x=${old_PATH%%:*}       # the first remaining entry
    case $PATH: in
      *:"$x":*) ;;         # already there
      *) PATH=$PATH:$x;;    # not there yet
    esac
    old_PATH=${old_PATH#*:}
  done
  PATH=${PATH#:}
  unset old_PATH x
fi

if [ -n "$LD_LIBRARY_PATH" ]; then
  old_LD_LIBRARY_PATH=$LD_LIBRARY_PATH:; LD_LIBRARY_PATH=
  while [ -n "$old_LD_LIBRARY_PATH" ]; do
    x=${old_LD_LIBRARY_PATH%%:*}       # the first remaining entry
    case $LD_LIBRARY_PATH: in
      *:"$x":*) ;;         # already there
      *) LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$x;;    # not there yet
    esac
    old_LD_LIBRARY_PATH=${old_LD_LIBRARY_PATH#*:}
  done
  LD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}
  unset old_LD_LIBRARY_PATH x
fi

