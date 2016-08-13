=============================================
	My Notes to make it working
=============================================

Chef dk version is 0.15.16. Chef latest is giving issues with kitchen.

To install the gems Refer to GemFile in the cookbook. 

There are several gems to be installed and they are mentioned there.

Once specified install them using chef exec bundle install inside cookbook directory.

Docker gives issues when setting up ubuntu 14.04

Issue is for IPV6

Go to /etc/resolv.conf and comment out lines for IPv6 settings and most importantly restart docker otherwise it wont work
