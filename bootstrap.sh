#!/bin/bash

wget https://downloads.sourceforge.net/project/zsh/zsh/5.3.1/zsh-5.3.1.tar.xz
tar xzf zsh-5.3.1.tar.xz
rm zsh-5.3.1.tar.xz
cd zsh-5.3.1
./configure
make
make install
