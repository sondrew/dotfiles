
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
PATH=$PATH:/usr/local/mysql/bin
export PATH

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[0;33m\]\w\[\e[0m\]\$(parse_git_branch)\n\[\e[0;31m\]→\[\e[0m\] "

# TERMINAL SHORTCUTS
alias o='open .'
alias ..='cd ..'
alias la='ls -a'
alias cl='clear'
alias pls='sudo'
alias cpyf='pbpaste >' # Copy file
alias cpy='pwd|pbcopy' # Copy path
alias sub='open -a Sublime' # Open file/directory in Sublime
alias tab='printf "\e]1;%s\a"' # Name tab in terminal
alias bprof='nano /User/Sondre/.bash_profile'

# GIT
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gph='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gall='git add -A'
alias gres='git reset'
alias grh='git reset --hard'
alias gcom='git commit -m'
alias gcam='git commit -am'
alias gb='git branch -a'
alias gco='git checkout'
alias gnb='git checkout -b'
alias glc="git log --graph --pretty=format:'%Cred%h%Creset %an -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# MISC
alias lcat='lolcat' # Colorful alternativ to 'cat'
alias python='python3' # Run python 3 by default
alias python2='\python'
alias screensaver='while true; do doge | lolcat -a -d 100 -s 100 -p 1; done'
alias start_docker='bash "/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh"'