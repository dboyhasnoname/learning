# CLoudFormation Templates

An AWS CloudFormation template consists of various AWS resource types, depending on your needs in the infrastructure.

The template consists of various attributes, such as AWSTemplateFormatVersion, Description, Metadata, and Parameters:

![CF template structure](img/cf_template_structure.jpeg)

<br>

1. **AWSTemplateFormatVersion:** This is the AWS CloudFormation template version that is not the same as the API or WSDL version. <s>This attribute is optional.</s>

2. **Description:** This defines a text string that describes the template. <s>This attribute is optional.</s>

3. **Metadata:** This defines objects that provide additional information about the template. <s>This attribute is optional.</s>

4. **Parameters:** This defines values to pass to your template at runtime. You can refer to parameters from the Resources and Outputs sections of the template. <s>This attribute is optional.</s>

5. **Mappings:** This is a mapping of keys and associated values that you can use to specify conditional parameter values. <s>This attribute is optional.</s>

6. **Conditions:** This defines conditions that control whether certain resources are created or whether certain resource properties are assigned a value during stack-creation or stack-update. <s>This attribute is optional.</s>

6. **Transform:** This helps simplify template authoring by condensing the expression of AWS infrastructure as code and enabling the reuse of template components.

7. **Resources:** This specifies the stack resources and their properties, such as EC2 and Amazon S3. ***This attribute is required.***

8. **Output:** This describes the values that are returned whenever you view your stack's properties. <s>This attribute is optional.</s>

