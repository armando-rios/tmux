#!/usr/bin/env bash

# Sistema de temas para tmux powerline bar
# Múltiples esquemas de colores incluyendo Catppuccin variants y temas populares

# Función para definir colores por tema
set_theme_colors() {
  local theme="$1"
  
  case "$theme" in
    "mocha"|"catppuccin-mocha")
      # Catppuccin Mocha (por defecto - tu configuración actual)
      colors[base]="#1E1E2E"       # base
      colors[text]="#CDD6F4"       # white
      colors[hostname]="#89B4FA"   # blue
      colors[prefix]="#A6E3A1"     # green
      colors[active]="#F38BA8"     # red
      colors[inactive]="#CBA6F7"   # mauve
      colors[cwd]="#F5C2E7"        # pink
      colors[sysinfo]="#74C7EC"    # sapphire
      colors[clock]="#B4BEFE"      # lavender
      colors[background]="#1E1E2E" # base
      ;;
    "latte"|"catppuccin-latte")
      # Catppuccin Latte (claro)
      colors[base]="#EFF1F5"       # base
      colors[text]="#4C4F69"       # text
      colors[hostname]="#1E66F5"   # blue
      colors[prefix]="#40A02B"     # green
      colors[active]="#D20F39"     # red
      colors[inactive]="#8839EF"   # purple
      colors[cwd]="#EA76CB"        # pink
      colors[sysinfo]="#209FB5"    # sapphire
      colors[clock]="#7287FD"      # lavender
      colors[background]="#EFF1F5" # base
      ;;
    "frappe"|"catppuccin-frappe")
      # Catppuccin Frappé
      colors[base]="#303446"       # base
      colors[text]="#C6D0F5"       # text
      colors[hostname]="#8CAAEE"   # blue
      colors[prefix]="#A6D189"     # green
      colors[active]="#E78284"     # red
      colors[inactive]="#CA9EE6"   # mauve
      colors[cwd]="#F4B8E4"        # pink
      colors[sysinfo]="#81C8BE"    # teal
      colors[clock]="#BABBF1"      # lavender
      colors[background]="#303446" # base
      ;;
    "macchiato"|"catppuccin-macchiato")
      # Catppuccin Macchiato
      colors[base]="#24273A"       # base
      colors[text]="#CAD3F5"       # text
      colors[hostname]="#8AADF4"   # blue
      colors[prefix]="#A6DA95"     # green
      colors[active]="#EE99A0"     # red
      colors[inactive]="#C6A0F6"   # mauve
      colors[cwd]="#F5BDE6"        # pink
      colors[sysinfo]="#8BD5CA"    # teal
      colors[clock]="#B7BDF8"      # lavender
      colors[background]="#24273A" # base
      ;;
    "dracula")
      # Dracula theme
      colors[base]="#282A36"       # background
      colors[text]="#F8F8F2"       # foreground
      colors[hostname]="#8BE9FD"   # cyan
      colors[prefix]="#50FA7B"     # green
      colors[active]="#FF79C6"     # pink
      colors[inactive]="#BD93F9"   # purple
      colors[cwd]="#FFB86C"        # orange
      colors[sysinfo]="#FF5555"    # red
      colors[clock]="#F1FA8C"      # yellow
      colors[background]="#282A36" # background
      ;;
    "nord")
      # Nord theme
      colors[base]="#2E3440"       # polar night
      colors[text]="#D8DEE9"       # snow storm
      colors[hostname]="#5E81AC"   # frost blue
      colors[prefix]="#A3BE8C"     # aurora green
      colors[active]="#BF616A"     # aurora red
      colors[inactive]="#B48EAD"   # aurora purple
      colors[cwd]="#D08770"        # aurora orange
      colors[sysinfo]="#88C0D0"    # frost light blue
      colors[clock]="#EBCB8B"      # aurora yellow
      colors[background]="#2E3440" # polar night
      ;;
    "gruvbox"|"gruvbox-dark")
      # Gruvbox Dark theme
      colors[base]="#282828"       # bg0
      colors[text]="#EBDBB2"       # fg0
      colors[hostname]="#83A598"   # blue
      colors[prefix]="#B8BB26"     # green
      colors[active]="#FB4934"     # red
      colors[inactive]="#D3869B"   # purple
      colors[cwd]="#FE8019"        # orange
      colors[sysinfo]="#8EC07C"    # aqua
      colors[clock]="#FABD2F"      # yellow
      colors[background]="#282828" # bg0
      ;;
    "tokyo-night"|"tokyonight")
      # Tokyo Night theme
      colors[base]="#1A1B26"       # background
      colors[text]="#C0CAF5"       # foreground
      colors[hostname]="#7AA2F7"   # blue
      colors[prefix]="#9ECE6A"     # green
      colors[active]="#F7768E"     # red
      colors[inactive]="#BB9AF7"   # purple
      colors[cwd]="#FF9E64"        # orange
      colors[sysinfo]="#7DCFFF"    # cyan
      colors[clock]="#E0AF68"      # yellow
      colors[background]="#1A1B26" # background
      ;;
    "one-dark"|"onedark")
      # One Dark theme
      colors[base]="#282C34"       # background
      colors[text]="#ABB2BF"       # foreground
      colors[hostname]="#61AFEF"   # blue
      colors[prefix]="#98C379"     # green
      colors[active]="#E06C75"     # red
      colors[inactive]="#C678DD"   # purple
      colors[cwd]="#D19A66"        # orange
      colors[sysinfo]="#56B6C2"    # cyan
      colors[clock]="#E5C07B"      # yellow
      colors[background]="#282C34" # background
      ;;
    *)
      # Fallback a Mocha si el tema no existe
      echo "Warning: Unknown theme '$theme', falling back to 'mocha'" >&2
      set_theme_colors "mocha"
      ;;
  esac
}

# Lista de temas disponibles
get_available_themes() {
  echo "mocha latte frappe macchiato dracula nord gruvbox tokyo-night one-dark"
}

# Función para validar tema
is_valid_theme() {
  local theme="$1"
  local available_themes=$(get_available_themes)
  
  if [[ " $available_themes " =~ " $theme " ]]; then
    return 0
  else
    return 1
  fi
}