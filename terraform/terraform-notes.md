# Terraform
Terraform is an application to manage infrastructure described as code.
Terraform gathers a series of APIs so you can centralize and abstract inumerous services (such as AWS, Azure, Google Cloud, ...) and manage them with terraform commands.
Terraform as a specific syntax to describe infrastructure as code - but it also parses json. 
___
---
\
\
\
\
\.





# How it works

## Types of Files
Once Terraform is operating in a directory, that directory will contain the following types of files:
- ```configuration files``` - human input code descriptions of a desired state for the inrastructure.
    - ```main.tf``` - 
- ```status files``` - a code description of the actuall current state of the infrastructure.
- ```plan files``` - a binary file containing the actions necessary to carry the current state of your infrastructure into the state defined in the configuration file.

## Basic Operation
### Working files
Before you actully initialize terraform you need to create at least one configurtion file named ```main.tf```.
### Validate
Before proceeding, you may ask terraform to validate your configuration - run:

    terraform validate
This will validate your configuration starting on ```main.tf``` and 'pre-compile' all the configuration files. 
### Initialize:
To initialize Terrafor on a directory, you get into that directory and run:

    terraform init
Terraform will create at least one ```.terraform.lock.hcl*``` lockfile. These lock files are mantained by terraform or its providers.
Note that for a successfull initialization you'll need to have the providers, called in your configuration files, currectly configured. According to the provider your configuration requires, terraform will fetch the necessary APIs and dependencies into ```.terraform```.
### Plan:
Once you have finished editing your configurations and successfully ran the initialization, you can run:

    terraform plan
Terraform will design a plan containig the necessary actions to implement your infrastructure and present it to you. You can have the plan exported to a file using the parameter ``` -out=<file_name> ```.
### Apply
    terraform apply

    terraform destroy
---
\
\
\
\
\.





# Syntax
Althogh Terraform supports json, its native language is HCL.

HCL's has the following syntax concepts:
- Coments
- Arguments
- Blocks
- Identifiers



## Some Reminders:
- Delimiters are allways ASCII characters
- Non-ASCII values are accepted in identifiers, strings and comments 
- Configuration files must alway be encoded as UTF-8
- Both Unix and Windows Line endings are accepted
---
\
\
\
\
\.





#  References
- https://www.terraform.io/
- https://www.terraform.io/docs/configuration/syntax/index.html
- Syntax: https://github.com/hashicorp/hcl/blob/hcl2/hclsyntax/spec.md
---
\
\
\.
___
---
