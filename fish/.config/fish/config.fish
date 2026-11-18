# >>> lig pre >>>
eval ('/home/jzyb/.local/bin/lig' init fish pre | string collect)
# <<< lig pre <<<
# ============================================================
# Base CachyOS config
# ============================================================
source /usr/share/cachyos-fish-config/cachyos-config.fish

# ============================================================
# Personal overrides / additions
# ============================================================
function fish_greeting
    fastfetch-centered
end

# Tools
zoxide init fish | source

# Aliases — paru (AUR + official)
alias aurupdate="paru -Syu"
alias aurinstall="paru -S"
alias aurremove="paru -Rns"
alias aursearch="paru -Ss"
# >>> lig post >>>
eval ('/home/jzyb/.local/bin/lig' init fish post | string collect)
# <<< lig post <<<
