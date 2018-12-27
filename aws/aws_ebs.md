# Storing your data on hard drives: EBS and instance store

Block-level storage with a disk file system (FAT32, NTFS, ext3, ext4, XFS, and so on) can be used to store files as we do on a personal computer. 

A block is a sequence of bytes and the smallest addressable unit. The OS is the intermediary between the application that wants to access files and the underlying file system and block-level storage. The disk file system manages where (at what block address) your files are persisted on the underlying block-level storage. We can use block-level storage only in combination with an EC2 instance where the OS runs.

---

The OS provides access to block-level storage via open, write, and read system calls. The simplified flow of a read request goes like this:

1.  An application wants to read the file /path/to/file.txt and makes a read system call.

2.  The OS forwards the read request to the file system.

3.  The file system translates /path/to/file.txt to the block on the disk where the data is stored.

Applications like databases that read or write files by using system calls must have access to block-level storage for persistence. _We can’t tell a MySQL database to store its files in an object store because MySQL uses system calls to access files._

---

AWS provides two kinds of block-level storage:
1. **Network-attached storage (NAS):**
    - NAS is (like iSCSI) attached to your EC2 instance via a network connection.
    - EBS provides NAS storage in AWS.
    - NAS is the best choice for most problems because it provides 99.999% availability of the data.
2. **Instance storage:**:
    - instance storage is a normal hard disk that the host system provides to your EC2 instance.  
    - Instance storage is interesting if we’re optimizing for performance. 


# NETWORK-ATTACHED STORAGE(EBS)

* Elastic Block Store (EBS) provides network-attached, block-level storage with 99.999% availability.
* EBS volumes are independent resources but can only be used when attached to an EC2 instance.
* _We can’t attach the same EBS volume to multiple servers!_

* EBS volumes:
    - Aren’t part of EC2 instances; they’re attached to EC2 instance via a network connection. 
    - If we terminate the EC2 instance, the EBS volumes remain.
    - Can be attached to no EC2 instances or one EC2 instance at a time.
    - Can be used like normal hard disks.
    - Are comparable to RAID1: data is saved to multiple disks in the background.

## Creating an EBS volume and attaching it to your server    

An EBS volume is a standalone resource. This means EBS volume can exist without an EC2 server, but we need an EC2 server to use the EBS volume.

```
{
	"AWSTemplateFormatVersion": "2010-09-09",
	"Description": "mukund-learning-aws EBS learning",
	"Parameters": {
		"KeyName": {
			"Description": "Key Pair name",
			"Type": "AWS::EC2::KeyPair::KeyName",
			"Default": "mykey"
		},
		"VPC": {
			"Description": "Just select the one and only default VPC",
			"Type": "AWS::EC2::VPC::Id"
		},
		"Subnet": {
			"Description": "Just select one of the available subnets",
			"Type": "AWS::EC2::Subnet::Id"
		},
		"AttachVolume": {
			"Description": "Should the volume be attached?",
			"Type": "String",
			"Default": "yes",
			"AllowedValues": ["yes", "no"]
		}
	},
	"Mappings": {
		"EC2RegionMap": {
			"us-east-1": {"AmazonLinuxAMIHVMEBSBacked64bit": "ami-1ecae776"}
		}
	},
	"Conditions": {
		"Attached": {"Fn::Equals": [{"Ref": "AttachVolume"}, "yes"]}
	},
	"Resources": {
		"SecurityGroup": {
			"Type": "AWS::EC2::SecurityGroup",
			"Properties": {
				"GroupDescription": "My security group",
				"VpcId": {"Ref": "VPC"},
				"SecurityGroupIngress": [{
					"CidrIp": "0.0.0.0/0",
					"FromPort": 22,
					"IpProtocol": "tcp",
					"ToPort": 22
				}]
			}
		},
		"IamRole": {
			"Type": "AWS::IAM::Role",
			"Properties": {
				"AssumeRolePolicyDocument": {
					"Version": "2012-10-17",
					"Statement": [
						{
							"Effect": "Allow",
							"Principal": {
								"Service": ["ec2.amazonaws.com"]
							},
							"Action": ["sts:AssumeRole"]
						}
					]
				},
				"Path": "/",
				"Policies": [
					{
						"PolicyName": "ec2",
						"PolicyDocument": {
							"Version": "2012-10-17",
							"Statement": [{
								"Effect" : "Allow",
								"Action" : ["ec2:DescribeVolumes", "ec2:CreateSnapshot", "ec2:DescribeSnapshots", "ec2:DeleteSnapshot"],
								"Resource": "*"
							}]
						}
					}
				]
			}
		},
		"IamInstanceProfile": {
			"Type": "AWS::IAM::InstanceProfile",
			"Properties": {
				"Path": "/",
				"Roles": [{"Ref": "IamRole"}]
			}
		},
		"Server": {
			"Type": "AWS::EC2::Instance",
			"Properties": {
				"IamInstanceProfile": {"Ref": "IamInstanceProfile"},
				"ImageId": {"Fn::FindInMap": ["EC2RegionMap", {"Ref": "AWS::Region"}, "AmazonLinuxAMIHVMEBSBacked64bit"]},
				"InstanceType": "t2.micro",
				"KeyName": {"Ref": "KeyName"},
				"SecurityGroupIds": [{"Ref": "SecurityGroup"}],
				"SubnetId": {"Ref": "Subnet"}
			}
		},
		"Volume": {
			"Type": "AWS::EC2::Volume",                                             # EBS Volume Description
			"Properties": {
				"AvailabilityZone": {"Fn::GetAtt": ["Server", "AvailabilityZone"]},
				"Size": "5",                                                        # 5GB capacity
				"VolumeType": "gp2"                                                 # SSD backed
			}
		},
		"VolumeAttachment": {
			"Type": "AWS::EC2::VolumeAttachment",                                   # Attach EBS volume to server
			"Condition": "Attached",
			"Properties": {
				"Device": "/dev/xvdf",                                              # Device name
				"InstanceId": {"Ref": "Server"},
				"VolumeId": {"Ref": "Volume"}
			}
		}
	},
	"Outputs": {
		"PublicName": {
			"Value": {"Fn::GetAtt": ["Server", "PublicDnsName"]},
			"Description": "Public name (connect via SSH as user ec2-user)"
		},
		"VolumeId": {
			"Value": {"Ref": "Volume"},
			"Description": "Volume id"
		}
	}
}
```






