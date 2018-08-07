# install homebrew
/usr/bin/ruby -e "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/master/install)"
# make sure everything is ready
brew update
brew doctor
# install Brewfile
brew bundle
# useful npm packages
npm install -g iterm2-tab-set
npm install -g n
# copy fish functions from repo into fish function folder
cp -a fish/functions/. ~/.config/fish/functions
# copy bash_profile and gitconfig to user folder
cp {.bash_profile,.gitconfig} ~/.
# load iterm profile
# load .osx defaults config 
# check versions
python --version
git --version
# Change computer name
# sudo scutil --set HostName <new host name>
# sudo scutil --set LocalHostName <new host name>
# sudo scutil --set ComputerName <new name>
