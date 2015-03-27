# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gnzh"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git, sudo, compleat, colored-man web-search)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh-autosuggestions/autosuggestions.zsh

#Enable autosuggestions
# zle-line-init() {
#     zle autosuggest-start
# }
# zle -N zle-line-init
#
# bindkey '^T' autosuggest-toggle

# User configuration

alias la="ls -a"
alias archey="archey3"
alias t="task"
alias ta="task add"
alias yt="youtube-viewer -C"
alias sleep="systemctl suspend"
alias update="yaourt -Syua --noconfirm"
alias install="yaourt -Sa"
alias music="ncmpcpp"
alias vimrc="vim ~/.vimrc"
alias g++="g++ -Wall -pedantic"
alias pvsim="wine ~/.wine/drive_c/Program\ Files\ \(x86\)/PVSim/PVSim.exe"
alias vi="vim"

export PATH=$HOME/bin:/usr/local/bin:$PATH:
export LFS=/mnt/lfs
# export STEAM_RUNTIME=0
export EDITOR="vim"
export KSP=~/.steam/steam/SteamApps/common/Kerbal\ Space\ Program/
export QT_STYLE_OVERRIDE=gtk
export LS_COLORS="di=00;34"

#Enable fasd
eval "$(fasd --init posix-alias zsh-hook)"

#Dissable flow control so we can use crtl q/s
stty -ixon -ixoff

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#Set TERM environment
export TERM=xterm-256color

PATH="/home/carl/perl5/bin:/usr/share/pk2${PATH+:}$PATH"; export PATH;
PERL5LIB="/home/carl/perl5/lib/perl5${PERL5LIB+:}$PERL5LIB"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/carl/perl5${PERL_LOCAL_LIB_ROOT+:}$PERL_LOCAL_LIB_ROOT"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/carl/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/carl/perl5"; export PERL_MM_OPT;
unset GREP_OPTIONS
