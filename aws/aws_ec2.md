# EC2: Elastic Cloud Compute

## Agenda
* Launching a virtual server with Linux
* Controlling a virtual server remotely via SSH
* Monitoring and debugging a virtual server
* Reducing costs for virtual servers

 **On AWS, virtual servers are offered by the service called Elastic Compute Cloud (EC2).**

Typical use cases for a EC2(virtual server) are as follows:

* Hosting a web application
* Executing enterprise applications
* Transforming or analyzing data

## Virtual appliances on AWS

A virtual appliance is an image containing an OS and preconfigured software that can be run on a hypervisor. It’s the hypervisor’s job to run one or more virtual appliances. Because a virtual appliance contains a fixed state, every time we start the virtual appliance, we’ll get exactly the same result.

**AMI**

* The AMI is the virtual appliance image in AWS. 
* It’s a special virtual appliance for use with the EC2 service for virtual servers. 
* An AMI technically consists of a read-only file-system including the OS, additional software, and configuration; _**it doesn’t include the kernel of the OS.**_ 
* The kernel is loaded from an Amazon Kernel Image (AKI). 
* We can also use AMIs for deploying software on AWS.

AWS uses **Xen, an open source hypervisor**, as the underlying technology for the EC2 service. 

The current generations of virtual servers on AWS use hardware-assisted virtualization. The technology is called Hardware Virtual Machine (HVM) and uses the Intel VT-x platform. 

A virtual server run by an AMI based on HVM uses a fully virtualized set of hardware and can take advantage of hardware extensions that provide fast access to the underlying hardware.

_**Using a 3.8+ kernel for your virtual Linux servers will provide the best performance. To do so, we should use at least Amazon Linux 13.09, Ubuntu 14.04, or RHEL7.**_