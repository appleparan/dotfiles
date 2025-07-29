# Liam's Dotfiles

A comprehensive collection of configuration files for setting up a consistent development environment across different platforms.

## Overview

This repository contains configuration files (dotfiles) for various command-line tools and applications, organized by platform and tool type. The configurations are designed to work seamlessly across Linux and WSL environments.

## Structure

```
├── bash/          # Bash shell configurations
│   ├── .bashrc
│   └── .bash_profile
├── tmux/          # Terminal multiplexer configurations
│   └── linux/
│       ├── .tmux.conf
│       └── .tmux.conf.local
├── vim/           # Vim editor configuration
│   └── .vimrc
└── zsh/           # Zsh shell configurations
    ├── .zshrc     # Global zsh configuration
    ├── .zshenv    # Global zsh environment
    ├── linux/     # Linux-specific configurations
    │   ├── .zshrc
    │   └── .zshenv
    └── wsl/       # WSL-specific configurations
        ├── .zshrc
        └── .zshenv
```

## Features

- **Multi-platform support**: Separate configurations for Linux and WSL environments
- **Shell configurations**: Both Bash and Zsh setups with platform-specific optimizations
- **Terminal multiplexing**: Tmux configuration for enhanced terminal productivity
- **Editor setup**: Vim configuration for consistent editing experience
- **Oh-My-Zsh integration**: Pre-configured with useful plugins and spaceship theme
- **Development tools**: Automated setup for Julia and Node.js version managers

## Included Tools and Plugins

### Zsh Configuration
- **Oh-My-Zsh**: Feature-rich framework for zsh
- **Spaceship Theme**: Modern, minimalist theme with git status and extensive customization
- **MesloLGS NF Font**: Meslo Nerd Font patched for Powerlevel10k with optimal powerline support
- **zsh-autosuggestions**: Fish-like autosuggestions for zsh
- **zsh-syntax-highlighting**: Syntax highlighting for the zsh command line
- **1Password Plugin**: Integration with 1Password CLI (if available)

### Development Tools
- **juliaup**: Julia version manager for easy Julia installation and management
- **fnm**: Fast Node.js version manager written in Rust
- **Git**: Version control with oh-my-zsh git plugin integration

### Vim Configuration
- **vim-plug**: Modern plugin manager for Vim
- **CoC (Conquer of Completion)**: Language Server Protocol support with auto-completion
- **Language Support**: Optimized for Python, Go, Rust, JavaScript/TypeScript/Node.js
- **Code Formatting**: Automatic formatting with ALE (black, gofmt, rustfmt, prettier)
- **Syntax Highlighting**: Enhanced syntax highlighting for all supported languages
- **File Navigation**: FZF integration for fuzzy file finding
- **Git Integration**: GitGutter for diff indicators and Fugitive for Git commands

## Installation

### Quick Installation (Recommended)

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the automated installation script:
   ```bash
   ./install.sh
   ```

The installation script will automatically:
- Install zsh and oh-my-zsh with spaceship theme
- Install required zsh plugins (autosuggestions, syntax-highlighting)
- Install MesloLGS NF Font for optimal terminal display
- Install development tools (juliaup, fnm)
- Setup modern vim configuration with plugins
- Create symbolic links for your platform (Linux/WSL)
- Change your default shell to zsh

### Manual Installation

If you prefer to install manually or want to customize the process:

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Install oh-my-zsh:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. Install zsh plugins:
   ```bash
   # zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   
   # zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
   ```

4. Install spaceship prompt theme:
   ```bash
   # Clone spaceship prompt
   git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
   
   # Create symbolic link
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
   ```

5. Install MesloLGS NF Font:
   ```bash
   # Create fonts directory
   mkdir -p ~/.local/share/fonts
   
   # Download MesloLGS NF fonts (optimized for Powerlevel10k)
   base_url="https://github.com/romkatv/powerlevel10k-media/raw/master"
   fonts=("MesloLGS NF Regular.ttf" "MesloLGS NF Bold.ttf" "MesloLGS NF Italic.ttf" "MesloLGS NF Bold Italic.ttf")
   
   for font in "${fonts[@]}"; do
       curl -fsSL "$base_url/${font// /%20}" -o ~/.local/share/fonts/"$font"
   done
   
   # Update font cache
   fc-cache -f -v
   ```

6. Create symbolic links based on your platform:

   **For Linux:**
   ```bash
   ln -sf ~/dotfiles/zsh/linux/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/zsh/linux/.zshenv ~/.zshenv
   ln -sf ~/dotfiles/tmux/linux/.tmux.conf ~/.tmux.conf
   ln -sf ~/dotfiles/tmux/linux/.tmux.conf.local ~/.tmux.conf.local
   ```

   **For WSL:**
   ```bash
   ln -sf ~/dotfiles/zsh/wsl/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/zsh/wsl/.zshenv ~/.zshenv
   ```

   **Common configurations:**
   ```bash
   ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
   ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
   ln -sf ~/dotfiles/bash/.bash_profile ~/.bash_profile
   ```

7. Change default shell to zsh:
   ```bash
   chsh -s $(which zsh)
   ```

8. Configure your terminal to use MesloLGS NF Regular for optimal display of the spaceship theme.

### Installation Script Options

The `install.sh` script supports several options:

```bash
# Show help information
./install.sh --help

# Dry run (show what would be installed without making changes)
./install.sh --dry-run

# Normal installation
./install.sh
```

## Tool Management

### Julia (juliaup)
After installation, you can manage Julia versions:
```bash
# Install the latest stable Julia
julia-up add release

# List available versions
julia-up status

# Set default version
julia-up default 1.9
```

### Node.js (fnm)
Manage Node.js versions with fnm:
```bash
# Install latest LTS Node.js
fnm install --lts

# List installed versions
fnm list

# Use specific version
fnm use 18

# Set default version
fnm default 18
```

### Vim Usage

The modern vim configuration includes many productivity features:

#### Key Mappings (Leader key: Space)
```vim
" File operations
<Space>w    - Save file
<Space>q    - Quit
<Space>x    - Save and quit

" File navigation
<Space>e    - Toggle NERDTree
<Space>f    - Find current file in NERDTree
<Space>p    - Fuzzy file finder (FZF)
<Space>b    - Buffer list
<Space>rg   - Search in files (ripgrep)

" Code navigation
gd          - Go to definition
gr          - Go to references
K           - Show documentation
<Space>rn   - Rename symbol

" Code formatting
<Space>F    - Format selected code

" Buffer/Tab management
<Space>bn   - Next buffer
<Space>bp   - Previous buffer
<Space>bd   - Delete buffer
```

#### Language-Specific Features

**Python**:
- Black formatting on save
- PEP 8 compliance checking
- Type checking with mypy
- `<Space>r` to run current file

**Go**:
- Auto-imports with goimports
- Built-in testing support
- `<Space>r` to run, `<Space>b` to build, `<Space>t` to test

**Rust**:
- rustfmt formatting on save
- Cargo integration
- `<Space>r` to run, `<Space>b` to build, `<Space>t` to test

**JavaScript/TypeScript**:
- Prettier formatting on save
- ESLint integration
- `<Space>r` to run with node/ts-node

#### Plugin Management
```bash
# Update vim plugins
vim +PlugUpdate +qall

# Install new plugins (after adding to .vimrc)
vim +PlugInstall +qall

# Clean unused plugins
vim +PlugClean +qall
```

## Terminal Font Configuration

For the best experience with the spaceship theme, configure your terminal to use **MesloLGS NF Regular**:

### Popular Terminal Emulators

**GNOME Terminal / Ubuntu Terminal:**
1. Open terminal preferences
2. Go to Profiles → Text
3. Enable "Custom font" and select "MesloLGS NF Regular"

**Windows Terminal:**
```json
{
    "profiles": {
        "defaults": {
            "fontFace": "MesloLGS NF"
        }
    }
}
```

**VS Code Integrated Terminal:**
```json
{
    "terminal.integrated.fontFamily": "MesloLGS NF"
}
```

**iTerm2 (macOS):**
1. iTerm2 → Preferences → Profiles → Text
2. Change font to "MesloLGS NF Regular"

### Font Features
- **Optimized for Powerlevel10k**: Specially patched for maximum compatibility
- **Perfect powerline symbols**: Seamless arrows and separators in spaceship theme
- **Nerd Font icons**: Git status, file type, and other visual indicators
- **Consistent spacing**: Monospace with proper character alignment

## Platform-Specific Notes

### Linux
- Includes native Linux shell optimizations
- Full tmux configuration with local customizations

### WSL (Windows Subsystem for Linux)
- Optimized for Windows integration
- Adjusted paths and environment variables for WSL compatibility

## Customization

Feel free to modify these configurations to suit your preferences. The modular structure makes it easy to:
- Add platform-specific tweaks
- Override settings in local configuration files
- Extend functionality with additional tools

## Contributing

This is a personal dotfiles repository, but suggestions and improvements are welcome through issues or pull requests.

## License

These configurations are provided as-is for personal use and reference.