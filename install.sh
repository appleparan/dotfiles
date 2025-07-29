#!/bin/bash

# Dotfiles Installation Script
# Automatically installs and configures zsh with oh-my-zsh and required tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect platform
detect_platform() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    else
        echo "linux"
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install system packages
install_system_packages() {
    log_info "Installing system packages..."
    
    if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y zsh curl git build-essential
    elif command_exists yum; then
        sudo yum install -y zsh curl git gcc gcc-c++ make
    elif command_exists dnf; then
        sudo dnf install -y zsh curl git gcc gcc-c++ make
    elif command_exists pacman; then
        sudo pacman -S --noconfirm zsh curl git base-devel
    else
        log_warning "Unknown package manager. Please install zsh, curl, and git manually."
    fi
}

# Install oh-my-zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "oh-my-zsh installed"
    else
        log_info "oh-my-zsh already installed"
    fi
}

# Install zsh plugins
install_zsh_plugins() {
    log_info "Installing zsh plugins..."
    
    # zsh-autosuggestions
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
        log_success "zsh-autosuggestions installed"
    else
        log_info "zsh-autosuggestions already installed"
    fi
    
    # zsh-syntax-highlighting
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting installed"
    else
        log_info "zsh-syntax-highlighting already installed"
    fi
}

# Install gallifrey theme
install_gallifrey_theme() {
    log_info "Installing gallifrey theme..."
    
    if [ ! -f "$HOME/.oh-my-zsh/custom/themes/gallifrey.zsh-theme" ]; then
        curl -fsSL https://raw.githubusercontent.com/yottaawesome/gallifrey-zsh-theme/master/gallifrey.zsh-theme \
            -o "$HOME/.oh-my-zsh/custom/themes/gallifrey.zsh-theme"
        log_success "gallifrey theme installed"
    else
        log_info "gallifrey theme already installed"
    fi
}

# Install development tools
install_dev_tools() {
    log_info "Installing development tools..."
    
    # Install juliaup (Julia version manager)
    if ! command_exists julia; then
        log_info "Installing juliaup..."
        curl -fsSL https://install.julialang.org | sh -s -- --yes
        log_success "juliaup installed"
    else
        log_info "Julia already installed"
    fi
    
    # Install deno
    if ! command_exists deno; then
        log_info "Installing deno..."
        curl -fsSL https://deno.land/install.sh | sh
        log_success "deno installed"
    else
        log_info "deno already installed"
    fi
    
    # Install fnm (Node.js version manager)
    if ! command_exists fnm; then
        log_info "Installing fnm..."
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
        log_success "fnm installed"
    else
        log_info "fnm already installed"
    fi
}

# Setup dotfiles
setup_dotfiles() {
    local platform=$(detect_platform)
    log_info "Setting up dotfiles for platform: $platform"
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Backup existing files
    if [ -f "$HOME/.zshrc" ]; then
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
        log_warning "Backed up existing .zshrc"
    fi
    
    if [ -f "$HOME/.zshenv" ]; then
        mv "$HOME/.zshenv" "$HOME/.zshenv.backup.$(date +%Y%m%d_%H%M%S)"
        log_warning "Backed up existing .zshenv"
    fi
    
    # Create symbolic links
    if [ "$platform" = "wsl" ]; then
        ln -sf "$SCRIPT_DIR/zsh/wsl/.zshrc" "$HOME/.zshrc"
        ln -sf "$SCRIPT_DIR/zsh/wsl/.zshenv" "$HOME/.zshenv"
    else
        ln -sf "$SCRIPT_DIR/zsh/linux/.zshrc" "$HOME/.zshrc"
        ln -sf "$SCRIPT_DIR/zsh/linux/.zshenv" "$HOME/.zshenv"
    fi
    
    # Link other dotfiles
    ln -sf "$SCRIPT_DIR/vim/.vimrc" "$HOME/.vimrc"
    ln -sf "$SCRIPT_DIR/bash/.bashrc" "$HOME/.bashrc"
    ln -sf "$SCRIPT_DIR/bash/.bash_profile" "$HOME/.bash_profile"
    
    # Link tmux config for Linux
    if [ "$platform" = "linux" ]; then
        ln -sf "$SCRIPT_DIR/tmux/linux/.tmux.conf" "$HOME/.tmux.conf"
        ln -sf "$SCRIPT_DIR/tmux/linux/.tmux.conf.local" "$HOME/.tmux.conf.local"
    fi
    
    log_success "Dotfiles linked successfully"
}

# Create necessary directories
create_directories() {
    log_info "Creating necessary directories..."
    
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.zsh/completions"
    
    log_success "Directories created"
}

# Change default shell to zsh
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

# Main installation function
main() {
    log_info "Starting dotfiles installation..."
    log_info "Platform detected: $(detect_platform)"
    
    install_system_packages
    install_oh_my_zsh
    install_zsh_plugins
    install_gallifrey_theme
    install_dev_tools
    create_directories
    setup_dotfiles
    change_shell
    
    log_success "Installation completed successfully!"
    log_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
    log_info "Note: Some tools like juliaup, deno, and fnm require a new terminal session to be available in PATH"
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Dotfiles Installation Script"
        echo ""
        echo "Usage: $0 [options]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --dry-run      Show what would be installed without actually installing"
        echo ""
        echo "This script will:"
        echo "  - Install zsh and oh-my-zsh"
        echo "  - Install required zsh plugins and themes"
        echo "  - Install development tools (juliaup, deno, fnm)"
        echo "  - Setup dotfiles with symbolic links"
        echo "  - Change default shell to zsh"
        exit 0
        ;;
    --dry-run)
        log_info "DRY RUN MODE - No changes will be made"
        log_info "Would install:"
        log_info "  - System packages: zsh, curl, git, build tools"
        log_info "  - oh-my-zsh"
        log_info "  - zsh plugins: autosuggestions, syntax-highlighting"
        log_info "  - gallifrey theme"
        log_info "  - Development tools: juliaup, deno, fnm"
        log_info "  - Dotfiles symlinks for platform: $(detect_platform)"
        exit 0
        ;;
    "")
        main
        ;;
    *)
        log_error "Unknown option: $1"
        log_info "Use --help for usage information"
        exit 1
        ;;
esac