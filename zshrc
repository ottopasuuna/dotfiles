#initialize fasd
eval "$(fasd --init auto)"

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

autoload -U zargs

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache 1
#don't know what this does
zstyle ':completion:*' completer _expand _complete _ignored _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

unsetopt CASE_GLOB
setopt COMPLETE_ALIASES
setopt HIST_IGNORE_DUPS
setopt GLOB_COMPLETE
setopt emacs #expected readline behaivior
setopt EXTENDED_GLOB

#Dissable flow control so we can use crtl q/s
stty -ixon -ixoff

#plugin management with zplug
source ~/.zplug/init.zsh
# source /usr/share/zsh/scripts/zplug/init.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
zplug "zplug/zplug"
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "bcho/Watson.zsh"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "caarlos0/zsh-open-pr"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

source ~/.zsh-theme/zsh-git-prompt/zshrc.sh
source ~/.zsh-theme/gnzh.zsh-theme
#Aliases
alias ls='ls --color=tty'
alias la="ls -a"
alias sl="ls"
alias ll="ls -l"
alias vim="nvim"
alias archey="archey3"
alias t="task"
alias ta="task add"
alias tm="task mod"
alias tw="vim +TW"
alias yt="youtube-viewer -C"
alias suspend="systemctl suspend"
alias music="ncmpcpp"
alias ytmusic="mpsyt"
alias vimrc="nvim ~/.vimrc"
alias zshrc="nvim ~/.zshrc"
alias g++="g++ -Wall -pedantic"
alias vi="nvim"
alias makeandroid="./gradlew assembleDebug && adb install -r app/build/outputs/apk/app-debug.apk"
alias gcap="git commit -a && git push"
alias upass="sudo umount /media/KINGSTON"
alias modelsim="/opt/altera/16.0/modelsim_ase/bin/vsim"
alias gl="git log --format=\"%C(auto)%h %d %Creset%s%n%Cgreen%ar %C(magenta)%an\" --graph --all"
alias buspirate="picocom -b 115200 /dev/buspirate"
alias arch2="sudo systemd-nspawn -b -D ~/vm/arch2 "

#export PATH=$HOME/bin:/usr/local/bin:$PATH:/home/carl/.gem/ruby/2.4.0/bin
for n in {1..9}; do
    alias $n="%$n";
done

#Variables
export PATH=$HOME/.ellipsis/bin:$HOME/bin:/usr/local/bin:$HOME/.gem/ruby/2.3.0/bin:/home/carl/.gem/ruby/2.4.0/bin:$PATH
export PATH=$HOME/miniconda3/bin:$PATH
export LFS=/mnt/lfs
# export STEAM_RUNTIME=0
export EDITOR="nvim"
export KSP=~/.steam/steam/SteamApps/common/Kerbal\ Space\ Program/
export QT_STYLE_OVERRIDE=gtk
export LS_COLORS="di=00;34"
export BROWSER=firefox
export ANDROID_HOME=/opt/android-sdk/tools
export TERM=xterm-256color
export DISPLAY=:0.0
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus


#Functions
function search() {
    pikaur -Ss $@
}

function install() {
    sudo pikaur -S $@ #|| sudo aura -Axa --hotedit $@
}


function mr() {
    if [[ ! -d ~/.Trash ]]
    then
       mkdir ~/.Trash
    fi
    mv $@ ~/.Trash
}

function vga-start() {
    xrandr --output VGA-1 --mode 1920x1080 --right-of LVDS-1
}

function vga-stop() {
    xrandr --output VGA-1 --off
}

function average() {
    awk '{sum+=$1} END {print sum/NR}' $1
}

function gshell() {
    if [[ $# -eq 1 ]] then
        machinectl shell $USER@games /usr/bin/$1
    else
        machinectl shell $USER@games
    fi
}


# Uncomment these if trouble occurs
# PATH="/home/carl/perl5/bin:/usr/share/pk2${PATH+:}$PATH:$ANDROID_HOME"; export PATH;
# PERL5LIB="/home/carl/perl5/lib/perl5${PERL5LIB+:}$PERL5LIB"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/carl/perl5${PERL_LOCAL_LIB_ROOT+:}$PERL_LOCAL_LIB_ROOT"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/carl/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/carl/perl5"; export PERL_MM_OPT;
unset GREP_OPTIONS
