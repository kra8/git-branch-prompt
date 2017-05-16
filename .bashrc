###########################################
# Prompt
###########################################
get_current_branch()
{
    git symbolic-ref --short HEAD
}

get_branch_color()
{
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        # 全てcommitされてクリーンな状態
        printf "\e[32m" # GREEN
    elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
        # git addされていないファイルがある状態
        printf "\e[31m" # RED
    elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
        # gitに管理されていないファイルがある状態
        printf "\e[31m" # RED
    elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
        # git commitされていないファイルがある状態
        printf "\e[33m" # YELLOW
    else
        # 上記以外の状態の場合は青色で表示させる
        printf "\e[34m" # BLUE
    fi
}

preprompt()
{
    PS1L="\W ₍₍(ง˘ω˘)ว⁾⁾$ "
    PS1R=""

    PS1=$PS1L

    if [ -e  ".git" ]; then
        PS1R="$(get_branch_color)$(get_current_branch)$(printf "\e[m")"

        # 8 is offsets.
        printf "%$((`tput cols` + 8))s`tput cr`" $PS1R
    fi
}

PROMPT_COMMAND=preprompt
