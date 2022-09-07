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

# aliases
alias myip="curl http://ipecho.net/plain; echo"
alias slp="pmset sleepnow" 
alias shutdown="sudo shutdown -h now"
alias reboot="sudo reboot"
alias python="python3"
alias pip="pip3"

# FUNCTIONS

# function to retrieve git branch for prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# mv files to trash
mvt() {
    for file in "$@"; do; 
    mv ./$file ~/.Trash
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

# compile c/c++ source code
function compile() {
    FILE=$1
    EXT=$(echo $FILE | cut -d'.' -f 2)
    TARGET=$(echo $FILE | cut -d'.' -f 1)
    echo $EXT
    echo $TARGET
    if [[ -f $FILE ]] && [[ $EXT == "c" ]]; then
        gcc $FILE -o $TARGET
    elif [[ -f $FILE ]] && [[ $EXT == "cpp" ]]; then
        g++ $FILE -o $TARGET
    else
        echo "no file named $file exists"
    fi
}

# color setting
TERM=xterm-256color

# use vim keys to edit in terminal
set -o vi

# commands to run at startup
neofetch
