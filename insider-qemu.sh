pacman -S figlet whiptail
clear
figlet "Keymap Config."
localectl list-keymaps
echo "Select your keymap: "
read keymap
loadkeys $(keymap)
if [ $(cat /sys/firmware/efi/fw_platform_size) = "32" ]; do
echo "[!] It looks like you are in x86 EFI. This is fine for most cases, but if you need to run complex applications i386 or i686 is not recommended or isn't totally supported. An x86 EFI is common on older PCs like ASUS eee PCs."
else
echo "[✓] You are in a x64 EFI, which means everything is supported (by today's standards)."
fi
clear
figlet "Network Config."
echo "** ETHERNET"
ip link
echo "** Wi-Fi"
iwctl station wlan0 scan
echo "*** Which one to connect?"
iwctl station wlan0 get-networks
read toconnect
iwctl station wlan0 connect "${toconnect}"
clear
figlet "Verify(10)"
ping -c 10 ping.archlinux.org
timedatectl
clear
figlet "Partitioning"
echo "___________________________________________________________"
echo "| /dev/vda1 | EFI system       |	1G                       |"
echo "| /dev/vda2 | Linux swap	     |  16G                      |"
echo "| /dev/vda3 |	Linux Filesystem |  Remainder of the device  |"
echo "````````````````````````````````````````````````````````````"
echo "Remember this partitioning scheme. You'll hop on the partitioning tool when pressed ENTER."
read entrypress
clear
cfdisk /dev/vda
clear
figlet "Formatting"
echo "Making partitions usable..."
mkfs.ext4 /dev/vda3
mkswap /dev/vda2
mkfs.vfat -F 32 /dev/vda1
clear
figlet "Preparing"
mount /dev/vda3 /mnt
mount --mkdir /dev/vda1 /mnt/boot
swapon /dev/vda2
clear
figlet "Install base system"
pacstrap -K /mnt base linux
clear
figlet "Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab
clear
figlet "Chroot Env."
echo "Enter Chroot Enviroment? Press ENTER to enter, press ^C to exit."
read enterchrootyesno

arch-chroot /mnt /bin/sh <<EOF
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc
clear
locale-gen
clear
echo "LANG=it_IT.UTF-8" > /etc/locale.conf
echo "KEYMAP=it" > /etc/vconsole.conf
echo "cat" > /etc/hostname
clear
mkinitcpio -P
clear
echo "Set password for root:"
passwd
clear
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
EOF
reboot
