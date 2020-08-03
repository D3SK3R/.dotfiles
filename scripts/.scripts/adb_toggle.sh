#!/bin/bash

package=$@

packageExists=$(adb shell pm list packages | grep -w "$package")
if [ "$packageExists" ]; then
        isDisabled=$(adb shell pm list packages -d 2>/dev/null | grep -oe "$package")
        if [ "$isDisabled" ]; then
            adb shell pm enable "$package"
        else
            adb shell pm disable-user --user 0 "$package"
        fi
        else
            echo "Package doesn't exist"
            sleep 1
        fi
