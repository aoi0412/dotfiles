# エイリアス
alias ll='ls -laFh'
alias vi='nvim'
alias vim='nvim'
alias view='nvim -R'

# zsh オプション
setopt auto_cd
setopt auto_pushd
setopt correct
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt pushd_ignore_dups
setopt share_history

export HISTFILE=~/.zsh_history
export HISTSIZE=500
export SAVEHIST=500

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# sheldon
eval "$(sheldon source)"

# tmux
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
if [ -z "$TMUX" ]; then
    exec tmux -f ~/.config/tmux/.tmux.conf new-session -As main
fi

# Added by Antigravity
export PATH="${HOME}/.antigravity/antigravity/bin:$PATH"

# podman-composeのソケット用
export DOCKER_HOST="unix:///run/user/$(id -u)/podman/podman.sock"

. "$HOME/.local/bin/env"

# uv / ghq — ~/.local/bin に入るツール共通
export PATH="$HOME/.local/bin:$PATH"

# ghq
export GHQ_ROOT="/mnt/c/Users/tamao/ghq"

# gcd — ghq + fzf でリポジトリに移動
function gcd() {
  local repo
  repo=$(ghq list | fzf \
    --prompt="repo > " \
    --preview="ls $(ghq root)/{}" \
    --preview-window=right:50% \
    --height=40% \
    --reverse \
    --query="$1"
  )
  [ -n "$repo" ] && cd "$(ghq root)/$repo"
}
