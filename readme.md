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
brew install --cask google-chrome 1password raycast dropbox 1password-cli iterm2 displaylink eul visual-studio-code obsidian little-snitch linear-linear tailscale-app docker-desktop
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
cp zsh/local.szh-theme ~/.oh-my-zsh/custom/themes
```
