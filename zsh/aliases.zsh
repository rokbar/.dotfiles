
# Print processes of specific port, e.g pbp :3005
alias pbp="lsof -i"

# Stole from https://github.com/mathiasbynens/dotfiles/blob/main/.aliases
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # macOS `ls`
	colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
