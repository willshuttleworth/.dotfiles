# emacs binding thing to fix tmux binds
bindkey -e

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# colors for prompt
COLOR_DEF='%f'
COLOR_USR='%F{cyan}'
COLOR_DIR='%F{197}'
COLOR_GIT='%F{39}'
# prompt
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n@%M ${COLOR_DIR}%1~ ${COLOR_GIT}$(parse_git_branch) ${COLOR_DEF}%% '

# idk python multiprocess thing
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# java stuff
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# google cloud cli
export PATH="/Users/willshuttleworth/google-cloud-sdk/bin/:$PATH"

# aliases
alias myip="curl http://ipecho.net/plain; echo"
alias slp="pmset sleepnow" 
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"
alias update="brew update && brew upgrade"
alias thoth="ssh wps20@thoth.cs.pitt.edu"
alias c="clear" # im really bad at spelling clear
alias gdb="aarch64-elf-gdb"
alias refresh-trial="mvt ~/Library/Application\ Support/.ffuserdata" # unlimited final cut pro trial fuck you apple

# FUNCTIONS

# function to retrieve git branch for prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# mv files to trash
mvt() {
    for file in "$@"; do; 
    mv $file ~/.Trash
    done
}

# git push origin master/main 
gpom() {
    BRANCH=$(parse_git_branch)

    if [ $BRANCH = "[main]" ]; then
        echo "pushing to branch $BRANCH"        
        git push origin main
    elif [ $BRANCH = "[master]" ]; then
        echo "pushing to branch $BRANCH"        
        git push origin master
    else
        echo "not on master or main branch"
    fi
}

# color setting
TERM=xterm-256color

# use vim keys to edit in terminal
set -o vi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/willshuttleworth/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/willshuttleworth/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/willshuttleworth/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/willshuttleworth/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
export PATH="/Users/willshuttleworth/Library/Caches/Homebrew/Backup/include:$PATH"
