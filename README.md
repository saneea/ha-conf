# ha-conf

## General

It is just my **Home Assistant** configuration

This configuration assume run **Home Assistant** as docker container.

In order to extend **Home Assistant** possibilities or do maintenance a few additional containers are needed.

List of services (containers):
- ha - Home Assistant
- ha-conf - just web interface for configuring **Home Assistant** files
- mqtt - MQTT broker is some type of gateway which join different devices and services via event messages in queue
- z2m - Zigbee2MQTT is a bridge between MQTT broker and zigbee devices

## Installation steps

1. Clone the repo from
   ```sh
   git clone git@github.com:saneea/ha-conf.git
   ```
2. Go to `ha-conf` directory
   ```sh
   cd ./ha-conf
   ```
3. Create `.env` file from example
   ```sh
   cp ./.env.example ./.env
   ```
4. Create `data` directory from example
   ```sh
   cp -r ./data.example ./data
   ```
5. Change owner of `data` directory (and nested files) to `root` user
   (because some docker containers may complain about non-root-owner files)
   ```sh
   chown -R root:root ./data
   ```
6. Find out your Zigbee stick device file
   ```sh
   ls /dev/serial/by-id
   ```
   You should see something like
   ```
   total 0
   drwxr-xr-x 2 root root 60 Jan  7 22:08 .
   drwxr-xr-x 4 root root 80 Jan  7 22:08 ..
   lrwxrwxrwx 1 root root 13 Jan  7 22:08 usb-Itead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_V2_... -> ../../ttyUSB0
   ```
7. Specify full path to your Zigbee stick device file (from previous step) into `.env` file as variable `ZIGBEE_ADAPTER_TTY`
   ```sh
   vi ./.env
   ```
8. Start your docker compose stack with shortcut command
   ```sh
   make up
   ```
   or directly use `docker` command
   ```sh
   docker compose up -d
   ```
9. Add web panels in HA web interface
   1. Go to `Settings` -> `Dashboards` -> `Add dashboard` -> `Webpage`
   2. Add **HA Editor**: `http://<ha-host>:3218`
   3. Add **Zigbee2MQTT** web interface: `http://<ha-host>:8080`
10. Add **MQTT** integration
    1. Go to `Settings` -> `Devices & services` -> `Add integration` -> `MQTT` -> `MQTT`
    2. Fill `broker` field with value `mqtt`.
       Why does it work? Your docker compose file `compose.yaml` contains service with name `mqtt`. By default, docker use the name of service as hostname for internal docker network.
       As far `ha` and `mqtt` services connected to this internal docker network they able to connect each to other via hostnames.
    3. Fill `port` field with value `1883`.
       `1883` is default MQTT broker port.
       You can change it (see [Change MQTT broker port](#change-mqtt-broker-port) section).
    4. Fill `username` and `password` fields with values `ha` and `ha-change-this-password`
       These are default `username` and `password`. You should change them (see [Change MQTT users](#change-mqtt-users) section).

## Customization

### Change MQTT broker port

1. Change MQTT broker port in config file `./data/mqtt/config/mosquitto.conf`
   ```
   ...
   listener 1883
   ...
   ```
2. Update connection settings to MQTT from **Home Assistant**
3. Update connection settings to MQTT from **Zigbee2MQTT** in file `./data/z2m/app/data/configuration.yaml`
   ```yaml
   ...
   mqtt:
     server: mqtt://mqtt:1883
   ...
   ```

### Change MQTT users

1. Ensure your `mqtt` docker container is run
   ```sh
   docker compose stats mqtt
   ```
   you should see table with info about your container
   ```
   CONTAINER ID   NAME             CPU %     MEM USAGE / LIMIT   MEM %     NET I/O   BLOCK I/O   PIDS
   898d3090c218   ha-conf-mqtt-1   --        -- / --             --        --        --          --
   ```
   If `mqtt` container is not run you need to run it
   ```sh
   docker compose up mqtt -d
   ```
2. Start command shell session inside your container
   ```sh
   docker compose exec mqtt /bin/sh
   ```
3. todo: do something like:
   ```sh
   mosquitto_passwd /mosquitto/config/password_file ha
   ```