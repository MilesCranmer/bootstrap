#!/bin/bash

wget -O ncurses.tar.gz https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
mkdir ncurses
tar -xvzf ncurses.tar.gz -C ncurses --strip-components 1
rm ncurses.tar.gz
cd ncurses
export CXXFLAGS="$CXXFLAGS -fPIC"
export CFLAGS="$CFLAGS -fPIC"
./configure --prefix=$HOME
make
make install
cd ..
rm -rf ncurses
wget -O zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download
mkdir zsh
tar -xvzf zsh.tar.gz -C zsh --strip-components 1
rm zsh.tar.gz
cd zsh
export CPPFLAGS="$CPPFLAGS -I$HOME/include"
export LDFLAGS="$LDFLAGS -L$HOME/lib"
./configure --prefix=$HOME
make
make install
cd ..
rm -rf zsh

cd $HOME

# Put in my settings
mv .zshrc .zshrc.backup
mv .vimrc .vimrc.backup
wget -O .zshrc https://raw.githubusercontent.com/milescranmer/zshrc/master/.zshrc
wget -O .vimrc https://raw.githubusercontent.com/milescranmer/vimrc/master/.vimrc

# Turn of solarized temporarily
sed -i -- 's/colorscheme solarized/" colorscheme solarized/g' .vimrc

# Install vundle
git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall

# Turn back on solarized
sed -i -- 's/" colorscheme solarized/colorscheme solarized/g' .vimrc
