#!/bin/bash
#
# Orange Pi Zero 2 Plus H5
#
# *************************************
# *** Works on Legacy kernel only!  ***
# *************************************
#
# Change HDMI resulution (720P or 1080P)
#	 


function pt_error()
{
    echo -e "\033[1;31mERROR: $*\033[0m"
}

function pt_warn()
{
    echo -e "\033[1;31mWARN: $*\033[0m"
}

function pt_info()
{
    echo -e "\033[1;32mINFO: $*\033[0m"
}

function pt_ok()
{
    echo -e "\033[1;33mOK: $*\033[0m"
}

function do_720p()
{
if [ ! -d "/media/ubuntu/${BOOT_DEVICE}boot/opi" ]
then
  pt_error "Directory missing!"
  exit  
fi
cd /media/ubuntu/${BOOT_DEVICE}boot/opi
if [ ! -f "opiz2p-h5.dtb_720p" ]
then
   pt_error "There is no 720p file mode for your board!"
   exit
fi
if [ ! -f "opi-h5.dtb" ]
then
   pt_error "There is no n64.dtb on your board!"
   exit
fi
sudo rm -f opi-h5.dtb
sudo ln -s opiz2p-h5.dtb_720p opi-h5.dtb
sync

whiptail --msgbox "HDMI resolution is set up to boot with 720p mode." 20 40 2
pt_info "Please, reboot"
}

function do_1080p()
{
if [ ! -d "/media/ubuntu/${BOOT_DEVICE}boot/opi" ]
then
  pt_error "Directory missing!"
  exit  
fi
cd /media/ubuntu/${BOOT_DEVICE}boot/opi
if [ ! -f "opiz2p-h5.dtb_1080p" ]
then
   pt_error "There is no 1080p file mode for your board!"
   exit
fi
if [ ! -f "opi-h5.dtb" ]
then
   pt_error "There is no opi-h5.dtb on your board!"
   exit
fi

sudo rm -f opi-h5.dtb
sudo ln -s opiz2p-h5.dtb_1080p opi-h5.dtb
sync
whiptail --msgbox "HDMI resolution is set up to boot with 1080p mode." 20 40 2
pt_info "Please, reboot"
}

function do_1080p_OV5640()
{
pt_error "*************************************************"
pt_error "*** WARNING: This can burn your OV5640 sensor ***"
pt_error "*** WARNING: You have been warned!            ***"
pt_error "*************************************************"
if [ ! -d "/media/ubuntu/${BOOT_DEVICE}boot/opi" ]
then
  pt_error "Directory missing!"
  exit  
fi
cd /media/ubuntu/${BOOT_DEVICE}boot/opi
if [ ! -f "opiz2p-h5.dtb_1080p_OV5640" ]
then
   pt_error "There is no 1080p OV5640 file mode for your board!"
   exit
fi
if [ ! -f "opi-h5.dtb" ]
then
   pt_error "There is no opi-h5.dtb on this device!"
   exit
fi

sudo rm -f opi-h5.dtb
sudo ln -s opiz2p-h5.dtb_1080p_OV5640 opi-h5.dtb
sync
whiptail --msgbox "HDMI resolution is set up to boot with 1080p mode with OV5640." 20 40 2
pt_info "Please, reboot"
}



if [ $UID -ne 0 ]
    then
    pt_error "Please run as root."
    exit
fi
set -e

  BOOT_DEVICE="emmc" 
  boot_dev=$(whiptail --menu "Chose Boot device to change HDMI resolution (eMMC or SD CARD)" 20 60 10 \
      "SDCARD" "Changes will be visible when booting from SD card" \
      "EMMC" "Changes will be visible when booting from eMMC card" \
    3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then
    case "$boot_dev" in
      SDCARD*) BOOT_DEVICE="" ;;
      EMMC*) BOOT_DEVICE="emmc" ;;
      *)
        whiptail --msgbox "Please, choose one of the option" 20 50 2
        return 1
        ;;
    esac

  fi


  hdmi_res=$(whiptail --menu "Chose HDMI Resolution for the next boot" 20 50 10 \
      "720p" "HD Resolution ( 1280 x 720 )" \
      "1080p" "Full HD Resolution ( 1920 x 1080 )" \
      "1080p_OV5640" "Full HD with OV5640 ( 1920 x 1080 )" \
    3>&1 1>&2 2>&3)
  if [ $? -eq 0 ]; then
    case "$hdmi_res" in
      720p*) do_720p ;;
      1080p*) do_1080p ;;
      1080p_OV5640*) do_1080p_OV5640 ;;
      *)
        whiptail --msgbox "Please, choose one of the option" 20 50 2
        return 1
        ;;
    esac

  fi
