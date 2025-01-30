#!/usr/bin/env bash

# Obtener uso de CPU
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Obtener uso de RAM
ram=$(free -m | awk '/Mem:/ {printf "%.1fGB", $3 /1024}')

# Mostrar información del sistema
echo " ${cpu}%  ${ram} "
