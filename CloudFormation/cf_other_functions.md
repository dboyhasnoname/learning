# Working with intrinsic functions

Intrinsic functions enable us to put logic functions inside CloudFormation templates.

The following is a list of intrinsic functions:

1. Fn::Base64 
2. Fn::Cidr
3. Condition Functions
    1. Fn::And
    2. Fn::Equals
    3. Fn::If
    4. Fn::Not
    5. Fn::Or
4. Fn::FindInMap
5. Fn::GetAtt
6. Fn::GetAZs
7. Fn::ImportValue
8. Fn::Join
9. Fn::Select
10. Fn::Split
11. Fn::Sub
12. Ref
13. Fn::Transform

## Fn::Base64 

The intrinsic function Fn::Base64 returns the Base64 representation of the input string. This function is typically used to pass encoded data to Amazon EC2 instances by way of the UserData property.

We can use any function that returns a string inside the Fn::Base64 function.

##### JSON

`{ "Fn::Base64" : valueToEncode }`

##### YAML

`Fn::Base64: valueToEncode`

## Fn::Cidr

The intrinsic function Fn::Cidr returns an array of CIDR(Classless Inter-Domain Routing, sometimes called supernetting) address blocks. The number of CIDR blocks returned is dependent on the count parameter.

We can use the following functions in a Fn::Cidr function:
1. Fn::Select
2. Ref
3. Fn::GetAtt

It returns an array of CIDR address blocks.

##### JSON

`{ "Fn::Cidr" : [ipBlock, count, cidrBits]}`

<br>

`{ "Fn::Cidr" : [ "192.168.0.0/24", "6", "5"] }`

##### YAML

```
Fn::Cidr: 
  - ipBlock  # user-specified CIDR address block to be split into smaller CIDR blocks.
  - count    # number of CIDRs to generate. Valid range is between 1 and 256.
  - cidrBits # number of subnet bits for the CIDR. For example, specifying a value "8" for this parameter will create a CIDR with a mask of "/24".
```

`!Cidr [ "192.168.0.0/24", 6, 5 ]`

Syntax for short form:

`!Cidr [ ipBlock, count, cidrBits ]`

Example:

```
{
  "Resources" : {
    "ExampleVpc" : {
      "Type" : "AWS::EC2::VPC",
      "Properties" : {
        "CidrBlock" : "10.0.0.0/16"
      }
    },
    "IPv6CidrBlock" : {
      "Type" : "AWS::EC2::VPCCidrBlock",
      "Properties" : {
        "AmazonProvidedIpv6CidrBlock" : true,
        "VpcId" : { "Ref" : "ExampleVpc" }
      }
    },
    "ExampleSubnet" : {
      "Type" : "AWS::EC2::Subnet",
      "DependsOn" : "IPv6CidrBlock",
      "Properties" : {
        "AssignIpv6AddressOnCreation" : true,
        "CidrBlock" : { "Fn::Select" : [ 0, { "Fn::Cidr" : [{ "Fn::GetAtt" : [ "ExampleVpc", "CidrBlock" ]}, 1, 8 ]}]},
        "Ipv6CidrBlock" : { "Fn::Select" : [ 0, { "Fn::Cidr" : [{ "Fn::Select" : [ 0, { "Fn::GetAtt" : [ "ExampleVpc", "Ipv6CidrBlocks" ]}]}, 1, 64 ]}]},
        "VpcId" : { "Ref" : "ExampleVpc" }
      }
    }
  }
}
```

## Fn::FindInMap

The intrinsic function Fn::FindInMap returns the value corresponding to keys in a two-level map that is declared in the Mappings section.


##### JSON

```
{ "Fn::FindInMap" : [ "MapName", "TopLevelKey", "SecondLevelKey"] }
```

```
{
  ...
  "Mappings" : {
    "RegionMap" : {
      "us-east-1" : { 
        "HVM64" : "ami-0ff8a91507f77f867", "HVMG2" : "ami-0a584ac55a7631c0c" 
      },
      "us-west-1" : { 
        "HVM64" : "ami-0bdb828fd58c52235", "HVMG2" : "ami-066ee5fd4a9ef77f1" 
      },
      "eu-west-1" : { 
        "HVM64" : "ami-047bb4163c506cd98", "HVMG2" : "ami-0a7c483d527806435" 
      },
      "ap-southeast-1" : { 
        "HVM64" : "ami-08569b978cc4dfa10", "HVMG2" : "ami-0be9df32ae9f92309" 
      },
      "ap-northeast-1" : { 
        "HVM64" : "ami-06cd52961ce9f0d85", "HVMG2" : "ami-053cdd503598e4a9d" 
      }
    }
  },

  "Resources" : {
    "myEC2Instance" : {
      "Type" : "AWS::EC2::Instance",
      "Properties" : {
        "ImageId" : { 
          "Fn::FindInMap" : [ 
            "RegionMap", 
            { 
              "Ref" : "AWS::Region" 
            }, 
            "HVM64"
          ]
        },
        "InstanceType" : "m1.small"
      }   
    }
  }
}
```

##### YAML

```
Fn::FindInMap: [ MapName, TopLevelKey, SecondLevelKey ]
```

```
Mappings: 
  RegionMap: 
    us-east-1: 
      HVM64: "ami-0ff8a91507f77f867"
      HVMG2: "ami-0a584ac55a7631c0c"
    us-west-1: 
      HVM64: "ami-0bdb828fd58c52235"
      HVMG2: "ami-066ee5fd4a9ef77f1"
    eu-west-1: 
      HVM64: "ami-047bb4163c506cd98"
      HVMG2: "ami-31c2f645"
    ap-southeast-1: 
      HVM64: "ami-08569b978cc4dfa10"
      HVMG2: "ami-0be9df32ae9f92309"
    ap-northeast-1: 
      HVM64: "ami-06cd52961ce9f0d85"
      HVMG2: "ami-053cdd503598e4a9d"
Resources: 
  myEC2Instance: 
    Type: "AWS::EC2::Instance"
    Properties: 
      ImageId: !FindInMap
        - RegionMap
        - !Ref 'AWS::Region'
        - HVM64
      InstanceType: m1.small
```

##### Supported Functions
We can use the following functions in a Fn::FindInMap function:

1. Fn::FindInMap
2. Ref

##### Syntax for the short form:

`!FindInMap [ MapName, TopLevelKey, SecondLevelKey ]`

##### Return Value:
The value that is assigned to SecondLevelKey.

_We can't nest two instances of two functions in short form._


## Fn::GetAtt

The Fn::GetAtt intrinsic function returns the value of an attribute from a resource in the template.

##### JSON

`{ "Fn::GetAtt" : [ "logicalNameOfResource", "attributeName" ] }`

##### YAML

`Fn::GetAtt: [ logicalNameOfResource, attributeName ]`

##### Syntax for the short form:

`!GetAtt logicalNameOfResource.attributeName`


##### Parameters:
* logicalNameOfResource
The logical name (also called logical ID) of the resource that contains the attribute that you want.

* attributeName
The name of the resource-specific attribute whose value you want. See the resource's reference page for details about the attributes available for that resource type.

##### Return Value
The attribute value.

##### Example:

JSON

```
{
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "myELB": {
            "Type": "AWS::ElasticLoadBalancing::LoadBalancer",
            "Properties": {
                "AvailabilityZones": [
                    "eu-west-1a"
                ],
                "Listeners": [
                    {
                        "LoadBalancerPort": "80",
                        "InstancePort": "80",
                        "Protocol": "HTTP"
                    }
                ]
            }
        },
        "myELBIngressGroup": {
            "Type": "AWS::EC2::SecurityGroup",
            "Properties": {
                "GroupDescription": "ELB ingress group",
                "SecurityGroupIngress": [
                    {
                        "IpProtocol": "tcp",
                        "FromPort": "80",
                        "ToPort": "80",
                        "SourceSecurityGroupOwnerId": {
                            "Fn::GetAtt": [
                                "myELB",
                                "SourceSecurityGroup",
                                "OwnerAlias"
                            ]
                        },
                        "SourceSecurityGroupName": {
                            "Fn::GetAtt": [
                                "myELB",
                                "SourceSecurityGroup",
                                "GroupName"
                            ]
                        }
                    }
                ]
            }
        }
    }
}
```

YAML

```
AWSTemplateFormatVersion: 2010-09-09
Resources:
  myELB:
    Type: AWS::ElasticLoadBalancing::LoadBalancer
    Properties:
      AvailabilityZones:
        - eu-west-1a
      Listeners:
        - LoadBalancerPort: '80'
          InstancePort: '80'
          Protocol: HTTP
  myELBIngressGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: ELB ingress group
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: '80'
          ToPort: '80'
          SourceSecurityGroupOwnerId: !GetAtt myELB.SourceSecurityGroup.OwnerAlias
          SourceSecurityGroupName: !GetAtt myELB.SourceSecurityGroup.GroupName
```          


## Fn::GetAZs

The intrinsic function Fn::GetAZs returns an array that lists Availability Zones for a specified region. Because customers have access to different Availability Zones, the intrinsic function Fn::GetAZs enables template authors to write templates that adapt to the calling user's access. 

#### IAM permissions

The permissions that we need in order to use the Fn::GetAZs function depend on the platform in which we're launching Amazon EC2 instances. 

##### JSON

`{ "Fn::GetAZs" : "region" }`

##### YAML

`Fn::GetAZs: region`

##### Syntax for the short form:

`!GetAZs region`

#### Parameters
* region
The name of the region for which we want to get the Availability Zones.


#### Return Value
The list of Availability Zones for the region.

##### Examples:

AWS CloudFormation evaluates Fn::GetAZs to the following array—assuming that the user has created the stack in the us-east-1 region:

[ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]

JSON

```
{ "Fn::GetAZs" : "" }
{ "Fn::GetAZs" : { "Ref" : "AWS::Region" } }
{ "Fn::GetAZs" : "us-east-1" }
```

YAML

```
Fn::GetAZs: ""
Fn::GetAZs:
  Ref: "AWS::Region"
Fn::GetAZs: us-east-1
```

#### Supported Functions
We can use the **Ref** function in the **Fn::GetAZs** function.

## Fn::ImportValue

The intrinsic function Fn::ImportValue returns the value of an output exported by another stack. We typically use this function to create cross-stack references.

##### JSON
`{ "Fn::ImportValue" : sharedValueToImport }`

##### Fn::ImportValue: sharedValueToImport
`Fn::ImportValue: sharedValueToImport`

##### short form:
`!ImportValue sharedValueToImport`

#### Parameters
* sharedValueToImport
The stack output value that you want to import.

#### Return Value
The stack output value.

_We can't use the short form of !ImportValue when it contains a !Sub in YAML format_

#### Example:

Stack A:

```
"Outputs" : {
  "PublicSubnet" : {
    "Description" : "The subnet ID to use for public web servers",
    "Value" :  { "Ref" : "PublicSubnet" },
    "Export" : { "Name" : {"Fn::Sub": "${AWS::StackName}-SubnetID" }}
  },
  "WebServerSecurityGroup" : {
    "Description" : "The security group ID to use for public web servers",
    "Value" :  { "Fn::GetAtt" : ["WebServerSecurityGroup", "GroupId"] },
    "Export" : { "Name" : {"Fn::Sub": "${AWS::StackName}-SecurityGroupID" }}
  }
}
```

Stack B:

```
"Resources" : {
  "WebServerInstance" : {
    "Type" : "AWS::EC2::Instance",
    "Properties" : {
      "InstanceType" : "t2.micro",
      "ImageId" : "ami-a1b23456",
      "NetworkInterfaces" : [{
        "GroupSet" : [{"Fn::ImportValue" : {"Fn::Sub" : "${NetworkStackNameParameter}-SecurityGroupID"}}],
        "AssociatePublicIpAddress" : "true",
        "DeviceIndex" : "0",
        "DeleteOnTermination" : "true",
        "SubnetId" : {"Fn::ImportValue" : {"Fn::Sub" : "${NetworkStackNameParameter}-SubnetID"}}
      }]
    }
  }
}
```

#### Supported Functions
We can use the following functions in the Fn::ImportValue function. The value of these functions can't depend on a resource.

- Fn::Base64
- Fn::FindInMap
- Fn::If
- Fn::Join
- Fn::Select
- Fn::Split
- Fn::Sub
- Ref

## Fn::Join

The intrinsic function Fn::Join appends a set of values into a single value, separated by the specified delimiter. If a delimiter is the empty string, the set of values are concatenated with no delimiter.

##### JSON
`{ "Fn::Join" : [ "delimiter", [ comma-delimited list of values ] ] }`

##### YAML
`Fn::Join: [ delimiter, [ comma-delimited list of values ] ]`

##### Syntax for the short form:
`!Join [ delimiter, [ comma-delimited list of values ] ]`

#### Parameters
* delimiter
The value you want to occur between fragments. The delimiter will occur between fragments only. It will not terminate the final value.
* ListOfValues
The list of values you want combined.

#### Return Value
The combined string.

#### Supported Functions

* For the Fn::Join delimiter, we cannot use any functions. We must specify a string value.
* For the Fn::Join list of values, we can use the following functions:

- Fn::Base64
- Fn::FindInMap
- Fn::GetAtt
- Fn::GetAZs
- Fn::If
- Fn::ImportValue
- Fn::Join
- Fn::Split
- Fn::Select
- Fn::Sub
- Ref




