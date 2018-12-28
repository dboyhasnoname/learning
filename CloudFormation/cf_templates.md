# CloudFormation Templates

An AWS CloudFormation template consists of various AWS resource types, depending on your needs in the infrastructure.

The template consists of various attributes, such as AWSTemplateFormatVersion, Description, Metadata, and Parameters:

![CF template structure](img/cf_template_structure.jpeg)

<br>

1. **AWSTemplateFormatVersion:** <s>Required</s>. This is the AWS CloudFormation template version that is not the same as the API or WSDL version. This attribute is optional. 

2. **Description:** <s>Required</s>. This defines a text string that describes the template. This attribute is optional.

3. **Metadata:** <s>Required</s>. This defines objects that provide additional information about the template. This attribute is optional.

4. **Parameters:** <s>Required</s>. This defines values to pass to your template at runtime. You can refer to parameters from the Resources and Outputs sections of the template. This attribute is optional.

5. **Mappings:** <s>Required</s>. This is a mapping of keys and associated values that you can use to specify conditional parameter values. This attribute is optional.

6. **Conditions:** <s>Required</s>. This defines conditions that control whether certain resources are created or whether certain resource properties are assigned a value during stack-creation or stack-update. This attribute is optional.

6. **Transform:** This helps simplify template authoring by condensing the expression of AWS infrastructure as code and enabling the reuse of template components.

7. **Resources:** This specifies the stack resources and their properties, such as EC2 and Amazon S3. ***This attribute is required.***

8. **Output:** T<s>Required</s>. his describes the values that are returned whenever you view your stack's properties. This attribute is optional.