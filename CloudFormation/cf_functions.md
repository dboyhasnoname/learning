# Working with intrinsic functions

Intrinsic functions enable us to put logic functions inside CloudFormation templates.

The following is a list of intrinsic functions:

1. Fn::Base64 
2. Fn::Cidr
3. Condition Functions
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

### JSON

`{ "Fn::Base64" : valueToEncode }`

## YAML

`Fn::Base64: valueToEncode`

## Fn::Cidr

The intrinsic function Fn::Cidr returns an array of CIDR(Classless Inter-Domain Routing, sometimes called supernetting) address blocks. The number of CIDR blocks returned is dependent on the count parameter.

We can use the following functions in a Fn::Cidr function:
1. Fn::Select
2. Ref
3. Fn::GetAtt

It returns an array of CIDR address blocks.

### JSON

`{ "Fn::Cidr" : [ipBlock, count, cidrBits]}`
`{ "Fn::Cidr" : [ "192.168.0.0/24", "6", "5"] }`

###YAML

```
Fn::Cidr: 
  - ipBlock  # user-specified CIDR address block to be split into smaller CIDR blocks.
  - count    # number of CIDRs to generate. Valid range is between 1 and 256.
  - cidrBits # number of subnet bits for the CIDR. For example, specifying a value "8" for this parameter will create a CIDR with a mask of "/24".
```

`!Cidr [ "192.168.0.0/24", 6, 5 ]`

Syntax for shot form:

`!Cidr [ ipBlock, count, cidrBits ]`

example:

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



