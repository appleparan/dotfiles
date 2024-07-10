
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

LS_COLORS=$LS_COLORS:'di=32:ow=1;34:' ; export LS_COLORS
alias ls="ls --color"

# Rust
. "$HOME/.cargo/env"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Go
GOPATH=${HOME}/go
PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
PYENV_ROOT="$HOME/.pyenv"
export PATH=$HOME/.poetry/bin:$HOME/.pyenv/bin:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# ssh agent
eval `keychain --eval --agents ssh github hf`

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/appleparan/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# eval "$(~/.rbenv/bin/rbenv init - zsh)"

# remove dupliate path
typeset -U PATH
typeset -U LD_LIBRARY_PATH

export PATH
export LD_LIBRARY_PATH


