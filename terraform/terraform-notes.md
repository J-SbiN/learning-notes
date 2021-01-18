# Terraform
*Terraform* is an application to manage infrastructure. It is based on the idea of infrastructure described as code.

*Terraform* gathers a series of APIs so you can centralize/decentralize and abstract multiple services (such as AWS, Azure, Google Cloud, ...) and manage them with terraform commands.

Terraform as a specific syntax to describe infrastructure as code - but it also parses json as input infrastructure description. 
___
---
\
\
\
\
\.





# How it works


## Types of Files
Once Terraform is operating in a directory, that directory may contain the following types of files:
- ```configuration files``` - human readable input code descriptions of a desired state for the infrastructure.
    - ```resource cofig files```
        - All the files with the ```*.tf``` file type extension.
        - Typical there exists a ```main.tf```.
    - ```variables files```
        - all files with the ```*.tfvars``` or ```*.auto.tfvars``` filetype extension are automatically loaded by *Terraform*.
        - any file can be included as a variables file if you use the ```-var-file``` flag.
- ```status files``` - a description of the actual current state of the infrastructure. These is called ```terraform.tfstate(.backup)```.
- ```plan files``` - a file containing the actions necessary to transform the infrastructure from its current state into the state defined in the configuration file.
    - You'll need to explicitly require these;
    - You can name them freely.
- *```Terraform```* ```files```
    - ```.terraform.lock.hcl``` - a lockfile for terraform to workflow control avoiding overlapping.
    - ```.terraform directory``` - directories which mainly refer to providers APIs. 



## Basic Operation
*Terraform* as a simple iterative approach to infrastructure management.

You start by describing your infrastructure than, prior to implement it, you check what is already operating and plan the necessary changes to get your infrastructure to the desired description. After planning you may actually implement your infrastructure.

This approach makes it possible to loop over `description -> planning -> applying` virtually *ad aeternum*.

You can also enquire about the current state of the infrastructure or destroy it at any time.

The geeral flowsteps are described below:

### Required files
Before you actually initialize terraform you need to create at least one configuration file (it is usually named ```main.tf```)  inside the directory where you want to initialize. Ex.:

    mkdir -pf <path-to-create-your-dir> && cd ${_}; \
    touch main.tf && vim ${_}  # place some configs in there

### Initialize:
To initialize Terraform on a directory, you get into that directory and run:

    terraform init
Terraform will create at least one ```.terraform.lock.hcl*``` lockfile. These lock files are maintained by terraform or its providers.
Note that, for a successful initialization, you'll need to have the providers, called in your configuration files, correctly configured. According to the provider your configuration requires, terraform will fetch the necessary APIs and dependencies into ```.terraform```.

### Validate
Before proceeding, you may ask terraform to validate your configuration. This is a good practice - run:

    terraform validate

This will check your configuration files for syntax errors and some logical issues such as repetitions/concurrency and undefined implicit dependencies.

NOte that all files with a ```*.tf``` filetype will be loaded. These are considered alphabetically by file name.

### Plan:
Once you have finished editing your configurations and successfully ran the initialization, you can run:

    terraform plan

Terraform will design a plan containing the necessary actions to implement your infrastructure and present it to you. You can have the plan exported to a file using the parameter ```-out=<file_name>```.

### Apply
To apply the latest result of the plan command changes you can simply run:

    terraform apply

This actually creates the real world infrastructure. If you want to apply a specific plan.

### Destroy
At any point you can destroy your infrastructure in a programmatic fashion - just run: 

    terraform destroy
and *Terraform* wil make sure every component gets destroyed in the correct order.

### Show
At any point you can enquire about the current state of your infrastructure, or about the changes to be implemented by given plan - just run:

    terraform show [path-to-file]
If no ```[path-to-file]``` is provided, *Terraform* will present you with the contents of the ```terraform.tfstate``` file on the present directory.
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
- Providers
- Variables


        - if a variable is not defined and has no default, *Terraform* will prompt the user to input a value.
        - some variable types have built-in type verification.



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
