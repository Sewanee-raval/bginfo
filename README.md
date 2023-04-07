# bginfo

Script for displaying information on a background


## Installation

### Requires
imagemagick
procinfo

### Installation
Install files in user's $home/bin/bginfo direcotory

or

Install files into any user's directory and modify SCHOME in bginfo.sh

set wallpaper to $SCHOME/newwall.png


### [Optional]

#### Add Crontab Entry to refresh

Optionally, if you want your image to be refreshed every 15 minutes, add a crontab entry as shown:

crontab -e

and add

*/15 * * * * /$HOME/bin/bginfo/bginfo.sh
 
replacing the $HOME with the actual path and save the file.

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