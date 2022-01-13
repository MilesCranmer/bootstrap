#!/bin/bash

# # Install ncurses locally
# wget -O ncurses.tar.gz https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
# mkdir ncurses
# tar -xvzf ncurses.tar.gz -C ncurses --strip-components 1
# rm ncurses.tar.gz
# cd ncurses
# export CXXFLAGS="$CXXFLAGS -fPIC"
# export CFLAGS="$CFLAGS -fPIC"
# ./configure --prefix=$HOME
# make
# make install
# cd ..
# rm -rf ncurses

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
mv $HOME/.vimrc $HOME/.vimrc.backup
wget -O $HOME/.vimrc https://raw.githubusercontent.com/milescranmer/vimrc/master/.vimrc

# Turn of solarized temporarily
sed -i -- 's/colorscheme solarized/" colorscheme solarized/g' $HOME/.vimrc

# Install vundle
git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

# Install some python modules for vim plugins
pip install google-api-python-client Cython py-stackexchange lxml

# Install plugins
vim +PluginInstall +qall

# Get command-line GSO
cp $HOME/.vim/bundle/GooglingStackOverflow.vim/tools/gso.sh /bin/gso

# Turn back on solarized
sed -i -- 's/" colorscheme solarized/colorscheme solarized/g' $HOME/.vimrc

# Install oh-my-zsh
wget -O install-oh-my-zsh.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sed -i -- 's/CHECK_ZSH_INSTALLED=/CHECK_ZSH_INSTALLED=1\n#/g' install-oh-my-zsh.sh 
chmod +x install-oh-my-zsh.sh
./install-oh-my-zsh.sh
rm install-oh-my-zsh.sh

# Put in the .zshrc
mv $HOME/.zshrc $HOME/.zshrc.backup
wget -O $HOME/.zshrc https://raw.githubusercontent.com/milescranmer/zshrc/master/.zshrc

# Download vim-stream
wget https://raw.githubusercontent.com/MilesCranmer/vim-stream/master/vims -O /bin/vims
chmod +x /bin/vims

# Download zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
