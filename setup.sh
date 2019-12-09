#!/bin/sh
# install homebrew

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# make sure everything is ready
brew update
brew doctor

echo "Starting Brewfile install..."
brew bundle

echo "Installing iterm2..."
npm install -g iterm2-tab-set

echo "Installing node version manager..."
npm install -g n

echo "Installing latest node version..."
n latest

echo "Copying fish config..."
mkdir -p ~/.config/
cp -a fish ~/.config/

echo "Making fish default shell..."
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s `which fish`

echo "Copying git and bash configs..."
cp {.bash_profile,.gitconfig} ~/.
# load iterm profile
# load .osx defaults config 
# check versions
python --version
git --version
# Change computer name
echo -e "\nIf you wish to change the name of your local comuter, run these commands"
echo "hostname=\"cool_name\""
echo "sudo scutil --set HostName \$hostname"
echo "sudo scutil --set LocalHostName \$hostname"
echo "sudo scutil --set ComputerName \$hostname"

echo -e "\nOpening fish terminal..."
fish
exit 1