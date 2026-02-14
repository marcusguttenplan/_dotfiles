# Bootstrapping a New Device

This repo contains dotfiles and shell settings for a new device

## Usage

### Install Packages

Install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install casks
```
brew install --cask google-chrome 1password raycast dropbox 1password-cli iterm2 displaylink eul visual-studio-code obsidian little-snitch linear-linear tailscale-app docker-desktop font-meslo-lg-nerd-font chroma
```

Install Oh My Zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Configure Services

Github
```
git config --global user.name "Marcus Guttenplan"
git config --global user.email "marcusguttenplan@gmail.com"
```

Create public key for github and add to keys on website
```
ssh-keygen -t ed25519 -C "marcusguttenplan@gmail.com"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

Set up touch ID for terminal
```
sed -i '.bak' '1s/^/auth       sufficient     pam_tid.so\'$'\n/g' todo.txt
```

Set touch ID to ignore a restriction caused by DisplayLink
```
sudo /usr/bin/defaults write /Library/Preferences/com.apple.security.authorization.plist ignoreArd -bool TRUE
```


### Dotfiles
```
git clone git@github.com:marcusguttenplan/_dotfiles.git && cd _dotfiles
```

```
cp .gitconfig ~
cp .gitignore ~
cp .vimrc ~
```

### Zsh

```
cp zsh/.zshrc ~
cp zsh/.zprofile ~
cp zsh/.zshenv ~
cp zsh/local.zsh-theme ~/.oh-my-zsh/custom/themes
```

### Setup Dev tools

```
brew install node nodenv rbenv ruby-build
```

```
brew install qlstephen qlmarkdown betterzip
```
