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

# Check if sudo is available and user has sudo privileges
check_sudo() {
    if command_exists sudo && sudo -n true 2>/dev/null; then
        return 0  # sudo available
    else
        return 1  # sudo not available or no privileges
    fi
}

# Check if required packages are installed
check_packages_installed() {
    local packages=("zsh" "curl" "git" "unzip")
    
    for pkg in "${packages[@]}"; do
        if ! command_exists "$pkg"; then
            return 1  # At least one package is missing
        fi
    done
    
    # Check for build tools
    if ! command_exists gcc && ! command_exists clang; then
        return 1  # No compiler found
    fi
    
    return 0  # All packages are installed
}

# Install system packages
install_system_packages() {
    log_info "Checking system packages..."
    
    # Check if packages are already installed
    if check_packages_installed; then
        log_success "All required packages are already installed"
        return 0
    fi
    
    # Packages are missing, check sudo availability
    if ! check_sudo; then
        log_warning "Some required packages are missing but sudo is not available or you don't have sudo privileges"
        log_warning "Please install the following packages manually: zsh, curl, git, build-essential/gcc, unzip, fontconfig"
        log_warning "Continuing with installation..."
        return 0
    fi
    
    # Packages are missing but sudo is available
    log_info "Installing missing system packages..."
    
    if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y zsh curl git build-essential unzip fontconfig
    elif command_exists yum; then
        sudo yum install -y zsh curl git gcc gcc-c++ make unzip fontconfig
    elif command_exists dnf; then
        sudo dnf install -y zsh curl git gcc gcc-c++ make unzip fontconfig
    elif command_exists pacman; then
        sudo pacman -S --noconfirm zsh curl git base-devel unzip fontconfig
    else
        log_warning "Unknown package manager. Please install zsh, curl, git, unzip, and fontconfig manually."
        return 1
    fi
    
    # Verify installation
    if check_packages_installed; then
        log_success "System packages installed successfully"
    else
        log_warning "Some packages may not have been installed correctly"
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

# Install spaceship prompt theme
install_spaceship_theme() {
    log_info "Installing spaceship prompt theme..."
    
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # Install spaceship prompt
    if [ ! -d "$zsh_custom/themes/spaceship-prompt" ]; then
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$zsh_custom/themes/spaceship-prompt" --depth=1
        log_success "spaceship-prompt cloned"
    else
        log_info "spaceship-prompt already installed"
    fi
    
    # Create symlink for spaceship theme
    if [ ! -L "$zsh_custom/themes/spaceship.zsh-theme" ]; then
        ln -s "$zsh_custom/themes/spaceship-prompt/spaceship.zsh-theme" "$zsh_custom/themes/spaceship.zsh-theme"
        log_success "spaceship theme symlink created"
    else
        log_info "spaceship theme symlink already exists"
    fi
}

# Install MesloLGS NF Font (Meslo Nerd Font patched for Powerlevel10k)
install_nerd_fonts() {
    log_info "Installing MesloLGS NF Font..."
    
    local font_dir="$HOME/.local/share/fonts"
    
    # Create fonts directory if it doesn't exist
    mkdir -p "$font_dir"
    
    # Check if MesloLGS NF is already installed
    if fc-list | grep -i "meslolgs nf" > /dev/null 2>&1; then
        log_info "MesloLGS NF Font already installed"
        return
    fi
    
    # Download and install MesloLGS NF fonts
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
        local font_file="${font//%20/ }"  # Replace %20 with spaces
        log_info "Downloading $font_file..."
        
        if ! curl -fsSL "$base_url/$font" -o "$font_dir/$font_file"; then
            log_error "Failed to download $font_file"
            download_success=false
        fi
    done
    
    if $download_success; then
        # Update font cache
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
    
    
    # Install fnm (Node.js version manager)
    if ! command_exists fnm; then
        log_info "Installing fnm..."
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
        log_success "fnm installed"
        
        # Source fnm for current session
        export PATH="$HOME/.local/share/fnm:$PATH"
        eval "$(fnm env --use-on-cd)"
        
        # Install Node.js LTS
        log_info "Installing Node.js LTS via fnm..."
        fnm install --lts
        fnm use lts-latest
        fnm default lts-latest
        log_success "Node.js LTS installed and set as default"
    else
        log_info "fnm already installed"
        
        # Check if Node.js is installed via fnm
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
    
    # Install bun (JavaScript runtime and package manager)
    if ! command_exists bun; then
        log_info "Installing bun..."
        curl -fsSL https://bun.sh/install | bash
        log_success "bun installed"
    else
        log_info "bun already installed"
    fi
    
    # Install uv (Python package manager)
    if ! command_exists uv; then
        log_info "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        log_success "uv installed"
    else
        log_info "uv already installed"
    fi
    
    # Install Rust
    if ! command_exists rustc; then
        log_info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        log_success "Rust installed"
    else
        log_info "Rust already installed"
    fi
    
    # Install Go
    if ! command_exists go; then
        log_info "Installing Go..."
        local go_version="1.21.5"
        local go_archive="go${go_version}.linux-amd64.tar.gz"
        
        # Download and install Go
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

# Install vim plugins
install_vim_plugins() {
    log_info "Installing vim plugins..."
    
    # Install vim-plug if not present
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        log_info "Installing vim-plug..."
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        log_success "vim-plug installed"
    else
        log_info "vim-plug already installed"
    fi
    
    # Install plugins
    log_info "Installing vim plugins (this may take a while)..."
    vim +PlugInstall +qall
    log_success "vim plugins installed"
}

# Backup existing dotfile
backup_file() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        local backup_path="${file_path}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$file_path" "$backup_path"
        log_warning "Backed up existing $(basename "$file_path") to $(basename "$backup_path")"
    fi
}

# Copy dotfile with backup
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

# Setup dotfiles
setup_dotfiles() {
    local platform=$(detect_platform)
    log_info "Setting up dotfiles for platform: $platform"
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy platform-specific dotfiles
    if [ "$platform" = "wsl" ]; then
        copy_dotfile "$SCRIPT_DIR/zsh/wsl/.zshrc" "$HOME/.zshrc"
        copy_dotfile "$SCRIPT_DIR/zsh/wsl/.zshenv" "$HOME/.zshenv"
    else
        copy_dotfile "$SCRIPT_DIR/zsh/linux/.zshrc" "$HOME/.zshrc"
        copy_dotfile "$SCRIPT_DIR/zsh/linux/.zshenv" "$HOME/.zshenv"
    fi
    
    # Copy other dotfiles
    copy_dotfile "$SCRIPT_DIR/vim/.vimrc" "$HOME/.vimrc"
    copy_dotfile "$SCRIPT_DIR/bash/.bashrc" "$HOME/.bashrc"
    copy_dotfile "$SCRIPT_DIR/bash/.bash_profile" "$HOME/.bash_profile"
    
    # Copy tmux config for Linux
    if [ "$platform" = "linux" ]; then
        copy_dotfile "$SCRIPT_DIR/tmux/linux/.tmux.conf" "$HOME/.tmux.conf"
        copy_dotfile "$SCRIPT_DIR/tmux/linux/.tmux.conf.local" "$HOME/.tmux.conf.local"
    fi
    
    log_success "Dotfiles copied successfully"
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
    install_spaceship_theme
    install_nerd_fonts
    install_dev_tools
    create_directories
    setup_dotfiles
    install_vim_plugins
    change_shell
    
    log_success "Installation completed successfully!"
    log_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
    log_info "Note: Some tools like juliaup, fnm, bun, uv, rust, and go require a new terminal session to be available in PATH"
    log_info "Don't forget to set your terminal font to 'MesloLGS NF Regular' for optimal display"
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
        echo "  - Install zsh and oh-my-zsh with spaceship theme"
        echo "  - Install required zsh plugins"
        echo "  - Install spaceship prompt theme"
        echo "  - Install MesloLGS NF Font (optimized for Powerlevel10k)"
        echo "  - Install development tools (juliaup, fnm, bun, uv, rust, go)"
        echo "  - Setup modern vim configuration with plugins"
        echo "  - Setup dotfiles with symbolic links"
        echo "  - Change default shell to zsh"
        exit 0
        ;;
    --dry-run)
        log_info "DRY RUN MODE - No changes will be made"
        log_info "Would install:"
        log_info "  - System packages: zsh, curl, git, build tools, unzip, fontconfig"
        log_info "  - oh-my-zsh with spaceship theme"
        log_info "  - zsh plugins: autosuggestions, syntax-highlighting"
        log_info "  - spaceship prompt theme"
        log_info "  - MesloLGS NF Font (optimized for Powerlevel10k)"
        log_info "  - Development tools: juliaup, fnm, bun, uv, rust, go"
        log_info "  - vim-plug and modern vim configuration"
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