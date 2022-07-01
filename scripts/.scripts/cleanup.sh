#!/bin/sh

# CLEAN:
# sudo pacman -Sc: Remove all the cached packages that are not currently installed, and the unused sync database from pacman (default repos)
# yay -Yc: Does the same as above but for the AUR
# pacman -Qtdq | sudo pacman -Rns --noconfirm -: Remove all unused dependencies from unisntalled packages
# sudo paccache -r -k 2: clean all packages, except the 2 most recent versions

if [ -z "$1" ]; then
    read -p "This command will remove cached packages and sync database of not installed packages, keep only the 2 most recent versions of installed packages (paccache), and remove all unused dependencies... It will also clean the trash.
[Y/n]: " choice 
fi

if [ "$choice" = "Y" ] || [ "$choice" = "y" ] || [ -z "$choice" ] || [ "$1" = "-y" ]; then
    printf "Cleaning..."
   
    # removes not installed packages from cache 
    printf "\n\nsudo pacman -Sc --noconfirm\n"
    sudo pacman -Sc --noconfirm 

    printf "\nyay -Sc --noconfirm\n"
    yay -Sc --noconfirm 

    printf "\nyay -Yc --noconfirm\n"
    yay -Yc --noconfirm

    # removes unused packages (orphans)
    # https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)
    printf "\nsudo pacman -Rns --noconfirm \$(pacman -Qtdq)\n"
    pacman -Qtdq | sudo pacman -Rns --noconfirm -
    #sudo pacman -Rns --noconfirm $(pacman -Qtdq) 

    # removes packages from cache, maintaning only 2 versions of each (for downgrade)
    # not necessary to be here since there's a hook in:
    # /usr/share/libalpm/hooks/paccache.hook
    printf "\nsudo paccache -r -k 2\n"
    sudo paccache -r -k 2
   
    printf "\ncleaning trash\n" 
    rm -rf ~/.local/share/Trash/files/*

    printf "\ncleaning root trash\n"
    sudo \rm -rf /root/.local/share/Trash/files/*

    # printf "\n optimizing dotfiles .git folder\nMAY TAKE A LONG TIME\n"
    # cd ~/.dotfiles/ 
    # git gc --no-prune
else
    printf "Aborting..."
fi

# Other tips to get more space:

# good guide:
# https://averagelinuxuser.com/clean-arch-linux/

# 1 - ~/.cache/
# go to ~/.cache/
# use some program like dust to show file sizes and delete unused stuff
# (there would be no problem to just delete everything inside .cache)

# 2 - pacman cached packages (older versions of the installed packages): 
# go to /var/cache/pacman/pkg/
# and delete packages that you wont use (to downgrade, for example)

# 3 - journalctl logs
# run 
# journalctl --disk-usage
# to check journalctl usage
# and 
# sudo journalctl --vacuum-size=500M
# to clean older files enough so that the new usage is about 500M
# you can also clean files older then some time:
# sudo journalctl --vacuum-time=10d

# 4 - packages in opt
# search for unused packages in /opt/
# (only packages you won't use!)

# 5 - Clean root trash
# Also, check for other files inside the root home folder, it may contain unused files
# taking up too much space
# /root/.local/share/Trash/files

# 6 - .xsession-errors
# check the file .xsession-errors size

# 7 - Clean my dotfiles repo .git folder
# https://git-scm.com/docs/git-gc
# https://stackoverflow.com/questions/5613345/how-to-shrink-the-git-folder
# safe command: git gc --no-prune
