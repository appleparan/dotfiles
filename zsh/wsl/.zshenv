LS_COLORS=$LS_COLORS:'di=32:ow=1;34:' ; export LS_COLORS
alias ls="ls --color"

# zsh auto-completion
autoload -Uz compinit
compinit

# Rust
. "$HOME/.cargo/env"

# Go
GOPATH=${HOME}/go
PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Python
source $HOME/.local/bin/env
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Ruby
#eval "$(~/.rbenv/bin/rbenv init - zsh)"

# node
VOLTA_HOME=$HOME/.volta
PATH=$VOLTA_HOME:$PATH

# CUDA
export CUDA_HOME=/usr/local/cuda-12.8
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# ssh agent
eval `keychain --eval --agents ssh github hf`

#export KUBERNETES_MASTER=$(sudo grep server: /etc/rancher/k3s/k3s.yaml | cut -c13-)
#export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('$HOME/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
# remove dupliate path
typeset -U PATH
typeset -U LD_LIBRARY_PATH

export PATH
export LD_LIBRARY_PATH

. "/home/appleparan/.deno/env"

export KUBECONFIG=~/.kube/config

