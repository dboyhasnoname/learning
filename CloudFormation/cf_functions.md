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

#### JSON

`{ "Fn::Base64" : valueToEncode }`

#### YAML

`Fn::Base64: valueToEncode`

## Fn::Cidr

The intrinsic function Fn::Cidr returns an array of CIDR(Classless Inter-Domain Routing, sometimes called supernetting) address blocks. The number of CIDR blocks returned is dependent on the count parameter.

We can use the following functions in a Fn::Cidr function:
1. Fn::Select
2. Ref
3. Fn::GetAtt

It returns an array of CIDR address blocks.

#### JSON

`{ "Fn::Cidr" : [ipBlock, count, cidrBits]}`

<br>

`{ "Fn::Cidr" : [ "192.168.0.0/24", "6", "5"] }`

#### YAML

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

## Condition Functions

1. Fn::And
2. Fn::Equals
3. Fn::If
4. Fn::Not
5. Fn::Or

 These conditions are evaluated based on input parameters that we declare when we create or update a stack. After we define all our conditions, we can associate them with resources or resource properties in the Resources and Outputs sections of a template.

#### Associating a Condition

To conditionally create resources, resource properties, or outputs, you must associate a condition with them. Add the Condition: key and the logical ID of the condition as an attribute to associate a condition.

##### JSON

```
"NewVolume" : {
  "Type" : "AWS::EC2::Volume",
  "Condition" : "CreateProdResources",
  "Properties" : {
     "Size" : "100",
     "AvailabilityZone" : { "Fn::GetAtt" : [ "EC2Instance", "AvailabilityZone" ]}
}  
```

#### YAML

```
NewVolume:
  Type: "AWS::EC2::Volume"
  Condition: CreateProdResources
  Properties: 
    Size: 100
    AvailabilityZone: !GetAtt EC2Instance.AvailabilityZone
```

We can also use conditions inside other conditions. The following snippet is from the Conditions section of a template. The MyAndCondition condition includes the SomeOtherCondition condition:

#### JSON

```
"MyAndCondition": {
   "Fn::And": [
      {"Fn::Equals": ["sg-mysggroup", {"Ref": "ASecurityGroup"}]},
      {"Condition": "SomeOtherCondition"}
   ]
}
```

#### YAML

```
MyAndCondition: !And
  - !Equals ["sg-mysggroup", !Ref "ASecurityGroup"]
  - !Condition SomeOtherCondition
```

#### Fn::If function: 
- only need to specify the condition name.
___

- Returns one value if the specified condition evaluates to true and another value if the specified condition evaluates to false. 
- Currently, AWS CloudFormation supports the Fn::If intrinsic function in the metadata attribute, update policy attribute, and property values in the Resources section and Outputs sections of a template. 
- We can use the AWS::NoValue pseudo parameter as a return value to remove the corresponding property.

____

##### JSON

```
"Fn::If": [condition_name, value_if_true, value_if_false]
```

```
"NewVolume" : {
  "Type" : "AWS::EC2::Volume",
  "Properties" : {
    "Size" : {
      "Fn::If" : [
        "CreateLargeSize",
        "100",
        "10"
      ]},
    "AvailabilityZone" : { "Fn::GetAtt" : [ "Ec2Instance", "AvailabilityZone" ]}
  },
  "DeletionPolicy" : "Snapshot"
}
```

##### YAML
```
Fn::If: [condition_name, value_if_true, value_if_false]
```
```
NewVolume:
  Type: "AWS::EC2::Volume"
  Properties: 
    Size: 
      !If [CreateLargeSize, 100, 10]
    AvailabilityZone: !GetAtt: Ec2Instance.AvailabilityZone
  DeletionPolicy: Snapshot
```

Short form syntax:

`!If [condition_name, value_if_true, value_if_false]`

We  can use the following functions in the Fn::If condition:

* Fn::Base64
* Fn::FindInMap
* Fn::GetAtt
* Fn::GetAZs
* Fn::If
* Fn::Join
* Fn::Select
* Fn::Sub
* Ref

#### Fn::And: 
Returns true if all the specified conditions evaluate to true, or returns false if any one of the conditions evaluates to false. Fn::And acts as an AND operator. The minimum number of conditions that you can include is 2, and the maximum is 10.

##### JSON
```
"MyAndCondition": {
   "Fn::And": [
      {"Fn::Equals": ["sg-mysggroup", {"Ref": "ASecurityGroup"}]},
      {"Condition": "SomeOtherCondition"}
   ]
}
```

##### YAML
```
MyAndCondition: !And
  - !Equals ["sg-mysggroup", !Ref ASecurityGroup]
  - !Condition SomeOtherCondition
```

#### Fn::Equals: 
Compares if two values are equal. Returns true if the two values are equal or false if they aren't.

##### JSON
```
"UseProdCondition" : {
   "Fn::Equals": [
      {"Ref": "EnvironmentType"},
      "prod"
   ]
}
```

#### YAML
```
UseProdCondition:
  !Equals [!Ref EnvironmentType, prod]
```

#### Fn::Not:

Returns true for a condition that evaluates to false or returns false for a condition that evaluates to true. Fn::Not acts as a NOT operator.

##### JSON

```
"Fn::Not": [{condition}]
```
```"MyNotCondition" : {
   "Fn::Not" : [{
      "Fn::Equals" : [
         {"Ref" : "EnvironmentType"},
         "prod"
      ]
   }]
}
```

##### YAML

```
Fn::Not: [condition]
```
```
MyNotCondition:
  !Not [!Equals [!Ref EnvironmentType, prod]]
```

Syntax for the short form:
`!Not [condition]`

#### Fn::Or:

Returns true if any one of the specified conditions evaluate to true, or returns false if all of the conditions evaluates to false. Fn::Or acts as an OR operator. The minimum number of conditions that you can include is 2, and the maximum is 10.

##### JSON
```
"Fn::Or": [{condition}, {...}]
```
```
"MyOrCondition" : {
   "Fn::Or" : [
      {"Fn::Equals" : ["sg-mysggroup", {"Ref" : "ASecurityGroup"}]},
      {"Condition" : "SomeOtherCondition"}
   ]
}
```

##### YAML
```
Fn::Or: [condition, ...]
```
```
MyOrCondition:
  !Or [!Equals [sg-mysggroup, !Ref ASecurityGroup], Condition: SomeOtherCondition]
```

Syntax for the short form:
`!Or [condition, ...]`






