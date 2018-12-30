# CloudFormation Templates

An AWS CloudFormation template consists of various AWS resource types, depending on your needs in the infrastructure.

## Template Anatomy

The template consists of various attributes, such as AWSTemplateFormatVersion, Description, Metadata, and Parameters._The Resources section is the only required section._

![CF template structure](img/cf_template_structure.jpeg)

<br>

#### Sample tempalte: in YAML format:

```
---
AWSTemplateFormatVersion: "<version date>"
Description:
  <String>
Metadata:
  <template metadata>
Parameters:
  <set of parameters>
Mappings:
  <set of mappings>
Conditions:
  <set of conditions>
Resources:
  <set of resources>
Outputs:
  <set of outputs>
```

1. **AWSTemplateFormatVersion:** <s>Required</s>. 
*  This is the AWS CloudFormation template version that is not the same as the API or WSDL version. 
*  The latest template format version is 2010-09-09 and is currently the only valid value. 
* This attribute is optional. 

2. **Description:** <s>Required</s>. 
* This defines a text string that describes the template. 
* The Description must follow the AWSTemplateFormatVersion section. 
* The value for the description declaration must be a literal string that is between 0 and 1024 bytes in length. 
* This attribute is optional. The following snippet is an example of a description declaration:
```
Description: >
  Here are some
  details about
  the template.
```
3. **Metadata:** <s>Required</s>. 
* This defines objects that provide additional information about the template. 
* This attribute is optional. 
* For example, we can include template implementation details about specific resources, as shown in the following snippet:
```
Metadata:
  Instances:
    Description: "Information about the instances"
  Databases:
    Description: "Information about the databases"
```    

4. **Parameters:** <s>Required</s>. 
* This defines values to pass to your template at runtime. 
* We can refer to parameters from the Resources and Outputs sections of the template. 
* This attribute is optional.
* _We can have a maximum of 60 parameters in an AWS CloudFormation template._ 
* We can specify a default value to make the parameter optional so that we don’t need to pass in a value when creating a stack; AWS CloudFormation will use the default value.
* For each parameter, we must declare a logical name, which must be alphanumeric and unique among all logical names within the template. 
* _For sensitive parameter values (such as passwords), set the NoEcho property to true._
* Parameter’s Properties:
    1. AllowedPattern
        - A regular expression that represents the patterns you want to allow for String types.
        - Required: No
    2. AllowedValues
        - An array containing the list of values allowed for the parameter.
        - Required: No
    3. ConstraintDescription
        - A string that explains the constraint when the constraint is violated
        - Required: No
        -  For example, without a constraint description, a parameter that has an allowed pattern of [A-Za-z0-9]+ displays the following error message when the user specifies an invalid value:
        `"Malformed input-Parameter MyParameter must match pattern [A-Za-z0-9]+"`
    4. 

5. **Mappings:** <s>Required</s>. This is a mapping of keys and associated values that we can use to specify conditional parameter values. We can match a key to a corresponding value by using the Fn::FindInMap intrinsic function in the Resources and Outputs. This attribute is optional.

6. **Conditions:** <s>Required</s>. This defines conditions that control whether certain resources are created or whether certain resource properties are assigned a value during stack-creation or stack-update. This attribute is optional.

6. **Transform:** This helps simplify template authoring by condensing the expression of AWS infrastructure as code and enabling the reuse of template components.

7. **Resources:** This specifies the stack resources and their properties, such as EC2 and Amazon S3. ***This attribute is required.***

8. **Output:** <s>Required</s>. This describes the values that are returned whenever we view our stack's properties. This attribute is optional.


## Creating a template

All attributes in CloudFormation are not required. Only the Resources attribute should be defined on your CloudFormation template. 

We will create a S3 bucket template which takes bucket name as parameter:

```
AWSTemplateFormatVersion: "2010-09-09"
Description: "mukund-learning-aws-s3-template"
Parameters:
  YourBucketName:
    Description: "Bucket name to be created"
    Type: "String" 
Resources:
  MyBucket:
    Type: "AWS::S3::Bucket"
    Properties:
      AccessControl: "PublicRead"
      BucketName:
        Ref: "YourBucketName"
```        

CLI command to validate template:

```
aws cloudformation validate-template  --template-body file:///Users/mukund_bihari/git/learning/CloudFormation/templates/s3.yaml
{
    "Description": "mukund-learning-aws-s3-template", 
    "Parameters": [
        {
            "NoEcho": false, 
            "Description": "Bucket name to be created", 
            "ParameterKey": "YourBucketName"
        }
    ]
}
```

CLI command to create bucket run in debug mode:

```


$ aws cloudformation create-stack --stack-name my-simple-stack  --template-body file:///Users/mukund_bihari/git/learning/CloudFormation/templates/s3.yaml  --parameters ParameterKey=BucketName,ParameterValue=mukund-learning-aws --debug


2018-12-29 00:49:54,907 - MainThread - awscli.clidriver - DEBUG - CLI version: aws-cli/1.16.37 Python/2.7.15 Darwin/17.7.0 botocore/1.12.27
2018-12-29 00:49:54,908 - MainThread - awscli.clidriver - DEBUG - Arguments entered to CLI: ['cloudformation', 'create-stack', '--stack-name', 'my-simple-stack', '--template-body', 'file:///Users/mukund_bihari/git/learning/CloudFormation/templates/s3.yaml', '--parameters', 'ParameterKey=BucketName,ParameterValue=mukund-learning-aws', '--debug']
2018-12-29 00:49:54,908 - MainThread - botocore.hooks - DEBUG - Event session-initialized: calling handler <function add_scalar_parsers at 0x10bec5b18>
2018-12-29 00:49:54,908 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,908 - MainThread - botocore.hooks - DEBUG - Event session-initialized: calling handler <function register_uri_param_handler at 0x10b7ba2a8>
2018-12-29 00:49:54,908 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,908 - MainThread - botocore.hooks - DEBUG - Event session-initialized: calling handler <function inject_assume_role_provider_cache at 0x10b809c08>
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable credentials_file from defaults.
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable config_file from defaults.
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable metadata_service_timeout from defaults.
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,909 - MainThread - botocore.session - DEBUG - Loading variable metadata_service_num_attempts from defaults.
2018-12-29 00:49:54,913 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,913 - MainThread - botocore.hooks - DEBUG - Event session-initialized: calling handler <function attach_history_handler at 0x10baad140>
2018-12-29 00:49:54,913 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,913 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,913 - MainThread - botocore.session - DEBUG - Loading variable api_versions from defaults.
2018-12-29 00:49:54,914 - MainThread - botocore.loaders - DEBUG - Loading JSON file: /usr/local/aws/lib/python2.7/site-packages/botocore/data/cloudformation/2010-05-15/service-2.json
2018-12-29 00:49:54,925 - MainThread - botocore.hooks - DEBUG - Event service-data-loaded.cloudformation: calling handler <function register_retries_for_service at 0x10b2f27d0>
2018-12-29 00:49:54,925 - MainThread - botocore.handlers - DEBUG - Registering retry handlers for service: cloudformation
2018-12-29 00:49:54,926 - MainThread - botocore.hooks - DEBUG - Event building-command-table.cloudformation: calling handler <function inject_commands at 0x10b9b3320>
2018-12-29 00:49:54,926 - MainThread - botocore.hooks - DEBUG - Event building-command-table.cloudformation: calling handler <function add_waiters at 0x10bed1668>
2018-12-29 00:49:54,932 - MainThread - botocore.loaders - DEBUG - Loading JSON file: /usr/local/aws/lib/python2.7/site-packages/botocore/data/cloudformation/2010-05-15/waiters-2.json
2018-12-29 00:49:54,934 - MainThread - awscli.clidriver - DEBUG - OrderedDict([(u'stack-name', <awscli.arguments.CLIArgument object at 0x10d239390>), (u'template-body', <awscli.arguments.CLIArgument object at 0x10d239890>), (u'template-url', <awscli.arguments.CLIArgument object at 0x10d2398d0>), (u'parameters', <awscli.arguments.ListArgument object at 0x10d239910>), (u'disable-rollback', <awscli.arguments.BooleanArgument object at 0x10d239950>), (u'no-disable-rollback', <awscli.arguments.BooleanArgument object at 0x10d239990>), (u'rollback-configuration', <awscli.arguments.CLIArgument object at 0x10d2399d0>), (u'timeout-in-minutes', <awscli.arguments.CLIArgument object at 0x10d239a10>), (u'notification-arns', <awscli.arguments.ListArgument object at 0x10d239a50>), (u'capabilities', <awscli.arguments.ListArgument object at 0x10d239a90>), (u'resource-types', <awscli.arguments.ListArgument object at 0x10d239ad0>), (u'role-arn', <awscli.arguments.CLIArgument object at 0x10d239b10>), (u'on-failure', <awscli.arguments.CLIArgument object at 0x10d239b50>), (u'stack-policy-body', <awscli.arguments.CLIArgument object at 0x10d239b90>), (u'stack-policy-url', <awscli.arguments.CLIArgument object at 0x10d239bd0>), (u'tags', <awscli.arguments.ListArgument object at 0x10d239c10>), (u'client-request-token', <awscli.arguments.CLIArgument object at 0x10d239c50>), (u'enable-termination-protection', <awscli.arguments.BooleanArgument object at 0x10d239c90>), (u'no-enable-termination-protection', <awscli.arguments.BooleanArgument object at 0x10d239d50>)])
2018-12-29 00:49:54,934 - MainThread - botocore.hooks - DEBUG - Event building-argument-table.cloudformation.create-stack: calling handler <function add_streaming_output_arg at 0x10bec5de8>
2018-12-29 00:49:54,934 - MainThread - botocore.hooks - DEBUG - Event building-argument-table.cloudformation.create-stack: calling handler <function add_cli_input_json at 0x10b80dc08>
2018-12-29 00:49:54,935 - MainThread - botocore.hooks - DEBUG - Event building-argument-table.cloudformation.create-stack: calling handler <function unify_paging_params at 0x10bb52938>
2018-12-29 00:49:54,940 - MainThread - botocore.loaders - DEBUG - Loading JSON file: /usr/local/aws/lib/python2.7/site-packages/botocore/data/cloudformation/2010-05-15/paginators-1.json
2018-12-29 00:49:54,940 - MainThread - botocore.hooks - DEBUG - Event building-argument-table.cloudformation.create-stack: calling handler <function add_generate_skeleton at 0x10bb3b2a8>
2018-12-29 00:49:54,941 - MainThread - botocore.hooks - DEBUG - Event before-building-argument-table-parser.cloudformation.create-stack: calling handler <bound method CliInputJSONArgument.override_required_args of <awscli.customizations.cliinputjson.CliInputJSONArgument object at 0x10d239dd0>>
2018-12-29 00:49:54,941 - MainThread - botocore.hooks - DEBUG - Event before-building-argument-table-parser.cloudformation.create-stack: calling handler <bound method GenerateCliSkeletonArgument.override_required_args of <awscli.customizations.generatecliskeleton.GenerateCliSkeletonArgument object at 0x10d239f50>>
2018-12-29 00:49:54,942 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.stack-name: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,942 - MainThread - botocore.hooks - DEBUG - Event process-cli-arg.cloudformation.create-stack: calling handler <awscli.argprocess.ParamShorthandParser object at 0x10b7e7510>
2018-12-29 00:49:54,942 - MainThread - awscli.arguments - DEBUG - Unpacked value of u'my-simple-stack' for parameter "stack_name": u'my-simple-stack'
2018-12-29 00:49:54,943 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.template-body: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,943 - MainThread - botocore.hooks - DEBUG - Event process-cli-arg.cloudformation.create-stack: calling handler <awscli.argprocess.ParamShorthandParser object at 0x10b7e7510>
2018-12-29 00:49:54,943 - MainThread - awscli.arguments - DEBUG - Unpacked value of u'AWSTemplateFormatVersion: "2010-09-09"\nDescription: "mukund-learning-aws-s3-template"\nParameters:\n  BucketName:\n    Description: "Bucket name to be created"\n    Type: "String" \nResources:\n  MyBucket:\n    Type: "AWS::S3::Bucket"\n    Properties:\n      AccessControl: "PublicRead"\n      BucketName:\n        Ref: "BucketName"' for parameter "template_body": u'AWSTemplateFormatVersion: "2010-09-09"\nDescription: "mukund-learning-aws-s3-template"\nParameters:\n  BucketName:\n    Description: "Bucket name to be created"\n    Type: "String" \nResources:\n  MyBucket:\n    Type: "AWS::S3::Bucket"\n    Properties:\n      AccessControl: "PublicRead"\n      BucketName:\n        Ref: "BucketName"'
2018-12-29 00:49:54,944 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.template-url: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,944 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.parameters: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,944 - MainThread - botocore.hooks - DEBUG - Event process-cli-arg.cloudformation.create-stack: calling handler <awscli.argprocess.ParamShorthandParser object at 0x10b7e7510>
2018-12-29 00:49:54,944 - MainThread - awscli.argprocess - DEBUG - Parsing param --parameters as shorthand
2018-12-29 00:49:54,944 - MainThread - awscli.arguments - DEBUG - Unpacked value of [u'ParameterKey=BucketName,ParameterValue=mukund-learning-aws'] for parameter "parameters": [{u'ParameterValue': u'mukund-learning-aws', u'ParameterKey': u'BucketName'}]
2018-12-29 00:49:54,945 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.disable-rollback: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,945 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.rollback-configuration: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,945 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.timeout-in-minutes: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,945 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.notification-arns: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,945 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.capabilities: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,945 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.resource-types: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.role-arn: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.on-failure: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.stack-policy-body: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.stack-policy-url: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.tags: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.client-request-token: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,946 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.enable-termination-protection: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,947 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.cli-input-json: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,947 - MainThread - botocore.hooks - DEBUG - Event load-cli-arg.cloudformation.create-stack.generate-cli-skeleton: calling handler <awscli.paramfile.URIArgumentHandler object at 0x10bfedd50>
2018-12-29 00:49:54,947 - MainThread - botocore.hooks - DEBUG - Event calling-command.cloudformation.create-stack: calling handler <bound method CliInputJSONArgument.add_to_call_parameters of <awscli.customizations.cliinputjson.CliInputJSONArgument object at 0x10d239dd0>>
2018-12-29 00:49:54,947 - MainThread - botocore.hooks - DEBUG - Event calling-command.cloudformation.create-stack: calling handler <bound method GenerateCliSkeletonArgument.generate_json_skeleton of <awscli.customizations.generatecliskeleton.GenerateCliSkeletonArgument object at 0x10d239f50>>
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable region from config file with value 'us-east-1'.
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable ca_bundle from defaults.
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,947 - MainThread - botocore.session - DEBUG - Loading variable api_versions from defaults.
2018-12-29 00:49:54,947 - MainThread - botocore.credentials - DEBUG - Looking for credentials via: env
2018-12-29 00:49:54,947 - MainThread - botocore.credentials - DEBUG - Looking for credentials via: assume-role
2018-12-29 00:49:54,947 - MainThread - botocore.credentials - DEBUG - Looking for credentials via: shared-credentials-file
2018-12-29 00:49:54,947 - MainThread - botocore.credentials - INFO - Found credentials in shared credentials file: ~/.aws/credentials
2018-12-29 00:49:54,948 - MainThread - botocore.loaders - DEBUG - Loading JSON file: /usr/local/aws/lib/python2.7/site-packages/botocore/data/endpoints.json
2018-12-29 00:49:54,964 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:54,964 - MainThread - botocore.hooks - DEBUG - Event choose-service-name: calling handler <function handle_service_name_alias at 0x10b2ebf50>
2018-12-29 00:49:54,966 - MainThread - botocore.hooks - DEBUG - Event creating-client-class.cloudformation: calling handler <function add_generate_presigned_url at 0x10b2a85f0>
2018-12-29 00:49:54,967 - MainThread - botocore.args - DEBUG - The s3 config key is not a dictionary type, ignoring its value of: None
2018-12-29 00:49:54,969 - MainThread - botocore.endpoint - DEBUG - Setting cloudformation timeout as (60, 60)
2018-12-29 00:49:54,971 - MainThread - botocore.client - DEBUG - Registering retry handlers for service: cloudformation
2018-12-29 00:49:54,972 - MainThread - botocore.hooks - DEBUG - Event before-parameter-build.cloudformation.CreateStack: calling handler <function generate_idempotent_uuid at 0x10b2f2230>
2018-12-29 00:49:54,973 - MainThread - botocore.endpoint - DEBUG - Making request for OperationModel(name=CreateStack) with params: {'body': {u'Parameters.member.1.ParameterKey': u'BucketName', u'TemplateBody': u'AWSTemplateFormatVersion: "2010-09-09"\nDescription: "mukund-learning-aws-s3-template"\nParameters:\n  BucketName:\n    Description: "Bucket name to be created"\n    Type: "String" \nResources:\n  MyBucket:\n    Type: "AWS::S3::Bucket"\n    Properties:\n      AccessControl: "PublicRead"\n      BucketName:\n        Ref: "BucketName"', u'StackName': u'my-simple-stack', 'Version': u'2010-05-15', 'Action': u'CreateStack', u'Parameters.member.1.ParameterValue': u'mukund-learning-aws'}, 'url': u'https://cloudformation.us-east-1.amazonaws.com/', 'headers': {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8', 'User-Agent': 'aws-cli/1.16.37 Python/2.7.15 Darwin/17.7.0 botocore/1.12.27'}, 'context': {'auth_type': None, 'client_region': 'us-east-1', 'has_streaming_input': False, 'client_config': <botocore.config.Config object at 0x10d8a7890>}, 'query_string': '', 'url_path': '/', 'method': u'POST'}
2018-12-29 00:49:54,973 - MainThread - botocore.hooks - DEBUG - Event request-created.cloudformation.CreateStack: calling handler <bound method RequestSigner.handler of <botocore.signers.RequestSigner object at 0x10d8a7850>>
2018-12-29 00:49:54,973 - MainThread - botocore.hooks - DEBUG - Event choose-signer.cloudformation.CreateStack: calling handler <function set_operation_specific_signer at 0x10b2f2140>
2018-12-29 00:49:54,973 - MainThread - botocore.auth - DEBUG - Calculating signature using v4 auth.
2018-12-29 00:49:54,974 - MainThread - botocore.auth - DEBUG - CanonicalRequest:
POST
/

content-type:application/x-www-form-urlencoded; charset=utf-8
host:cloudformation.us-east-1.amazonaws.com
x-amz-date:20181228T191954Z

content-type;host;x-amz-date
18da3b0f09e87ec79bdd9a1bf19cc02990e8df478797d7ccf04ae32a09beb0cd
2018-12-29 00:49:54,974 - MainThread - botocore.auth - DEBUG - StringToSign:
AWS4-HMAC-SHA256
20181228T191954Z
20181228/us-east-1/cloudformation/aws4_request
00484ce833a3ad25971db2ca8cb9019dabb053c30a397710d495453f1fc84ce3
2018-12-29 00:49:54,974 - MainThread - botocore.auth - DEBUG - Signature:
9bd9c1444304704cbabc665cccf9aca7c600d85ffafd20973c4f004e2c51d284
2018-12-29 00:49:54,974 - MainThread - botocore.endpoint - DEBUG - Sending http request: <AWSPreparedRequest stream_output=False, method=POST, url=https://cloudformation.us-east-1.amazonaws.com/, headers={'Content-Length': '583', 'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8', 'Authorization': 'AWS4-HMAC-SHA256 Credential=AKIAIQQ5QFP5TC7MFBHA/20181228/us-east-1/cloudformation/aws4_request, SignedHeaders=content-type;host;x-amz-date, Signature=9bd9c1444304704cbabc665cccf9aca7c600d85ffafd20973c4f004e2c51d284', 'X-Amz-Date': '20181228T191954Z', 'User-Agent': 'aws-cli/1.16.37 Python/2.7.15 Darwin/17.7.0 botocore/1.12.27'}>
2018-12-29 00:49:56,672 - MainThread - botocore.parsers - DEBUG - Response headers: {'x-amzn-RequestId': '8f89df8e-0ad5-11e9-9a18-af93a0c83685', 'Date': 'Fri, 28 Dec 2018 19:19:56 GMT', 'Content-Length': '385', 'Content-Type': 'text/xml'}
2018-12-29 00:49:56,673 - MainThread - botocore.parsers - DEBUG - Response body:
<CreateStackResponse xmlns="http://cloudformation.amazonaws.com/doc/2010-05-15/">
  <CreateStackResult>
    <StackId>arn:aws:cloudformation:us-east-1:825796472415:stack/my-simple-stack/8f92dfb0-0ad5-11e9-a2ae-0af1b2bb447e</StackId>
  </CreateStackResult>
  <ResponseMetadata>
    <RequestId>8f89df8e-0ad5-11e9-9a18-af93a0c83685</RequestId>
  </ResponseMetadata>
</CreateStackResponse>

2018-12-29 00:49:56,673 - MainThread - botocore.hooks - DEBUG - Event needs-retry.cloudformation.CreateStack: calling handler <botocore.retryhandler.RetryHandler object at 0x10bff9e90>
2018-12-29 00:49:56,673 - MainThread - botocore.retryhandler - DEBUG - No retry needed.
2018-12-29 00:49:56,673 - MainThread - botocore.session - DEBUG - Loading variable profile from defaults.
2018-12-29 00:49:56,673 - MainThread - botocore.session - DEBUG - Loading variable output from defaults.
2018-12-29 00:49:56,674 - MainThread - awscli.formatter - DEBUG - RequestId: 8f89df8e-0ad5-11e9-9a18-af93a0c83685
{
    "StackId": "arn:aws:cloudformation:us-east-1:825796472415:stack/my-simple-stack/8f92dfb0-0ad5-11e9-a2ae-0af1b2bb447e"
}

```

## Selecting the input from options

[ec2.yaml](templates/ec2.yaml)

```
AWSTemplateFormatVersion: "2010-09-09"
Description: "EC2 instance creation"
Parameters:
  InstanceType: 
    Description: "EC2 instance type"
    Type: "String"
    Default: "t2.nano"
    AllowedValues: [
        "t1.micro",
        "t2.micro",
        "t2.nano",
        "t2.small"
    ]
    ConstraintDescription: "must be a valid EC2 instance type"
Resources:
  MyEC2Instance:
    Type: "AWS::EC2::Instance"
    Properties:
      InstanceType:
        Ref: "InstanceType"
      ImageId: "ami-6869aa05"
```

**Validation:**

```
$ aws cloudformation validate-template  --template-body file:///Users/mukund_bihari/git/learning/CloudFormation/templates/ec2.yaml
{
    "Description": "EC2 instance creation", 
    "Parameters": [
        {
            "DefaultValue": "t2.nano", 
            "NoEcho": false, 
            "Description": "EC2 instance type", 
            "ParameterKey": "InstanceType"
        }
    ]
}
```

**Stack creation:**

```
$ aws cloudformation create-stack --stack-name my-ec2-stack  --template-body file:///Users/mukund_bihari/git/learning/CloudFormation/templates/ec2.yaml  --parameters ParameterKey=InstanceType,ParameterValue="t2.micro" 
{
    "StackId": "arn:aws:cloudformation:us-east-1:825796472415:stack/my-ec2-stack/6fc41320-0ada-11e9-aa83-0e23c20390b0"
}
```

We won't be able to SSH to the ec2-instance creation as we do not have binded it with nay key-pair.








