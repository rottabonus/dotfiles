#eval "$(pyenv virtualenv-init -)"
#eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
. "$HOME/.cargo/env"
