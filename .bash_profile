source ~/.profile

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# nodenv
eval "$(nodenv init -)"

# Homebrew Big Sur
eval "$(/opt/homebrew/bin/brew shellenv)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


## updates PATH for the Google Cloud SDK.
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'

## shell command completion for gcloud.
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'