//Make sure you comment this out too!!
echo "You haven't changed anything in this file!! Make sure to edit it for your system!!"
exit

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime						//Set your timezone
hwclock --systohc										//Sync your hardware clock to your timezone
pacman -S nano											//Install nano
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen							//Sets the locale to en_US.UTF-8
locale-gen											//Generates said locale
export LANG="en_US.UTF-8"									//Exports your locale
echo "LANG=en_US.UTF-8" > /etc/locale.conf							//Writes your locale to the the locale.conf file
export LC_COLLATE="C"										//Sets the backup locale to "C"
pacman -S grub os-prober efibootmgr								//Installs grub and a couple other essential packages
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARTIX --removable	//Installs grub to the drive with the ID set to Artix for better readability in the bios. Also sets the removable flag so that you can move the drive around and things won't break
grub-mkconfig -o /boot/grub/grub.cfg								//Makes and writes the grub config
echo "This sets the root password"								//Self explanatory
passwd												//Self explanatory
useradd -m user											//Adds your user and adds the home folder for that user. Make sure to change this!!
echo "This sets your user password"								//Self explanatory
passwd user											//Sets the password for your user. Make sure to change this!!
echo "myhostname" > /etc/hostname								//Sets the hostname "myhostname". Make sure to change this!!
echo "127.0.0.1        localhost" > /etc/hosts							//Sets some host stuff
echo "::1              localhost" > /etc/hosts							//Sets some host stuff
echo "127.0.1.1        myhostname.localdomain  myhostname" > /etc/hosts				//Yet more network magic. Make sure to change "myhostname" to your preferred hostname
echo "hostname=myhostname" > /etc/conf.d/hostname						//Sets the hostname in an openrc only file. Change this as well
pacman -S dhcpd											//Installs dhcpd
//pacman -S connman-openrc connman-gtk								//Uncomment this if you're using a gtk based DE
//rc-update add connmand									//Ditto as above
echo "You have to reboot now!!"
exit
