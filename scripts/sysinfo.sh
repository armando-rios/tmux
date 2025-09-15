#!/usr/bin/env bash

# Función para obtener uso de CPU de forma robusta
get_cpu_usage() {
  if command -v top >/dev/null 2>&1; then
    # Intentar con formato estándar
    cpu=$(top -bn1 | grep -E "Cpu\(s\)|%Cpu" | head -1 | sed 's/,/\n/g' | grep -E "us|user" | sed 's/[^0-9.]//g' | head -1)
    if [[ -z "$cpu" ]] || ! [[ "$cpu" =~ ^[0-9.]+$ ]]; then
      # Fallback: usar vmstat si está disponible
      if command -v vmstat >/dev/null 2>&1; then
        cpu=$(vmstat 1 2 | tail -1 | awk '{print 100-$15}')
      else
        cpu="--"
      fi
    fi
  else
    cpu="--"
  fi
  echo "${cpu}"
}

# Función para obtener uso de RAM de forma robusta
get_ram_usage() {
  if command -v free >/dev/null 2>&1; then
    ram=$(free -m | awk '/^Mem:/ {printf "%.1fGB", $3/1024}')
    if [[ -z "$ram" ]]; then
      ram="--GB"
    fi
  else
    ram="--GB"
  fi
  echo "${ram}"
}

# Obtener información del sistema
cpu=$(get_cpu_usage)
ram=$(get_ram_usage)

# Mostrar información del sistema
echo " ${cpu}%  ${ram} "