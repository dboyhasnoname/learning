# Securing AWS infra: IAM, security groups, and VPC

## Networking terms

* **Subnet**

A subnet is a logical partition of an IP network into multiple, smaller network segments. It is typically used to subdivide large networks into smaller, more efficient subnetworks.

* **Route table**

A routing table is a set of rules, often viewed in table format, that is used to determine where data packets traveling over an Internet Protocol (IP) network will be directed. All IP-enabled devices, including routers and switches, use routing tables.

A basic routing table includes the following information:

1. Destination: The IP address of the packet's final destination
2. Next hop: The IP address to which the packet is forwarded
3. Interface: The outgoing network interface the device should use when forwarding the packet to the next hop or final destination
4. Metric: Assigns a cost to each available route so that the most cost-effective path can be chosen
5. Routes: Includes directly-attached subnets, indirect subnets that are not attached to the device but can be accessed through one or more hops, and default routes to use for certain types of traffic or when information is lacking.

* **Access control list (ACL)**

Access Control List (ACL) are filters that enable you to control which routing updates or packets are permitted or denied in or out of a network.

* **Gateway**

A gateway is a network node that connects two networks using different protocols together. While a bridge is used to join two similar types of networks, a gateway is used to join two dissimilar networks.

* **Firewall**

A firewall is a network security device that monitors incoming and outgoing network traffic and decides whether to allow or block specific traffic based on a defined set of security rules.

