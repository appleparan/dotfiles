# Modern .bash_profile Configuration
# Login shell configuration

# =============================================================================
# Source bashrc
# =============================================================================

# Get the aliases and functions from .bashrc
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

# =============================================================================
# Login Shell Specific Settings
# =============================================================================

# Set umask for better default permissions
umask 022

# =============================================================================
# Environment Variables (Login Shell)
# =============================================================================

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Create XDG directories if they don't exist
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# =============================================================================
# PATH Cleanup and Deduplication
# =============================================================================

# Function to remove duplicates from PATH
dedupe_path() {
    local path_var="$1"
    local old_path="${!path_var}:"
    local new_path=""
    
    while [[ -n "$old_path" ]]; do
        local entry="${old_path%%:*}"
        if [[ -n "$entry" ]] && [[ ":$new_path:" != *":$entry:"* ]]; then
            new_path="$new_path:$entry"
        fi
        old_path="${old_path#*:}"
    done
    
    new_path="${new_path#:}"
    export "$path_var"="$new_path"
}

# Remove duplicates from PATH
if [[ -n "$PATH" ]]; then
    dedupe_path PATH
fi

# Remove duplicates from LD_LIBRARY_PATH
if [[ -n "$LD_LIBRARY_PATH" ]]; then
    dedupe_path LD_LIBRARY_PATH
fi

# Remove duplicates from PYTHONPATH
if [[ -n "$PYTHONPATH" ]]; then
    dedupe_path PYTHONPATH
fi

# =============================================================================
# Development Environment Setup
# =============================================================================

# Python Development
if command -v python3 >/dev/null 2>&1; then
    # Set Python to use UTF-8 encoding
    export PYTHONIOENCODING=utf-8
    export PYTHONDONTWRITEBYTECODE=1
    
    # Python user site packages
    python_user_site=$(python3 -m site --user-site 2>/dev/null)
    if [[ -n "$python_user_site" ]]; then
        export PYTHONPATH="$python_user_site:$PYTHONPATH"
    fi
fi

# Rust/Cargo
if [[ -d "$HOME/.cargo" ]]; then
    export CARGO_HOME="$HOME/.cargo"
    source "$HOME/.cargo/env" 2>/dev/null
fi

# Node.js (fnm)
if [[ -d "$HOME/.local/share/fnm" ]]; then
    export FNM_PATH="$HOME/.local/share/fnm"
    export PATH="$FNM_PATH:$PATH"
    if command -v fnm >/dev/null 2>&1; then
        eval "$(fnm env --use-on-cd)"
    fi
fi

# Go
if [[ -d "/usr/local/go/bin" ]]; then
    export PATH="/usr/local/go/bin:$PATH"
fi
if [[ -d "$HOME/go/bin" ]]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

# Julia (juliaup)
if [[ -d "$HOME/.juliaup/bin" ]]; then
    export PATH="$HOME/.juliaup/bin:$PATH"
fi

# =============================================================================
# Terminal and Display Settings
# =============================================================================

# Set terminal capabilities
export TERM=${TERM:-xterm-256color}

# Better less options
export LESS="-R -M --shift 5"
export LESSOPEN="|lesspipe %s"

# Pager settings
export PAGER="less"

# =============================================================================
# SSH Agent Management (if not using keychain)
# =============================================================================

# Start SSH agent if not running
start_ssh_agent() {
    local ssh_env="$HOME/.ssh/environment"
    
    # Check if SSH agent is already running
    if [[ -n "$SSH_AGENT_PID" ]] && kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
        return 0
    fi
    
    # Try to load existing SSH agent environment
    if [[ -f "$ssh_env" ]]; then
        source "$ssh_env" >/dev/null
        if [[ -n "$SSH_AGENT_PID" ]] && kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
            return 0
        fi
    fi
    
    # Start new SSH agent
    echo "Starting SSH agent..."
    ssh-agent | sed 's/^echo/#echo/' > "$ssh_env"
    chmod 600 "$ssh_env"
    source "$ssh_env" >/dev/null
    
    # Add default keys
    if [[ -f "$HOME/.ssh/id_rsa" ]]; then
        ssh-add "$HOME/.ssh/id_rsa" 2>/dev/null
    fi
    if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
        ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null
    fi
}

# Only start SSH agent for login shells and if not in tmux
if [[ -z "$TMUX" ]] && [[ "$-" == *i* ]]; then
    # Check if keychain is available (preferred)
    if command -v keychain >/dev/null 2>&1; then
        # Use keychain if available
        eval "$(keychain --eval --quiet --agents ssh)"
    else
        # Fallback to custom SSH agent management
        start_ssh_agent
    fi
fi

# =============================================================================
# GPG Settings
# =============================================================================

# GPG TTY for signing
export GPG_TTY=$(tty)

# =============================================================================
# Platform-specific Settings
# =============================================================================

# WSL specific settings
if grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL display settings
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    export LIBGL_ALWAYS_INDIRECT=1
    
    # Windows interop
    export WSLENV="$WSLENV:DISPLAY"
fi

# macOS specific settings (for compatibility)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Use GNU tools if available
    if [[ -d "/usr/local/opt/coreutils/libexec/gnubin" ]]; then
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    fi
    
    # Homebrew
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
fi

# =============================================================================
# Local Customizations
# =============================================================================

# Source local bash_profile if it exists
if [[ -f ~/.bash_profile.local ]]; then
    source ~/.bash_profile.local
fi

# =============================================================================
# Final PATH cleanup
# =============================================================================

# Final deduplication of PATH
dedupe_path PATH

# Export final PATH
export PATH