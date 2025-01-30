#!/usr/bin/env bash

# Obtener uso de CPU
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Obtener uso de RAM
ram=$(free -m | awk '/Mem:/ {printf "%dMB/%dMB", $3, $2}')

# Mostrar información del sistema
echo "  ${cpu}%   ${ram}"
