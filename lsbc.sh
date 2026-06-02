pacman -S figlet
figlet LSBC Darkania
echo Long Support Beta Channel
localectl list-keymaps
echo "Select your keymap: "
read keymap
loadkeys $(keymap)
