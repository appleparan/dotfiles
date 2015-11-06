#!/bin/bash
 
# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/usr/bin.
# It's assumed that wget and a C/C++ compiler are installed.
 
# exit on error
set -e
 
TMUX_VERSION=1.9
 
# create our directories
mkdir -p $HOME/usr $HOME/tmux_tmp
cd $HOME/tmux_tmp
 
# download source files for tmux, libevent, and ncurses
wget -O tmux-${TMUX_VERSION}.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz/download
wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
 
# extract files, configure, and compile
 
############
# libevent #
############
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-2.0.19-stable
./configure --prefix=$HOME/usr --disable-shared
make
make install
cd ..
 
############
# ncurses #
############
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
./configure --prefix=$HOME/usr
make
make install
cd ..
 
############
# tmux #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I$HOME/usr/include -I$HOME/usr/include/ncurses" LDFLAGS="-L$HOME/usr/lib -L$HOME/usr/include/ncurses -L$HOME/usr/include"
CPPFLAGS="-I$HOME/usr/include -I$HOME/usr/include/ncurses" LDFLAGS="-static -L$HOME/usr/include -L$HOME/usr/include/ncurses -L$HOME/usr/lib" make
cp tmux $HOME/usr/bin
cd ..
 
# cleanup
rm -rf $HOME/tmux_tmp
 
echo "$HOME/usr/bin/tmux is now available. You can optionally add $HOME/usr/bin to your PATH."
