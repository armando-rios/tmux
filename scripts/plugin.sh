#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Cargar colores desde archivo externo
source "${current_dir}/colors.sh"

# Leer opciones desde .tmux.conf
transparent_mode=$(tmux show-option -gqv @tmux_transparent)
show_cwd=$(tmux show-option -gqv @tmux_status_show_cwd)
show_clock=$(tmux show-option -gqv @tmux_status_show_clock)
show_sysinfo=$(tmux show-option -gqv @tmux_status_show_sysinfo)

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

set_status_right() {
  status_right=""
  last_bg="${colors[background]}"

  if [[ "$show_cwd" == "on" ]]; then
    status_right+="#[fg=${colors[cwd]},bg=${last_bg}]${sep_right}#[fg=${colors[base]},bg=${colors[cwd]}]  #(sh ${current_dir}/cwd.sh) "
    last_bg="${colors[cwd]}"
  fi

  if [[ "$show_sysinfo" == "on" ]]; then
    status_right+="#[fg=${colors[sysinfo]},bg=${last_bg}]${sep_right}#[fg=${colors[base]},bg=${colors[sysinfo]}] #(sh ${current_dir}/sysinfo.sh) "
    last_bg="${colors[sysinfo]}"
  fi

  if [[ "$show_clock" == "on" ]]; then
    status_right+="#[fg=${colors[clock]},bg=${last_bg}]${sep_right}#[fg=${colors[base]},bg=${colors[clock]}]  %H:%M "
  fi

  tmux set-option -g status-right "$status_right"
}

main() {
  set_status_bar
  set_status_left
  set_window_options
  set_status_right
}

main
