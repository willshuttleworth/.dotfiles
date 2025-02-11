#!/bin/zsh

# install homebrew
# make symlinks between files in this directory and ones in home directory
# install homebrew packages

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make symlinks
files=(".zshrc" ".vimrc" ".gitconfig" ".gitignore_global" "Brewfile" ".tmux.conf")
dirs=(".vim" "ghostty") 

cd; echo "moving to home directory"

if [ ! -d .old_dotfiles ]; then    
    mkdir .old_dotfiles
else
    rm -r ".old_dotfiles"
    mkdir .old_dotfiles
fi

echo "created old_dotfiles dir"

# making directories that need symlinked later
for dir in ${dirs[@]}; do
    if [ -d $dir ]; then    
        echo "attempting to move existing dir $dir to ~/.old_dotfiles"
        mv ~/$dir ~/.old_dotfiles
    fi
    echo "symlinking $dir"
    ln -s ~/.dotfiles/$dir ~/$dir
done

# symlinking all files 
for file in ${files[@]}; do
    if [ -f $file ]; then
        echo "attempting to move existing file $file to ~/.old_dotfiles"
        mv ~/$file ~/.old_dotfiles
    fi
    echo "symlinking $file"
    ln -s ~/.dotfiles/$file ~/$file
done    


# installing homebrew packages (assuming that Brewfile exists in home directory)
brew bundle

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins 

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
vim -S ~/.vim/setup.vim +qall

# install things managed outside homebrew
# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
