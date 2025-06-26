#!/bin/bash
# install homebrew

# Ask for the administrator password upfront
echo "Run script as admin..."
sudo -v

#if test ! $(which brew); then
#  echo "Installing homebrew..."
#  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#fi

#echo "Add brew to zsh path"
#echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
#eval "$(/opt/homebrew/bin/brew shellenv)"

# make sure everything is ready
brew update
brew doctor

echo "Starting Brewfile install..."
brew bundle

echo "Installing iterm2..."
npm install -g iterm2-tab-set

#echo "Installing node version manager..."
#sudo brew install n
# Use nvm fish

# install fisher

echo "Installing latest node version..."
sudo n lts

echo "Installing yarn..."
npm install -g yarn

#echo "Installing Xcode and Mac developer tools"
#xcode-select --install

#echo "Symlinking fish config in repo with local fish config..."
#mkdir -p ~/.config/fish
#ln -s fish/ ~/.config/fish

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
node --version
npm --version
yarn --version
xcode-select -p
# Change computer name
echo -e "\nIf you wish to change the name of your local comuter, run these commands"
echo "hostname=\"cool_name\""
echo "sudo scutil --set HostName \$hostname"
echo "sudo scutil --set LocalHostName \$hostname"
echo "sudo scutil --set ComputerName \$hostname"

echo -e "\nOpening fish terminal..."
fish
exit 1
