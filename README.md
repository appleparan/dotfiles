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

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Create symbolic links to the appropriate configuration files based on your platform:

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