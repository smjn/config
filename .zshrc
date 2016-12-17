# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "$TERM" = "linux" ]; then
	ZSH_THEME="maran2"
else
	#export TERM="xterm-color"
	ZSH_THEME="sushant"
fi
#good themes agnoster

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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
# Add wisely, as too many plugins slow down shell startup.
plugins=(git debian common-aliases sublime zsh-syntax-highlighting)

# User configuration

export GOROOT=/opt/go
export GOPATH=~/programs/gocode
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias APT='sudo apt-fast update'
alias APTU='sudo apt-fast update && sudo apt-fast -y upgrade'
alias AP='sudo apt-fast'
alias g++11="g++ -std=c++11"
alias t2="tmux -2 -u"
alias vimx="vim '+set t_ut='"
alias zsrc='source /home/sushant/.zshrc'
alias axe='axel -n30 -a'
alias PUB='git add .; echo -n "message? "; read msg; gcmsg $msg; ggpush'
alias POW='please poweroff'
alias REB='please reboot'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias mean='sdcv'
alias fixNumix="sudo cp -v /usr/share/themes/Numix\ Daily/gtk-2.0/{gtkrc.bak,gtkrc}"
alias cdA='cd ~/.config/awesome/'
alias awerc='vim ~/.config/awesome/rc.lua'
alias cdI='cd ~/.config/i3/'
alias i3rc='vim ~/.config/i3/config'
alias IB='bash ~/programs/bash/bright.sh'
alias DB='bash ~/programs/bash/bright.sh 1'

#alias htop='htop -C'

#.dircolors.ansi-dark
#.dircolors.ansi-dark
eval `dircolors ~/.dircolors`
#LS_COLORS=$LS_COLORS:'ow=0;34:di=0;34'; export LS_COLORS
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit -u
setopt extended_glob
