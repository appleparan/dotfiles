#!/bin/bash

# Minimal Dotfiles Installation Script for Python Development
# Focused on Python development with bash environment

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
    local packages=("curl" "git" "python3" "pip3")
    
    for pkg in "${packages[@]}"; do
        if ! command_exists "$pkg"; then
            return 1  # At least one package is missing
        fi
    done
    
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
        log_warning "Please install the following packages manually: curl, git, python3, python3-pip"
        log_warning "Continuing with installation..."
        return 0
    fi
    
    # Packages are missing but sudo is available
    log_info "Installing missing system packages..."
    
    if command_exists apt-get; then
        sudo apt-get update
        sudo apt-get install -y curl git python3 python3-pip python3-venv
    elif command_exists yum; then
        sudo yum install -y curl git python3 python3-pip
    elif command_exists dnf; then
        sudo dnf install -y curl git python3 python3-pip
    elif command_exists pacman; then
        sudo pacman -S --noconfirm curl git python python-pip
    else
        log_warning "Unknown package manager. Please install curl, git, python3, and python3-pip manually."
        return 1
    fi
    
    # Verify installation
    if check_packages_installed; then
        log_success "System packages installed successfully"
    else
        log_warning "Some packages may not have been installed correctly"
    fi
}

# Install bashit framework
install_bashit() {
    log_info "Installing bash-it framework..."
    
    if [ ! -d "$HOME/.bash_it" ]; then
        log_info "Cloning bash-it repository..."
        git clone --depth=1 https://github.com/Bash-it/bash-it.git "$HOME/.bash_it"
        
        # Install bash-it non-interactively
        log_info "Installing bash-it..."
        "$HOME/.bash_it/install.sh" --silent
        
        log_success "bash-it installed"
    else
        log_info "bash-it already installed"
    fi
}

# Install Python development tools
install_python_tools() {
    log_info "Installing Python development tools..."
    
    # Install uv (Python package manager)
    if ! command_exists uv; then
        log_info "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        log_success "uv installed"
    else
        log_info "uv already installed"
    fi
    
    # Install pipx for global Python tools
    if ! command_exists pipx; then
        log_info "Installing pipx..."
        python3 -m pip install --user pipx
        python3 -m pipx ensurepath
        log_success "pipx installed"
    else
        log_info "pipx already installed"
    fi
    
    # Install common Python development tools via pipx
    log_info "Installing Python development tools via pipx..."
    
    local tools=("black" "isort" "flake8" "mypy" "pytest" "ipython")
    
    for tool in "${tools[@]}"; do
        if ! command_exists "$tool"; then
            log_info "Installing $tool..."
            pipx install "$tool"
            log_success "$tool installed"
        else
            log_info "$tool already installed"
        fi
    done
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
    log_info "Setting up minimal dotfiles for platform: $platform"
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Copy minimal vim configuration
    copy_dotfile "$SCRIPT_DIR/vim/minimal/.vimrc" "$HOME/.vimrc"
    
    # Setup modern bash configuration
    if [ -f "$SCRIPT_DIR/bash/.bashrc.modern" ]; then
        copy_dotfile "$SCRIPT_DIR/bash/.bashrc.modern" "$HOME/.bashrc"
    fi
    
    if [ -f "$SCRIPT_DIR/bash/.bash_profile.modern" ]; then
        copy_dotfile "$SCRIPT_DIR/bash/.bash_profile.modern" "$HOME/.bash_profile"
    fi
    
    log_success "Minimal dotfiles copied successfully"
}

# Create necessary directories
create_directories() {
    log_info "Creating necessary directories..."
    
    mkdir -p "$HOME/.local/bin"
    
    log_success "Directories created"
}

# Setup Python environment
setup_python_environment() {
    log_info "Setting up Python environment..."
    
    # Add Python user base to PATH if not already there
    local python_user_base=$(python3 -m site --user-base)
    local python_user_bin="$python_user_base/bin"
    
    if [[ ":$PATH:" != *":$python_user_bin:"* ]]; then
        echo "# Python user base" >> "$HOME/.bashrc"
        echo "export PATH=\"$python_user_bin:\$PATH\"" >> "$HOME/.bashrc"
        log_info "Added Python user base to PATH in .bashrc"
    fi
    
    # Add uv to PATH
    if [ -d "$HOME/.cargo/bin" ]; then
        if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
            echo "# uv (Python package manager)" >> "$HOME/.bashrc"
            echo "export PATH=\"\$HOME/.cargo/bin:\$PATH\"" >> "$HOME/.bashrc"
            log_info "Added uv to PATH in .bashrc"
        fi
    fi
    
    log_success "Python environment setup completed"
}

# Main installation function
main() {
    log_info "Starting minimal dotfiles installation for Python development..."
    log_info "Platform detected: $(detect_platform)"
    
    install_system_packages
    install_bashit
    install_python_tools
    create_directories
    setup_dotfiles
    install_vim_plugins
    setup_python_environment
    
    log_success "Minimal installation completed successfully!"
    log_info "Please restart your terminal or run 'source ~/.bashrc' to apply changes"
    log_info "Note: Some tools like uv and pipx require a new terminal session to be available in PATH"
    
    log_info ""
    log_info "Installed tools:"
    log_info "  - Python 3 with pip"
    log_info "  - bash-it framework with modern shell features"
    log_info "  - uv (fast Python package manager)"
    log_info "  - pipx (isolated Python app installation)"
    log_info "  - Python dev tools: black, isort, flake8, mypy, pytest, ipython"
    log_info "  - Minimal vim configuration with essential plugins"
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Minimal Dotfiles Installation Script for Python Development"
        echo ""
        echo "Usage: $0 [options]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --dry-run      Show what would be installed without actually installing"
        echo ""
        echo "This script will:"
        echo "  - Install basic system packages (curl, git, python3, pip)"
        echo "  - Install bash-it framework for enhanced bash experience"
        echo "  - Install Python development tools (uv, pipx, black, isort, flake8, mypy, pytest, ipython)"
        echo "  - Setup minimal vim configuration with essential plugins"
        echo "  - Setup modern bash configuration for Python development"
        echo ""
        echo "This is a minimal version focused on Python development without heavy language servers or complex setups."
        exit 0
        ;;
    --dry-run)
        log_info "DRY RUN MODE - No changes will be made"
        log_info "Would install:"
        log_info "  - System packages: curl, git, python3, python3-pip"
        log_info "  - bash-it framework"
        log_info "  - Python tools: uv, pipx"
        log_info "  - Python dev tools: black, isort, flake8, mypy, pytest, ipython"
        log_info "  - vim-plug and minimal vim configuration"
        log_info "  - Modern bash configuration for Python development"
        log_info "  - Platform: $(detect_platform)"
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