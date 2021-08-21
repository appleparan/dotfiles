
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

LS_COLORS=$LS_COLORS:'di=32:ow=1;34:' ; export LS_COLORS
alias ls="ls --color"

# basic PATH & LD_LIBRARY_PATH
PATH=/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
LD_LIBRARY_PATH=/lib:/usr/lib:/usr/lib/x86_64-linux-gnu

# CUDA
PATH=/usr/local/cuda/bin:$PATH
LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

# user defined executable path
PATH=$HOME/usr/bin:$PATH

# user defined LD_LIBARY_PATH
LD_LIBRARY_PATH=$HOME/usr/lib:$HOME/usr/lib64:$LD_LIBRARY_PATH

# Rust
. "$HOME/.cargo/env"

# Ruby
. "/etc/profile.d/rvm.sh"

# Go
GOPATH=${HOME}/go
ATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Julia
## JULIA PATH
JULIA_BINDIR=/usr/local/julia/bin
PATH=$JULIA_BINDIR:$PATH

# Python
PYENV_ROOT="$HOME/.pyenv"
export PATH=$HOME/.poetry/bin:$HOME/.pyenv/bin:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init --path)"; fi
#if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# ssh agent
eval `keychain --eval --agents ssh github`

# remove dupliate path
typeset -U PATH
typeset -U LD_LIBRARY_PATH

export PATH
export LD_LIBRARY_PATH

