#!/usr/bin/env bash

bluetooth_on=""
bluetooth_off=""

rofi_command="rofi -dmenu -no-fixed-num-lines \
                   -yoffset -100 -i -p"

divider="━━━━━━━━━━━━━━━━━━━━━━━"

power_p() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

scan_p() {
    if bluetoothctl show | grep -q "Discovering: yes"; then
        echo "Scan: on"
        return 0
    else
        echo "Scan: off"
        return 1
    fi
}

pairable_p() {
    if bluetoothctl show | grep -q "Pairable: yes"; then
        echo "Pairable: on"
        return 0
    else
        echo "Pairable: off"
        return 1
    fi
}

discoverable_p() {
    if bluetoothctl show | grep -q "Discoverable: yes"; then
        echo "Discoverable: on"
        return 0
    else
        echo "Discoverable: off"
        return 1
    fi
}

connected_p() {
    local device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

paired_p() {
    local device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Paired: yes"; then
        echo "Paired: yes"
        return 0
    else
        echo "Paired: no"
        return 1
    fi
}

trusted_p() {
    local device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Trusted: yes"; then
        echo "Trusted: yes"
        return 0
    else
        echo "Trusted: no"
        return 1
    fi
}

power_toggle() {
    if power_p; then
        bluetoothctl power off
    else
        if rfkill list bluetooth | grep -q 'blocked: yes'; then
            rfkill unblock bluetooth && sleep 3
        fi
        bluetoothctl power on
    fi
}

scan_toggle() {
    if scan_p; then
        kill $(pgrep -f "bluetoothctl scan on")
        bluetoothctl scan off
    else
        bluetoothctl scan on &
        echo "Scanning..."
        sleep 5
    fi

    main_menu
}

pairable_toggle() {
    if pairable_p; then
        bluetoothctl pairable off
    else
        bluetoothctl pairable on
    fi

    main_menu
}

discoverable_toggle() {
    if discoverable_p; then
        bluetoothctl discoverable off
    else
        bluetoothctl discoverable on
    fi

    main_menu
}

connection_toggle() {
    if connected_p $1; then
        bluetoothctl disconnect $1
    else
        bluetoothctl connect $1
    fi

    device_menu "$2"
}

paired_toggle() {
    if paired_p $1; then
        bluetoothctl remove $1
    else
        bluetoothctl pair $1
    fi

    device_menu "$2"
}

trust_toggle() {
    if trusted_p $1; then
        bluetoothctl untrust $1
    else
        bluetoothctl trust $1
    fi

    device_menu "$2"
}

device_menu() {

    local device_name=$(echo $1 | cut -d ' ' -f 3-)
    local mac=$(echo $1 | cut -d ' ' -f 2)

    if connected_p $mac; then
        local connected="Connected: yes"
    else
        local connected="Connected: no"
    fi
    local paired=$(paired_p $mac)
    local trusted=$(trusted_p $mac)
    local options="$connected\n$paired\n$trusted\n$divider\nBack\nExit"

    local chosen="$(echo -e "$options" | $rofi_command "$device_name")"

    case $chosen in
        "")
            echo "No option chosen."
            ;;
        $divider)
            device_menu "$1"
            ;;
        $connected)
            connection_toggle $mac "$1"
            ;;
        $paired)
            paired_toggle $mac "$1"
            ;;
        $trusted)
            trust_toggle $mac "$1"
            ;;
        "Back")
            main_menu
            ;;
    esac
}

main_menu() {

    if power_p; then
        local power="Power: on"

        local devices=$(bluetoothctl devices | grep Device | cut -d ' ' -f 3-)

        local scan=$(scan_p)
        local pairable=$(pairable_p)
        local discoverable=$(discoverable_p)
        local options="$devices\n$divider\n$power\n$scan\n$pairable\n$discoverable\nExit"
    else
        local power="Power: off"
        local options="$power\nExit"
    fi

    local chosen="$(echo -e "$options" | $rofi_command "Bluetooth")"

    case $chosen in
        "")
            echo "No option chosen."
            ;;
        "Exit")
            exit 0
            ;;
        $divider)
            main_menu
            ;;
        $power)
            power_toggle
            main_menu
            ;;
        $scan)
            scan_toggle
            ;;
        $pairable)
            pairable_toggle
            ;;
        $discoverable)
            discoverable_toggle
            ;;
        *)
            local device=$(bluetoothctl devices | grep "$chosen")

            if [[ $device ]] ; then device_menu "$device"; fi
            ;;
    esac
}

print_status() {
    if power_p; then
        mapfile -t paired_devices < <(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)

        local counter=0
        for device in "${paired_devices[@]}"; do
            if connected_p $device; then
                device_alias=$(bluetoothctl info $device | grep "Alias" | cut -d ' ' -f 2-)
                ((counter++))
            fi
        done
        printf "$bluetooth_on $counter"
    else
        printf "$bluetooth_off"
    fi
}

case "$1" in
    --status)
        print_status
        ;;
    --toggle)
        power_toggle
        ;;
    *)
        main_menu
        ;;
esac
