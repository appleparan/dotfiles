source ~/.profile

SSH_ENV="$HOME/.ssh/environment"

PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
