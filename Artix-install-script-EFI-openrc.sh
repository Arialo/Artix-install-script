#Make sure you comment this ↓ before running the script!!!!!
echo "You need to change a few things and make sure you know what you're doing!!"
exit

mkfs.ext4 -L ROOT /dev/sda2					#Make and label the root partition
mkfs.ext4 -L HOME /dev/sda4					#Make and label the home partition
mkfs.fat -F 32 /dev/sda1					#Format the EFI partition
fatlabel /dev/sda1 ESP						#Label the EFI partition
mkswap -L SWAP /dev/sda3					#Make and label the swap partition
swapon /dev/disk/by-label/SWAP					#Turn swap on to the swap partition
mount /dev/disk/by-label/ROOT /mnt				#Mount root to /mnt
mkdir /mnt/boot							#Make the boot folder
mkdir /mnt/home							#Make the base home folder
mount /dev/disk/by-label/HOME /mnt/home         		#Mount the home partition
mkdir /mnt/boot/efi						#Make the efi folder
mount /dev/disk/by-label/ESP /mnt/boot/efi			#Mount the EFI partition the the efi folder
rc-service ntpd start						#Start the ntpd service
basestrap /mnt base nano base-devel openrc elogind-openrc	#Install a couple of essential packages
basestrap /mnt linux linux-firmware				#Install the linux kernel and linux firmware. These can be substituted for the -lts and -zen variants
fstabgen -U /mnt >> /mnt/etc/fstab				#Generate the fstab file
cp Artix-install-script-EFI-openrc-pt2.sh /mnt/			#Copy the second part of the install script to the new install
cp Artix-install-script-EFI-openrc-pt3.sh /mnt/			#Copy the third part of the install script to the new install
artix-chroot /mnt						#Chroot into the newly installed system
