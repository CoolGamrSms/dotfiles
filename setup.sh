#!/bin/bash

./install.sh
mkdir -p ~/Tools
cd ~/Tools

# Install zsh plugins
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search ]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
else
    echo "zsh-history-substring-search already installed"
fi
if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed"
fi


# Install neovim 0.4.2
if ! vim -v | grep "NVIM v0.4.2" -q; then
    wget https://github.com/neovim/neovim/releases/download/v0.4.2/nvim.appimage
    sudo mv nvim.appimage ~/bin/.
    sudo update-alternatives --install /usr/bin/vim vim ~/bin/nvim.appimage 200
    chmod +x nvim.appimage
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "NVIM v0.4.2 already installed"
fi

# install global nodejs
if ! which node > /dev/null; then
    sudo apt-get install nodejs
else
    echo "nodejs already installed"
fi

# install global yarn
if ! which yarn > /dev/null; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list\n
    sudo apt update
    sudo apt install yarn
else
    echo "yarn already installed"
fi

# Install fzf
if ! which fzf > /dev/null; then
    cd ~/Tools
    wget https://github.com/junegunn/fzf/archive/0.18.0.tar.gz
    mkdir -p fzf
    tar -xzf 0.18.0.tar.gz -C fzf
    cd fzf/fzf-0.18.0
    ./install
else
    echo "fzf already installed"
fi
