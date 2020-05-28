JULIA_BINDIR="/Applications/Julia-1.3.app/Contents/Resources/julia/bin"
export PATH=$JULIA_BINDIR

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

eval `keychain --eval --agents ssh --inherit any github`
