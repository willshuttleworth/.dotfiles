#!/bin/zsh

# install homebrew
# make symlinks between files in this directory and ones in home directory
# install homebrew packages

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# make symlinks
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

# installing homebrew packages (assuming that Brewfile exists in home directory)
brew bundle

# using macos defaults to restore old settings
# dock size
defaults write com.apple.dock "tilesize" -int "50" && killall Dock
# deck autohiding
defaults write com.apple.dock "autohide" -bool "true" && killall Dock
# show hidden files in finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true" && killall Finder
# show pathbar in finder
defaults write com.apple.finder "ShowPathbar" -bool "true" && killall Finder
# show files in list view in finder
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv" && killall Finder
# no warning for changing file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false" && killall Finder
