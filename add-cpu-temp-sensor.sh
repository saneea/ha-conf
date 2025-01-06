echo "

command_line:
  - sensor:
      unique_id: rpi.cpu.temperature
      name: CPU Temperature
      command: 'cat /sys/class/thermal/thermal_zone0/temp'
      unit_of_measurement: 'C'
      scan_interval: 60
      value_template: '{{ value | multiply(0.001) | round(3) }}'
" >> ./data/ha/config/configuration.yaml
