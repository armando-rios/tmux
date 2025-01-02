#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

main()
{
  # Catppuccin Mocha Colors (oficiales)
  rosewater="#F5E0DC"
  flamingo="#F2CDCD"
  pink="#F5C2E7"
  mauve="#CBA6F7"
  red="#F38BA8"
  maroon="#EBA0AC"
  peach="#FAB387"
  yellow="#F9E2AF"
  green="#A6E3A1"
  teal="#94E2D5"
  sky="#89DCEB"
  sapphire="#74C7EC"
  blue="#89B4FA"
  lavender="#B4BEFE"
  text="#CDD6F4"
  subtext1="#BAC2DE"
  subtext0="#A6ADC8"
  overlay2="#9399B2"
  overlay1="#7F849C"
  overlay0="#6C7086"
  surface2="#585B70"
  surface1="#45475A"
  surface0="#313244"
  base="#1E1E2E"
  mantle="#181825"
  crust="#11111B"
  background="#1e1e2e"

  sep_left=""
  sep_right=""
  left_icon=""
  on_icon=""
  off_icon=""

  # Status left
  tmux set-option -g status-left "#[bg=${blue},fg=${base}]#{?client_prefix,#[bg=${green}],} ${left_icon} #H #[fg=${blue},bg=${background}]#{?client_prefix,#[fg=${green}],}${sep_left} "

  # Window option
  tmux set-window-option -g window-status-current-format "#[fg=${background},bg=${mauve}]${sep_left}#[fg=${surface0},bg=${mauve}]   #W #[fg=${mauve},bg=${background}]${sep_left}"

  tmux set-window-option -g window-status-format "#[fg=${background},bg=${red}]${sep_left}#[fg=${text},bg=${red}]   #W #[fg=${red},bg=${background}]${sep_left}"

  tmux set-window-option -g window-status-activity-style "bold"
  tmux set-window-option -g window-status-bell-style "bold"
}

# run main function
main
