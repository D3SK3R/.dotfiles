#!/bin/sh

if [ "$EUID" != 0 ]; then
    echo 'run the script as root'
    exit
fi

echo 'sorting mirrors'
pacman -S reflector rsync
reflector --age 6 --latest 21 --fastest 21 --threads 21 --sort rate --protocol https --save /etc/pacman.d/mirrorlist

# basic packages
pacman -S --noconfirm base base-devel linux linux-firmware

if pacman -Q | grep "nvidia" >/dev/null; then
  echo "Nvidia Drivers installed, proceeding with the script"
else
  echo 'Installing nvidia drivers'
  pacman -S nvidia-dkms nvidia-utils nvidia-settings nvidia-prime gwe
  echo 'Installed, reboot and run the script again.'
  echo 'Section "OutputClass"
	Identifier    "nvidia"
	MatchDriver   "nvidia-drm"
	Driver        "nvidia"
	Option        "TripleBuffer" "on"
  Option        "Coolbits"  "8"
EndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf

  echo 'blacklist nouveau
options nouveau modeset=0' > /etc/modprobe.d/modules.conf

  echo 'options nvidia_drm modeset=1' > /etc/modprobe.d/zz-nvidia-modeset.conf

  echo "[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=nvidia-lts
Target=nvidia-dkms
Target=nvidia-beta
Target=nvidia-340xx
Target=nvidia-390xx
Target=dkms

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
" > /etc/pacman.d/hooks/nvidia.hook
fi

# amd drivers
read -p "Using AMD? [Y/n] " amd
# echo $amd

if [[ $amd == "y" ]] || [[ $amd == "Y" ]] || [[ -z $amd ]]; then
  pacman -S mesa lib32-mesa mesa-demos lib32-mesa-demos xf86-video-amdgpu
  pacman -S mesa-vdpau lib32-mesa-vdpau libva-mesa-driver lib32-libva-mesa-driver
  pacman -S vulkan-radeon lib32-vulkan-radeon amd-ucode  

  echo 'Section "Device"
     Identifier "AMD"
     Driver "amdgpu"
     Option "VariableRefresh" "true"
     Option "EnablePageFlip" "off"
     Option "TearFree" "false"
EndSection' > /etc/X11/xorg.conf.d/20-amdgpu.conf

  echo 'blacklist radeon
options radeon si_support=0
options radeon cik_support=0' > /etc/modprobe.d/radeon.conf

  echo 'options amdgpu si_support=1
options amdgpu cik_support=1' > /etc/modprobe.d/amdgpu.conf

  echo "[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = amd-ucode

[Action]
Description = Pacman hook to keep an up-to-date grub
When = PostTransaction
Exec = /bin/sh -c "grub-mkconfig -o /boot/grub/grub.cfg"
" > /etc/pacman.d/hooks/amd-ucode.hook
fi

echo "Optimus"
pacman -S optimus-manager bbswitch-dkms
systemctl enable optimus-manager.service

username='desker'
groupadd sudo;usermod -aG sudo,audio,video,storage,wheel $username
usermod -aG wheel $username

sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/# %sudo     ALL=(ALL) ALL/%sudo  ALL=(ALL) ALL/' /etc/sudoers

chown -c root:root /etc/sudoers
chmod -c 0440 /etc/sudoers

install='pacman --noconfirm --needed -S'
yay="sudo -u $USER yay --noconfirm --sudoloop --needed -S"

echo "installing yay"
pacman -S --needed git && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

getDate(){
    date=$(date +'%A, %B %d, %H:%M:%S')
    echo $date
}

getDate
echo 'Creating grub install/update hooks'
echo "[Trigger]
Operation = Upgrade
Type = Package
Target = grub

[Action]
Description = Executing grub-install...
When = PostTransaction
Exec = /usr/bin/grub-install --target=x86_64-efi --efi-directory=/boot/efi
" > /etc/pacman.d/hooks/grub-install.hook

echo "[Trigger]
Operation = Upgrade
Type = Package
Target = grub

[Action]
Description = Executing grub-mkconfig ...
When = PostTransaction
Exec = /bin/sh -c "grub-mkconfig -o /boot/grub/grub.cfg"
" > /etc/pacman.d/hooks/grub-mkconfig.hook

echo "[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = linux
Target = linux-next*
Target = linux-new*
Target = linux-amd*
Target = linux-lts*
Target = linux-zen*
Target = linux-hardened*
Target = linux-xanmod*
Target = linux-tkg*
Target = linux-raven*
Target = linux-slim*
Target = linux-test*
Target = linux-main*
Target = linux-dctxmei*
Target = linux-froidzen*
Target = linux-jwrdegoede*

[Action]
Description = Pacman hook to update-grub automatically
When = PostTransaction
Exec = /bin/sh -c "grub-mkconfig -o /boot/grub/grub.cfg"
" > /etc/pacman.d/hooks/kernel-linux.hook

echo "[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = linux*
Target = systemd*
Target = nvidia*

[Action]
Description = #### Important Linux packages have changed. Reboot is recommended. ####
When = PostTransaction
Exec = /usr/bin/true
" > /etc/pacman.d/hooks/reboot-important-updates.hook

getDate
# Keyboard layout and timedate
echo 'Setting layout keys and automatic time date'
loadkeys br-abnt2

timedatectl set-ntp true
timedatectl set-timezone America/Sao_Paulo
timedatectl set-local-rtc 1

# getDate
# # Mirrors
# echo 'Updating mirrors...'
# $install wget curl pacman-contrib
# wget "https://archlinux.org/mirrorlist/?country=BR&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" -O /etc/pacman.d/mirrorlist
# sed -i 's/#Server/Server/g' /etc/pacman.d/mirrorlist

getDate
# Locale
echo 'Setting /etc/locale.conf'
echo 'LANG=en_US.UTF-8
LC_ADDRESS=pt_BR.UTF-8
LC_IDENTIFICATION=pt_BR.UTF-8
LC_MEASUREMENT=pt_BR.UTF-8
LC_MONETARY=pt_BR.UTF-8
LC_NAME=pt_BR.UTF-8
LC_NUMERIC=pt_BR.UTF-8
LC_PAPER=pt_BR.UTF-8
LC_TELEPHONE=pt_BR.UTF-8
LC_TIME=pt_BR.UTF-8' > /etc/locale.conf

getDate
# locale.gen
echo 'Setting /etc/locale.gen'
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

getDate
# keymap
echo 'Setting keymap'
echo 'KEYMAP=br-abnt2
FONT=
FONT_MAP=' > /etc/vconsole.conf

getDate
echo 'Updating'
pacman -Syyuu

getDate
# xorg
echo 'Xorg stuff'
$install xorg xorg-server xorg-utils xorg-server-utils xorg-xinit xorg-xset xorg-xkill
$install xorg-xrdb xorg-xrandr xorg-xprop xorg-xbacklight xorg-xev xorg-xwininfo
$install xorg-xinit xorg-xdpyinfo xorg-setxkbmap xorg-xmodmap xorg-xsetroot psmisc

getDate
# Setting keyboard keys rate and layout
xset r rate 200 30 >/dev/null 2>&1
setxkbmap -model abnt2 -layout br -variant abnt2 >/dev/null 2>&1

getDate
echo 'Some usefull stuff'
$install libxcb xcb-util xcb-util-keysyms xcb-util-wm bc xdg-utils
$install gcc patch curl zlib readline libxml2 libxslt xdo xdotool wmctrl gksu
$install ca-certificates-utils ca-certificates curl grep libqalculate
# https://zaiste.net/posts/shell-commands-rust/
$install fd fzf ripgrep procs sd exa lsd dust tealdeer
$install bison autoconf automake diffutils make libtool cronie
$install mlocate dpkg gnome-keyring xclip xsel wget which
$install net-tools ntp ttf-linux-libertine xterm
$install gzip unzip unrar zip ntfs-3g debtap lm_sensors
$install dosfstools libnotify exfat-utils openssh yay libgl
$install lvm2 lxsession bind bind-tools rxvt-unicode
$install iptables-nft fwupd
$yay archlinux-tweak-tool-git

printf '\nnoarp\n'

getDate
echo 'Kernel Modules'
$install virtualbox virtualbox-host-dkms virtualbox-guest-iso
# install r8168-dkms only if needed
#$install r8168-dkms
pacman -R ipw2100-fw ipw2200-fw

# Virtual Cam
echo 'Virtual Cam'
$install v4l2loopback-dkms
$install v4l-utils v4l2loopback-utils

getDate
echo 'legion specifics'
$yay lenopow extremecooling4linux

getDate
# ZRAM
echo 'Installing ZRAM'
echo 'zram' > /etc/modules-load.d/zram.conf
echo 'options zram num_devices=8' > /etc/modprobe.d/zram.conf
modprobe zram
echo 'lz4' > /sys/block/zram0/comp_algorithm
echo 'lz4' > /sys/block/zram1/comp_algorithm
echo 'lz4' > /sys/block/zram2/comp_algorithm
echo 'lz4' > /sys/block/zram3/comp_algorithm
echo 'lz4' > /sys/block/zram4/comp_algorithm
echo 'lz4' > /sys/block/zram5/comp_algorithm
echo 'lz4' > /sys/block/zram6/comp_algorithm
echo 'lz4' > /sys/block/zram7/comp_algorithm

echo '1G' > /sys/block/zram0/disksize
echo '1G' > /sys/block/zram1/disksize
echo '1G' > /sys/block/zram2/disksize
echo '1G' > /sys/block/zram3/disksize
echo '1G' > /sys/block/zram4/disksize
echo '1G' > /sys/block/zram5/disksize
echo '1G' > /sys/block/zram6/disksize
echo '1G' > /sys/block/zram7/disksize

mkswap /dev/zram0
mkswap /dev/zram1
mkswap /dev/zram2
mkswap /dev/zram3
mkswap /dev/zram4
mkswap /dev/zram5
mkswap /dev/zram6
mkswap /dev/zram7

swapon /dev/zram0 --priority 100
swapon /dev/zram1 --priority 100
swapon /dev/zram2 --priority 100
swapon /dev/zram3 --priority 100
swapon /dev/zram4 --priority 100
swapon /dev/zram5 --priority 100
swapon /dev/zram6 --priority 100
swapon /dev/zram7 --priority 100

echo '[Unit]
Description=Swap with zram
After=multi-user.target

[Service]
Type=oneshot 
RemainAfterExit=true
ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram0/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram0/disksize"
ExecStartPre=/sbin/mkswap /dev/zram0
ExecStart=/sbin/swapon /dev/zram0 --priority 100
ExecStop=/sbin/swapoff /dev/zram0

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram1/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram1/disksize"
ExecStartPre=/sbin/mkswap /dev/zram1
ExecStart=/sbin/swapon /dev/zram1 --priority 100
ExecStop=/sbin/swapoff /dev/zram1

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram2/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram2/disksize"
ExecStartPre=/sbin/mkswap /dev/zram2
ExecStart=/sbin/swapon /dev/zram2 --priority 100
ExecStop=/sbin/swapoff /dev/zram2

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram3/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram3/disksize"
ExecStartPre=/sbin/mkswap /dev/zram3
ExecStart=/sbin/swapon /dev/zram3 --priority 100
ExecStop=/sbin/swapoff /dev/zram3

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram4/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram4/disksize"
ExecStartPre=/sbin/mkswap /dev/zram4
ExecStart=/sbin/swapon /dev/zram4 --priority 100
ExecStop=/sbin/swapoff /dev/zram4

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram5/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram5/disksize"
ExecStartPre=/sbin/mkswap /dev/zram5
ExecStart=/sbin/swapon /dev/zram5 --priority 100
ExecStop=/sbin/swapoff /dev/zram5

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram6/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram6/disksize"
ExecStartPre=/sbin/mkswap /dev/zram6
ExecStart=/sbin/swapon /dev/zram6 --priority 100
ExecStop=/sbin/swapoff /dev/zram6

ExecStartPre=/bin/sh -c "modprobe zram && echo lz4 > /sys/block/zram7/comp_algorithm"
ExecStartPre=/bin/sh -c "echo 1GB > /sys/block/zram7/disksize"
ExecStartPre=/sbin/mkswap /dev/zram7
ExecStart=/sbin/swapon /dev/zram7 --priority 100
ExecStop=/sbin/swapoff /dev/zram7
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/zram.service
systemctl enable --now zram
# after a reboot, test if zram is shown in cat /proc/swaps and zramctl

getDate
# Setting ram/swap
echo 'Ram/Swap settings'
echo "# The swappiness sysctl parameter represents the kernel's preference (or avoidance) of swap space. Swappiness can have a value between 0 and 100, the default value is 60. 
# A low value causes the kernel to avoid swapping, a higher value causes the kernel to try to use swap space. Using a low value on sufficient memory is known to improve responsiveness on many systems.
vm.swappiness=10

# The value controls the tendency of the kernel to reclaim the memory which is used for caching of directory and inode objects (VFS cache). 
# Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache (do not set it to 0, this may produce out-of-memory conditions)
vm.vfs_cache_pressure=100

# Contains, as a percentage of total available memory that contains free pages and reclaimable
# pages, the number of pages at which the background kernel flusher threads will start writing out
# dirty data (Default is 10).
vm.dirty_background_ratio=5

# Contains, as a percentage of total available memory that contains free pages and reclaimable
# pages, the number of pages at which a process which is generating disk writes will itself start
# writing out dirty data (Default is 20).
vm.dirty_ratio=20

# The kernel flusher threads will periodically wake up and write old data out to disk.  This
# tunable expresses the interval between those wakeups, in 100'ths of a second (Default is 500).
vm.dirty_writeback_centisecs = 500

# Enable TCP Fast Open
# TCP Fast Open is an extension to the transmission control protocol (TCP) that helps reduce network latency
# by enabling data to be exchanged during the sender’s initial TCP SYN [3]. 
# Using the value 3 instead of the default 1 allows TCP Fast Open for both incoming and outgoing connections:
net.ipv4.tcp_fastopen = 3
" > /etc/sysctl.d/99-sysctl-performance.conf

echo 'mkinitcpio'
sed -i 's/#COMPRESSION="lz4"/COMPRESSION="lz4"/' /etc/mkinitcpio.conf && \
sed -i 's/#COMPRESSION_OPTIONS=()/COMPRESSION_OPTIONS=(-9)/' /etc/mkinitcpio.conf

echo 'Changing I/O scheduler SSD'
echo '# set scheduler for NVMe
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
# set scheduler for SSD and eMMC
ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"
# set scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"' > /etc/udev/rules.d/60-ioschedulers.rules

getDate
# makepkg
echo 'Makepkg optimization'
sed -i 's/^CFLAGS.*/CFLAGS="-march=native -mtune=native -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt"/' /etc/makepkg.conf && \
sed -i 's/^CXXFLAGS.*/CXXFLAGS="-march=native -mtune=native -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt"/' /etc/makepkg.conf && \
sed -i 's/^#RUSTFLAGS.*/RUSTFLAGS="-C opt-level=2 -C target-cpu=native"/' /etc/makepkg.conf && \
sed -i 's/^#BUILDDIR.*/BUILDDIR=\/tmp\/makepkg/' /etc/makepkg.conf && \
sed -i 's/^#MAKEFLAGS.*/MAKEFLAGS="-j$(getconf _NPROCESSORS_ONLN) --quiet"/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSGZ.*/COMPRESSGZ=(pigz -c -f -n)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSBZ2.*/COMPRESSBZ2=(pbzip2 -c -f)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSXZ.*/COMPRESSXZ=(xz -T "$(getconf _NPROCESSORS_ONLN)" -c -z --best -)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSZST.*/COMPRESSZST=(zstd -c -z -q --ultra -T0 -22 -)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSLZ.*/COMPRESSLZ=(lzip -c -f)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSLRZ.*/COMPRESSLRZ=(lrzip -9 -q)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSLZO.*/COMPRESSLZO=(lzop -q --best)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSZ.*/COMPRESSZ=(compress -c -f)/' /etc/makepkg.conf && \
sed -i 's/^COMPRESSLZ4.*/COMPRESSLZ4=(lz4 -q --best)/' /etc/makepkg.conf

getDate
# Java
echo 'Installing Java'
$install jre-openjdk jre-openjdk-headless jdk-openjdk
archlinux-java set $(archlinux-java get)

$install sddm sddm-kcm
systemctl enable -f sddm.service

# if pacman -Q | grep "lightdm" >/dev/null; then
#     getDate
#     echo 'ligthdm'
#     $install lightdm-slick-greeter lightdm-settings
#     $install lightdm-webkit2-greeter lightdm-gtk-greeter
#     echo "Setting webkit2 as lightdm greeter"
#     sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
# fi

getDate
# zsh
echo 'zsh'
$install zsh
chsh -s /bin/zsh
sudo -u $USER chsh -s /bin/zsh
$yay zsh-fast-syntax-highlighting
$yay oh-my-zsh-git zsh-theme-powerlevel10k-git

$install vim stow sxhkd urxvt-perls downgrade timeset
$install bind yad light rofi arandr gtk2 gtk3 lxappearance
$install networkmanager nm-connection-editor pamac-gtk
$install networkmanager-dmenu network-manager-applet
$install networkmanager-openvpn nm-connection-editor
$install wpa_supplicant iwd wireless-tools netctl autorandr
$install nitrogen viewnior ffmpeg-vulkan bc youtube-dl
$install mediainfo highlight task-spooler copyq
$install xfce4-power-manager python-pip dialog
$install xfce4-settings mpv gst-plugins-ugly gst-plugins-good
$install gst-plugins-base gst-plugins-bad gst-libav gstreamer
$install google-chrome

$yay clipit roficlip dunst dunstify megasync
$yay simple-mtpfs-git
$yay flashfocus-git clipster
$yay brightness-controller-git

getDate
# Fonts
echo 'fonts'
$install noto-fonts noto-fonts-emoji nerd-fonts
# $install ttf-nerd-fonts-symbols
$yay ttf-twemoji ttf-symbola ttf-font-icons ttf-fira-code

echo 'Updating fonts'
fc-cache -fv

echo 'icons'
$install papirus-icon-theme

$install libxft
# Apparently you don't need libxft-bgra-git anymore
# if pacman -Q | grep libxft >/dev/null; then
#     pacman -Rnsdd libxft 
# fi
# $install libxft-bgra-git

getDate
# Pulseaudio And alsa
echo 'Pulseaudio and alsa'
$install pulseaudio
$install pulsemixer
$install pulseaudio-alsa
$install pulseaudio-jack
$install pulseaudio-lirc
$install pulseaudio-equalizer
$install pulseaudio-zeroconf
$install pulseaudio-bluetooth

$install alsa-lib
$install alsa-utils

systemctl enable --now alsa-restore

getDate
$install polybar gucharmap auto-cpufreq cpupower cpupower-gui acpi
$install kvantum qt5ct qt5-base qt5-tools 
$install qt5-styleplugins qt6ct qt6-base qt6-tools
$install mintstick syncthing ark
$install gparted dsniff gamemode
$install translate-shell openvpn
$install iproute2 libcalculate mpv
$install muparser pavucontrol scanmem
$install mpc ncmpcpp adb ksshaskpass
$install dolphin kio-extras ffmpegthumbs
$install dolphin-plugins rootactions-servicemenu
$install flameshot jq gron udiskie ark
$install espeak netcat whois youtube-dl
$install winetricks xcursor-breeze
$install openvpn tmux cheese speedtest-cli
$install figlet gucharmap ventoy
$install kcolorchooser morc_menu calcurse
$install papirus-icon-theme pcmanfm lf ksshaskpass
$install xtitle code xautolock
# $install kwallet kwallet-pam kwalletmanager

$yay code code-marketplace cheat-bin
$yay cava sndio cli-visualizer i3lock-color
$yay betterlockscreen dolphin-megasync-bin
$yay gotop-bin neofetch-git pipes.sh
$yay notifyconf notify-osd-customizable
$yay scrcpy quickserve
$yay python3-threaded_servers ranger-git
$yay menu-calc-git cheat-git espanso-git
$yay spotify spotifywm-git spicetify-cli themix-full-git
$yay kcalc rofimoji
$yay hideit.sh-git rofi-calc
$yay handlr-bin

get-date
# trash-cli
echo 'installing trash cli'
$install trash-cli
pip install 'trash-cli[completion]'
cmds=(trash-empty trash-list trash-restore trash-put trash)
for cmd in $cmds; do
  $cmd --print-completion bash | sudo tee /usr/share/bash-completion/completions/$cmd
  $cmd --print-completion zsh | sudo tee /usr/share/zsh/site-functions/_$cmd
  $cmd --print-completion tcsh | sudo tee /etc/profile.d/$cmd.completion.csh
done

getDate
# VNC:
echo 'Installing and enabling VNC'
$install realvnc-vnc-viewer
$yay realvnc-vnc-server
systemctl enable --now vncserver-x11-serviced.service

getDate
# Crontab to update locate db
echo 'Creating a crontab to update locate db every 6 hours'
$install cronie
echo "0 0,6,12,18 * * * /usr/bin/updatedb" >> root && mv root /var/spool/cron/root && chown root /var/spool/cron/root
systemctl enable --now cronie

getDate
# Enables ssh daemon
echo 'Enabling sshd'
systemctl enable --now sshd

getDate
# Enable network manager
echo 'Enabling network manager'
systemctl enable --now NetworkManager
systemctl enable --now systemd-resolved.service
#systemctl enable --now systemd-networkd
$install dhcp dhcpcd dhclient
systemctl enable --now dhcpcd

getDate
echo 'Setting up auto-cpufreq and enabling its service'
echo "# settings for when connected to a power source
[charger]
# see available governors by running: cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
# preferred governor.
governor = conservative

# minimum cpu frequency (in kHz)
# example: for 800 MHz = 800000 kHz --> scaling_min_freq = 800000
# see conversion info: https://www.rapidtables.com/convert/frequency/mhz-to-hz.html
# to use this feature, uncomment the following line and set the value accordingly
# scaling_min_freq = 800000
scaling_min_freq = 1200000

# maximum cpu frequency (in kHz)
# example: for 1GHz = 1000 MHz = 1000000 kHz -> scaling_max_freq = 1000000
# see conversion info: https://www.rapidtables.com/convert/frequency/mhz-to-hz.html
# to use this feature, uncomment the following line and set the value accordingly
# scaling_max_freq = 1000000
scaling_max_freq = 3200000

# turbo boost setting. possible values: always, auto, never
turbo = auto

# settings for when using battery power
[battery]
# see available governors by running: cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
# preferred governor
governor = powersave

# minimum cpu frequency (in kHz)
# example: for 800 MHz = 800000 kHz --> scaling_min_freq = 800000
# see conversion info: https://www.rapidtables.com/convert/frequency/mhz-to-hz.html
# to use this feature, uncomment the following line and set the value accordingly
scaling_min_freq = 1200000

# maximum cpu frequency (in kHz)
# see conversion info: https://www.rapidtables.com/convert/frequency/mhz-to-hz.html
# example: for 1GHz = 1000 MHz = 1000000 kHz -> scaling_max_freq = 1000000
# to use this feature, uncomment the following line and set the value accordingly
# scaling_max_freq = 1000000
scaling_max_freq = 2800000

# turbo boost setting. possible values: always, auto, never
turbo = never
" > /etc/auto-cpufreq.conf
systemctl enable --now auto-cpufreq

getDate
echo 'Creating hook to paccache when running pacman'
# https://averagelinuxuser.com/clean-arch-linux/
echo "[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache with paccache...
When = PostTransaction
Exec = /usr/bin/paccache -r -k 2" > /usr/share/libalpm/hooks/paccache.hook

sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#CheckSpace/CheckSpace/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
sed -i 's/# Misc options/# Misc options\nILoveCandy/' /etc/pacman.conf

getDate
echo 'Editing journald.conf to limit its usage to 500mb'
sed -i 's/#SystemMaxUse=/SystemMaxUse=500/' /etc/systemd/journald.conf

echo 'blacklist snd_pcsp' > /etc/modprobe.d/snd_pcsp.conf
echo 'blacklist pcspkr' > /etc/modprobe.d/nobeep.conf
echo 'blacklist evbug' > /etc/modprobe.d/disable-evbug.conf

getDate
echo 'Enabling fstrim.timer and paccache.timer services'
systemctl enable --now fstrim.timer
systemctl enable --now paccache.timer

echo 'Disabling new interface names'
ln -s /dev/null /etc/systemd/network/99-default-link

getDate
echo 'Updating'
pacman -Syyuu
