alias ls='ls -FGw'
alias li='ls -lvh'

PYENV_ROOT="$HOME/.pyenv"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$PYENV_ROOT/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export SHELL=/usr/local/bin/zsh

eval `keychain --eval --agents ssh bitbucket_rsa github_console_rsa`

