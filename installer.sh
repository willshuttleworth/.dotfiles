#!/bin/zsh

# make symlinks between files in this directory and ones in home directory
# install homebrew packages
# assumptions: homebrew and xcode cli things are already installed

files=(".zshrc" ".vimrc" ".gitconfig" ".gitignore_global" "Brewfile")
dirs=(".vim") 

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

#installing homebrew packages
brew bundle
