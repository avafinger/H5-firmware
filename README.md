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


Next step is to check how to work with the camera....

Instructions to install
-----------------------

To be completed

*** WIP ***

History Log:
===========
* initial commit (readme file)
* Updated
* Plotting data samples
* Instructions to install (WiP)
