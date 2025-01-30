#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Cargar colores desde archivo externo
source "${current_dir}/colors.sh"

# Símbolos y separadores
sep_left=""
sep_right=""
divider=""
left_icon=""
on_icon=""
off_icon=""

set_status_bar() {
  tmux set-option -g status-style "bg=${colors[background]},fg=${colors[text]}"
}

set_status_left() {
  prefix_style="#{?client_prefix,#[bg=${colors[green]}],}"
  tmux set-option -g status-left "#[bg=${colors[blue]},fg=${colors[background]}]${prefix_style} ${left_icon} #H #[fg=${colors[blue}],bg=${colors[background]}]${sep_left}"
}

set_window_options() {
  tmux set-window-option -g window-status-current-format "#[fg=${colors[red]},bg=${colors[background]}]${divider}#[fg=${colors[surface0]},bg=${colors[red]}] ${on_icon}  #W #[fg=${colors[red]},bg=${colors[background]}]${sep_left}"
  tmux set-window-option -g window-status-format "#[fg=${colors[mauve]},bg=${colors[background]}]${divider}#[fg=${colors[surface0]},bg=${colors[mauve]}] ${off_icon}  #W #[fg=${colors[mauve}],bg=${colors[background]}]${sep_left}"
  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"
}

set_status_right() {
  tmux set-option -g status-right ""
}

main() {
  set_status_bar
  set_status_left
  set_window_options
  set_status_right
}

main
