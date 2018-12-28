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

### Creating a CloudWatch alarm:

A CloudWatch alarm consists of the following:

1. A metric that monitors data (health check, CPU usage, and so on)
2. A rule defining a threshold based on a statistical function over a period of time
3. Actions to trigger if the state of the alarm changes (such as triggering a recovery of an EC2 instance if the state changes to ALARM)

The following states are available for an alarm:

1. OK —Everything is fine; the threshold hasn’t been reached.
2. INSUFFICIENT_DATA —There isn’t enough data to evaluate the alarm.
3. ALARM —Something is broken: the threshold has been overstepped.

Sample CloudWatch alarm:

![cloudwatch alarm](img/cloudwatch_alarm.jpg)

<br>

## Monitoring and recovering a jenkins server based on a CloudWatch alarm

```
$ aws cloudformation create-stack --stack-name jenkins \
--template-url https://s3.amazonaws.com/mukund-learning-aws-jenkins-setup/jenkins.json \
--parameters ParameterKey=JenkinsAdminPassword,ParameterValue=iwonttellu108

{
    "StackId": "arn:aws:cloudformation:us-east-1:825796472415:stack/jenkins/cb9bded0-0a67-11e9-b5ce-12a3b4ca1ea2"
}
$
```

<br>

![jenkins setup 1](img/jenkins_setup_1.jpg)

<br>

![jenkins setup 2](img/jenkins_setup_2.jpeg)

<br>

![jenkins setup 3](img/jenkins_setup_3.jpeg)

<br>

![jenkins setup 3](img/jenkins_setup_4.jpeg)

<br>

Alarm in the CLoudWatch

![alarm cloudwatch](img/jenkins_cloudwatch_alarm.jpeg)

<br>

![alarm 2](img/jenkins_alarm.jpeg)

<br>

Recovery

![alarm3](img/jenkins_alarm_2.jpeg)

<br>

##  Availability zones: multiple data centers per region

AWS operates multiple locations worldwide, called regions.

* Each region consists of multiple availability zones. 
* A*vailability zone are isolated data centers and a region as an area where multiple isolated data centers are located at a sufficient distance. 
* The availability zones are connected through low-latency links, so requests between different availability zones aren’t as expensive as requests across the internet in terms of latency.

![availablity zones 1](img/availability_zones_1.jpg)

<br>

AWS services can operate in a single availability zone, over multiple availability zones within a region, or even globally.

- There are services operating globally over multiple regions: Route 53 (DNS) and CloudFront (CDN).
- Some services are using multiple availability zones within a region so they can recover from a data center outage: S3 (object store) and DynamoDB (NoSQL database).
- The relational database service (RDS) offers the ability to deploy a master-standby setup, called Multi-AZ deployment, so you can failover into another availability zone if necessary.
- A virtual server runs in a single availability zone. But AWS offers tools to build an architecture based on EC2 instances that can failover into another availability zone.

![availablity zone 2](img/availability_zones_2.jpg)

<br>

List of availability [zones](https://howto.lintel.in/list-of-aws-regions-and-availability-zones/):

![availability zones list](img/availability_zones_list.jpeg)

<br>

## Dependencies of VPC service on availability zone

1. A VPC is always bound to a region.
2. A subnet within a VPC is linked to an availability zone.
3. A virtual server is launched into a single subnet.

![VPC dependencies](img/availability_zones_3.jpg)


## Auto-scaling

Auto-scaling is part of the EC2 service and helps us to ensure that a specified number of virtual servers is running.

To configure auto-scaling, you need to create two parts of the configuration:

1. A launch configuration contains all information needed to launch a virtual server: 
    - instance type (size of virtual server) and 
    - image (AMI) to start from.
2. An auto-scaling group tells the EC2 service how many virtual servers should be started with a specific launch configuration, how to monitor the instances, and in which subnets virtual servers should be started.

![autoscaling](img/atuo_scaling_flow.jpg)

<br>

![autoscaling paramters](img/auotscaling_2.jpeg)

<br>

![autoscaling config](img/auotscaling_config.jpeg)

<br>

Jenkins CI server with auto-scaling in two availability zones

![autoscaling az](img/auotscaling_3.jpg)

<br>

![autoscaling az 2](img/autoscaling_4.jpg)



















