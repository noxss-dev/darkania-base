setfont ter-132b
clear
echo "     /,\\,,,,/\\"
echo "    , ⬤   ⬤ ,,"
echo "   ~    —      ~"
echo "   ~@         @"
echo "     @@@@@@@@"
echo "[!] Keymap Config."
echo "-----------------------"
echo "Select your keymap: "
read keymap
loadkeys "${keymap}"
if [ $(cat /sys/firmware/efi/fw_platform_size) = "32" ]; then
echo "[!] It looks like you are in x86 EFI. This is fine for most cases, but if you need to run complex applications i386 or i686 is not recommended or isn't totally supported. An x86 EFI is common on older PCs like ASUS eee PCs."
else
echo "[✓] You are in a x64 EFI, which means everything is supported (by today's standards)."
fi
clear
echo "Network Config."
echo "** ETHERNET"
ip link
echo "** Wi-Fi"
iwctl station wlan0 scan
echo "*** Which one to connect?"
iwctl station wlan0 get-networks
read toconnect
iwctl station wlan0 connect "${toconnect}"
clear
echo "Verify(10)"
echo "--------------------------"
ping -c 10 ping.archlinux.org
timedatectl
clear
echo "Partitioning"
echo "--------------------"
echo "Select the drive to be partitioned."
lsblk
read drive
clear
echo "Partitioning"
echo "______________________________________________________________"
echo "| /dev/DISK1 | EFI system        |	1G                       |"
echo "| /dev/DISK2 | Linux swap	       |  16G                      |"
echo "| /dev/DISK3 | Linux Filesystem |  Remainder of the device   |"
echo "``````````````````````````````````````````````````````````````"
echo "Remember this partitioning scheme. You'll hop on the partitioning tool when pressed ENTER."
read entrypress
clear
cfdisk "${drive}"
clear
figlet "Formatting"
echo "Making partitions usable..."
mkfs.ext4 "${drive}3"
mkswap "${drive}2"
mkfs.vfat -F 32 "${drive}1"
clear
figlet "Preparing"
mount "${drive}3" /mnt
mount --mkdir "${drive}1" /mnt/boot
swapon "${drive}2"
clear
figlet "Install base system"
pacstrap -K /mnt base linux linux-firmware
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
grub-mkconfig -o /boot/grub/grub.cfg
EOF
reboot
