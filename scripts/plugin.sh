#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Validar dependencias
check_dependencies() {
  # Verificar versión de tmux
  if ! command -v tmux >/dev/null 2>&1; then
    echo "Error: tmux is not installed" >&2
    exit 1
  fi
  
  local tmux_version=$(tmux -V | cut -d' ' -f2 | tr -d 'a-zA-Z')
  local required_version="3.0"
  
  if ! command -v bc >/dev/null 2>&1; then
    # Fallback simple sin bc
    local major=$(echo "$tmux_version" | cut -d'.' -f1)
    if [[ "$major" -lt 3 ]]; then
      echo "Warning: tmux version $tmux_version may not be fully supported (requires 3.0+)" >&2
    fi
  else
    if (( $(echo "$tmux_version < $required_version" | bc -l) )); then
      echo "Warning: tmux version $tmux_version may not be fully supported (requires 3.0+)" >&2
    fi
  fi
}

# Ejecutar validación de dependencias
check_dependencies

# Cargar sistema de temas
if [[ ! -f "${current_dir}/themes.sh" ]]; then
  echo "Error: themes.sh not found in ${current_dir}" >&2
  exit 1
fi
source "${current_dir}/themes.sh"

# Leer opciones desde .tmux.conf con valores por defecto
transparent_mode=$(tmux show-option -gqv @tmux_transparent)
show_cwd=$(tmux show-option -gqv @tmux_status_show_cwd)
show_clock=$(tmux show-option -gqv @tmux_status_show_clock)
show_sysinfo=$(tmux show-option -gqv @tmux_status_show_sysinfo)
status_format=$(tmux show-option -gqv @tmux_status_format)
theme=$(tmux show-option -gqv @tmux_theme)

# Establecer valores por defecto si no están configurados
[[ -z "$transparent_mode" ]] && transparent_mode="off"
[[ -z "$show_cwd" ]] && show_cwd="on"
[[ -z "$show_clock" ]] && show_clock="on"
[[ -z "$show_sysinfo" ]] && show_sysinfo="on"
[[ -z "$status_format" ]] && status_format="cwd|sysinfo|clock"
[[ -z "$theme" ]] && theme="mocha"

# Inicializar array de colores y cargar tema
declare -A colors
set_theme_colors "$theme"

# Función para validar formato
validate_format() {
  local format="$1"
  local valid_elements="cwd sysinfo clock"
  
  # Dividir formato por |
  IFS='|' read -ra elements <<< "$format"
  
  for element in "${elements[@]}"; do
    if [[ ! " $valid_elements " =~ " $element " ]]; then
      echo "Warning: Unknown status element '$element'. Valid elements: $valid_elements" >&2
      return 1
    fi
  done
  return 0
}

# Función para validar tema
validate_theme() {
  local theme_name="$1"
  
  if ! is_valid_theme "$theme_name"; then
    echo "Warning: Unknown theme '$theme_name'. Available themes: $(get_available_themes)" >&2
    echo "Using default theme 'mocha'" >&2
    return 1
  fi
  return 0
}

# Validar configuraciones
validate_format "$status_format"
validate_theme "$theme"

# Símbolos y separadores
sep_left=""
sep_right=""
divider=""
left_icon=""
on_icon=""
off_icon=""

if [[ "$transparent_mode" == "on" ]]; then
  colors[background]=default
fi

set_status_bar() {
  tmux set-option -g status-style "bg=${colors[background]},fg=${colors[text]}"
}

set_status_left() {
  tmux set-option -g status-left "#[bg=${colors[hostname]},fg=${colors[base]}]#{?client_prefix,#[bg=${colors[prefix]}],} ${left_icon} #H #[fg=${colors[hostname]},bg=${colors[background]}]#{?client_prefix,#[fg=${colors[prefix]}],}${sep_left} "
}

set_window_options() {
  tmux set-window-option -g window-status-current-format "#[fg=${colors[active]},bg=${colors[background]}]${divider}#[fg=${colors[base]},bg=${colors[active]}] ${on_icon}  #W #[fg=${colors[active]},bg=${colors[background]}]${sep_left}"
  tmux set-window-option -g window-status-format "#[fg=${colors[inactive]},bg=${colors[background]}]${divider}#[fg=${colors[base]},bg=${colors[inactive]}] ${off_icon}  #W #[fg=${colors[inactive]},bg=${colors[background]}]${sep_left}"
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"
}

# Función para generar elemento individual
generate_element() {
  local element="$1"
  local last_bg="$2"
  local result=""
  
  case "$element" in
    "cwd")
      if [[ "$show_cwd" == "on" ]]; then
        result="#[fg=${colors[cwd]},bg=${last_bg}]${sep_right}#[fg=${colors[base]},bg=${colors[cwd]}]  #(sh ${current_dir}/cwd.sh) "
        echo "$result|${colors[cwd]}"
      else
        echo "|$last_bg"
      fi
      ;;
    "sysinfo")
      if [[ "$show_sysinfo" == "on" ]]; then
        result="#[fg=${colors[sysinfo]},bg=${last_bg}]${sep_right}#[fg=${colors[base]},bg=${colors[sysinfo]}] #(sh ${current_dir}/sysinfo.sh) "
        echo "$result|${colors[sysinfo]}"
      else
        echo "|$last_bg"
      fi
      ;;
    "clock")
      if [[ "$show_clock" == "on" ]]; then
        result="#[fg=${colors[clock]},bg=${last_bg}]${sep_right}#[fg=${colors[base]},bg=${colors[clock]}]  %H:%M "
        echo "$result|${colors[clock]}"
      else
        echo "|$last_bg"
      fi
      ;;
    *)
      echo "|$last_bg"
      ;;
  esac
}

set_status_right() {
  status_right=""
  last_bg="${colors[background]}"
  
  # Dividir formato por |
  IFS="|" read -ra elements <<< "$status_format"
  
  # Generar elementos en el orden especificado
  for element in "${elements[@]}"; do
    element_result=$(generate_element "$element" "$last_bg")
    element_content="${element_result%|*}"
    last_bg="${element_result#*|}"
    
    if [[ -n "$element_content" ]]; then
      status_right+="$element_content"
    fi
  done

  tmux set-option -g status-right "$status_right"
}

main() {
  set_status_bar
  set_status_left
  set_window_options
  set_status_right
}

main
