# Infrastructure

The MTS infrastructure is all built using the Infrastructure as Code DevOps principles, allowing new infrastructure to be provisioned and applications to be released without manual intervention.  The infrastructure code is stored in a Git repository which enables reuse, versioning and history and executed using the MTS Jenkins instances.

Amazon [AWS](https://aws.amazon.com) is used for hosting both the production environment and the various pre-production environments.  Predominantly two accounts are used, a Production account which contains production sensitive data and a Development account containing anonymised data.  Access to the Production account is limited to Technical Service Support (TSS), wheras access to the Development account is open to all of the engineering teams as required.

DVSA has a Technical Steering Group (TSG) whos role is to standardise technologies across multiple DVSA projects (rather than just MTS).  The TSGs position on infrastructure is to focus on AWS as a service provider, utilising the most appropriate AWS products for the requirements.

A large proportion of the MTS infrastructure is provisioned on [AWS EC2](https://aws.amazon.com/ec2) instances of various sizes, with the size depending on the usage requirements.  Where a clear business benefit is seen MTS are trying to move towards a serverless infrastruture using [AWS Lambda](https://aws.amazon.com/lambda).