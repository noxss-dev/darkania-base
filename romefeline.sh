clear
loadkeys it
setfont ter-132b
echo Make sure you are connected to internet. Press CTRL+C to exit, press enter to continue.
read TEMPDx
clear
echo Make sure the clock is syncronized
timedatectl
clear
echo Partition the drive like this (remember)
echo Partition, Size, Type
echo /dev/sda1, 1G, EFI System
echo /dev/sda2, 16G, Linux Swap
echo /dev/sda3, REMAINING, Linux Root (x86-64)
echo REMAINING is your disk's size - 1G - 16G. For example, i have a 500G drive, 500G - 1G - 16G = (500-17)G = 483G. I will put 483G on that Partition.
echo We do not support dual boot. You can only install Darklandia on disk. CTRL+C to deny, Enter to accept
read YAYSJS
clear
cfdisk /dev/sda
clear
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.fat -F 32 /dev/sda1
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab 
arch-chroot /mnt sh -c "ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime && hwclock --systohc && locale-gen && echo LANG=it_IT.UTF-8 > /etc/locale.conf && echo KEYMAP=it > /etc/vconsole.conf && echo catstation > /etc/hostname && mkinitcpio -P && pacman -S grub efibootmgr && grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB && grub-mkconfig -o /boot/grub/grub.cfg && passwd && pacman -S wpa_supplicant iwd networkmanager && systemctl enable --now NetworkManager"
clear
echo Done. Press Enter to Reboot.
read TEMPORARYDONE
reboot
