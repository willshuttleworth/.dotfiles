#!/bin/zsh

# make symlinks between files in this directory and ones in home directory

files=".zshrc .vimrc .gitconfig .gitignore_global .vscode Brewfile" 
dirs=".vscode"
mkdir ~/.old_dotfiles

echo -n "moving to .dotfiles dir"
cd ~/.dotfiles
echo -n "done"

# making directories that need symlinked later
for dir in $dirs; do
    if [ ! -d $dir ]; then    
        mkdir ~/$dir
    done
    ln -s $dir ~/$dir
done

# symlinking all files 
for file in $files; do
    echo -n "attempting to move existing file $file to ~/.old_dotfiles"
    mv ~/$file ~/.old_dotfiles
    echo -n "symlinking $file"
    ln -s $file ~/$file
done    
