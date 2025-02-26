[1mdiff --git a/bash/.bashrc b/bash/.bashrc[m
[1mindex f78c121..9e887c6 100644[m
[1m--- a/bash/.bashrc[m
[1m+++ b/bash/.bashrc[m
[36m@@ -23,7 +23,7 @@[m [m_source_if() { [[ -r "$1" ]] && source "$1"; }[m
 #                           (also see envx)[m
 [m
 export USER="${USER:-$(whoami)}"[m
[31m-export GITUSER="iviixii"[m
[32m+[m[32mexport GITUSER="amadv"[m
 export GITWORKUSER="aaron-bcw"[m
 export REPOS="$HOME/Repos"[m
 export GHREPOS="$REPOS/$GITUSER"[m
[36m@@ -80,7 +80,8 @@[m [mexport HISTFILESIZE=10000[m
 shopt -s histappend  # In Ubuntu this is already set by default[m
 [m
 # ------------------------------ prompt ---------------------------[m
[31m-export PS1=" λ  "[m
[32m+[m[32m# export PS1=" λ  "[m
[32m+[m[32mexport PS1=", "[m
 export PS2="\011" # Tab[m
 [m
 # enable color support of ls and also add handy aliases[m
[36m@@ -179,3 +180,5 @@[m [mif [ -f '/var/home/aron/Repos/aaron-bcw/google-cloud-sdk/completion.bash.inc' ];[m
 [m
 export PATH=$PATH:/home/x4192/.local/bin[m
 [m
[32m+[m[32m. "/home/aron/.deno/env"[m
[32m+[m[32m. "$HOME/.cargo/env"[m
[1mdiff --git a/git/.gitconfig b/git/.gitconfig[m
[1mindex 3f8629d..c28bb12 100644[m
[1m--- a/git/.gitconfig[m
[1m+++ b/git/.gitconfig[m
[36m@@ -1,5 +1,5 @@[m
 [user][m
[31m-  name = iviixii[m
[32m+[m[32m  name = amadv[m
   email = aaronmadved@gmail.com[m
 [core][m
   excludesfile = ~/.gitignore[m
