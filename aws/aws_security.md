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


## ARN

Amazon resource name

![arn](img/aws-arn.jpg)

<br>

Find out the account ID by CLI:

```
$ aws iam get-user --query "User.Arn" 
"arn:aws:iam::2323899173415:user/xxxxxmukund"
```

<br>

If you know the account ID, you can use ARNs to allow access to specific resources of a service:

```
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "2",
    "Effect": "Allow",
    "Action": ["ec2:TerminateInstances"],
    "Resource": ["arn:aws:ec2:us-east-1:878533158213:instance/i-3dd4f812"]
  }]
}
```

## Policies for authorization

There are two types of policies:

1. Managed policy —If you want to create policies that can be reused in your account, a managed policy is what you’re looking for. There are two types of managed policies:
    - AWS managed policy —A policy that is maintained by AWS. There are policies that grant admin rights, read-only rights, and so on.
    - Customer managed —Could be a policy that represents the roles in your organization.
2. Inline policy —A policy that belongs to a certain IAM role, user, or group. The inline policy can’t exist without the IAM role, the user, or the group.

With CloudFormation, it’s easy to maintain inline policies.

## Users for authentication, and groups to organize users

Using root user should be avoided.

**Commands to create user and group by CLI:**

1. Create group:

```
$ aws iam create-group --group-name "admin"
{
    "Group": {
        "Path": "/", 
        "CreateDate": "2018-12-26T14:28:14Z", 
        "GroupId": "SDJKFSJKFDC6UY2UKYXYWM", 
        "Arn": "arn:aws:iam::329573949834:group/admin", 
        "GroupName": "admin"
    }
}
```

<br>

2. Attach policy to group
```
aws iam attach-group-policy --group-name "admin" \
--policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"
```

<br>

3. Create a user:
```
$ aws iam create-user --user-name "awsuser"
{
    "User": {
        "UserName": "awsuser", 
        "Path": "/", 
        "CreateDate": "2018-12-26T14:29:49Z", 
        "UserId": "ASKFJKSHFDLSHJLGHSDJL", 
        "Arn": "arn:aws:iam::329573949834:user/awsuser"
    }
}
```

<br>

4. Add the user to group:
`aws iam add-user-to-group --group-name "admin" --user-name "awsuser"`

<br>

5. Creating login profile:
```
$ aws iam create-login-profile --user-name "awsuser" --password "$Password"
{
    "LoginProfile": {
        "UserName": "awsuser", 
        "CreateDate": "2018-12-26T14:31:31Z", 
        "PasswordResetRequired": false
    }
}
```

<br>

6. Creating access key:
```
$ aws iam create-access-key --user-name awsuser
{
    "AccessKey": {
        "UserName": "awsuser", 
        "Status": "Active", 
        "CreateDate": "2018-12-26T14:40:21Z", 
        "SecretAccessKey": "SDKsadfrFJKadsfkaLSDFJKjdsvfJv9ybK+bRRL6fz//SHDkfu+Hl", 
        "AccessKeyId": "DCKSJDKHDLJHOWYFVKSANCK"
    }
}
```



