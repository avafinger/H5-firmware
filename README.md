Ubuntu Base Minimal Image (Xenial Xerus 16.04.3)
------------------------------------------------

Ubuntu Xenial Base Minimal Image (barebone minimal image) for the NanoPi NEO2 H5.

This OS Image firmware is based on legacy kernel 3.10.65+ squeezed to get some benefits like **CSI/VFE** already in use by Desktop Images.
This Image is made available so you can compare to and test the performance against Mainline kernel.

Please, note this is a WiP with a somewhat working DVFS cpu frequency ranging from 480 Mhz to 1008 Mhz.
Idle Temp. is ~ 35ºC without heatsink and the board works in a reliable way.

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
![legacy with interactive governor](https://github.com/avafinger/H5-firmware/raw/master/img/plot_mainline_kernel_ondemandx.png)


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
