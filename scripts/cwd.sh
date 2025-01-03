#!/bin/bash

path=$(tmux display-message -p "#{pane_current_path}")

echo "${path/#$HOME/~}"
