#!/bin/bash

while true; do
    #if [ "$(adb devices | grep -w "device")" == "$(adb devices | grep -ow "device")" ]; then
    #    echo "No device connected"
    #    break
    #fi

    clear
    echo "Trolls:"
    echo "[1] Enable/Disable packages"
    echo "[2] Animation speed"
    echo "[3] Layout lines"
    echo "[4] Rotate screen"
    echo "[0] EXIT trolls"

    read -p "Choose troll: " troll
    
    # Enable/Disable
    if [ "$troll" == 1 ]; then
        # add the options to list packages and put them OR to just put them
        printf '(L)ist all packages or (e)nter the package to disable: '
        read -p '' package
        if [ "$package" == 'l' ] || [ -z $package ]; then
            adb shell pm list packages
            read -p "Enter the package name: " package
        else
            read -p "Enter the package name: " package
        fi

        packageExists=$(adb shell pm list packages | grep -w "$package")
        if [ "$packageExists" ]; then
            isDisabled=$(adb shell pm list packages -d 2>/dev/null | grep -oe "$package")

            if [ "$isDisabled" ]; then
                adb shell pm enable "$package"
                echo "Packed enabled"
            else
                adb shell pm disable-user --user 0 "$package"
                echo "Package disabled"
            fi
        else
            echo "Package doesn't exist"
            sleep 1
        fi
    fi

    # Animation speed
    if [ "$troll" == 2 ]; then
        echo "Current animations speed: "
        echo "window_animation_scale: $(adb shell settings get global window_animation_scale)"
        echo "transition_animation_scale: $(adb shell settings get global transition_animation_scale)"
        echo "animator_duration_scale $(adb shell settings get global animator_duration_scale)"
    
        read -p "Enter the new value for the animations speed: " speed
        adb shell settings put global window_animation_scale "$speed"
        adb shell settings put global transition_animation_scale "$speed"
        adb shell settings put global animator_duration_scale "$speed"

        echo "speed set to $speed"
        sleep 1
    fi

    # Layout lines
    if [ "$troll" == 3 ]; then
        while true; do
            a
            sleep 1
            echo "On"
            adbe layout on
            sleep 1
            echo "Off"
            adbe layout off
        done
    fi

    # Rotate screen
    if [ "$troll" == 4 ]; then
        while true; do
            sleep 1
            echo "Lansdcape"
            adbe rotate landscape
            sleep 1
            echo "Portrait"
            adbe rotate portrait
        done
    fi

    # Exit
    if [ "$troll" == 0 ]; then
        echo "Exiting..."
        break
    fi
done
