# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
alias tnbit="ssh -C -L 8022:bitbucket.org:22 appleparan@165.132.24.127 -N ,"
alias tngithub="ssh -C -L 8022:github.com:22 appleparan@165.132.24.127 -N ,"



