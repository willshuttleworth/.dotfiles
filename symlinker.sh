#!/bin/zsh

# make symlinks between files in this directory and ones in home directory

files=(".zshrc" ".vimrc" ".gitconfig" ".gitignore_global" "Brewfile")
dirs=(".vim") 
if [ ! -d $dir ]; then    
    mkdir ~/.old_dotfiles
fi

echo "moving to .dotfiles dir"
cd ~/.dotfiles
echo "done"

# making directories that need symlinked later
for dir in ${dirs[@]}; do
    if [ ! -d $dir ]; then    
        mkdir ~/.dotfiles/$dir 
    fi    
    mv ~/$dir ~/.old_dotfiles
    ln -s ~/.dotfiles/$dir ~/$dir
done

# symlinking all files 
for file in ${files[@]}; do
    echo "attempting to move existing file $file to ~/.old_dotfiles"
    mv ~/$file ~/.old_dotfiles
    echo "symlinking $file"
    ln -s ~/.dotfiles/$file ~/$file
done    
