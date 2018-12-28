# Achieving high availability: availability zones, auto-scaling, and CloudWatch

* High availability describes a system that’s operating with almost no downtime. Even if a failure occurs, the system can provide its services at a high probability. Although a short interruption might be necessary to recover from a failure, there’s no need for human interaction. 

* The Harvard Research Group (HRG) defines high availability with the classification AEC-2, which requires an uptime of 99.99 % over a year.

### High availability vs. fault tolerance

- A highly available system can recover from a failure automatically with a short downtime.

- A fault-tolerant system, in contrast, requires the system to provide its services without interruption in case of a component failure. 

### AWS offers tools for building highly available systems based on EC2 instances:

1. Monitoring the health of virtual servers with CloudWatch and triggering recovery automatically if needed.
2. Building a highly available infrastructure by using multiple isolated data centers, called availability zones, within a region.
3. Using auto-scaling to have a guaranteed number of virtual servers running and replace failed instances automatically.

## Recovering from server failure with CloudWatch

The status of every virtual server is checked by the EC2 service automatically. Checks are performed every minute and are available as CloudWatch metrics. 

### AWS CloudWatch is a service offering metrics, logs, and alarms for AWS resources.

- A system status check detects a loss of network connectivity or power and software or hardware issues on the physical host. 

- AWS needs to be involved to repair failures detected by the system status check. 
- One possible strategy to resolve such failures is to recover by moving the virtual machine to another physical host.

 In the case of a hardware failure, CloudWatch triggers the recovery of the virtual server.

 ![cloudwatch flow](img/cloudwatch_flow.jpg)

 <br>

 - After the recovery, a new virtual server is running with the same ID and private IP address. Data on EBS volumes, the network-attached storage, is restored as well. 
 - No data is lost because the EBS volume stays the same. Virtual servers with local disks (instance storage) aren’t supported for the CloudWatch alarm-based recovery process. 
 - If the old virtual server was connected to an Elastic IP address, the new server is connected to the same public IP address.

 ### Requirements for recovering EC2 instances

A virtual server must fulfill the following requirements if you want to use the recovery feature:

1. It must be running in a virtual private cloud (VPC) network.
2. The instance family must be c3 (compute optimized), c4 (compute optimized), m3 (general), r3 (memory optimized), or t2 (burstable performance). Earlier instance families aren’t supported (such as t1).
3. The EC2 instance must use EBS volumes exclusively because data on instance storage would be lost after a recovery of the instance.

