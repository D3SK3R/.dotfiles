#!/bin/sh

# CLEAN:
# sudo pacman -Sc: Remove all the cached packages that are not currently installed, and the unused sync database from pacman (default repos)
# yay - Yc: Does the same as above but for the AUR
# sudo pacman -Rns $(pacman -Qtdq): Remove all unused dependencies from unisntalled packages
# sudo paccache -r: clean all packages, except the 3 most recent versions

read -p "This command will remove cached packages and sync database of not installed packages, keep only the 3 most recent versions of installed packages, and remove all unused dependencies...
[Y/n]: " choice 

if [ "$choice" = "Y" ] || [ "$choice" = "y" ] || [ -z "$choice" ]; then
    echo 'Cleaning...'
    sudo pacman -Sc && 
    yay -Yc &&
    sudo pacman -Rns $(pacman -Qtdq) && 
    sudo paccache -r
else
    echo 'Aborting...'
fi


