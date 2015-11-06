export SHELL=$HOME/usr/bin/zsh

alias cdgist="ssh 210.110.244.101 -p 1444 -l ycse02"

PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
PATH=$HOME/usr/bin:$HOME/.anyenv/bin:/engrid/enhpc/mpich3.0.4/bin:/engrid/enhpc/mpich2/intel/bin:$PATH:/bin

export PYENV_ROOT
export PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if which anyenv > /dev/null; then eval "$(anyenv init -)"; fi

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval `keychain --eval --agents ssh bitbucket_rsa github_rsa cdgist`
