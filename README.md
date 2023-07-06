# bginfo

Script for displaying information on a background

The original design for this script comes from Vikram Khatri
and can be found at https://www.zinox.com/archives/170

## Installation

### Requires
- imagemagick
- procinfo
- git (if installing via git)
### Installation
Install files in user's $home/bin/bginfo directory

or 

Install files in /opt/bginfo
and modify SCHOME in bginfo.sh

set wallpaper to $SCHOME/newwall.png

### [Optional]

#### Add Script to run at boot time
Using systemd
We need to create a service descriptor, called a unit file, under /etc/systemd/system:

```
[Unit]
Description=Create BG info Wallpaper.

[Service]
Type=simple
ExecStart=/bin/bash /opt/bginfo/bginfo.sh

[Install]
WantedBy=multi-user.target
```

The file is organized into different sections:

Unit – contains general metadata, like a human-readable description
Service – describes the process and daemonizing behavior, along with the command to start the service
Install – enables the service to run at startup using the folder specified in WantedBy to handle dependencies
Next, we’ll need to set the file permissions to 644, and enable our service by using systemctl:

$ chmod 644 /etc/systemd/system/reboot_message.service
$ systemctl enable reboot_message.service

#### Add Crontab Entry to refresh

Optionally, if you want your image to be refreshed every 15 minutes, add a crontab entry as shown:
    crontab -e
and add
    */15 * * * * /$HOME/bin/bginfo/bginfo.sh
 
replacing the $HOME with the actual path and save the file.

You can also copy the contents of user.cron to your crontab
## ImageMagick operation not authorized

Solution

Since ImageMagick is sometimes used on web servers to operate on images for users, it has security checks on certain operations.

Option 1:

sudo rm /etc/ImageMagick-6/policy.xml 

Option 2:

sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.off

When done, you can restore the original with

sudo mv /etc/ImageMagick-6/policy.xml.off /etc/ImageMagick-6/policy.xml

Option 3:

Edit the Imagemagick policy.xml file to uncomment this line:

  <!-- <policy domain="module" rights="none" pattern="{PS,PDF,XPS}" /> -->

And change it from rights="none" to rights="read|write"

  <policy domain="module" rights="read|write" pattern="{PS,PDF,XPS}" />