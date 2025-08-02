# Modern .bashrc Configuration
# Optimized for Python development with bashit framework

# =============================================================================
# Environment Variables
# =============================================================================

# Set default editor
export EDITOR='vim'
export VISUAL='vim'

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History configuration
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="ls:ll:la:cd:pwd:exit:date:* --help"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# Enable colored output
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# =============================================================================
# Bash Options
# =============================================================================

# Enable useful bash options
shopt -s histappend        # Append to history file, don't overwrite
shopt -s checkwinsize      # Check window size after each command
shopt -s cdspell           # Correct minor spelling errors in cd
shopt -s dirspell          # Correct minor spelling errors in directory names
shopt -s autocd            # Change to a directory just by typing its name
shopt -s globstar          # Enable ** recursive globbing
shopt -s nocaseglob        # Case-insensitive globbing
shopt -s dotglob           # Include dotfiles in pathname expansion

# Prevent file overwrite on stdout redirection
set -o noclobber

# =============================================================================
# PATH Management
# =============================================================================

# Function to safely add to PATH
add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# Add common directories to PATH
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"
add_to_path "$HOME/.cargo/bin"

# Python user base
if command -v python3 >/dev/null 2>&1; then
    python_user_base=$(python3 -m site --user-base 2>/dev/null)
    if [[ -n "$python_user_base" ]]; then
        add_to_path "$python_user_base/bin"
    fi
fi

# =============================================================================
# Bash-it Configuration
# =============================================================================

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
export BASH_IT_THEME='powerline'

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this
export BASH_IT_COMMAND_DURATION=true

# Set Xterm/screen/Tmux title with shortened command and directory.
export SHORT_TERM_LINE=true

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
if [[ -f "$BASH_IT/bash_it.sh" ]]; then
    source "$BASH_IT/bash_it.sh"
fi

# =============================================================================
# Completions
# =============================================================================

# Enable programmable completion features
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

# Git completion
if [[ -f /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
fi

# =============================================================================
# Python Development Tools
# =============================================================================

# uv (Python package manager) - if installed
if command -v uv >/dev/null 2>&1; then
    eval "$(uv generate-shell-completion bash)"
fi

# pipx completion
if command -v pipx >/dev/null 2>&1; then
    eval "$(register-python-argcomplete pipx)"
fi

# =============================================================================
# Aliases
# =============================================================================

# Enhanced ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -altrF'     # Sort by time
alias lh='ls -alh'       # Human readable sizes

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# File operations
alias mkdir='mkdir -pv'
alias rmdir='rmdir -v'

# System information
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='top -d 1'
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Network
alias ping='ping -c 5'
alias ports='netstat -tulanp'

# Git aliases (if not using bash-it git plugin)
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gst='git stash'

# Python development
alias py='python3'
alias pip='python3 -m pip'
alias venv='python3 -m venv'
alias serve='python3 -m http.server'

# Quick editing
alias vimrc='vim ~/.bashrc'
alias bashrc='vim ~/.bashrc'
alias reload='source ~/.bashrc'

# =============================================================================
# Functions
# =============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find process by name
pgrep_name() {
    ps aux | grep -i "$1" | grep -v grep
}

# Weather function (using wttr.in)
weather() {
    local city="${1:-Seoul}"
    curl -s "wttr.in/$city?format=3"
}

# Quick git commit
qcommit() {
    git add -A && git commit -m "$1"
}

# Create and activate Python virtual environment
pyenv_create() {
    python3 -m venv "${1:-venv}" && source "${1:-venv}/bin/activate"
}

# Activate Python virtual environment
pyenv_activate() {
    if [[ -f "${1:-venv}/bin/activate" ]]; then
        source "${1:-venv}/bin/activate"
    else
        echo "Virtual environment not found: ${1:-venv}"
    fi
}

# =============================================================================
# FZF Integration (if available)
# =============================================================================

if command -v fzf >/dev/null 2>&1; then
    # FZF key bindings and completion
    if [[ -f ~/.fzf.bash ]]; then
        source ~/.fzf.bash
    fi
    
    # FZF configuration
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*" -not -path "*/node_modules/*" -not -path "*/__pycache__/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    
    # FZF functions
    fcd() {
        local dir
        dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
    }
    
    fvim() {
        local file
        file=$(fzf) && vim "$file"
    }
fi

# =============================================================================
# Custom Prompt (fallback if bash-it theme fails)
# =============================================================================

# Git prompt function
git_prompt() {
    local git_branch
    if git_branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        local git_status=""
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            git_status="*"
        fi
        echo " (${git_branch}${git_status})"
    fi
}

# Set custom prompt if bash-it is not available
if [[ ! -f "$BASH_IT/bash_it.sh" ]]; then
    # Colors
    RED='\[\033[0;31m\]'
    GREEN='\[\033[0;32m\]'
    YELLOW='\[\033[1;33m\]'
    BLUE='\[\033[0;34m\]'
    PURPLE='\[\033[0;35m\]'
    CYAN='\[\033[0;36m\]'
    WHITE='\[\033[1;37m\]'
    NC='\[\033[0m\]' # No Color
    
    # Prompt
    PS1="${BLUE}\u${NC}@${GREEN}\h${NC}:${YELLOW}\w${PURPLE}\$(git_prompt)${NC}\$ "
fi

# =============================================================================
# Local Customizations
# =============================================================================

# Source local bashrc if it exists
if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

# Source global definitions (compatibility)
if [[ -f /etc/bashrc ]]; then
    source /etc/bashrc
fi

# =============================================================================
# Auto-activation of Python virtual environment
# =============================================================================

# Auto-activate venv when entering project directory
auto_activate_venv() {
    if [[ -f "venv/bin/activate" && "$VIRTUAL_ENV" != "$PWD/venv" ]]; then
        echo "Activating virtual environment: venv"
        source venv/bin/activate
    elif [[ -f ".venv/bin/activate" && "$VIRTUAL_ENV" != "$PWD/.venv" ]]; then
        echo "Activating virtual environment: .venv"
        source .venv/bin/activate
    fi
}

# Hook into cd command
cd() {
    builtin cd "$@" && auto_activate_venv
}

# Check for venv on shell startup
auto_activate_venv