LS_COLORS=$LS_COLORS:'di=32:ow=1;34:' ; export LS_COLORS
alias ls="ls --color"

# zsh auto-completion
autoload -Uz compinit
compinit

# Rust
. "$HOME/.cargo/env"

# Go
GOPATH=/usr/local/go
PATH=${GOPATH}/bin:$PATH

# Python
source $HOME/.local/bin/env
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Ruby
#eval "$(~/.rbenv/bin/rbenv init - zsh)"

# ssh agent
#eval `keychain --eval --agents ssh github hf`

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

export KUBECONFIG=~/.kube/config

FNM_PATH="/home/appleparan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/appleparan/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# bun completions
[ -s "/home/appleparan/.bun/_bun" ] && source "/home/appleparan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ====================
# CUDA Configuration
# ====================

export CUDA_HOME=/usr/local/cuda

# Add CUDA binaries to PATH
if [[ -d "$CUDA_HOME/bin" ]]; then
  path=("$CUDA_HOME/bin" $path)
fi

# Add CUDA libraries to LD_LIBRARY_PATH
if [[ -d "$CUDA_HOME/lib64" ]]; then
  export LD_LIBRARY_PATH="${CUDA_HOME}/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi

# opencode
export PATH=/home/appleparan/.opencode/bin:$PATH
export PATH="/home/appleparan/src/authentik:$PATH"
export PATH="/home/appleparan/src/authentik:$PATH"

# fnm
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
mkdir -p "$XDG_RUNTIME_DIR/fnm_multishells" 2>/dev/null

FNM_PATH="/home/appleparan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/appleparan/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/home/appleparan/.julia/juliaup/completions/zsh.zsh" ] && source "/home/appleparan/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<
. "/home/appleparan/.deno/env"
# fnm
FNM_PATH="/home/appleparan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/appleparan/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

#eval "$(zellij setup --generate-auto-start zsh)"
#
