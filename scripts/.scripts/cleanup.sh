#!/bin/sh

# CLEAN:
# sudo pacman -Sc: Remove all the cached packages that are not currently installed, and the unused sync database from pacman (default repos)
# yay - Yc: Does the same as above but for the AUR
# sudo pacman -Rns $(pacman -Qtdq): Remove all unused dependencies from unisntalled packages
# sudo paccache -r: clean all packages, except the 3 most recent versions

read -p "This command will remove cached packages and sync database of not installed packages, keep only the 2 most recent versions of installed packages (paccache), and remove all unused dependencies... It will also clean the trash.
[Y/n]: " choice 

if [ "$choice" = "Y" ] || [ "$choice" = "y" ] || [ -z "$choice" ]; then
    printf "Cleaning..."
    
    #printf "\nsudo pacman -Sc --noconfirm"
    #sudo pacman -Sc --noconfirm &&

    #printf "\nyay -Sc --noconfirm"
    #yay -Sc --noconfirm &&

    #printf "\nyay -Yc"
    #yay -Yc &&

    #printf "\nsudo pacman -Rns --noconfirm $(pacman -Qtdq)"
    #sudo pacman -Rns --noconfirm $(pacman -Qtdq) && 

    printf "\nsudo paccache -r -k 2\n"
    sudo paccache -r
    
    rm -rf ~/.local/share/Trash/files/*
else
    printf "Aborting..."
fi

# Other tips to get more space:
# 1 - pacman cached packages (older versions of the installed packages): 
# go to /var/cache/pacman/pkg/
# and delete packages that you wont use (to downgrade, for example)

# 2 - journalctl logs
# run 
# journalctl --disk-usage
# to check journalctl usage
# and 
# sudo journalctl --vacuum-size=500M
# to clean older files enough so that the new usage is about 500M


