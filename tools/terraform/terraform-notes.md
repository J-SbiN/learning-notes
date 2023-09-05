# Terraform
*Terraform* is an application to manage infrastructure. It is based on the idea of infrastructure described as code.

*Terraform* gathers a series of APIs so you can centralize/decentralize and abstract multiple services (such as AWS, Azure, Google Cloud, ...) and manage them in a single environment.

Terraform as a specific syntax to describe infrastructure as code - but it also parses json as input infrastructure description. 
___
---
\
\
\
\
\.





# How it works

## Files Organization
Once Terraform is operating in a directory, that directory may contain the following types of files:
- `configuration files` - human readable input code descriptions of a desired state for the infrastructure.
    - `resource cofig files`
        - All the files with the `*.tf` and `*.tf.json` file type extension.
        - Typical there exists a `main.tf`.
    - `variables files`
        - all files with the `*.tfvars` or `*.auto.tfvars` filetype extension are automatically loaded by *Terraform*.
        - any file can be included as a variables file if you use the `-var-file` flag.
- `status files` - a description of the actual current state of the infrastructure. These is called `terraform.tfstate(.backup)`.
- `plan files` - a file containing the actions necessary to transform the infrastructure from its current state into the state defined in the configuration file.
    - You'll need to explicitly require these;
    - You can name them freely.
- *`Terraform`* `files`
    - `.terraform.lock.hcl` - a lockfile for terraform to workflow control avoiding overlapping.
    - `.terraform directory` - directories which mainly refer to providers APIs. 

The set of configuration files in a specific directory is called a *module*. The files contained in distinct or nested directories are separated modules. Terraform only considers *sub-modules* if they are called on the *root module*.


## Basic Operation
*Terraform* as a simple iterative approach to infrastructure management.

You start by describing your infrastructure than, prior to implement it, you check what is already operating and plan the necessary changes to get your infrastructure to the desired description. After planning you may actually implement your infrastructure.

This approach makes it possible to loop over `description -> planning -> applying` virtually *ad aeternum*.

You can also enquire about the current state of the infrastructure or destroy it at any time.

The general flow steps are described below:

### Required files
Before you actually initialize terraform you need to create at least one configuration file (it is usually named `main.tf`)  inside the directory where you want to initialize. Ex.:

    mkdir -pf <path-to-create-your-dir> && cd ${_}; \
    touch main.tf && vim ${_}  # place some configs in there

### Initialize:
To initialize Terraform on a directory, you get into that directory and run:

    terraform init
Terraform will create at least one `.terraform.lock.hcl*` lockfile. These lock files are maintained by terraform or its providers and are used to void concurrency issues.
Note that, for a successful initialization, you'll need to have the providers, called in your configuration files, correctly configured. According to the provider your configuration requires, terraform will fetch the necessary plugins and dependencies into `.terraform`.

### Validate
Before proceeding, you may ask terraform to validate your configuration. This is a good practice - run:

    terraform validate

This will check your configuration files for syntax errors and some logical issues such as repetitions/concurrency and undefined implicit dependencies.

Note that all files with a `*.tf` and `*.tf.json` filetype will be loaded. These are considered alphabetically by file name.

### Plan:
Once you have finished editing your configurations and successfully ran the initialization, you can run:

    terraform plan [-out=<plan-file-path>] 

Terraform will design a plan containing the necessary actions to implement your infrastructure and present it to you. You can have the plan exported to a file using the parameter `-out=<plan-file-path>`.

### Apply
To apply the latest result of the plan command changes you can simply run:

    terraform apply [plan-file-path]

This actually creates the real world infrastructure. If you want to apply a specific plan, just pass the `plan-file-path` as an argument. The default behavior is to run a new plan step and use that plan.

### Destroy
At any point you can destroy your infrastructure in a programmatic fashion - just run: 

    terraform destroy
and *Terraform* wil make sure every component gets destroyed in the correct order.

### Show
At any point you can enquire about the current state of your infrastructure, or about the changes to be implemented by given plan - just run:

    terraform show [path-to-file]
If no `[path-to-file]` is provided, *Terraform* will present you with the contents of the `terraform.tfstate` file on the present directory.

## Lose Notes
- If a variable is not defined and has no default, *Terraform* will prompt the user to input a value.
- Some variable types have built-in type verification.
___
---
\
\
\
\
\.




# Writing Terraform Files

Althogh Terraform supports json, its native language is HCL.

## Syntax
A full description of the syntax may be found in the [official repo](https://github.com/hashicorp/hcl/blob/hcl2/hclsyntax/spec.md).

The very basic building blocks of a terraform configuration file are:
- **Comments**  -   the usual comments
    - *in line* -   `#` or `//`
    - *bulk comment*    -   `/*` and `*/` initiate and terminate the multiline comment.
- **Identifiers**   -   the actual names of the variables, block types and the names of most Terraform constructs.
    - Identifiers may contain letters, digits, hyphens and underscores.
    - An identifier must not start with a digit.
    - A regex could be `[a-Z_-][0-9a-Z_-]*`.`[a-Z_][0-9a-Z_-]*`
    - storage accounts names may only contain lowercase or numbers: `[a-z][a-z0-9]*`
- **Expressions** - a generic expression that represents a yields a value. These can be a simple string or a complex expressions such as references to data exported by resources, arithmetic, conditional evaluation, or any terraform built-in functions.
- **Arguments** - an identifier and an expression that represent a variable and its value in the form: `identifier = expression`. 
- **Blocks**    -   a block is a container for other content (including blocks).

        BlockType "lable1" "lablen" {
            identifier1 = "expression1" # argument1

            # the block body may include other blocks
            another-block_type "labelA" "labelN" {
                identifierA = "${{ some + complex * $(computation.result) }}"  # argumentA
            }
        }
    - Blocks may have several *block types*:
        - Terraform built-in *types*. 
        - Provider specific *types*, according to your provider.
    - The number and type of labels varies according to the *block type*.
    - Each *block type* may have its own required *arguments*.
You may read about your specific provider's *block types* and requirements in [Terraform Regestry](https://registry.terraform.io/browse/providers).

  

## Lose Notes:
- Delimiters are always ASCII characters
- Non-ASCII values are accepted in identifiers, strings and comments.
- Configuration files must alway be encoded as UTF-8.
- Both Unix and Windows Line endings are accepted.
___
---
\
\
\
\
\.





# References
- https://www.terraform.io/
- https://www.terraform.io/docs/glossary.html
- https://learn.hashicorp.com/terraform
- https://www.terraform.io/docs/configuration/index.html
- TF Syntax: https://github.com/hashicorp/hcl/blob/hcl2/hclsyntax/spec.md
- Providers: https://registry.terraform.io/browse/providers
- AWS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- GCP: https://registry.terraform.io/providers/hashicorp/google/latest/docs
- Azure: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
---
\
\
\
\
\.
\[#]
