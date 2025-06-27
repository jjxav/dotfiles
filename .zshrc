
export PATH=$HOME/.local/bin:$PATH

export HISTFILE=$HOME/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=$HISTFILESIZE
export SAVEHIST=$HISTFILESIZE

export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/noob.yml)"

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.config}/zinit"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -U +X bashcompinit && bashcompinit
autoload -U compinit && compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

alias ls="ls --color=always"
alias eza="eza --color=always"
alias less="less -R"

source ~/.zshrc.custom

eval "$(zoxide init zsh --cmd cd)"
source <(gowall completion zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.zshrc.custom
