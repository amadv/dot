# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ------------------------- distro detection -------------------------

export DISTRO
[[ $(uname -r) =~ Microsoft ]] && DISTRO=WSL2 #distinguish WSL1
[[ $(uname -r) =~ android ]] && DISTRO=ANDROID #distinguish Termux

# ---------------------- local utility functions ---------------------

_have()      { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# ----------------------- environment variables ----------------------
#                           (also see envx)

export USER="${USER:-$(whoami)}"
export GITUSER="amadv"
export GITWORKUSER="aaron-bcw"
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/$GITUSER"
export GHWORKREPOS="$REPOS/$GITWORKUSER"
export DOTFILES="$GHREPOS/dot"
export SCRIPTS="$DOTFILES/scripts"
export SNIPPETS="$DOTFILES/snippets"
export HELP_BROWSER=lynx
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export PUBLIC="$HOME/Public"
export PRIVATE="$HOME/Private"
export PICTURES="$HOME/Pictures"
export MUSIC="$HOME/Music"
export VIDEOS="$HOME/Videos"
export ZETDIR="$GHREPOS/zet"
export CLIP_VOLUME=0
export CLIP_SCREEN=0
export TERM=xterm-256color
export HRULEWIDTH=73
export EDITOR=vim
export VISUAL=vim
export EDITOR_PREFIX=vim
export GOPRIVATE="github.com/$GITUSER/*,github.com/$GITWORKUSER/*"
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export GOPROXY=direct
export CGO_ENABLED=0
export LC_COLLATE=C
export CFLAGS="-Wall -Wextra -Werror -O0 -g -fsanitize=address -fno-omit-frame-pointer -finstrument-functions"

export LESS="-FXR"
export LESS_TERMCAP_mb="[35m" # magenta
export LESS_TERMCAP_md="[33m" # yellow
export LESS_TERMCAP_me="" # "0m"
export LESS_TERMCAP_se="" # "0m"
export LESS_TERMCAP_so="[34m" # blue
export LESS_TERMCAP_ue="" # "0m"
export LESS_TERMCAP_us="[4m"  # underline

export ANSIBLE_CONFIG="$HOME/.config/ansible/config.ini"
export ANSIBLE_INVENTORY="$HOME/.config/ansible/inventory.yaml"
export ANSIBLE_LOAD_CALLBACK_PLUGINS=1

[[ -d /.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")

export acmeshell="bash"
export KIND_EXPERIMENTAL_PROVIDER=podman

# ------------------------------ history -----------------------------
export HISTSIZE=5000
export HISTFILESIZE=10000
shopt -s histappend  # In Ubuntu this is already set by default

# ------------------------------ prompt ---------------------------
# export PS1=" λ  "
export PS1=", "
export PS2="\011" # Tab

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ------------------------------ aliases -----------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ip='ip -c'
alias '?'=duck
alias '??'=$SCRIPTS/google
alias '???'=bing
alias tt=$SCRIPTS/termux-tmux
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias snippets='cd $SNIPPETS'
alias ls='ls -h --color=auto'
alias free='free -h'
alias tree='tree -a'
alias df='df -h'
alias chmox='chmod +x'
alias diff='diff --color'
alias temp='cd $(mktemp -d)'
alias view='vi -R' # which is usually linked to vim
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias coin="clip '(yes|no)'"
alias gpati='GITHUB_PAT=<key> npm install'
alias zet=$SCRIPTS/zet
alias npm_update='npx npm-check-updates -u'
alias vim='vim'
alias vi='vim'
alias '..'='cd ..'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ------------------------------ auto-complete -----------------------
#source /etc/profile.d/bash_completion.sh
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ----------------------------- lynx ---------------------------------
export LYNX_CFG=$HOME/.config/lynx/lynx.cfg
export LYNX_LSS=$HOME/.config/lynx/lynx.lss

# ----------------------------- golang -------------------------------
if [[ $(uname -r) =~ android ]]; then
    export GOROOT=/data/data/com.termux/files/usr/lib/go
    export GOPATH=$HOME/go
    common_path="/usr/bin/tmux:/usr/bin/screen"
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH:$common_path
    export PATH=$PATH:/data/data/com.termux/files/usr/bin/go
else
    export GOROOT=/usr/local/go # Comment out if go is dnf/apt installed
    export GOPATH=$HOME/go
    common_path="/usr/bin/tmux:/usr/bin/screen"
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH:$common_path # Comment out if go is dnf/apt installed
    # export PATH=$GOPATH/bin:$PATH:$common_path # Uncomment if GOROOT does not exist
fi

# ----------------------------- plan9 --------------------------------
# export PLAN9=~/plan9port
export PLAN9=/usr/local/plan9
export PATH=$PATH:$PLAN9/bin

# ----------------------------- node ---------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/var/home/aron/Repos/aaron-bcw/google-cloud-sdk/path.bash.inc' ]; then . '/var/home/aron/Repos/aaron-bcw/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/var/home/aron/Repos/aaron-bcw/google-cloud-sdk/completion.bash.inc' ]; then . '/var/home/aron/Repos/aaron-bcw/google-cloud-sdk/completion.bash.inc'; fi

export PATH=$PATH:/home/aron/.local/bin

. "/home/aron/.deno/env"
. "$HOME/.cargo/env"
