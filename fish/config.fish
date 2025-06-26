if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.asdf/asdf.fish

# starship 
# starship init fish | source

# Add n (node version manager) to path
#set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH 
"$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
# Remove windows node path from WSL path
#set PATH (string match -v /mnt/c/Program\ Files/nodejs/ $PATH)
# source autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# Display system info on startup
#screenfetch -- doesnt suppoert Apple silicon chipso
neofetch

cd ~

# ------------------ #
# FISH ABBREVIATIONS #
# ------------------ #

# -- GENERAL -- #
abbr . 'open .'
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .... 'cd ../../..'
abbr s 'sudo'
abbr cl 'clear'
abbr m 'man'
abbr lat 'lolcat'
abbr pss 'ps aux | grep'
abbr week 'date +%V'
#direcories
abbr tre 'tree -a'
abbr tref 'tree --filelimit'
abbr trel 'tree -L'
abbr lsize 'du * --total --human-readable' #files/directories/subdirectories and their size
abbr slist 'du -sm *' #all files/directories and number of subdirectories at root
abbr dirnum 'ls -l | grep "^d" | wc -l' #number of non-hidden directories
abbr dirnuma 'ls -al | grep "^d" | wc -l' #number of directories incl. hidden
#npm/yarn
abbr ns 'npm start'
abbr ni 'npm install'
abbr nid 'npm install --save-dev'
abbr nis 'npm install --save'
abbr nri 'rm -rf node_modules/* && npm install'
abbr yw 'yarn watch'
abbr yi 'yarn install'
#iterm2 tabset
abbr tabc 'tabset --color'
abbr tabb 'tabset --badge'
abbr tab 'tabset'

# -- GIT -- #
abbr g 'git'
abbr gs 'git status'
# branches
abbr gco 'git checkout'
abbr gnb 'git checkout -b'
abbr gcm 'git checkout master'
abbr gcmm 'git checkout main'
abbr gb 'git branch --all'
# push/pull
abbr gpl 'git pull'
abbr gplo 'git pull origin'
abbr gph 'git push'
abbr gpho 'git push origin'
abbr gphm 'git push origin master'
abbr gphmm 'git push origin main'
abbr gplm 'git pull origin master'
abbr gplmm 'git pull origin main'
# files
abbr ga 'git add'
abbr gai 'git add --interactive'
abbr gas 'git add src/client/'
abbr gap 'git add package.json'
abbr gan 'git add --intent-to-add'
abbr gael git\ add\ .\ --\ \':\(exclude\)package-lock.json\'
# commit
abbr gc 'git commit -m'
abbr gcam 'git commit -a -m'
# diff
abbr gd 'git diff'
abbr gds 'git diff --staged'
abbr gdp 'git diff package.json'
abbr gdel git\ diff\ --\ .\ \':\(exclude\)package-lock.json\'
# stash
abbr gst 'git stash'
abbr gstp 'git stash pop'
abbr gsl 'git stash list'
abbr gsa 'git stash apply'
abbr gss 'git stash show -p'
abbr gsp 'git stash push -m'
# reset
abbr gre 'git reset'
abbr grs 'git reset --soft HEAD~'
# rebase
abbr grc 'git rebase --continue'
abbr gri 'git rebase --interactive'
abbr gri 'git rebase --interactive HEAD~'
# misc
abbr gl 'git log'
abbr gm 'git merge'
abbr gbl 'git blame'
abbr gr 'git remote -v'
abbr gcp 'git cherry-pick'
abbr gf 'git fetch --all --prune'

# project specific
abbr dev 'cd ~/dev'
abbr rdev 'npm run dev:start'


thefuck --alias | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sondre/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/sondre/Downloads/google-cloud-sdk/path.fish.inc'; end
