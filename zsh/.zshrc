# ===========================================================================
# FASTFETCH
# ===========================================================================

 fastfetch-centered.sh


# ===========================================================================
# STARSHIP PROMPT
# ===========================================================================
eval "$(starship init zsh)"


# ===========================================================================
# HISTORY
# ===========================================================================

export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS


# ===========================================================================
# SHELL BEHAVIOUR
# ===========================================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT


# ===========================================================================
# COMPLETIONS
# ===========================================================================

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select


# ===========================================================================
# TOOLS 
# ===========================================================================

eval "$(zoxide init zsh)"

# fzf key bindings and completions
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


# ===========================================================================
# PLUGINS (loaded last so they capture zoxide/fzf configurations)
# ===========================================================================

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh


# ===========================================================================
# ALIASES
# ===========================================================================

# PACMAN
alias update="sudo pacman -Syu"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rns"
alias search="pacman -Ss"

# PARU
alias aurupdate="paru -Syu"
alias aurinstall="paru -S"
alias aurremove="paru -Rns"
alias aursearch="paru -Ss"

# Build speed
alias make="make -j$(nproc)"
alias ninja="ninja -j$(nproc)"
alias n="ninja"

# Arch-help for apt muscle memory
alias apt="man pacman"
alias apt-get="man pacman"
alias please="sudo"

# journalctl error shortcut
alias jctl="journalctl -p 3 -xb"

# Recently installed packages (needs 'expac' package)
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# History tweaks
export HISTCONTROL=ignoreboth
export HISTORY_IGNORE="(&|[bf]g|c|clear|history|exit|q|pwd|* --help)"

# Nicer man page colors
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"


# ===========================================================================
# MISC
# ===========================================================================

# Truly clear terminal scrollback buffer (Kitty-specific)
function clear() {
  echo -ne '\e[3J'
  command clear
}

# Orphan cleanup function
cleanup() {
  sudo pacman -Rsn $(pacman -Qtdq)
}

