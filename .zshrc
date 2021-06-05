# ------------------------------Customize to your needs...-----------------------------
autoload -Uz promptinit
promptinit

# rust command
alias ls='exa -G --icons'
alias ll='exa -lG --icons -al --git'
alias la='exa -laG --icons'
alias lt='exa -GT --icons'
alias cat='bat'
alias cp='xcp'

# my alias
alias ..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

# my directory alias

# my directory alias(hash)

# Rust
export PATH="$HOME/.cargo/bin:$PATH"


# ------------------------------zprezto and p10k-----------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ------------------------------fzf customize------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ^rでコマンドヒストリーをfzfで表示
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# fzf + fd 
# fzf で fuzzy 検索+ 特定のディレクトリに cd
# >> https://dev.classmethod.jp/articles/shuntaka-rust-20190816/#toc-10
function fd-fzf() {
  local target_dir=$(fd -t d -I -H -E ".git"| fzf --reverse --query="$LBUFFER")
  local current_dir=$(pwd)

  if [ -n "$target_dir" ]; then
    BUFFER="cd ${current_dir}/${target_dir}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N fd-fzf
bindkey '^n' fd-fzf

# fzfでプレビューを表示
# alias fzf= 'fzf --preview 'head -100 {}''


# ------------------------------customize terminal------------------------------
# https://qiita.com/ktr_type23/items/3eb782f98c7a5f4c60b0
# タブ補完時に色つける
autoload -Uz compinit
compinit
 
zstyle ':completion:*' menu select

# heroku autocomplete setup
# https://masutaka.net/chalow/2018-10-28-1.html
HEROKU_AC_ZSH_SETUP_PATH=/Users/shota/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
