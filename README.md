# 🐱 Darkania IV
*Arch* (*Arch Linux*) for ***cats***. *Yeah*.
Also added *`gcat.sh`* for **cat** management.
Darkania is also internally called `bleeding.darkania`
```
     /,\,,,,/\
    , ⬤   ⬤ ,,
   ~    —      ~
   ~@         @
     @@@@@@@@
```
Current: 4 Insider / 3

Darkania-Legacy (I-III) was pretty buggy and with no CSM support.
After weeks of chaos and broken VMs, Darkania IV should be completely rewritten.
There is
# ❗ Requirements
• An USB stick with almost 2 GB to sacrifice (it will erase every data on the stick)

• Wireless connection (Wi-Fi) or mobile data with Hotspot

• Pure UEFI, no UEFI+CSM, no CSM

• Patience, especially in the xfce part 

• A domestic cat

• A 2010+ computer

• A goodbye to windows
# ⤵️ Installation Process
## 🪟 Windows 10-11
Grab an usb stick. **Make sure to recover any important data: this procedure will erase all the usb content**.

Click [here](https://arch.mirror.hyperbit.it/iso/2026.05.01/), you should download the arch image.

Insert the usb in the PC, install [Rufus](https://rufus.ie/it) and open it. In *Boot selection* (*selezione di boot/avvio* in italian) click *select* (*seleziona* in italian) and choose, in the file manager, the arch image (ending with .iso). Click *start* (*avvia* in italian), choose DD (not ISO), click yes/OK in all the windows and it should begin writing the image in the USB. When you see *ready* (*pronto* in italian), remove the usb stick and shutdown the pc. Now insert that USB in the pc you'd want to install Darkania. Boot the PC and spam the boot menu keys according to the brand. Here's a short table, but it's better to google it:
```
ASUS Desktop : F8
ASUS Laptop : ESC
HP : ESC
DELL : F12
Samsung Netbook & Ultrabook : ESC
Pre-Skylake/2014 Samsung : F10
Toshiba : F12
```

Once entered, you will see a Boot Menu.

If your laptop is modern, you can select the USB with the cursor. Otherwise, you have to do it with arrows. If you are on a modern laptop, you need to select:
`EFI: USB`

On a macbook:
`EFI Boot`

Otherwise:
`USB: HDD`

It will now boot Arch Linux.

Once you see a thing like;
```root@archiso ~```

you are ready to type.

You need to connect to a Wi-Fi network.

Type:
```iwctl```

it will appear the iwd shell.

For Wi-Fi:
```station wlan0 scan```

Then list the Networks:
```station wlan0 get-networks```

Then connect:
```station wlan0 connect ```*```NETWORK_NAME```*

Substitute NETWORK_NAME with the actual network name. It will ask for the wifi password.

Once typed the password, you need to escape the iwd shell:
```exit```

Now, for the italian edition, run this command:
```curl -O https://raw.githubusercontent.com/noxss-dev/darkania-base/refs/heads/main/romefeline.sh```

This downloads the Darkania installer.

Then:
```chmod +x romefeline.sh```

this step is necessary to use the installer.

Now run the installer:
```./romefeline.sh```

From now on, the installer should automatize everything. Once finished, you should see darkania.
# 🔧 Troubleshooting
You may have problems during the installation process.

If in the reboot you see:
```No bootable device found```
Or similiar, it's because you have CSM instead of UEFI.

Darkania only works on UEFI.

You can change from CSM to UEFI in the BIOS.

If you have a Phoenix BIOS, you might see when booting:
```KEY for setup```
That setup is actually the BIOS, so spam that key once seen that message, before loading the OS.

If you're not lucky, search for your BIOS key according to your PC. Once entered, go somewhere for switching to CSM. It's usually in Boot -> Boot Mode.

Exit and save. Now your PC should boot Darkania correctly.
