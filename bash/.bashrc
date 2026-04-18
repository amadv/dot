# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export EDITOR=vim
export VISUAL=vim
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cask/bin"
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.local/go/bin"
export GOBIN="~/.local/bin"

alias dot="cd $HOME/Repos/github.com/amadv/dot"
alias repos="cd $HOME/Repos/github.com/amadv"
alias aj="cd $HOME/Repos/github.com/amadv/aj-private && claude"
alias blog="cd $HOME/Repos/github.com/amadv/amadv.github.io && claude"
alias undo="git reset --soft HEAD~1"
alias youtube-mp3="youtube-dl --extract-audio --audio-format mp3"

# Load additional shell scripts from ~/.bashrc.d if the directory exists
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
    done
fi

make_prompt() {
    # Colors
    local default="\[\e[0m\]"
    local red="\[\e[31m\]"
    local green="\[\e[32m\]"

    # Prompt color based on last command exit status
    local status_color="\`[ \$? = 0 ] && echo \"$green\" || echo \"$red\"\`"

    # Git info: branch name and dirty indicator (*)
    local git_info='$( 
        branch=$(git symbolic-ref --short -q HEAD 2>/dev/null)
        if [ -n "$branch" ]; then
            dirty=$(git status --porcelain 2>/dev/null)
            [ -n "$dirty" ] && echo " [$branch*]" || echo " [$branch]"
        fi
    )'

    # Final prompt
    PS1="[\h \W]$git_info ${status_color}\$${default} "
}

make_prompt

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/aaron/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

