
Video reference: https://www.youtube.com/watch?v=DtXZ6BMaKbA&t=18s
Article Reference: https://www.jimangel.io/posts/automate-ubuntu-22-04-lts-bare-metal/#solution-deep-dive
Github URL: https://github.com/samcofer/ubuntu-autoinstall

Changed Files: `/boot/grub.cfg`, `/nocloud/user-data`,`/nocloud/meta-data`

### Grub.cfg Changes

Changes to this file are specifically there to tell the Ubuntu installer to autoinstall and to do so quietly without requesting user input

### User-Data Changes

Changes to this file have two impacts, the first is that this is where we set all the defaults for the Ubuntu Installer and then secondly we use this file to run follow-on setup and configuration commands such as creating the Ansible user, etc. 

```

#Installation Instructions

#Get latest Ubuntu 22 iso

mkdir source-files
xorriso -osirrox on -indev ubuntu-22.04.3-live-server-amd64.iso -extract_boot_images source-files/bootpart -extract / source-files

cd source-files/
mkdir nocloud
cp ../../user-data .

cd /source-files/boot/grub/
chmod 644 grub.cfg
cp ../../../grub.cfg .

xorriso -as mkisofs -r -V "ubuntu-autoinstall" -J -boot-load-size 4 -boot-info-table -input-charset utf-8 -eltorito-alt-boot -b bootpart/eltorito_img1_bios.img -no-emul-boot -o ../installer.iso .




```
