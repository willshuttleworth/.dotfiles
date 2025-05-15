#!/bin/zsh

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install stow

dirs=("vim" "ghostty" "git" "brew" "zsh" "aerospace" "helix")

for dir in ${dirs[@]}; do
    if [ -d $dir ]; then    
        stow $dir
    fi
    echo "stowed $dir"
done

# installing homebrew packages (assuming that Brewfile exists in home directory)
brew bundle --file brew/Brewfile

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
vim -S ~/.vim/setup.vim +qall

# install things managed outside homebrew
# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
