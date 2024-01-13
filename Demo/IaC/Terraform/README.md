# Terraform

HashiCorp Terraform is an open-source infrastructure as code software tool that enables you to safely and predictably 
create, change, and improve infrastructure. Terraform can manage existing and popular service providers as well as 
custom in-house solutions.

The benefits of using Terraform include:
- One unified workflow end to end
- Over 100 providers
## Architecture
Terraform uses a declarative language called HashiCorp Configuration Language (HCL) to define the infrastructure. The core
takes the terraform of config and state, figures out the resources, and then communicate with providers to create or manage the resources.
When working with Terraform, the first step to take is to terraform init within a folder to initialize a working directory. Next, the following
commands can be used to interact with Terraform:
- **Terraform refresh** is used to query the current state of the infrastructure. 
- **Terraform plan** is used to create an execution plan that previews changes being made (terraform figures out what needs to be done).
- **Terraform apply** is used to apply the changes required to reach the desired state of the configuration.
- **Terraform validate** is used to validate the configuration files in a directory, referring only to the configuration and 
not accessing any remote services such as remote state, provider APIs, etc.
- **Terraform destroy** is used to destroy the Terraform-managed infrastructure.
- **Terraform fmt** is used to rewrite Terraform configuration files to a canonical format and style.
Terraform can figure out what dependencies exist between resources and in what order to create or destroy them.

All state changes are reflected in the ```terraform.tfstate``` file. This file is used to map real world resources to your configuration.
For those familiar with Amazon CloudFormation (CFN), terraform plan is similar to change sets and terraform apply is similar to
deploying the change sets/ stack creation.
## Common Use Cases
- Infrastructure as Code in Cloud Providers
- Platform as a Service
- Monitoring solutions such as Terraform
- Kubernetes
## Resources
- [Introduction to Terraform AWS workshop](https://catalog.us-east-1.prod.workshops.aws/workshops/41c5a1b6-bd3e-41f4-bd46-85ab7dc6dad4/en-US/2-fundamentals )
- [Terraform](https://www.terraform.io/)