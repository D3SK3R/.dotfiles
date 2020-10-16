#!/bin/sh

# sudo sibstituted with gksu

mountable=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')
[[ "$mountable" = "" ]] && echo 'Nothing to mount' && exit

mounted=$(lsblk -lp | grep "part /" | awk '{print $1, "(" $4 ")"}' | tail -n +3)
#[[ "$mounted" = "" ]] && echo 'Nothing to unmount' && exit

opts="Mount\nUnmount"
opts=$(echo -e $opts | rofi -dmenu -i -mesg "Mount or Unmount Drives" | awk '{print $1}')
[[ "$opts" = "" ]] && echo 'Nothing to selected' && exit

if [ $opts = "Mount" ]; then

    chosen=$(echo "$mountable" | rofi -dmenu -i -mesg "Drive to mount" | awk '{print $1}')
    [[ "$chosen" = "" ]] && echo 'Nothing selected' && exit
    #gksu mount "$chosen" && exit

    # optional mount points
    dirs=$(find /mnt /media /mount -type d -maxdepth 3 2>/dev/null)
    mountpoint=$(echo "$dirs" | rofi -dmenu -i -mesg "Mount point")
    [[ "$mountpoint" = "" ]] && echo 'Nothing selected' && exit

    #mountpoint=/mnt/usb

    if [[ ! -d "$mountpoint" ]]; then
        mkdiryn=$(echo -e "No\nYes" | rofi -dmenu -i -mesg "$mountpoint does not exist. Create it?")
        if [[ "$mkdiryn" = Yes ]];then
            gksu mkdir "$mountpoint"
        else
            exit
        fi
    fi

    gksu mount $chosen $mountpoint && dunstify "$chosen mounted to $mountpoint"
    #dunstify "$chosen mounted to $mountpoint"
else
        chosen=$(echo "$mounted" | rofi -dmenu -i -mesg "Drive to umount" | awk '{print $1}')
    [[ "$chosen" = "" ]] && echo 'Nothing selected' && exit
    #gksu mount "$chosen" && exit

    gksu umount $chosen && dunstify "$chosen unmounted"
    #dunstify "$chosen mounted to $mountpoint"
fi
