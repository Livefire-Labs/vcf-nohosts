# Using the EPC - VCF 5.2.1 No Hosts - Lab Template

This template only has three VMs.  **Holo-Router**, **Holo-Console** and **VCF 5.2.1 Cloudbuilder**.  

In order to be able to deploy VCF 5.2.1 using this template, you will need to create four ESXi Hosts with the following settings in the vApp

* 128GB RAM
* 12 CPUs (Note.  You want one socket with 12 cores, NOT 12 sockets)
* 1 x 32GB Paravirtual (SCSI) 
* 1 x 256GB NVMe
* 4 x VMXNET3 NICS, connected to vAppNet and set to DHCP Mode



![Add VM](_images/add.vm.png)

Click **ALL ACTIONS --> Add --> Add VM**

![alt text](_images/add.vm.2.png)

Click **ADD VIRTUAL MACHINE**

![alt text](_images/add.vm.esxi1.png)
* Name: esxi-(1,2,3,4)
* Description: 
* Type: New
* Guest OS Family: Other
* Guest OS: VMware ESXi 8.0 or later

![alt text](_images/add.vm.esxi2.png)

![alt text](_images/add.vm.esxi3.png)

![alt text](_images/add.vm.esxi.Add.png)

![alt text](_images/edit.vm.esxi1.png)

1.

![alt text](_images/edit.vm.esxi2.png)

2.

![alt text](_images/edit.vm.esxi3.png)

3.

![alt text](_images/edit.vm.esxi4.png)

4.

![alt text](_images/copy.vm.esxi1.png)

5.

![alt text](_images/copy.vm.esxi2.png)

6

![alt text](_images/copy.vm.esxi3.png)

7.

![alt text](_images/copy.vm.esxi4.png)

Remember to rename it properly

Click **NEXT**

![alt text](_images/copy.vm.esxi5.png)

Click **DONE**

![alt text](_images/copy.vm.esxi6.png)

Wait for the new VM to be Created

![alt text](_images/copy.vm.esxi7.png)

Once that one is created, repeat until you have all the ESXi hosts you need

![alt text](_images/powerOn.vm.esxi1.png)

Power them all On

![alt text](_images/powerOn.vm.esxi2.png)

Wait for them all to power on and open all the consoles at once

![alt text](_images/configAll.vm.esxi.png)

From Here you can go through and configure each host properl

For the installation you install ESXi onto the 32GB drive and set a root password of VMware123!VMware123!

Once installation has completed and the vHosts have rebooted, you’ll need to log into each one and set the following values

|MGMT Net VLAN | SM            | DF and DNS         |
|:---------------------- |:------------- |:------------------ |
| 10 | 255.255.255.0 | 10.0.0.253 |




| FQDN (hostname)     | IP         |
|:------------------- |:---------- |
| esxi-1.vcf.sddc.lab | 10.0.0.101 |
| esxi-2.vcf.sddc.lab | 10.0.0.102 |
| esxi-3.vcf.sddc.lab | 10.0.0.103 |
| esxi-4.vcf.sddc.lab | 10.0.0.104 |


You must restart the management network when prompted.

You must enable SSH

Once all of the hosts have been configured, there are two more configuration items to tick off.

Start the vApp in vCloud Director.  Once it has started up, connect to the Holo-Console and use the web browser to log into each host in turn.  Go to services and configure NTP with 10.0.0.253 and set it to start and stop with host.

Finally, use Putty to ssh into each host and re-generate the default certificates using the following commands

From cmd or powershell run. 

```
putty.exe -load esxi-1 -l root -pw VMware123!VMware123!
putty.exe -load esxi-2 -l root -pw VMware123!VMware123!
putty.exe -load esxi-3 -l root -pw VMware123!VMware123!
putty.exe -load esxi-4 -l root -pw VMware123!VMware123!
```

Once in each putty session run


```
cd /etc/vmware/ssl
mv rui.crt orig.rui.crt
mv rui.key orig.rui.key
/sbin/generate-certificates
```
then
```
 /etc/init.d/hostd restart
```

then

```
reboot
```


And close the putty session

You need to do this so that the default certificate contains the FQDN of the host.

You are now ready to execute the cloudbuilder process.

Open a browser on the Holo-Console and go to https://10.0.0.253.  The JSON file you need to upload for bringup is in the c:\VLC folder

