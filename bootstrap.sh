#!/bin/bash

# Install ncurses locally
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

# Install zsh locally
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

# Start to set up local settings
cd $HOME

# Put in my settings
mv .vimrc .vimrc.backup
wget -O .vimrc https://raw.githubusercontent.com/milescranmer/vimrc/master/.vimrc

# Turn of solarized temporarily
sed -i -- 's/colorscheme solarized/" colorscheme solarized/g' .vimrc

# Install vundle
git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall

# Turn back on solarized
sed -i -- 's/" colorscheme solarized/colorscheme solarized/g' .vimrc

# Install oh-my-zsh
wget -O install-oh-my-zsh.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sed -i -- 's/CHECK_ZSH_INSTALLED=/CHECK_ZSH_INSTALLED=1\n#/g' install-oh-my-zsh.sh 
chmod +x install-oh-my-zsh.sh
./install-oh-my-zsh.sh
rm install-oh-my-zsh.sh

# Put in the .zshrc
mv .zshrc .zshrc.backup
wget -O .zshrc https://raw.githubusercontent.com/milescranmer/zshrc/master/.zshrc

# Download zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
