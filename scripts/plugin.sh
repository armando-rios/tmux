#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8
current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Colores Catppuccin Mocha
declare -A colors=(
  [rosewater]="#F5E0DC"
  [flamingo]="#F2CDCD"
  [pink]="#F5C2E7"
  [mauve]="#CBA6F7"
  [red]="#F38BA8"
  [maroon]="#EBA0AC"
  [peach]="#FAB387"
  [yellow]="#F9E2AF"
  [green]="#A6E3A1"
  [teal]="#94E2D5"
  [sky]="#89DCEB"
  [sapphire]="#74C7EC"
  [blue]="#89B4FA"
  [lavender]="#B4BEFE"
  [text]="#CDD6F4"
  [subtext1]="#BAC2DE"
  [subtext0]="#A6ADC8"
  [overlay2]="#9399B2"
  [overlay1]="#7F849C"
  [overlay0]="#6C7086"
  [surface2]="#585B70"
  [surface1]="#45475A"
  [surface0]="#313244"
  [base]="#1E1E2E"
  [mantle]="#181825"
  [crust]="#11111B"
  [background]="#1E1E2E"
)

# Símbolos y separadores
sep_left=""
sep_right=""
divider=""
left_icon=""
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
  tmux set-window-option -g window-status-format "#[fg=${colors[mauve]},bg=${colors[background]}]${divider}#[fg=${colors[surface0]},bg=${colors[mauve]}] ${off_icon}  #W #[fg=${colors[mauve]},bg=${colors[background]}]${sep_left}"
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
