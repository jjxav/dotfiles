#!/usr/bin/env zsh

export PATH=$HOME/.local/bin:$PATH

export HISTFILE=$HOME/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=$HISTFILESIZE
export SAVEHIST=$HISTFILESIZE

export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

if which oh-my-posh 2>&1 > /dev/null ; then
	eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/noob.yml)"
fi

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
bindkey "$terminfo[kcuu1]" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "$terminfo[kcud1]" history-search-forward

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey -s ^S 'tmux-selector\n'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if which fzf 2>&1 > /dev/null ; then
	source <(fzf --zsh)
	export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
	--style full
	--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
	--color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
	--color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
	--color=border:#262626,label:#aeaeae,query:#d9d9d9
	--border="sharp" --border-label-pos="0" --preview-window="border-sharp"
	--padding="0" --margin="0,0" --prompt="> " --marker=">"
	--pointer="-" --separator="─" --scrollbar="│"'
fi

alias ls="ls --color=always"
alias eza="eza --color=always"
alias less="less -R"
alias vim=nvim

if which zoxide 2>&1 > /dev/null ; then
	eval "$(zoxide init zsh --cmd cd)"
fi

if which gowall 2>&1 > /dev/null ; then
	source <(gowall completion zsh)
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

