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

# Customize to your needs...
# PATHを通す
export PATH="/usr/local/bin:$PATH"

# Beep音をなくす
setopt no_beep

# Ctrl+Dでログアウトしてしまうことを防ぐ
setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# コマンドミスを修正
setopt correct
# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# alias
alias lst='ls -ltr'
alias l='ls -ltr'
alias la='ls -a'
alias ll='ls -l'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc ~/.vim/rc/dein.toml ~/.vim/rc/dein_lazy.toml'
alias vt='vim ~/.tmux.conf'
alias c='clear'
alias sz='source ~/.zshrc'
alias sv='source ~/.vimrc'
alias st='source ~/.tmux.conf'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias ..='cd ..'
alias jn='jupyter-notebook'
alias pip='pip3'
alias python='python3'
alias open='xdg-open'
alias ca='conda activate'

# prompt setting

# 1行あける
precmd () {
  print
}

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  # ブランチ名を色付きで表示する
  branch_status="%F{white}"
  echo "${branch_status}[$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

bindkey -v

#zshプロンプトにモード表示####################################
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    # PROMPT="%{$reset_color%}%n@jerky %{$reset_color%}%{$reset_color%}%~/
    PROMPT="%{$reset_color%}%n@jerky %{${fg[yellow]}%}%~/
%{$reset_color%}[%{$fg_bold[red]%}NOR%{$reset_color%}%{$reset_color%}]$ "
    ;;
    main|viins)
    PROMPT="%{$reset_color%}%n@jerky %{${fg[yellow]}%}%~/
%{$reset_color%}[%{$fg_bold[cyan]%}INS%{$reset_color%}%{$reset_color%}]$ "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins '^h' vi-backward-char
bindkey -M viins '^l' vi-forward-char
bindkey -M viins '^w' vi-forward-word
bindkey -M viins '^b' vi-backward-word
bindkey -M viins '^j' vi-down-line-or-history
bindkey -M viins '^k' vi-up-line-or-history
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd 'H' vi-digit-or-beginning-of-line

case $TERM in
    linux) LANG=C ;;
    *)     LANG=ja_JP.UTF-8;;
esac

source /home/xxx/anaconda3/etc/profile.d/conda.sh
conda activate RL
