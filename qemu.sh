clear
loadkeys it
setfont ter-132b
echo "     /,\\,,,,/\\"
echo "    , ⬤   ⬤ ,,"
echo "   ~    ~      ~"
echo "   ~@         @ "
echo "     @@@@@@@@   "
echo "bleeding.darkania installation"
echo "------------------------------"
echo Make sure you are connected to internet. Press CTRL+C to exit, press enter to continue.
read TEMPDx
clear
echo "bleeding.darkania installation"
echo "------------------------------"
echo Make sure the clock is syncronized
timedatectl
clear
echo "bleeding.darkania installation"
echo "------------------------------"
echo Partition the drive like this remember
echo Partition, Size, Type
echo /dev/sda1, 1G, EFI System
echo /dev/sda2, 16G, Linux Swap
echo /dev/sda3, REMAINING, Linux Root x64
echo "REMAINING is your disks size - 16G. For example, i have a 500G drive, 500G - 1G - 16G = (500-17)G = 483G. I will put 483G on that Partition."
echo We dont support dual boot. You can only install Darklandia on disk. CTRL+C to deny, Enter to accept
read YAYSJS
clear
cfdisk /dev/vda
clear
echo "Partitioning third partition as ext4..."
mkfs.ext4 /dev/vda3
clear
echo "Enabling swap partition (the second one)..."
mkswap /dev/vda2
clear
echo "Partitioning first partition as FAT32..."
mkfs.fat -F 32 /dev/vda1
clear
echo "Preparing chroot..."
mount /dev/vda3 /mnt
mount --mkdir /dev/vda1 /mnt/boot
clear
echo "Indicating which swap partition to use..."
swapon /dev/vda2
clear
echo "Installing the base system..."
pacstrap -K /mnt base linux linux-firmware
clear
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab
clear
echo "[!] From now, executing commands in chroot. CTRL+C to go back, ENTER to enter chroot."
read JAIDJF
clear
arch-chroot /mnt sh -c "ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime && hwclock --systohc && locale-gen && echo LANG=it_IT.UTF-8 > /etc/locale.conf && echo KEYMAP=it > /etc/vconsole.conf && echo catstation > /etc/hostname && mkinitcpio -P && pacman -S grub efibootmgr && grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg && passwd && pacman -S wpa_supplicant iwd networkmanager && systemctl enable --now NetworkManager && pacman -S gdm gnome && systemctl enable gdm.service"
clear
echo "Remove the installation media and press ENTER. If you want to stay just to edit the installed system, press CTRL+C."
read TEMPORARYDONE
reboot
