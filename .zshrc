# function to retrieve git branch for prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# colors for prompt
COLOR_DEF='%f'
COLOR_USR='%F{cyan}'
COLOR_DIR='%F{197}'
COLOR_GIT='%F{39}'
# prompt
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n@%M ${COLOR_DIR}%1~ ${COLOR_GIT}$(parse_git_branch) ${COLOR_DEF}%% '
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# aliases
alias myip="curl http://ipecho.net/plain; echo"
alias gpom="git push origin main"

# functions
fucntion mvt() {
    for file in "$@"
    do 
        mv ./$file ~/.Trash
    done
}
# color setting
TERM=xterm-256color

# commands to run at startup
neofetch
