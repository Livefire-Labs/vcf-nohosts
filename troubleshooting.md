DO NOT TRUST THE CLOUDBUILDER UI!!!!

ssh into the cloudbuilder:

```
tail -f /var/log/vmware/vcf/bringup/vcf-bringup-debug.log
```



look at cert in browser
https://www.martingustafsson.com/re-use-cloud-builder-for-another-deployment/

```
psql -U postgres -d bringup -h localhost
delete from execution;
delete from "Resource";
\q
```



```
 putty.exe -load Cloudbuilder-SiteA -l admin -pw VMware123!VMware123!
 ```


 Do this to each hosts before validation

 esxcfg-advcfg -s 0 /Net/FollowHardwareMac

 then

 reboot


To Open the putty sessions from CMD or Powershell with UserID and Password
```
putty.exe -load esxi-1 -l root -pw VMware123!VMware123!
putty.exe -load esxi-2 -l root -pw VMware123!VMware123!
putty.exe -load esxi-3 -l root -pw VMware123!VMware123!
putty.exe -load esxi-4 -l root -pw VMware123!VMware123!
putty.exe -load Cloudbuilder-SiteA -l admin -pw VMware123!VMware123!
 ```





 vcf-5.2.1-base-no-bringup

NTP - ESXi WebUI
SSH - ESXi WebUI

Certs - 
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

Edit JSON
esa on NOLIC JSON file





VLCGui.ps1 -iniConfigFile .\<VLC-HeadLess-Config-Filename>.ini -
isCLI:$true