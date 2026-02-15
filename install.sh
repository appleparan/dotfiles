#!/bin/bash

# Dotfiles Installation Script
# Full mode:    zsh + oh-my-zsh + dev tools (juliaup, fnm, bun, uv, rust, go)
# Minimal mode: bash-only + uv for Docker/container environments
#
# Usage:
#   ./install.sh              # Full installation
#   ./install.sh --minimal    # Minimal (Docker/container) installation

set -e

# =============================================================================
# Configuration
# =============================================================================

MINIMAL=false

# =============================================================================
# Colors and Logging
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# =============================================================================
# Utility Functions
# =============================================================================

detect_platform() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    else
        echo "linux"
    fi
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_sudo() {
    if command_exists sudo && sudo -n true 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

backup_file() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        local backup_path="${file_path}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$file_path" "$backup_path"
        log_warning "Backed up existing $(basename "$file_path") to $(basename "$backup_path")"
    fi
}

copy_dotfile() {
    local source="$1"
    local target="$2"

    if [ -f "$source" ]; then
        backup_file "$target"
        cp "$source" "$target"
        log_info "Copied $(basename "$source") to $(basename "$target")"
    else
        log_warning "Source file not found: $source"
    fi
}

# =============================================================================
# Package Installation
# =============================================================================

check_packages_installed() {
    if $MINIMAL; then
        local packages=("curl" "git" "python3" "pip3")
    else
        local packages=("zsh" "curl" "git" "unzip")
    fi

    for pkg in "${packages[@]}"; do
        if ! command_exists "$pkg"; then
            return 1
        fi
    done

    if ! $MINIMAL; then
        if ! command_exists gcc && ! command_exists clang; then
            return 1
        fi
    fi

    return 0
}

install_system_packages() {
    log_info "Checking system packages..."

    if check_packages_installed; then
        log_success "All required packages are already installed"
        return 0
    fi

    if ! check_sudo; then
        if $MINIMAL; then
            log_warning "Missing packages. Please install: curl, git, python3, python3-pip"
        else
            log_warning "Missing packages. Please install: zsh, curl, git, build-essential, unzip, fontconfig"
        fi
        log_warning "Continuing with installation..."
        return 0
    fi

    log_info "Installing missing system packages..."

    if command_exists apt-get; then
        sudo apt-get update
        if $MINIMAL; then
            sudo apt-get install -y curl git python3 python3-pip python3-venv
        else
            sudo apt-get install -y zsh curl git build-essential unzip fontconfig
        fi
    elif command_exists yum; then
        if $MINIMAL; then
            sudo yum install -y curl git python3 python3-pip
        else
            sudo yum install -y zsh curl git gcc gcc-c++ make unzip fontconfig
        fi
    elif command_exists dnf; then
        if $MINIMAL; then
            sudo dnf install -y curl git python3 python3-pip
        else
            sudo dnf install -y zsh curl git gcc gcc-c++ make unzip fontconfig
        fi
    elif command_exists pacman; then
        if $MINIMAL; then
            sudo pacman -S --noconfirm curl git python python-pip
        else
            sudo pacman -S --noconfirm zsh curl git base-devel unzip fontconfig
        fi
    else
        log_warning "Unknown package manager. Please install required packages manually."
        return 1
    fi

    if check_packages_installed; then
        log_success "System packages installed successfully"
    else
        log_warning "Some packages may not have been installed correctly"
    fi
}

# =============================================================================
# Full Mode: Zsh & Themes
# =============================================================================

install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "oh-my-zsh installed"
    else
        log_info "oh-my-zsh already installed"
    fi
}

install_zsh_plugins() {
    log_info "Installing zsh plugins..."

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
        log_success "zsh-autosuggestions installed"
    else
        log_info "zsh-autosuggestions already installed"
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting installed"
    else
        log_info "zsh-syntax-highlighting already installed"
    fi
}

install_spaceship_theme() {
    log_info "Installing spaceship prompt theme..."

    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [ ! -d "$zsh_custom/themes/spaceship-prompt" ]; then
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$zsh_custom/themes/spaceship-prompt" --depth=1
        log_success "spaceship-prompt cloned"
    else
        log_info "spaceship-prompt already installed"
    fi

    if [ ! -L "$zsh_custom/themes/spaceship.zsh-theme" ]; then
        ln -s "$zsh_custom/themes/spaceship-prompt/spaceship.zsh-theme" "$zsh_custom/themes/spaceship.zsh-theme"
        log_success "spaceship theme symlink created"
    else
        log_info "spaceship theme symlink already exists"
    fi
}

install_nerd_fonts() {
    log_info "Installing MesloLGS NF Font..."

    local font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"

    if fc-list | grep -i "meslolgs nf" > /dev/null 2>&1; then
        log_info "MesloLGS NF Font already installed"
        return
    fi

    log_info "Downloading MesloLGS NF Font..."

    local fonts=(
        "MesloLGS%20NF%20Regular.ttf"
        "MesloLGS%20NF%20Bold.ttf"
        "MesloLGS%20NF%20Italic.ttf"
        "MesloLGS%20NF%20Bold%20Italic.ttf"
    )

    local base_url="https://github.com/romkatv/powerlevel10k-media/raw/master"
    local download_success=true

    for font in "${fonts[@]}"; do
        local font_file="${font//%20/ }"
        log_info "Downloading $font_file..."

        if ! curl -fsSL "$base_url/$font" -o "$font_dir/$font_file"; then
            log_error "Failed to download $font_file"
            download_success=false
        fi
    done

    if $download_success; then
        if command_exists fc-cache; then
            fc-cache -f -v > /dev/null 2>&1
            log_success "MesloLGS NF Font installed and font cache updated"
        else
            log_success "MesloLGS NF Font installed"
            log_warning "Please install fontconfig and run 'fc-cache -f -v' to update font cache"
        fi
    else
        log_error "Some fonts failed to download"
    fi
}

# =============================================================================
# Development Tools
# =============================================================================

install_dev_tools() {
    log_info "Installing development tools..."

    # uv (both modes)
    if ! command_exists uv; then
        log_info "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        log_success "uv installed"
    else
        log_info "uv already installed"
    fi

    # Full mode only
    if $MINIMAL; then
        return
    fi

    # juliaup
    if ! command_exists julia; then
        log_info "Installing juliaup..."
        curl -fsSL https://install.julialang.org | sh -s -- --yes
        log_success "juliaup installed"
    else
        log_info "Julia already installed"
    fi

    # fnm
    if ! command_exists fnm; then
        log_info "Installing fnm..."
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
        log_success "fnm installed"

        export PATH="$HOME/.local/share/fnm:$PATH"
        eval "$(fnm env --use-on-cd)"

        log_info "Installing Node.js LTS via fnm..."
        fnm install --lts
        fnm use lts-latest
        fnm default lts-latest
        log_success "Node.js LTS installed and set as default"
    else
        log_info "fnm already installed"

        if ! fnm list | grep -q "lts"; then
            log_info "Installing Node.js LTS via fnm..."
            fnm install --lts
            fnm use lts-latest
            fnm default lts-latest
            log_success "Node.js LTS installed and set as default"
        else
            log_info "Node.js LTS already installed via fnm"
        fi
    fi

    # bun
    if ! command_exists bun; then
        log_info "Installing bun..."
        curl -fsSL https://bun.sh/install | bash
        log_success "bun installed"
    else
        log_info "bun already installed"
    fi

    # Rust
    if ! command_exists rustc; then
        log_info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        log_success "Rust installed"
    else
        log_info "Rust already installed"
    fi

    # Go
    if ! command_exists go; then
        log_info "Installing Go..."
        local go_version="1.21.5"
        local go_archive="go${go_version}.linux-amd64.tar.gz"

        curl -fsSL "https://go.dev/dl/${go_archive}" -o "/tmp/${go_archive}"
        if check_sudo; then
            sudo rm -rf /usr/local/go
            sudo tar -C /usr/local -xzf "/tmp/${go_archive}"
            rm "/tmp/${go_archive}"
            log_success "Go installed"
        else
            log_warning "Go installation requires sudo privileges. Please install Go manually from https://golang.org/dl/"
        fi
    else
        log_info "Go already installed"
    fi
}

# =============================================================================
# Vim Plugins
# =============================================================================

install_vim_plugins() {
    log_info "Installing vim plugins..."

    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        log_info "Installing vim-plug..."
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        log_success "vim-plug installed"
    else
        log_info "vim-plug already installed"
    fi

    log_info "Installing vim plugins (this may take a while)..."
    vim +PlugInstall +qall
    log_success "vim plugins installed"
}

# =============================================================================
# Dotfiles Setup
# =============================================================================

create_directories() {
    log_info "Creating necessary directories..."

    mkdir -p "$HOME/.local/bin"

    if ! $MINIMAL; then
        mkdir -p "$HOME/.zsh/completions"
    fi

    log_success "Directories created"
}

setup_dotfiles() {
    local platform=$(detect_platform)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    if $MINIMAL; then
        log_info "Setting up minimal dotfiles for platform: $platform"

        copy_dotfile "$SCRIPT_DIR/vim/minimal/.vimrc" "$HOME/.vimrc"
        copy_dotfile "$SCRIPT_DIR/bash/.bashrc.minimal" "$HOME/.bashrc"
        copy_dotfile "$SCRIPT_DIR/bash/.bash_profile.minimal" "$HOME/.bash_profile"
    else
        log_info "Setting up dotfiles for platform: $platform"

        # Zsh config (platform-specific)
        if [ "$platform" = "wsl" ]; then
            copy_dotfile "$SCRIPT_DIR/zsh/wsl/.zshrc" "$HOME/.zshrc"
            copy_dotfile "$SCRIPT_DIR/zsh/wsl/.zshenv" "$HOME/.zshenv"
        else
            copy_dotfile "$SCRIPT_DIR/zsh/linux/.zshrc" "$HOME/.zshrc"
            copy_dotfile "$SCRIPT_DIR/zsh/linux/.zshenv" "$HOME/.zshenv"
        fi

        # Vim, bash, tmux
        copy_dotfile "$SCRIPT_DIR/vim/.vimrc" "$HOME/.vimrc"
        copy_dotfile "$SCRIPT_DIR/bash/.bashrc" "$HOME/.bashrc"
        copy_dotfile "$SCRIPT_DIR/bash/.bash_profile" "$HOME/.bash_profile"

        if [ "$platform" = "linux" ]; then
            copy_dotfile "$SCRIPT_DIR/tmux/linux/.tmux.conf" "$HOME/.tmux.conf"
            copy_dotfile "$SCRIPT_DIR/tmux/linux/.tmux.conf.local" "$HOME/.tmux.conf.local"
        fi
    fi

    log_success "Dotfiles copied successfully"
}

change_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_info "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        log_success "Default shell changed to zsh"
        log_warning "Please log out and log back in for the shell change to take effect"
    else
        log_info "zsh is already the default shell"
    fi
}

# =============================================================================
# Main
# =============================================================================

main() {
    if $MINIMAL; then
        log_info "Starting minimal (Docker/container) installation..."
    else
        log_info "Starting full installation..."
    fi
    log_info "Platform detected: $(detect_platform)"

    install_system_packages
    install_dev_tools
    create_directories
    setup_dotfiles
    install_vim_plugins

    if ! $MINIMAL; then
        install_oh_my_zsh
        install_zsh_plugins
        install_spaceship_theme
        install_nerd_fonts
        change_shell
    fi

    log_success "Installation completed successfully!"

    if $MINIMAL; then
        log_info "Please restart your terminal or run 'source ~/.bashrc' to apply changes"
        log_info ""
        log_info "Installed:"
        log_info "  - uv (fast Python package manager)"
        log_info "  - Minimal vim configuration with essential plugins"
        log_info "  - Minimal bash configuration (no bash-it dependency)"
    else
        log_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
        log_info "Note: Some tools require a new terminal session to be available in PATH"
        log_info "Don't forget to set your terminal font to 'MesloLGS NF Regular' for optimal display"
    fi
}

# =============================================================================
# Argument Handling
# =============================================================================

show_help() {
    echo "Dotfiles Installation Script"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --minimal      Minimal installation for Docker/container environments"
    echo "                 (bash + uv + minimal vim, no zsh/oh-my-zsh)"
    echo "  --dry-run      Show what would be installed without actually installing"
    echo "  --help, -h     Show this help message"
    echo ""
    echo "Full mode (default):"
    echo "  - zsh + oh-my-zsh with spaceship theme"
    echo "  - MesloLGS NF Font"
    echo "  - Dev tools: juliaup, fnm, bun, uv, rust, go"
    echo "  - Modern vim + bash + tmux configs"
    echo ""
    echo "Minimal mode (--minimal):"
    echo "  - bash-only (no zsh)"
    echo "  - uv (Python package manager)"
    echo "  - Minimal vim + bash configs for containers"
}

show_dry_run() {
    log_info "DRY RUN MODE - No changes will be made"
    log_info "Mode: $( $MINIMAL && echo 'minimal' || echo 'full' )"
    log_info "Platform: $(detect_platform)"
    log_info ""

    if $MINIMAL; then
        log_info "Would install:"
        log_info "  - System packages: curl, git, python3, python3-pip"
        log_info "  - Python tools: uv"
        log_info "  - vim-plug and minimal vim configuration"
        log_info "  - Minimal bash configuration for Docker/container environments"
    else
        log_info "Would install:"
        log_info "  - System packages: zsh, curl, git, build tools, unzip, fontconfig"
        log_info "  - oh-my-zsh with spaceship theme"
        log_info "  - zsh plugins: autosuggestions, syntax-highlighting"
        log_info "  - MesloLGS NF Font"
        log_info "  - Development tools: juliaup, fnm, bun, uv, rust, go"
        log_info "  - vim-plug and modern vim configuration"
        log_info "  - Dotfiles for platform: $(detect_platform)"
    fi
}

# Parse arguments
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --minimal)
            MINIMAL=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            log_info "Use --help for usage information"
            exit 1
            ;;
    esac
done

if $DRY_RUN; then
    show_dry_run
else
    main
fi
