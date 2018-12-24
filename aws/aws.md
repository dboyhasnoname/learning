# AWS learnings

## What is Amazon Web Services?

* Amazon Web Services (AWS) is a platform of web services offering solutions for computing, storage, and networking, at different layers of abstraction. 
* The term web service means services can be controlled via a web interface. The web interface can be used by machines or by humans via a graphical user interface.
* The most prominent services are EC2, which offers virtual servers, and S3, which offers storage capacity.
* Services are charged for on a pay-per-use [pricing](https://aws.amazon.com/ec2/pricing/on-demand/)   model.

* The AWS Global infrastructure is built around Regions and Availability Zones (AZs). 
* AWS Regions provide multiple, physically separated and isolated Availability Zones which are connected with low latency, high throughput, and highly redundant networking. 
* These Availability Zones offer AWS customers an easier and more effective way to design and operate applications and databases, making them more highly available, fault tolerant, and scalable than traditional single datacenter infrastructures or multi-datacenter infrastructures. 
* For customers who specifically need to replicate their data or applications over greater geographic distances, there are AWS Local Regions.
* An AWS Local Region is a single datacenter designed to complement an existing AWS Region.
* Like all AWS Regions, AWS Local Regions are completely isolated from other AWS Regions. 

Details for AWS availability zones can be found [here](https://aws.amazon.com/about-aws/global-infrastructure/)


## What is Cloud computing?

Cloud computing is a model for 

* enabling ubiquitous, 
* convenient, 
* on-demand network access to a shared pool of configurable computing resources (e.g., networks, servers, storage, applications, and services) 

that can be rapidly provisioned and released with minimal management effort or service provider interaction.

Clouds are often divided into the following types:

* **Public** —A cloud managed by an organization and open to use by the general public
* **Private** —A cloud that virtualizes and shares the IT infrastructure within a single organization
* **Hybrid** —A mixture of a public and a private cloud

AWS is a public cloud. Cloud computing services also have several classifications:

* **Infrastructure as a service (IaaS)** —Offers fundamental resources like computing, storage, and networking capabilities, using virtual servers such as Amazon EC2, Google Compute Engine, and Microsoft Azure virtual machines

* **Platform as a service (PaaS)** —Provides platforms to deploy custom applications to the cloud, such as AWS Elastic Beanstalk, Google App Engine, and Heroku

* **Software as a service (SaaS)** —Combines infrastructure and software running in the cloud, including office applications like Amazon WorkSpaces, Google Apps for Work, and Microsoft Office 365

## Compairsion of hosting an appication in DC vs AWS

![dc vs aws](img/aws_dc_comparison.jpeg)



