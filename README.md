Ubuntu Base Minimal Image (Xenial Xerus 16.04.3)
------------------------------------------------

Ubuntu Xenial Base Minimal Image (barebone minimal image) for the NanoPi NEO2 H5.

This OS Image firmware is based on legacy kernel 3.10.65+ squeezed to get some benefits like **CSI/VFE** already in use by Desktop Images.
This Image is made available so you can compare to and test the performance against Mainline kernel.

Please, note this is a WiP with a somewhat working DVFS cpu frequency ranging from 480 Mhz to 1008 Mhz.
Idle Temp. is ~ 35ºC (- 45ºC after a few hours and ambient Temp- ~ 22ºC ) without heatsink and the board works in a reliable way.

The goal here is to have USB camera working and the board run in a stable way.

**use at your own risk**

Legacy (kernel 3.10.65+) x Mainline (kernel 4.11.2)
----------------------------------------------------

Simple test with a legacy kernel (3.10.65+) versus mainline kernel (4.11.2) to see how this old kernel stacks up against modern kernel.

How this simple test was conducted:

- 7ziped a binary file and gathered information about CPU freq and Temp in ºC
- legacy kernel used a 4 GB sd card, mainline used 8 GB sd card
- Time to compress this binary file must not be considered since SD CARD performance differs


Kernel 3.10.65+ with interactive governor
![legacy with interactive governor](https://github.com/avafinger/H5-firmware/raw/master/img/plot_legacy_kernel_interactive.png)

Kernel 3.10.65+ with ondemand governor
![legacy with interactive governor](https://github.com/avafinger/H5-firmware/raw/master/img/plot_legacy_kernel_ondemand.png)

Kernel 4.11.2 with ondemand governor
![legacy with interactive governor](https://github.com/avafinger/H5-firmware/raw/master/img/plot_mainline_kernel_ondemand.png)


**Collected Data**

* plot_legacy_kernel_ondemand_governor.txt
* plot_mainline_kernel_ondemand_governor.txt
* plot_legacy_kernel_interactive_governor.txt

USB camera Log
--------------

Conecting a 720p USB Camera gives the following log:

	[  348.953880] ehci_irq: highspeed device connect
	[  349.178887] usb 3-1: new high-speed USB device number 2 using sunxi-ehci
	[  349.426710] usb 3-1: New USB device found, idVendor=1b71, idProduct=0056
	[  349.426732] usb 3-1: New USB device strings: Mfr=2, Product=1, SerialNumber=0
	[  349.426749] usb 3-1: Product: USB 2.0 Camera
	[  349.426766] usb 3-1: Manufacturer: Sonix Technology Co., Ltd.
	[  349.686481] uvcvideo: Found UVC 1.00 device USB 2.0 Camera (1b71:0056)
	[  349.700509] input: USB 2.0 Camera as /devices/soc.0/1c1d000.ehci3-controller/usb3/3-1/3-1:1.0/input/input4
	[  349.701669] usbcore: registered new interface driver uvcvideo
	[  349.701681] USB Video Class driver (1.1.1)
	[  349.767156] 2:3:1: cannot get freq at ep 0x84
	[  349.786550] usbcore: registered new interface driver snd-usb-audio


Modules loaded:

	Module                  Size  Used by
	snd_usb_audio         130575  0
	uvcvideo               66170  0
	snd_usbmidi_lib        19739  1 snd_usb_audio
	snd_hwdep               7121  1 snd_usb_audio
	videobuf2_vmalloc       3303  1 uvcvideo
	vfe_v4l2              778548  0
	videobuf2_dma_contig     9798  1 vfe_v4l2
	videobuf2_memops        2675  2 videobuf2_vmalloc,videobuf2_dma_contig
	videobuf2_core         31309  2 uvcvideo,vfe_v4l2
	sunxi_ir_rx             8543  0
	vfe_io                 38940  1 vfe_v4l2
	sunxi_keyboard          6854  0
	ss                     34391  0


Using the 720p USB camera with mjpg-streamer with this command is quite simple:

	./mjpg_streamer -i "./input_uvc.so -r 1280x720 -f 30 -q 90 -n" -o "./output_http.so -w ./www"
	MJPG Streamer Version: svn rev: 
	 i: Using V4L2 device.: /dev/video0
	 i: Desired Resolution: 1280 x 720
	 i: Frames Per Second.: 30
	 i: Format............: MJPEG
	 o: www-folder-path...: ./www/
	 o: HTTP TCP port.....: 8080
	 o: username:password.: disabled
	 o: commands..........: enabled


Board is running smooth with 480Mhz and 44ºC and using ~4% Cpu.
Things changed a bit when grabbing YUV and compressing to a JPEG, Cpu usage varies from 4 to 10% and one core is 100%
I can get 12.5 FPS at web client side.

	top - 02:06:42 up 24 min,  2 users,  load average: 0.12, 0.09, 0.11
	Tasks:  93 total,   1 running,  92 sleeping,   0 stopped,   0 zombie
	%Cpu(s):  0.0 us,  0.6 sy,  0.0 ni, 99.4 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
	KiB Mem :   479800 total,   346340 free,    34868 used,    98592 buff/cache
	KiB Swap:        0 total,        0 free,        0 used.   416925 avail Mem 
	
	  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND     
	 9066 ubuntu    20   0    7648   1676   1176 R   1.3  0.3   0:00.90 top         
	 2057 ubuntu    20   0  318236   8268   7824 S   1.0  1.7   0:44.47 mjpg_strea+ 
	   20 root      20   0       0      0      0 S   0.3  0.0   0:00.23 kworker/2:0 
	    1 root      20   0    6580   3812   2376 S   0.0  0.8   0:04.30 systemd     
	    2 root      -2   0       0      0      0 S   0.0  0.0   0:00.00 kthreadd    
	    3 root      20   0       0      0      0 S   0.0  0.0   0:00.27 ksoftirqd/0 
	    5 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:+ 
	    6 root      20   0       0      0      0 S   0.0  0.0   0:00.40 kworker/u8+ 
	    7 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 migration/0 
	    8 root      20   0       0      0      0 S   0.0  0.0   0:00.59 rcu_preempt 
	    9 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh      
	   10 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_sched   
	   11 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/0  
	   12 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/1  
	   13 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 migration/1 
	   14 root      20   0       0      0      0 S   0.0  0.0   0:00.01 ksoftirqd/1 
	   15 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0 


Issues
------

- Shutdown


	If you issue a shutdown command (sudo shutdown -h), the board actualy is put to a stand-by mode,
	but is safe to cut down the power. when in stab-by mode the green led will be ON, and you can remove
	the power cord.     


GPIO
====


	The Leds turn on when you power the board (in uboot stage), and is turned off when kernel is fully loaded.
	There are the gpio(s) where you can manipulate the two Led(s) (blue and green).
	normal_led and standby_led are the pins to manipulate.

To manipulate the leds:

Type in shell: 

	sudo su        
	password: ubuntu

Turn ON

	echo 1 > /sys/class/gpio_sw/normal_led/data 
        echo 1 > /sys/class/gpio_sw/standby_led/data 

Turn OFF

	echo 0 > /sys/class/gpio_sw/normal_led/data 
        echo 0 > /sys/class/gpio_sw/standby_led/data 


Instructions to install
-----------------------

To flash the Image to SD CARD we need a linux box and a SD card reader/writer.
This will be done in your HOST PC.

Requirements:

	- We need a linux box
	
	- Install md5sum
	
	- PSU with at least 2.0A
	
	- Good SD CARD, 8GB minimum (find a good and trusted brand)
	
	- Good USB card reader (make sure you have a trusted USB card reader) or your Laptop SD CARD reader


Rebuild our new kernel, type:


        cat rootfs_neo2_rc1.tar.gz.0* > rootfs_neo2_rc1.tar.gz


Check MD5 (must match with this):

        md5sum boot_neo2_rc1.tar.gz 
        5149c05cc5d9e25b19635e2892651775  boot_neo2_rc1.tar.gz

and

        md5sum rootfs_neo2_rc1.tar.gz
        8034aba52437086c41045bd0b621edfb  rootfs_neo2_rc1.tar.gz


        md5sum rootfs_nanopia64_rc2.tar.gz
        81be98d5f36ec6d42178028c0ab05fce  rootfs_nanopia64_rc2.tar.gz


After you insert you SD card into the SD CARD reader, we need to find the device:
Finding your SD CARD device after inserting it, type:

        dmesg|tail


If you have a USB card reader the format would be some thing like this

        dmesg|tail
        [97286.659006] sdc: detected capacity change from 15523119104 to 0
        [99023.137526] sd 4:0:0:0: [sdc] 30318592 512-byte logical blocks: (15.5 GB/14.4 GiB)
        [99023.147516] sd 4:0:0:0: [sdc] No Caching mode page found
        [99023.147521] sd 4:0:0:0: [sdc] Assuming drive cache: write through
        [99023.162514] sd 4:0:0:0: [sdc] No Caching mode page found
        [99023.162518] sd 4:0:0:0: [sdc] Assuming drive cache: write through
        [99023.168535]  sdc: sdc1 sdc2

If you have a lpatop SD CARD reader, the format would be something like this:


        dmesg|tail
        [63376.329036] mmc0: new SDHC card at address 1234
        [63376.368234] mmcblk0: mmc0:1234 SA04G 3.67 GiB 
        [63376.368372]  mmcblk0: p1 p2


Flash New Image to SD CARD, type in shell:

        sudo chmod +x *.sh
        sudo ./burn_sdcard.sh /dev/sdc

or

        sudo chmod +x *.sh
        sudo ./burn_sdcard.sh /dev/mmcblk0


Wait until finish. 
**Remove the SD CARD and boot you device with the SD CARD inserted and Enjoy!**


First time boot:

	user: ubuntu
	pasw: ubuntu



*** WIP ***

History Log:
===========
* initial commit (readme file)
* Updated
* Plotting data samples
* Instructions to install (WiP)
