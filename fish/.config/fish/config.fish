# =================================================================
# Base CachyOS config
# =================================================================
  source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
       fastfetch-centered.sh
end
