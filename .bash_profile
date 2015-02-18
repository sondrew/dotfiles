
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[0;33m\]\w\[\e[0m\]\$(parse_git_branch)\n\[\e[0;31m\]→\[\e[0m\] "