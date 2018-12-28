# ELB

Exposing a single web server to the outside world introduces a dependency: the public IP address of the EC2 instance. From this point on, you can’t change the public IP address again because it’s used by many clients sending requests to your server. You’re faced with the following issues:

- Changing the public IP address is no longer possible because many clients rely on it.
- If you add an additional server (and IP address) to handle increasing load, it’s ignored by all current clients: they’re still sending all requests to the public IP address of the first server.

We can solve these issues with a DNS name pointing to the server. But DNS isn’t fully under your control. DNS servers cache entries, and sometimes they don’t respect your time to live (TTL) settings. A better solution is to use a load balancer.

A load balancer can help to decouple a system where the requester awaits an immediate response. Instead of exposing the web servers to the outside world, we only expose the load balancer to the outside world. 

The load balancer then redirects requests to the web servers behind it.

## Elastic Load Balancer

AWS offers load balancers through the ELB service. The AWS load balancer is fault-tolerant and scalable. For each ELB, you pay $ 0.025 per hour and $ 0.008 per GB of processed traffic. The prices are valid for the North Virginia (us-east-1) region.

The ELB service doesn’t have an independent Management Console. It’s integrated into the EC2 service.

The ELB is a fault-tolerant service. If you create an ELB, we receive a public name like elb-1079556024.us-east-1.elb.amazonaws.com as the endpoint

An ELB is described by the following:

* The subnets it’s attached to. There can be more than one.
* A mapping of the load balancer port to the port on the servers behind the ELB.
* The security groups that are assigned to the ELB. We can restrict traffic to the ELB in the same ways you can with EC2 instances.
* Whether the load balancer should be accessible from the public internet.

More use cases of ELB:

1.  ELB can balance TCP traffic. YoWeu can place almost any application behind a load balancer.

2.  ELB can turn SSL-encrypted traffic into plain traffic if we add your SSL certificate to AWS.

3.  ELB can log each request. ELB can integrate with S3 to provide access logs.

4.  ELB can distribute your requests evenly across multiple availability zones.

5.  Redirect plain TCP traffic, to decouple databases or legacy applications with proprietary interfaces. 

6.  An ELB can be used to terminate SSL without the need to do the configuration on your own. Terminating SSL means the ELB offers an SSL-encrypted endpoint that forwards requests unencrypted to the back-end servers.
