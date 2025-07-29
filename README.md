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
- **Oh-My-Zsh integration**: Pre-configured with useful plugins and gallifrey theme
- **Development tools**: Automated setup for Julia, Deno, and Node.js version managers

## Included Tools and Plugins

### Zsh Configuration
- **Oh-My-Zsh**: Feature-rich framework for zsh
- **Gallifrey Theme**: Clean and informative prompt theme
- **zsh-autosuggestions**: Fish-like autosuggestions for zsh
- **zsh-syntax-highlighting**: Syntax highlighting for the zsh command line
- **1Password Plugin**: Integration with 1Password CLI (if available)

### Development Tools
- **juliaup**: Julia version manager for easy Julia installation and management
- **Deno**: Modern runtime for JavaScript and TypeScript
- **fnm**: Fast Node.js version manager written in Rust
- **Git**: Version control with oh-my-zsh git plugin integration

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
- Install zsh and oh-my-zsh
- Install required zsh plugins (autosuggestions, syntax-highlighting)
- Install the gallifrey theme
- Install development tools (juliaup, deno, fnm)
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

4. Install gallifrey theme:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/yottaawesome/gallifrey-zsh-theme/master/gallifrey.zsh-theme \
       -o ~/.oh-my-zsh/custom/themes/gallifrey.zsh-theme
   ```

5. Create symbolic links based on your platform:

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

6. Change default shell to zsh:
   ```bash
   chsh -s $(which zsh)
   ```

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

### Deno
Deno is installed globally and ready to use:
```bash
# Check Deno version
deno --version

# Run a TypeScript file
deno run script.ts

# Update Deno
deno upgrade
```

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