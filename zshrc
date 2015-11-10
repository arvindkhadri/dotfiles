# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
BASH_ALIAS=$HOME/.bash_aliases
DEFAULT_USER=$USER

export TERM=xterm-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="clean"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux git-extras history history-substring-search python rsync virtualenv vagrant sudo pip jsontools npm quote tmux extract fbterm)

export PATH=$PATH:/home/zoso/Projects/android-sdk/tools:/home/zoso/Projects/android-sdk/build-tools/23.0.1:/home/zoso/Projects/ndk
export ANDROID_HOME="/home/zoso/Projects/android-sdk"
export JAVA_HOME=""
export DEVKIT_ANDROID_KEYSTORE="/home/zoso/.android/hashcube.keystore"
export DEVKIT_ANDROID_STOREPASS="why20hash!"
export DEVKIT_ANDROID_KEYPASS="why20hash!"
export DEVKIT_ANDROID_KEY="hashcube"

source $ZSH/oh-my-zsh.sh

if [[ -f /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
	  source /usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi
# Customize to your needs...
# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

source $BASH_ALIAS
