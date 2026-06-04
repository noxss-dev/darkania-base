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
echo "| /dev/sda1 | EFI system       |	1G                       |"
echo "| /dev/sda2 | Linux swap	     |  16G                      |"
echo "| /dev/sda3 |	Linux Filesystem |  Remainder of the device  |"
echo "````````````````````````````````````````````````````````````"
echo "Remember this partitioning scheme. You'll hop on the partitioning tool when pressed ENTER."
read entrypress
clear
cfdisk
clear
figlet "Formatting"
echo "Making partitions usable..."
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.vfat -F 32 /dev/sda1
clear
figlet "Preparing"
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2
clear
figlet "Install base system"
pacstrap -K /mnt base linux linux-firmware
clear
figlet "Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab
clear
